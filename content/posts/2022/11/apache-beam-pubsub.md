+++
layout =    "single"
type =      "blog"

date =      2022-11-23T12:31:53-08:00
draft =     false

title =     "Using Google Cloud Pubsub for Batch Pipelines in Apache Beam"
tagline =   ""
image =     ""
tags =      ["today-i-learned", "programming"]

aliases =   []
+++

Google Cloud's [Pub/Sub](https://cloud.google.com/pubsub/docs/overview) is a useful service that provides an asynchronous and scalable messaging platform that decouples services producing messages from those that receive and process those messages. When combined with [Apache Beam](https://github.com/apache/beam) (and/or [Dataflow](https://cloud.google.com/dataflow/docs/about-dataflow), Google's managed version of it), you can quickly develop powerful batch and streaming pipelines for data-parallel processing.

However, I recently ran into one slight hiccup - although Apache Beam has a [built-in IO connector for pubsub](https://beam.apache.org/releases/pydoc/2.4.0/apache_beam.io.gcp.pubsub.html#module-apache_beam.io.gcp.pubsub), it only supported streaming pipelines (at the time of development). Fortunately, after a bit of searching, someone else on [Stack Overflow](https://stackoverflow.com/a/67755184/7543727) figured out a workable solution:

> The trick is that if you call future.result() inside the process() method, you will block until that single message is successfully published, so instead collect a list of futures and then at the end of the bundle make sure they're all either published or definitively timed out. Some quick testing with one of our internal pipelines suggested that this approach can publish 1.6M messages in ~200s.

```python
import logging

import apache_beam as beam
from apache_beam.io.gcp.pubsub import PubsubMessage

from google.cloud.pubsub_v1 import PublisherClient
from google.cloud.pubsub_v1.types import (
    BatchSettings,
    LimitExceededBehavior,
    PublishFlowControl,
    PublisherOptions,
)


class PublishClient(PublisherClient):
    """
    You have to override __reduce__ to make PublisherClient pickleable 😡 😤 🤬

    Props to 'Ankur' and 'Benjamin' on SO for figuring this part out; god knows
    I would not have...
    """

    def __reduce__(self):
        return self.__class__, (self.batch_settings, self.publisher_options)


class BatchPubsubWriter(beam.DoFn):
    """
    beam.io.gcp.pubsub does not yet support batch operations, so
    we do this the hard way.  it's not as performant as the native
    pubsubio but it does the job.
    """

    def __init__(self, topic: str):
        self.topic = topic
        self.window = beam.window.GlobalWindow()
        self.count = 0

    def setup(self):
        batch_settings = BatchSettings(
            max_bytes=1e6,  # 1MB
            # by default it is 10 ms, should be less than timeout used in future.result() to avoid timeout
            max_latency=1,
        )

        publisher_options = PublisherOptions(
            enable_message_ordering=False,
            # better to be slow than to drop messages during a recovery...
            flow_control=PublishFlowControl(limit_exceeded_behavior=LimitExceededBehavior.BLOCK),
        )

        self.publisher = PublishClient(batch_settings, publisher_options)

    def start_bundle(self):
        self.futures = []

    def process(self, element: PubsubMessage, window=beam.DoFn.WindowParam):
        self.window = window
        self.futures.append(
            self.publisher.publish(
                topic=self.topic,
                data=element.data,
                **element.attributes,
            )
        )

    def finish_bundle(self):
        """Iterate over the list of async publish results and block
        until all of them have either succeeded or timed out.  Yield
        a WindowedValue of the success/fail counts."""

        results = []
        self.count = self.count + len(self.futures)
        for fut in self.futures:
            try:
                # future.result() blocks until success or timeout;
                # we've set a max_latency of 60s upstairs in BatchSettings,
                # so we should never spend much time waiting here.
                results.append(fut.result(timeout=60))
            except Exception as ex:
                results.append(ex)

        res_count = {"success": 0}
        for res in results:
            if isinstance(res, str):
                res_count["success"] += 1
            else:
                # if it's not a string, it's an exception
                msg = str(res)
                if msg not in res_count:
                    res_count[msg] = 1
                else:
                    res_count[msg] += 1

        logging.info(f"Pubsub publish results: {res_count}")

        yield beam.utils.windowed_value.WindowedValue(
            value=res_count,
            timestamp=0,
            windows=[self.window],
        )

    def teardown(self):
        logging.info(f"Published {self.count} messages")
```

Unfortunately, I eventually ran into an issue where the pubsub client was being overloaded when processing large amounts of data under specifying conditions. Explicitly batching the data mitigated the issue, instead of letting the (Dataflow) runner auto-magically determining the bundle sizes based on the input data.

```python
import apache_beam as beam

# This can probably be higher if needed, but works fine as it is
MIN_PUBSUB_BATCH_SIZE = 10000
# Have tested up to 400k, but instability seems to start occurring at these bundle sizes
MAX_PUBSUB_BATCH_SIZE = 200000

...

with beam.Pipeline(options=pipeline_options) as pipeline:
    (
        pipeline

        ...

        | "Batch Messages for Pubsub"
        >> beam.transforms.util.BatchElements(
            min_batch_size=MIN_PUBSUB_BATCH_SIZE,
            max_batch_size=MAX_PUBSUB_BATCH_SIZE,
        )
        | "Publish Batches to PubSub"
        >> beam.ParDo(BatchPubsubWriter("projects/myproject/topics/my-topic"))
    )
```

Hopefully Apache Beam eventually adds official support for pubsub in batch pipelines, but until then, this seems to suffice for processing millions of rows of data per job.
