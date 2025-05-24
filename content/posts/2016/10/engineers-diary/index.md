+++
layout =    "single"
type =      "project"

date =      2016-10-01T11:34:47-07:00
draft =     false

title =     "Engineer's Diary"
image =     "screencap2.PNG"
tagline =   "Getting into the habit of writing stuff down because I don't trust my memory."
tags =      ["programming"]

aliases =   ["/projects/software/engineers-diary/"]
+++

__Background:__ Between paper notebooks, post-it notes, OneNote, Evernote, and so many more, there is no shortage of ways to write things down. Each has its strengths and weaknesses, but none satisfied my requirements to act as a daily work log to record key events, thoughts, and milestones during my work day.

My paper notebook is excellent for free-form thoughts, sketches, and calculations, but I would want to keep a separate notebook to keep track of these sequential events. We use OneNote at work, but where the infinite blank canvas is a strength in applications such as for research or brainstorming, I found it to be a weakness in record keeping since the document is too easy to edit and "fragile".

One day after learning about Git and SourceTree, I knew wanted to create a similar commit-style application to record activites and "freeze" them in time. Not web-based, internet connected, or cross platform; just a no frills desktop application that does one thing and one thing only.

__Objective:__ Develop a simple application to log daily activities at work.

__Features:__

+ Entries for each day are saved in a date-stamped text file
+ Each commit is time-stamped in the text file
+ Archive of log entries is accessible through the list in the left column
+ Text files show up as read only in the application, but are editable and searchable through the Windows File Explorer

__Framework:__ C#

__Source:__ [Github](https://github.com/justinmklam/engineers-diary)

![Screencap of the Engineer's Diary. Write in the 'Description' and 'Project' text boxes, then press 'Commit' when complete.](screencap2.PNG)

![After the 'Commit' button is pressed, the entry is written or appended to a text file and displayed on screen.](screencap3.PNG)
