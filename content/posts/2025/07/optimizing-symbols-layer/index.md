---
title: Optimizing My Symbols Layer
date: 2025-07-22T10:37:03-07:00
tagline: 
image: placeholder.jpeg
tags: 
draft: true
layout: single
type: blog
aliases:
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

<!--more-->

Script:
```python
import json
from pynput import keyboard
from pathlib import Path

# Path to the JSON file where stats will be stored
STATS_FILE = Path("key_stats.json")

# Load existing stats or initialize a new dictionary
def load_stats():
    if STATS_FILE.exists():
        with open(STATS_FILE, "r") as f:
            return json.load(f)
    return {}

# Save stats to the JSON file
def save_stats(stats):
    with open(STATS_FILE, "w") as f:
        json.dump(stats, f, indent=4)

# Update key stats
def update_stats(key, stats):
    try:
        key_str = (key.char if hasattr(key, 'char') and key.char else str(key)).lower()
    except AttributeError:
        key_str = str(key)
    
    if key_str in stats:
        stats[key_str] += 1
    else:
        stats[key_str] = 1

# Key press handler
def on_press(key):
    global stats
    update_stats(key, stats)
    save_stats(stats)

# Initialize stats
stats = load_stats()

# Start listening to key presses
print("Keylogger started. Press 'Ctrl + C' to stop.")
with keyboard.Listener(on_press=on_press) as listener:
    try:
        listener.join()
    except KeyboardInterrupt:
        print("Keylogger stopped.")
        save_stats(stats)

```

Which outputs a file like this:
```json
{
    "key.cmd": 1259,
    "k": 5877,
    "key.shift": 3153,
    "l": 1953,
    "h": 1803,
    "e": 3930,
    "y": 1119,
	...
}
```

Key Frequency Distribution

![Alphanumeric keys](keystats-alphanumeric.png)


![Symbol keys](keystats-symbols.png)

![Misc keys](keystats-misc.png)