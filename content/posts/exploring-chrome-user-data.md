---
title: "Exploring Chromium User Data"
date: 2020-11-06T11:48:04-05:00
draft: true
toc: false
images:
tags:
  - browser
  - user
  - data
  - files
---

These days, browsers are much like mini operating systems in and of themselves.
I'm not talking about ChromeOS either, just plain old Chrome/Chromium.

These browsers store **a lot** of user data, especially should you choose to make
a profile/user or sign-in with a Google account.

There are some interesting ways to view how your own data is being stored
in Chromium that I would like to talk about.

## Internal Pages

There are a number of non-listed internal chromium pages that you can see by
typing in the address bar `chrome://about` or `chrome://chrome-urls`.

There's lots of hyperlinks there that can show a wide variety of information
about the state of your browser, system and current user.

I've tried to organize a list of the one's that I thought were interesting.

### System Info

| URL                   | Description                                                             |
| --------------------- | ----------------------------------------------------------------------- |
| `chrome://system`     | Info about chrome version, OS, extensions, and mem usage.               |
| `chrome://gpu`        | Graphics features like OpenGL, Video Decoding and Hardware Acceleration |
| `chrome://device-log` | Shows input devices relevant to the browser                             |

### Network Info

| URL                       | Description                                                          |
| ------------------------- | -------------------------------------------------------------------- |
| `chrome://network-errors` | Shows every kind of network error possible (at least in the browser) |

### Omnibar

| URL                   | Description                                                                                                |
| --------------------- | ---------------------------------------------------------------------------------------------------------- |
| `chrome://omnibox`    | Provides a debug view for the omnibar and shows additional information like where a suggestions comes from |
| `chrome://predictors` | Shows how chrome "predicts" things frequently typed into the omnibar                                       |

### Website Engagement

| URL                         | Description                                                                                                                                            |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `chrome://media-engagement` | Shows your [Media Engagement Index](https://developers.google.com/web/updates/2017/09/autoplay-policy-changes#mei) on sites.                           |
| `chrome://site-engagement`  | A measurement of time spent, scrolls, clicks, typing on a page. More info [here](https://www.chromium.org/developers/design-documents/site-engagement) |

### Local Browser State/User Preferences (in json)

| URL                       | Description                                                                    |
| ------------------------- | ------------------------------------------------------------------------------ |
| `chrome://local-state`    | Some basic browser information                                                 |
| `chrome://pref-internals` | A large json file with lots of browser state and most if not all user settings |

### Events / Actions

| URL                     | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `chrome://user-actions` | Every event/action that happens in the browser (not page) UI |

### Google Account Sync

| URL                        | Description                                         |
| -------------------------- | --------------------------------------------------- |
| `chrome://sync-internals/` | All information about syncing with a Google Account |
