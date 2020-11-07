---
title: "The Basics of Fetching Data (using curl, JavaScript, Python and Go)"
date: 2020-06-08T19:05:53-04:00
draft: false
toc: true
images:
tags:
  - basic
  - beginner
  - curl
  - fetch
  - http
  - network
---

![Arrows](/images/posts/fetch/arrow.png)
> horizontal by Ben Davis from the Noun Project

**Dear Reader:**
This post is aimed at beginners so if you are already familiar with how APIs work,
you might not get much from my explanation, but you are welcome to skim.

---

One of the most common activities a Web Developer will do is fetch data from some API,
parse it, and then do _something_ with that data, like displaying it on the page.

## Basic Info About APIs

- An API is often the separation between the **Frontend** and the **Backend** of a web application.

- Most API servers are [**CRUD**](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) interfaces to a database, and preform validation and error checking.

- A specific URL to an API where data may be requested or sent is called an **endpoint**.

- Most APIs use **JSON** for the serialization of data between client and server, but in reality, any type of
  data may be served.

- If there is no file extension (.txt, .png, .html, .xml) the [mime type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types)
  should be indicated by the `Content-Type:` header in the response.

- The **HTTP Status Code** returned in the response should tell whether the request was a success -- or if there was a failure (and what kind).

- Some APIs may require **authentication** to use, and some APIs may **rate-limit** unauthenticated requests.
  Authentication can differ between APIs, so consulting the documentation is never a bad idea.

- Depending on the language and API, there may be both official and unofficial **client libraries**.
  If possible, I would recommend using a library as they often simplify getting credentials and authentication
  set up.

- Always consult documentation if you are uncertain of how an API works.

- If there is no public API, and no unofficial API exposed, there are still ways to fetch data from
  a website. You may have parse HTML using XPATH or CSS selectors to get the specific data you need,
  but this would fall in the category of **Web Scraping** and that is the topic of another blog post.

## Examples Of Fetching An API

We will go through a couple ways somebody can 'fetch' a resource from the web
using curl, JavaScript, Python and Go (because using a browser is cheating).

For the uninitiated, a 'fetch' in a web context means: 1. sending an http request (the default method is probably GET) 2. waiting (asynchronously) for a response to come back 3. doing _something_ with the data when the response comes back

Code is typically executed **synchronously**, meaning execution goes from top to bottom
and your program will "wait" or "block" until a call finishes before executing the next line.

An operation such as a request across a network will block execution and your
program will wait idly until there is a response, so if you have more than a couple requests,
your program will quickly become **slow**.

The easiest solution to this is to fetch data **asynchronously** or in **parallel**.
Each language has a different notion of how works, so I will try my best to explain what's happening in each example.

### Other Language Differences

Things like naming, data structures, best practices and paradigms can differ between languages,
but they all converge around a similar model when it comes to encapsulating a protocol such as HTTP.

It is virtually guaranteed that there is a top level function or method of some sort that comes from a library
and acts like an http client.
At minimum you will supply a URL as the argument, but you may have to supply extra parameters
to configure how this function behaves or to give it data.

There is a good chance that this function is built from smaller primitive types
like `Request`, `Response`, `Session`, `Cookies`, `Headers`, `Body` and so on.
They will be represented and named differently depending on the data structures and
conventions provided by the language, but the pattern remains.

But first let's not get too far into that quite yet

### Curl

The first thing you may see when looking at docs for an API is a program called `curl`.
I don't think it is a stretch to say `curl` is the most commonly used CLI http client.
It is like the swiss army knife for doing http(s) stuff (and more!).
For the latest info about supported protocols and docs checkout the [curl website](https://curl.haxx.se/).
It has been around since 1998 and has grown with the internet and continues to be developed as
newer protocols come out and bugs are fixed. With that being said, curl has _a lot_ of flags
and options, but in the most basic invocation such as:

`curl http://example.com`, will send a GET request and write the body of the response to stdout.

Often a necessary argument to add is `-L`, which will "Follow redirects".
This is necessary because some web servers are sitting behind a proxy, or cache or some other
redirecting mechanism. The server itself can also be configured to "redirect" clients to switch
protocols, such as upgrading to HTTP/2 over HTTP/1.1.

Other useful options to checkout are `-I` to only get headers and `-v` for more verbose output
and `-Ss` to get rid of the progress bar, but show errors.

```text
$ curl -sSLI curl.haxx.se

HTTP/1.1 301 Moved Permanently
Server: Varnish
Retry-After: 0
Location: https://curl.haxx.se/
Content-Length: 0
Accept-Ranges: bytes
Date: Tue, 09 Jun 2020 19:58:21 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-fty21326-FTY
X-Cache: HIT
X-Cache-Hits: 0
X-Timer: S1591732701.195463,VS0,VE0

HTTP/2 200
server: Apache
x-frame-options: SAMEORIGIN
last-modified: Tue, 09 Jun 2020 10:05:06 GMT
etag: "223c-5a7a3dc9e9a74"
cache-control: max-age=60
expires: Tue, 09 Jun 2020 10:06:16 GMT
x-content-type-options: nosniff
content-security-policy: default-src 'self' www.fastly-insights.com; style-src 'unsafe-inline' 'self'
strict-transport-security: max-age=31536000; includeSubDomains; content-type: text/html
via: 1.1 varnish
accept-ranges: bytes
date: Tue, 09 Jun 2020 19:58:21 GMT
via: 1.1 varnish
age: 13
x-served-by: cache-bma1641-BMA, cache-fty21382-FTY
x-cache: HIT, HIT
x-cache-hits: 1, 1
x-timer: S1591732701.389830,VS0,VE520
vary: Accept-Encoding
content-length: 8764
```

Without the `-L`, we would have received only the first header with no data
and that's probably not what you want.

#### Find An API

Ok, so now we need an API to query so we can get some data.
Let's get the latest XKCD comic!

The endpoint is <https://xkcd.com/info.0.json>

and the data we get back from doing `curl -sSL https://xkcd.com/info.0.json` is

```json
{
  "month": "6",
  "num": 2317,
  "link": "",
  "year": "2020",
  "news": "",
  "safe_title": "Pinouts",
  "transcript": "",
  "alt": "The other side of USB-C is rotationally symmetric except that the 3rd pin from the top is designated FIREWIRE TRIBUTE PIN.",
  "img": "https://imgs.xkcd.com/comics/pinouts.png",
  "title": "Pinouts",
  "day": "8"
}
```

Note that all the data comes in on one line, which is to be expected from a data stream... but it's still hard to read for us humans.
Piping this output into `jq` or `python -m json.tool` can help to make this more readable.

```json
{
  "month": "6",
  "num": 2317,
  "link": "",
  "year": "2020",
  "news": "",
  "safe_title": "Pinouts",
  "transcript": "",
  "alt": "The other side of USB-C is rotationally symmetric except that the 3rd pin from the top is designated FIREWIRE TRIBUTE PIN.",
  "img": "https://imgs.xkcd.com/comics/pinouts.png",
  "title": "Pinouts",
  "day": "8"
}
```

`jq` can also get specific data from JSON structures without having to `grep`, `cut` or `awk`.

The syntax is similar to how you would access JSON or dictionary/maps from other languages using `.` and `[]`.
The command to get the value of `img` from the top level object would be:

```text
$ curl -sSL https://xkcd.com/info.0.json | jq '.img'
"https://imgs.xkcd.com/comics/pinouts.png"
```

Now, we can open it up in a web browser with `xdg-open` on Linux or `open` on Mac

```sh
xdg-open $(curl -sSL https://xkcd.com/info.0.json | jq '.img' | sed -e 's/"//g')
```

Working with APIs in the shell is great for testing and prototyping, but it's not
something that you would want to run in production out in the real world.

### JavaScript In The Browser

Unfortunately, fetching resources with JS in the browser is not as cut and dry as doing a `curl`
or running code in other environments. There are a few security related restrictions to be aware of.

#### Security

Modern browsers have security features that will block your unsolicited requests to domains of
any other _origin_ (a synonym for port, protocol, and domain).
To my knowledge, these restrictions exist only within browsers, and the only time you will have to deal with
them is writing frontend JavaScript that is run in a browser. Nevertheless, lets see the why and how.

#### Official Docs

MDN has a full rundown on both [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) (Cross-Origin Resource Sharing)
and [CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) (Content-Security-Policy)
as you will likely run into both of these when trying to fetch data from the web.

Also [this javascript.info explanation](https://javascript.info/fetch-crossorigin#cors-for-simple-requests)
was extremely helpful for me in understanding how CORS works.

#### TL;DR

The short version is this: CORS gives Web Admins control as to
**what outside domains** can request their resources and CSP allows Web Admins to specify
**what kind of content** can be requested in an outside browser.
And all this information is sent through specific directives in HTTP request/response Headers.

Browsers simply don't allow fetching of other domains unless the current origin is explicitly whitelisted by the requested origin.
This basically hinges on the response having a `Access-Control-Allow-Origin: *` or `Access-Control-Allow-Origin: <current domain>`
in the response header. This process is mostly hidden from end users -- unless something breaks of course.

I understand the urge to shrug away these overbearing and overly complicated security features, but
believe me, once you grasp the basic security model, it becomes easy enough to understand why they exist
and how you can work with -- or around them if need be.

#### Example

Let's try to fetch some JSON data from Reddit using declarative JavaScript :D

```javascript
function fetchRedditMovies() {
  fetch("https://reddit.com/r/movies.json")
    .then((res) => {
      if (res.status != 200) {
        let err = new Error(res.statusText);
        err.response = res;
        throw err;
      } else {
        return res.json();
      }
    })
    .then((json) => {
      json.data.children.forEach((post) => {
        console.log(post.data.title);
      });
    })
    .catch((error) => console.info(error));
}

fetchRedditMovies();
```

Getting blocked by CORS :frowning:

![CORS_ERROR](/images/posts/fetching-images/cors_error.png)

The quick-n-dirty way to get around this is by
utilizing a server to forward requests back and forth
on behalf of the browser, adding the necessary headers
`Access-Control-Allow-Origin: *` to allow the browser access to data
that would otherwise be blocked.

Solution:

Use a [CORS Proxy](https://github.com/Rob--W/cors-anywhere) to add the
correct headers for you.

```js
function fetchWithProxy(fetchUrl) {
  let corsProxy = "https://cors-anywhere.herokuapp.com/";

  fetch(corsProxy + fetchUrl)
    .then((res) => {
      if (res.status != 200) {
        let err = new Error(res.statusText);
        err.response = res;
        throw err;
      } else {
        return res.json();
      }
    })
    .then((json) => {
      json.data.children.forEach((post) => {
        console.log(post.data.title);
      });
    })
    .catch((error) => console.info(error));
}

fetchWithProxy("https://reddit.com/r/movies.json");

// execution continues
console.log("Hello from before the request");
```

**Note**: Don't use this kind of thing in production. A public server like this can
potentially log or leak a lot of sensitive information.

If you _have to_ bypass CORS, it is **much** more secure to use your own server as a proxy.

### Python

Making web requests with Python is really easy. The builtin libraries like `http.client`
and `urllib` are great for working with HTTP, but the [requests](https://requests.readthedocs.io/en/master/)
package provides an even easier way to interact with HTTP servers.

Chances are you already have it installed as a dependency somewhere, but if not,
just do a `python -m pip install requests`.

```python3
import requests

r = requests.get('https://reddit.com/r/movies.json')

posts = r.json()['data']['children']

for post in posts:
    print(post['data']['title']
```

Python is great because calling `type()` and `dir()` on an object can
give you so much information at a glance.

```python3
In [3]: type(r)
Out[3]: requests.models.Response

In [5]: dir(r)
Out[5]:
 ...
 'apparent_encoding',
 'close',
 'connection',
 'content',
 'cookies',
 'elapsed',
 'encoding',
 'headers',
 'history',
 'is_permanent_redirect',
 'is_redirect',
 'iter_content',
 'iter_lines',
 'json',
 'links',
 'next',
 'ok',
 'raise_for_status',
 'raw',
 'reason',
 'request',
 'status_code',
 'text',
 'url']
```

Some things to be aware of:

- The headers are automatically stored in `r.headers` as a case-insensitive Python dictionary.
- The status code is in `r.status_code` and `r.raise_for_status` makes for easy error handling.
- There are multiple representations of the data in the body of the request like:
  - `r.content` for bytes
  - `r.text` for a str
  - `r.json()` for a dict.

```text
>>> type(r.json())
<class 'dict'>
>>> type(r.text)
<class 'str'>
>>> type(r.content)
<class 'bytes'>
```

Very nice!

But all of this is synchronous. What happens if we want to send lots of requests and we don't necessarily want
to wait on all of them to get back.

#### Concurrency With Python

Python does have some standard libraries that allow various types of concurrency.
However, due to the design of Python's interpreter, fully concurrent execution cannot be achieved
like compiled languages.

Libraries like `threading` and `multiprocessing` are for dealing with individual threads
and processes respectively. The `concurrent.futures` library also provides an easy model for
concurrent execution by creating a thread pool or a process pool.

These modules are more useful for CPU intensive tasks, like number crunching or
compression. The downside is that they add a lot of extra complexity and potential
for bugs. For tasks where the main bottleneck is disk or network, `asyncio` is a
much better solution (especially with Python 3.7).

#### Async With Python3

The syntax of asynchronous code in Python is similar to JavaScript and Node.js.
Python3.7 has `async` for functions and `await` for "futures", which are
more or less the Python version of JS promises.

`asyncio` has both low level and high level APIs,
but they both are built around the idea of the **event loop**
which is a concept that should also be familiar to Node.js people.

Here is a simple example using `asyncio`

```python3
import asyncio
import requests

# a regular function made await-able
async def get_body(url):
    r = requests.get(url)
    r.raise_for_status() # do error handling
    return r.text

async def main():
    # creating an awaitable task from the function above
    fetch_task = asyncio.create_task(get_body('https://example.com'))

    # using await on the task here is what runs the get_body() function
    body = await fetch_task

    print(body)

# main function must be run in the event loop
asyncio.run(main())
```

That's is fine for running a few functions asynchronously,
but what is you want to call _a lot_ of functions asynchronously?
This is where the event loop comes in handy.

First, here's the synchronous way:

```python3
import requests
import time

# requests wrapper function
def fetch(url):
    r = requests.get(url)
    r.raise_for_status()
    return r

def main():
    url_list = [
        "https://example.com",
        "https://google.com",
        "https://bing.com",
        "https://yahoo.com",
        "https://docs.python.org",
        "https://realpython.com",
        "https://github.com"
    ]*10

    results = []

    # fetch urls
    for url in url_list:
        results.append(fetch(url))

    # print results
    for result in results:
        print(result, result.url)


start = time.perf_counter()
main()
end = time.perf_counter()

print(f"Time Elapsed: {end - start} sec")

# Time Elapsed: 28.453063446999295 sec
```

Now add some async:

```python3
import asyncio
import time

import requests

# requests wrapper function
def fetch(url):
    r = requests.get(url)
    r.raise_for_status()
    return r

async def main():
    # create a long url list
    url_list = [
        "https://example.com",
        "https://google.com",
        "https://bing.com",
        "https://yahoo.com",
        "https://docs.python.org",
        "https://realpython.com",
        "https://github.com"
    ]*10

    # get the event loop so we can run functions in a thread pool
    loop = asyncio.get_running_loop()

    # create a list of future jobs to run asynchronously
    futures = []

    for url in url_list:
        # create an awaitable object out of our fetch function
        futures.append(loop.run_in_executor(None, fetch, url))

    # 1. *futures will expand our list of awaitable objects into parameters
    # 2. asyncio.gather(*futures) will run each awaitable in a different thread
    # 3. a list of response objects is returned from all the function calls
    results = await asyncio.gather(*futures)

    # print results
    for result in results:
        print(result, result.url)


# do some performance testing
start = time.perf_counter()
asyncio.run(main())
end = time.perf_counter()

print(f"Time Elapsed: {end - start} sec")

# Time Elapsed: 2.476593152008718 sec
```

#### Further Reading

At the risk of creating more confusion, I will redirect you to
a more accurate and clear explanation of [asyncio event loops and executors](https://docs.python.org/3/library/asyncio-eventloop.html#asyncio.loop.run_in_executor),
which are the true magic behind all of this.

### Go

Let's see how easy it is to make a web request with Go's standard library.

The relevant packages here are:

- `os` -- for receiving arguments from the command line
- `io/ioutil` -- for writing to stdout
- `net/http` -- for sending http requests.

```go
package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {

	// iterate through arguments
	for _, url := range os.Args[1:] {
		// send a request and handle errors
		resp, err := http.Get(url)
		if err != nil {
			fmt.Fprintf(os.Stderr, "fetch: %v\n", err)
			os.Exit(1)
		}

		// store the body as a string and handle errors
		b, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			fmt.Fprintf(os.Stderr, "fetch: reading %s: %v\n", url, err)
			os.Exit(1)
		}

		// close body after function ends
		defer resp.Body.Close()

		// print the response
		fmt.Printf("%s", b)
	}

}
```

You can also use the `io` package directly to copy the body
of the response to stdout instead of storing it.

But wait, this code is synchronous and will slow down with lots of requests.
Unacceptable! Let's fix it using Go's builtin concurrency mechanisms: goroutines and channels.

```go
package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"time"
)

func main() {
	// start timer
	start := time.Now()

	// a channel allows communication between a goroutine and the current context
	ch := make(chan string)

	for _, url := range os.Args[1:] {
		go fetch(url, ch) // start a goroutine
	}

	for range os.Args[1:] {
		fmt.Println(<-ch) // receive from channel ch
	}

	// print total time
	fmt.Printf("%.2fs elapsed\n", time.Since(start).Seconds())
}

func fetch(url string, ch chan<- string) {
	// start fetch timer
	start := time.Now()

	// get  the url
	resp, err := http.Get(url)
	if err != nil {
		ch <- fmt.Sprint(err) // send to channel ch
		return
	}

	// get the number of bytes from the body
	nbytes, err := io.Copy(ioutil.Discard, resp.Body)
	if err != nil {
		ch <- fmt.Sprintf("while reading %s: %v", url, err)
		return
	}
	defer resp.Body.Close() // don't leak resources

	// end timer
	secs := time.Since(start).Seconds()

	// pass data back to the channel
	ch <- fmt.Sprintf("%.2fs  %7d  %s", secs, nbytes, url)
}
```

#### Explanation

All the fetching in this program takes place in [goroutines](https://gobyexample.com/goroutines).
The only special thing about the `fetch` function is that it takes
a channel as an argument. This is the main way data is shared between concurrent
functions.

This goroutine does not "return" data in the traditional sense, but
it does communicate data back to the function that called it by
way of this channel.

You will notice after the first for loop, there is another which
collects or receives the data that has been buffered in `ch` from the various goroutines.

There's much more to say about Go's concurrency model, but this post is long enough
but I hope this at least this covers the basics.

## Conclusion

Fetching data from the internet (even asynchronously) is a relatively painless
these days thing to do thanks to modern programming languages and libraries.
It is easier than ever to write networking code, and even having a basic
knowledge is enough to open up so many doors for future projects.
