# hypembot

Manually downloading songs from Hypemachine too difficult? Wish you could
download that song from Soundcloud? Since the browser stores songs in its cache
in order to play them, simply start `hypembot` and it will monitor the cache,
copying mp3's into your Music directory.

## How does it work?

The program monitors your browser cache using `kqueue` and once a 'quality' mp3
file has been stable in the cache for 5 minutes, `hypembot` copies out of the
cache for you.

## Install

    $ [sudo] gem install hypembot
    $ hypembot

Works on Mac OSX Lion. Uses kqueue by default.

## Copyright

`hypembot` is Copyright (c) 2012 [Kirk Scheibelhut](http://scheibo.com/about) and distributed under the MIT license.<br />
See the `LICENSE` file for further details regarding licensing and distribution.
