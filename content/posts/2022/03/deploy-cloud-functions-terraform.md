+++
layout =    "single"
type =      "blog"

date =      2022-03-08T11:47:29-08:00
draft =     false

title =     "Deploying Google Cloud Functions with Terraform"
tagline =   ""
image =     ""
tags =      ["today-i-learned", "programming"]

aliases =   []
+++

Cloud Functions are an easy, performant, and potentially inexpensive way to build serverless backends. I recently went down the route of setting up continuous deployments for them, and thought I'd share my learnings with it.

<!--more-->

The easiest way to deploy a Cloud Function is using the `gcloud` CLI like so:

```sh
gcloud functions deploy <YOUR_FUNCTION_NAME> \
  --region=<YOUR_REGION> \
  --runtime=<YOUR_RUNTIME> \
  --source=<YOUR_SOURCE_LOCATION> \
  --entry-point=<YOUR_CODE_ENTRYPOINT> \
  <TRIGGER_FLAGS>
```

Things get a bit more complicated if you want to use Terraform for deployments, which has its own set of advantages. The main trick to getting it to work is in line 43 below, where a checksum is appended to the archive's filename every time it's uploaded to the storage bucket.

The reason this is necessary is because the `google_cloudfunctions_function` resource won't be triggered for a redeployment on subsequent code changes - by having a checksum generated based on the source code, we ensure that Terraform knows to redeploy the Cloud Function whenever the underlying code changes.

```hcl {linenos=inline,hl_lines=["43-47", 64]}
locals {
  project_id = "my-project"
  region     = "us-west1"
  component  = "my-component"

  cloud_function = {
    name        = "${local.component}-cf"
    description = "Some description for this cloud function"
    runtime     = "python39"
    entry_point = "my_entry_point"

    source_dir       = "./src"
    archive_filepath = "/path/to/file"
  }
}

# Service account for the Cloud Function
resource "google_service_account" "cloud_function_sa" {
  project      = local.project_id
  account_id   = local.component
  display_name = local.component
}

# Bucket to store the source code archives
resource "google_storage_bucket" "function_archive" {
    name     = "${local.component}-cloud-function-archive"
    location = local.region
    project  = local.project_id
    uniform_bucket_level_access = true
}

# Archive the source code as a zip file
data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = local.cloud_functions.source_dir
  output_path = "${path.root}/${local.cloud_function.archive_filepath}"
}

# Upload the source code archive to the bucket. This will happen each time
# the source code changes.
resource "google_storage_bucket_object" "archive" {
  # Append checksum so file changes trigger a cloud function deployment
  name   = format(
            "%s#%s",
            local.cloud_function.archive_filepath,
            data.archive_file.function_archive.output_md5
          )
  bucket = google_storage_bucket.function_archive.name
  source = data.archive_file.function_archive.output_path

  content_disposition = "attachment"
  content_encoding    = "gzip"
  content_type        = "application/zip"
}

# Cloud Function that uses the uploaded source code archive
resource "google_cloudfunctions_function" "some_cloud_function" {
  name        = local.cloud_function.name
  description = "Some description for my cloud function"

  project               = local.project_id
  region                = local.region
  source_archive_bucket = google_storage_bucket_object.archive.bucket
  source_archive_object = google_storage_bucket_object.archive.name
  service_account_email = google_service_account.cloud_function_sa.email

  runtime               = local.cloud_function.runtime
  entry_point           = local.cloud_function.entry_point
  trigger_http          = true
}

```
