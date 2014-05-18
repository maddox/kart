# Kart!!

Kart is a frontend to the amazing multi-emulating system
[RetroArch](https://github.com/libretro/RetroArch).

Kart aspires to be an extremely simple front end that lets you get up and
running fast with a classy way to pick and choose your games.

Kart is targeted at running on a TV in an HTPC type set up, but can be run from
a desktop window just fine.

![kart emulator retroarch frontend](https://cloud.githubusercontent.com/assets/260/2924359/aec71d2e-d731-11e3-8bee-97b6e1b60680.png)
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

## How To Use

Kart is very simple right now. To use it, click on the settings button and set
your paths.

### Settings

There are only 2 settings for Kart right now. That's all it needs!

* **RetroArch Path** - The path to your RetroArch bundle. The root directory
where all of your RetroArch things are.
* **Roms Path** - The path to your roms.

### Convention over Configuration

Kart follows a model of Convention over Configuration. Instead of making you
specify a million different things or keeping a library of metadata, Kart makes
certain assumptions. This means as long as you follow some set guidelines, it's
very easy to set up.

For example, the name of a game is taken from it's rom's filename. The art for
the game should have the same name as the rom. By using this convention, its easy
to load in all of your roms without a complicated scanning process.

#### tl;dr

Configuring Kart is actually pretty easy, here's the gist:

* set up your console and rom directories right
* name your roms the titles you want them to appear in Kart
* add an `/images` directory for each console with `PNG` art that match the rom
filenames
* add an `image.png` image for each console
* set the paths for your roms and RetroArch bundle

#### Rom Directories

Your roms should be organized into directories based on the console they are for.
You should have a single rom directory that contains them. Your rom directory
hierarchy should look like this:

```
/roms
  /gb
  /gba
  /megadrive
  /nes
  /snes
    /Super Mario World.smc
```

Your rom names should be named exactly how you want to them appear in Kart.

##### Rom Art Directories

Art for your roms should be inside a directory named `images` within each
console's directory. Art for each rom should have the exact same file name as
the rom it's for. The art should also be a `PNG`.

```
/roms
  /snes
    /images
      /Super Mario World.png
```

Simply add this directory and add the art for all of the roms you want to show
up.

Kart uses Steam styled art. You can find art for your games all over the
internet, but the easiest place to find it is http://steambanners.booru.org.


#### Supported Consoles

Right now, kart only supports these consoles (directory names are in
  parenthesis):

* Super Nintendo Entertainment System (/snes)
* Nintendo Entertainment System /(nes)
* GameBoy and GameBoy Color (/gb)
* GameBoy Advance (/gba)
* Sega Genesis (/megadrive)

##### Console Art

Add an `image.png` image to a console's directory to set it's art.


#### Key Navigation

Kart supports browsing by the keyboard.

The keys `up`, `down`, `left`, `rigth`, `enter`, `esc` all do exactly what you'd
think they do.

In addition, `backspace` is an alias for `esc` to allow you to map controls
better.

For best results, use a keyboard mapper to map your joystick/controller to these
keys so you can navigate Kart with your controller.

#### RetroArch Configuration

In the future, Kart will provide it's own bundled version of RetroArch or the
ability to download a pre-configured one. But for now you need to use your own.

There are a few assumptions made about your RetroArch setup.

First, every console needs to have it's own config. Inside that config should
have a setting for the libretro emulator core you want to use.

For example for :

```
libretro_path = "/Applications/retroarch/libretro/libretro-snes9x-next.dylib"
```

The `libretro_path` is the minimum required setting, but you can add any extra
settings that you want. This may be different key settings, filters, or whatever.

Your config hierarchy should look like this:

```
/retroarch
  /config
    /gb
    /gba
    /megadrive
    /nes
    /snes
      /retroarch.cfg
```

Again, in the future this will be simpler.


## Roadmap

Kart is in it's early days. It's extremely simple right now, but there are lots
of plans.

* Browse by Console
* Browse Recently Played Games
* Set and Browse Favorites
* Bundled RetroArch distribution
* Better full screen support
* Better first run experience
* Everything better, lulz

Hopefully, by the time Kart is more mature, downloading it and setting it up
will be easy as pie.


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
