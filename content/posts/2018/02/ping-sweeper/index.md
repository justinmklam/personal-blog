+++
date = "2018-02-09T17:02:25-08:00"
draft = false
image = "banner2.PNG"
layout = "single"
tagline = "Life is better when you live asynchronously."
tags = ["programming"]
title = "Synchronous vs Asynchronous Ping Sweep in C# Windows Form"
type = "blog"

+++

As a mechatronics engineer (in training), sometimes I like to pretend that I also know how to program.

[^*]: Engineer in Training. EGBC please don't take my license away.

In my most recent adventures to software land at [MistyWest](https://mistywest.com/), I needed to write an application in C# that involved doing a ping sweep to find devices that were physically connected through ethernet. Since Google and Stack Overflow are my two best friends, I was able to find (what seemed to be) an off-the-net solution quite quickly.

However, despite this being a relatively well known objective with well-known libraries to accomplish it, my journey to developing a solution was not as easy as I originally thought. The following post outlines the things I tried before arriving to a working solution, which hopefully is at least mildly interesting and/or educational. Also if you're a software engineer reading this, please go easy on my code. Or not.

# The Development

## First Attempt: Some-ping Simple

A quick Google search showed that pinging addresses is dead easy in C#. Using the `System.Net.NetworkInformation` namespace, we can easily use the `Ping.Send()` command to check if a remote address is alive.

```c#
using System.Net.NetworkInformation;

int timeout = 10;   //in ms

Ping p = new Ping();
PingReply rep = p.Send("192.168.1.1", timeout);

if (rep.Status == IPStatus.Success)
{
    //host is active
}
```

This is great if we only had a few addresses to ping, because unfortunately this method is unacceptably slow for a user waiting to see if any devices are found. Although `Ping.Send` has an overload to accept a timeout interval, it appears that setting very low values doesn't actually change much. From the [MSDN docs](https://msdn.microsoft.com/en-us/library/ms144955.aspx):

> When specifying very small numbers for timeout, the Ping reply can be received even if timeout milliseconds have elapsed.

In practice, it seems that ~500ms is about the fastest threshold that can be set. Unfortunately, scanning 255 IP addresses this way will be excruciatingly slow (for both the developer and end user). And the search continues...

## Second Attempt: Jaime LAN-nister, Pingslayer

A few more Googles later and I had what seemed to be the golden solution.

Thanks to [Tim Coker](https://stackoverflow.com/a/4042887), I thought I was mostly done my application already (knowledge is half the battle, right?). His console application worked wonderfully and was written in C#, which was great news since I was developing the application using Windows Forms. Instead of using the synchronous `Ping.Send()`, it harnessed the asynchronous `Ping.SendAsync()` along with the `CountdownEvent` class in `System.Threading`. However, upon copying the code into Windows Forms, it didn't seem to work. What gives?

```csharp
/* Source: https://stackoverflow.com/a/4042887
 * Original author: Tim Coker
 */

using System;
using System.Diagnostics;
using System.Threading;
using System.Net.NetworkInformation;

namespace ConsoleApplication1
{
    class Program
    {
        static CountdownEvent countdown;
        static int upCount = 0;
        static object lockObj = new object();
        const bool resolveNames = true;

        static void Main(string[] args)
        {
            countdown = new CountdownEvent(1);
            Stopwatch sw = new Stopwatch();
            sw.Start();
            string ipBase = "10.22.4.";
            for (int i = 1; i < 255; i++)
            {
                string ip = ipBase + i.ToString();

                Ping p = new Ping();
                p.PingCompleted += new PingCompletedEventHandler(p_PingCompleted);
                countdown.AddCount();
                p.SendAsync(ip, 100, ip);
            }
            countdown.Signal();
            countdown.Wait();
            sw.Stop();
            TimeSpan span = new TimeSpan(sw.ElapsedTicks);
            Console.WriteLine("Took {0} milliseconds. {1} hosts active.", sw.ElapsedMilliseconds, upCount);
            Console.ReadLine();
        }

        static void p_PingCompleted(object sender, PingCompletedEventArgs e)
        {
            string ip = (string)e.UserState;
            if (e.Reply != null && e.Reply.Status == IPStatus.Success)
            {
                Console.WriteLine("{0} is up: ({1} ms)", ip, e.Reply.RoundtripTime);
                lock(lockObj)
                {
                    upCount++;
                }
            }
            else if (e.Reply == null)
            {
                Console.WriteLine("Pinging {0} failed. (Null Reply object?)", ip);
            }
            countdown.Signal();
        }
    }
}
```

Lesson learned: Console applications and Windows Forms are different beasts and deadlocks occur with the above code. According to [Hans Passant from another Stack Overflow thread](https://stackoverflow.com/a/7767632), the additional UI thread is the culprit:

> Winforms has a synchronization provider whereas console apps do not. The problem is that the `Ping` class makes a best effort to raise the `PingCompleted` event on the same thread that calls `SendAsync()`. So it tries to raise the event on the main thread, but that can't work since the main thread is blocked with the `countdown.Wait()` call. In a console app however, the `PingCompleted` event will be raised on a `ThreadPool` thread.

Hm, turns out this problem wasn't as easy as copying and pasting random code off the internet. Time for a bit of research!

### Digging Deeper: A Battle of Asynchronous Pings

For some reason that can only be to confuse inexperienced programmers like myself, there are two different asynchronous ping methods in this class. First on the list:

> `Ping.SendAsync()`: **Asynchronously attempts** to send an Internet Control Message Protocol (ICMP) echo message to a computer, and receive a corresponding ICMP echo reply message from that computer. - [MSDN](https://msdn.microsoft.com/en-us/library/system.net.networkinformation.ping.sendasync(v=vs.110).aspx)

And the second:

> `Ping.SendPingAsync()`: Sends an Internet Control Message Protocol (ICMP) echo message to a computer, and receives a corresponding ICMP echo reply message from that computer **as an asynchronous operation**. - [MSDN](https://msdn.microsoft.com/en-us/library/system.net.networkinformation.ping.sendpingasync(v=vs.110).aspx)

Based on these method descriptions, it appears that `SendAsync()` does not guarantee asynchronous operation. Since we just learned how threading in console applications vs windows forms is dealt with differently, this may be why it didn't work as expected in the latter case. What we want are guaranteed asynchronous operations, so hopefully `SendPingAsync()` should perform to its name.

(One can only assume this second method was added after-the-fact when Microsoft realized that developers wanted a truly asynchronous ping...)

**The takeaway:** Use `SendPingAsync()` or bust.

### Digging Deeper: Background Worker vs Async/Await

So we've selected our asynchronous ping method, but that still leaves us hanging over how we're going to handle it in a background task. Before .NET 4.0 was released, `BackgroundWorker` was the de-facto standard[^1]. However:

> The core problem that `BackgroundWorker` originally solved was the need to *execute synchronous code on a background thread*. If you're using it for asynchronous or parallel work, you're not using the right tool in the first place. - [Stephen Cleary](http://blog.stephencleary.com/2013/05/taskrun-vs-backgroundworker-round-1.html)

[^1]: According to [Stephen Cleary](http://blog.stephencleary.com/2010/08/various-implementations-of-asynchronous.html), one of [Microsoft's Most Valuable Professionals](https://mvp.microsoft.com/en-us/PublicProfile/5000058?fullName=Stephen%20Cleary) and top answerer for async/await questions on Stack Overflow. I'd trust him if I were you.

After .NET 4.0, we have the following options:

+ Tasks (Async Methods)
+ Tasks (Task Parallel Library)
+ Delegate.BeginInvoke
+ ThreadPool.QueueUserWorkItem
+ Threads

Discussing each of these methods is beyond the scope of this post, but you can read more on Cleary's article on [various implementations of asynchronous background tasks](http://blog.stephencleary.com/2010/08/various-implementations-of-asynchronous.html). In short, using `Task`-returning asynchronous methods is the best overall method to use.

Kind of.

For my application, sending each ping to its own task using `async/await` is logical, as I could then call `Task.WhenAll()` to wait until all pings have been received back to the main thread.

However, I could still use `BackgroundWorker` for SFTP file transfer from the remote devices to a local directory (required in my final application, but not included in this ping sweep demo). Doing so would prevent the main UI thread from hanging while files are being transferred. Although `async/await` may also be used for this, `BackgroundWorker` seemed to be the more appropriate (and easier) implementation since each file is serially transferred from remote to local device. Additionally, it's just drag and drop in WinForms!

**The takeaway:** Use `async/await` for asynchronous ping sweep, and `BackgroundWorker` for SFTP file transfers.

## Third Attempt: One Ping to Rule Them All, One Ping to Find Them

<!-- ![Simple Winform application to demonstrate the power of threads.](winform.png) -->

Finally, we have a working solution! Using `async/await` with `Tasks` in `System.Threading.Tasks` yields promising results. See below for the implementation.

```c#
private string BaseIP = "192.168.1.";
private int StartIP = 1;
private int StopIP = 255;
private string ip;

private int timeout = 100;
private int nFound = 0;

static object lockObj = new object();
Stopwatch stopWatch = new Stopwatch();
TimeSpan ts;

public async void RunPingSweep_Async()
{
    nFound = 0;

    var tasks = new List<Task>();

    stopWatch.Start();

    for (int i = StartIP; i <= StopIP; i++)
    {
        ip = BaseIP + i.ToString();

        System.Net.NetworkInformation.Ping p = new System.Net.NetworkInformation.Ping();
        var task = PingAndUpdateAsync(p, ip);
        tasks.Add(task);
    }

    await Task.WhenAll(tasks).ContinueWith(t =>
    {
        stopWatch.Stop();
        ts = stopWatch.Elapsed;
        MessageBox.Show(nFound.ToString() + " devices found! Elapsed time: " + ts.ToString(), "Asynchronous");
    });
}

private async Task PingAndUpdateAsync(System.Net.NetworkInformation.Ping ping, string ip)
{
    var reply = await ping.SendPingAsync(ip, timeout);

    if (reply.Status == System.Net.NetworkInformation.IPStatus.Success)
    {
        lock(lockObj)
        {
            nFound++;
        }
    }
}
```

![Asynchronous pings are light years faster! Half a second and we're rocking with all the pings we needed.](ping result - async.png)

### Verification with Benchmark

To make sure our numbers add up, let's compare it with a known tool that is much more mature than this C# application.

![Verifying scanned result with Angry IP scanner because apparently nmap isn't fully functional in Windows Subsystem for Linux yet.](angryip.PNG)

Same number of hosts alive, but a little slower. However, Angry IP Scanner is more robust in its pings and thread handling, so the few extra seconds is likely put to good use. I found my application to be somewhat inconsistent in finding all the alive hosts, which may be mitigated with multiple ping packets to send (instead of just one).

### Comparing with Synchronous Ping Sweep

Because pinging is such an interesting past-time, let's see how the very first synchronous solution performs using `Ping.Send()`.

```c#
private string BaseIP = "192.168.1.";
private int StartIP = 1;
private int StopIP = 255;
private string ip;

private int timeout = 100;
private int nFound = 0;

Stopwatch stopWatch = new Stopwatch();
TimeSpan ts;

public void RunPingSweep_Sync()
{
    nFound = 0;

    stopWatch.Start();
    System.Net.NetworkInformation.Ping p = new System.Net.NetworkInformation.Ping();

    for (int i = StartIP; i <= StopIP; i++)
    {
        ip = BaseIP + i.ToString();
        System.Net.NetworkInformation.PingReply rep = p.Send(ip, timeout);

        if (rep.Status == System.Net.NetworkInformation.IPStatus.Success)
        {
            nFound++;
        }
    }

    stopWatch.Stop();
    ts = stopWatch.Elapsed;

    MessageBox.Show(nFound.ToString() + " devices found! Elapsed time: " + ts.ToString(), "Synchronous");
}
```

![Result of 255 pings using a synchronous method. Nobody has 2 minutes to wait for a complete scan.](ping result - sync.png)

Wow. A full two minutes compared to less than one second. Life truly is better when you live asynchronously.

# Closing Thoughts

This concludes another adventure through asynchronous methods in C#. It's amazing how much information is available on the internet, and I truly would not be able to get this far without it. Google and Stack Overflow, what would I be without you?

Thanks for reading, and I hope you learned a *ping* or two about these methods.

<br>

Check out the full source code of this project on [Github](https://github.com/justinmklam/ping-sweeper/blob/master/Ping%20Sweep%20Demo/Ping%20Sweep%20Demo/FormMain.cs)!
