# hypembot

![unmaintained](http://img.shields.io/badge/status-unmaintained-lightgrey.svg)

Manually downloading songs from The Hype Machine too difficult? Wish you could
download that song from Soundcloud? Since the browser stores songs in its cache
in order to play them, simply start `hypembot` and it will monitor the cache,
copying mp3's into your Music directory.

## How does it work?

The program monitors your browser cache using `kqueue` and once a 'quality' mp3
file has been stable in the cache for 5 minutes, `hypembot` copies out of the
cache for you.

## Install

    $ [sudo] gem install hypembot
    $ hypembot # make sure to set ulimit -n 4096 or something similarily high

Use `-s` or `--source` to specify the path to where the music is cached, and
`-d` or `--directory` to specify where you want the files copied to.

Works on Mac OSX Lion. Uses kqueue by default.

## Copyright

`hypembot` is Copyright (c) 2012 [Kirk Scheibelhut](http://scheibo.com/about) and distributed under the MIT license.<br />
See the `LICENSE` file for further details regarding licensing and distribution.
