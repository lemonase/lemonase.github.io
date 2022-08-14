---
title: "Tracking the Hours of my Week with Python"
date: 2022-08-14T03:16:48-04:00
draft: false
toc: false
images:
tags:
  - time management
  - weekly
  - productivity
  - learning
---

I wanted to see some percentages of how much time certain things take out of my week.
This obviously does not reflect the reality and to be honest I doubt it really comes close, but I found it to be an interesting exercise.

## Script Output

```text
------------------------
Time Map:
------------------------
[29.8%] work           : {'working': 40, 'commuting': 10}
[40.5%] health         : {'sleep': 35, 'showers': 3.5, 'gym': 3, 'meditating': 3.5, 'cleaning_cooking': 7, 'eating': 7, 'pooping': 7, 'laundry': 2}
[16.7%] digital_entertainment: {'gaming': 7, 'watching_videos': 21}
[10.4%] learning_studying: {'reading': 7, 'learning_japanese': 3.5, 'coding_proj': 7}
------------------------
Time Used:
------------------------
[97.3] % used
[2.7] % left
------------------------

used hrs 163.5 / 168
```

## The Script

```python3
#!/usr/bin/env python3

# this is a very simplified, rough estimate of time as there is much more
# variation and drift in these things, however the things that do not change
# for me are work, sleep (I don't usually get a full 8 hours :/)

# i know there are lots of ways to log time spent on various things and that would
# take a lot of the guess work out of these things. something to consider in the future

hrs_in_week = 24 * 7                # 168 hours in a week - that's not ever going to change

# this is a map of groups of things that i dedicate my time to
# the (++) or (--) parentheses at the end of the comments indicate what i want to spend more or less time on

hours_map = {
    "work": {
        "working": 8 * 5,           # currently working a 9-5 schedule. this is not very cash money (--)
        "commuting": 2 * 5,         # an hour each way to work in the car. this does not spark joy (--)
    },
    "health": {
        "sleep": 5 * 7,             # ideally getting 8 hours of sleep (more often 4-6 is the case). I should get more sleep (++)
        "showers": .5 * 7,          # i take short showers (G)
        "gym": 1 * 3,               # if I don't skip leg day (++)
        "meditating": .5 * 7,       # like to spend an hour or two meditating throughout the day (++)
        "cleaning_cooking": 1 * 7,  # easily could be more/less (++)
        "eating": 1 * 7,            # could me more or less (G)
        "pooping": 1 * 7,           # also could be more or less (G)
        "laundry": 2                # pretty much 2 hours for washing/drying/folding/putting-away clothes for the week (G)
    },
    "digital_entertainment": {
        "gaming": 1 * 7,            # usually don't even play 7 hours of games these days :< (++)
        "watching_videos": 3 * 7,   # usually watch more on YT or streaming. includes social media (--) (unless classic movies)
    },
    "learning_studying": {
        "reading": 1 * 7,           # reading more would be nice (++)
        "learning_japanese": .5 * 7,# would like to spend an hour learning a new language (++)
        "coding_proj": 1 * 7        # would also like to do more of this (++)
    },
}


total_hours_used = 0
total_used_percentage = 0

print("------------------------")
print("Time Map:")
print("------------------------")

for k, v in hours_map.items():
    hrs_sum = sum(v.values())
    total_hours_used += hrs_sum
    percentage = (hrs_sum / hrs_in_week) * 100
    total_used_percentage += percentage
    print(f"[{percentage:.1f}%] {k : <15}: {v} ")

print("------------------------")

print("Time Used:")
print("------------------------")
print(f"[{total_used_percentage:.1f}] % used")
print(f"[{100 - total_used_percentage:.1f}] % left")
print("------------------------")
print()
print("used hrs", total_hours_used, "/", hrs_in_week)
print()
```

You can take this, modify it to what you spend time on and see what you can change around.

I would like to iterate on this script to keep track of the things I want to spend
more and less time on in the future.

<!-- github gist for good measure -->
<!-- {{< gist lemonase f398086ed4ecd8e500dbb6459ceb42ef "my_week_time.py" >}} -->
