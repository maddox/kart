# Kart!!

Kart is a frontend to the amazing mult-emulating system
[RetroArch](https://github.com/libretro/RetroArch).

Kart aspires to be an extremely simple front end that lets you get up and
running fast with a classy way to pick and choose your games.

Kart is targeted at running on a TV in an HTPC type set up, but can be run from
a desktop window just fine.

![kart emulator retroarch frontend](https://cloud.githubusercontent.com/assets/260/2924334/483a6a08-d730-11e3-9177-17ddf85671b1.png)
## Platforms

Kart is powered by [Atom Shell](https://github.com/atom/atom-shell), a cross
platform application shell.

While it's being developed in Mac OS X, Atom Shell is multi-platform so Kart
will easily eventually work on Windows and Linux.


## Tech Stack

From the Atom Shell README:

> Atom Shell lets you write cross-platform desktop applications using JavaScript,
HTML and CSS. It is based on node.js and Chromium and is used in the Atom
editor.

Atom Shell wraps up [Chromium](http://www.chromium.org) and integrates it with
Node.js so you have access to the local system. This allows for really fast
iterative development for an application of this nature.


Kart is developed using these technologies.

* HTML5
* CoffeeScript
* Less
* Spine JS
* Node.js


## Development

To get started working on Kart:

* clone it down
* run `script/bootstrap`
* run `script/run`

Voila, Kart will be running.

## Contributing

Contributions are welcome and encouraged. Please create pull request from a
feature branch.

* Fork it
* Create a feature branch
* Push up your branch to your fork
* Create new Pull Request
