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

## Exposition

These days browsers can store **a lot** of user data on your local computer if
you let them.
They also urge you to create an account and login so that your browsing data +
tons of other data can be synced to a server.

Those who sign-in to Chrome or Chromium with a Google account have no control over what
Google does with their data once it leaves their computer. The next best thing
is knowing what, where and how the data is being stored/used on a local machine.

There are some interesting ways to view how your own data is being stored
by Chromium that I would like to detail below.
The first method is looking at internal pages, which can show you quite a bit
of what chromium does under the hood. The second method involves looking at
user files, which are stored as sqlite databases or json.

One of the great things about Chromium being open source is that anyone can go
read the docs, clone and build the source code or follow active development
if they wish.

NOTE:
There is really only one way to see how things work "under the hood", but
that would require someone skilled and brave enough to go through Chromium's
massive C++ codebase to see how user data actually gets stored and synced in
code. I have no shame in admitting that I am not that person, at least not
at this point in time.

## Internal Pages

There are a number of non-listed internal chromium pages that you can see by
typing in the address bar `chrome://about` or `chrome://chrome-urls`.

There's lots of hyperlinks there that can show a wide variety of information
about the state of your browser, system and current user info.

I've tried to organize a list of the one's I found interesting.

### System Info

| URL                   | Description                                                             |
| --------------------- | ----------------------------------------------------------------------- |
| `chrome://system`     | Info about chrome version, OS, extensions, and mem usage.               |
| `chrome://gpu`        | Graphics features like OpenGL, Video Decoding and Hardware Acceleration |
| `chrome://device-log` | Shows input devices relevant to the browser (more useful for ChromeOS)  |

### Network Info

| URL                       | Description                                                               |
| ------------------------- | ------------------------------------------------------------------------- |
| `chrome://network-errors` | Shows every kind of network error possible (at least in the browser)      |
| `chrome://inspect`        | Shows every tab with an option to open DevTools for any page or extension |

### Omnibox

| URL                   | Description                                                                                                |
| --------------------- | ---------------------------------------------------------------------------------------------------------- |
| `chrome://omnibox`    | Provides a debug view for the omnibar and shows additional information like where a suggestions comes from |
| `chrome://predictors` | Shows how chrome "predicts" things frequently typed into the omnibar                                       |

### Website Engagement

| URL                         | Description                                                                                                                                            |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `chrome://media-engagement` | Shows your [Media Engagement Index](https://developers.google.com/web/updates/2017/09/autoplay-policy-changes#mei) on sites.                           |
| `chrome://site-engagement`  | A measurement of time spent, scrolls, clicks, typing on a page. More info [here](https://www.chromium.org/developers/design-documents/site-engagement) |

### Local Browser State and User Preferences (in json format)

| URL                       | Description                                                                    |
| ------------------------- | ------------------------------------------------------------------------------ |
| `chrome://local-state`    | Some basic browser information                                                 |
| `chrome://pref-internals` | A large json file with lots of browser state and most if not all user settings |

### New Tab Data

| URL                            | Description                                 |
| ------------------------------ | ------------------------------------------- |
| `chrome://newtab`              | The internal url for the new tab page       |
| `chrome://ntp-tiles-internals` | A view on data stored for the new tab page  |
| `chrome://suggestions`         | Suggestions that appear on the new tab page |

### Generated Events / Actions

| URL                     | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `chrome://user-actions` | Every event/action that happens in the browser (not page) UI |

### Signin and Sync

| URL                          | Description                                         |
| ---------------------------- | --------------------------------------------------- |
| `chrome://sync-internals/`   | All information about syncing with a Google Account |
| `chrome://signin-internals/` | Information about about signed-in Google Accounts   |

### URLS for regular UI pages

| URL                   | Description |
| --------------------- | ----------- |
| `chrome://settings`   | Settings    |
| `chrome://bookmarks`  | Bookmarks   |
| `chrome://history`    | History     |
| `chrome://downloads`  | Downloads   |
| `chrome://extensions` | Extensions  |

### Turn on experimental/disabled features

| URL              | Description                                                                                                |
| ---------------- | ---------------------------------------------------------------------------------------------------------- |
| `chrome://flags` | Turn on/off features with flags -- similar to settings command line flags in ~/.config/chromium-flags.conf |

### Chrome version info

| URL                | Description                   |
| ------------------ | ----------------------------- |
| `chrome://version` | Detailed/verbose version page |
| `chrome://help`    | Less verbose version page     |

## Find your user's data files on disk

Much of the state of the browser is stored in readable sqlite databases,
json files and/or other intermediate types of files (such as those in the cache)
that contain binary data.

### Windows

Found in: `C:\Users\<username>\AppData\Local\Google\Chrome\User Data\Default`

### Mac

Found in: `/Users/<username>/Library/Application Support/Google/Chrome/Default`

### Linux

Found in: `/home/<username>/.config/google-chrome/Default`

Files will be in the same directory using Chromium, but likely under the name
chromium instead of chrome or google-chrome.

## Get a list of sqlite databases used by chromium

```sh
$ file ~/.config/chromium/Default/* | grep -i sqlite | cut -d ':' -f 1 | xargs -I@ basename @
Affiliation Database
Cookies
Extension Cookies
Favicons
heavy_ad_intervention_opt_out.db
History
Login Data
Media History
Network Action Predictor
previews_opt_out.db
QuotaManager
Reporting and NEL
Shortcuts
Top Sites
Web Data
```

These files can all be opened with sqlite3 on the CLI or a SQL GUI such as
[dbeaver](https://dbeaver.io/).

## Using sqlite to query data

Getting schema and tables from a sqlite db:

```sh
sqlite3 <database> '.schema' '.tables' '.exit'
```

Once you know the table and column where data stored, you can do pretty
much anything with it a few examples would be

Export your browsing history from History db as a csv

```sh
sqlite3 History '.mode csv' 'SELECT * FROM urls' '.exit' > ~/history.csv
```

Get the urls where you have login data saved from 'Login Data' db

```sh
sqlite3 'Login Data' 'SELECT origin_url FROM logins' '.exit' > ~/login_urls.txt
```

Get search engine "keywords" from 'Web Data' db

```sh
sqlite3 'Web Data' '.mode json' 'SELECT * FROM keywords' | jq
```

## Conclusion

There are probably better ways to do this, but I learned a lot from looking
at some of these tucked away files. Specifically, I found it
interesting that Chrome keeps media and site engagement metrics as well as
the preloading/prediction that happens when you start to type in an often
visited URL.

Next to digging through the C++ implementation of how all these metrics are
created and captured, this was both insightful and relatively easy.
