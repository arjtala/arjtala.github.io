---
layout: post
---

# Life with 34 keys

<img src="{{ site.baseurl }}/images/ferris_compact_00.jpg"
     alt="ferris compact"
     style="margin-left: auto; margin-right: auto; display: block; width: 50%" /><img src="{{ site.baseurl }}/images/ferris_compact_01.jpg"
     alt="ferris compact"
     style="margin-left: auto; margin-right: auto; display: block; width: 50%" />



Pierre Chevalier’s [ferris family of keyboards][ferris_url] is based on using a 34-key split layout focused on minimalism, portability, and ergonomic comfort. It is fully open-sourced and the firmware is contributed to the QMK project released under GPL. You can print one yourself, purchase a kit to assemlbe (including soldering), or buy a pre-built one and just add keycaps. I first came across this from [Ben Vallack's][ben_vallack] channel where he discusses workflow optimizations including various trials with keyboards.

## Layout

You can use the layout editor at [config.qmk.fm][layout_url] to implement various layers, however you see fit. I currently use the following three layers though this is always an exercise in optimization (much like my [emacs configuration][emacs]). A few notes on the layout:

* I had initially used home-row mods (hrm) meaning that `A`, `S`, `D`, and `F` would be equivalent to `CTRL`, `ALT`, `SHIFT`, `CMD`/`GUI`, and the symmetric equivalent on the other side with `;`, `L`, `K`, and `J`. But as an emacs user I found needing my meta key (`CMD`/`GUI`) and control far more accesible for multiple combinations (e.g. `C-x C-r` for opening a recent file, where `C-` means holding down `CTRL`), and so the hrm setup meant having to switch whihc `CTRL` key I was holding down depening on what the action was. This is still fine for `SHIFT` and `ALT`, however.
* `LT(N,X)`: this lets me switch to layer `N` when held, otherwise the input is `X`. I've mapped the layer `1` and `TAB` on the left thumb key; and layer `2` and `RETURN` on the right thumb key
* I do think there is plenty of room for optimization, and I'm still techinically faster on a standard keyboard (loving my [Happy Hacking Keyboard][hhk]) but the fact that my hands almost never have to move is a huge benefit.

<img src="{{ site.baseurl }}/images/keymap_diagram.svg"
     alt="ferris compact"
     style="margin-left: auto; margin-right: auto; display: block; width: 75%" />


## QMK

I use the v0.2 Ferris Compact, and though it's marked as [experimental][qmk_0_2], I've had no issues compiling and flashing the board. 
You can find plenty of documentation regarding QMK on the [official website][qmk_url].

### Compiling the source and flashing the board

Replace the following variables in the `build.sh` script:
* `QMK_FIRMWARE_DIR`: location of the QMK source
* `LAYOUT`: name for your layout
* `LAYOUT_FILE`: filename of your JSON layout

#### Build
{% highlight bash %}
#!/bin/sh

QMK_FIRMWARE_DIR=$HOME/src/qmk_firmware
LAYOUT=arj_ferris
LAYOUT_FILE=./ferris_compact_v01.json
CURRENTDIR=`pwd`

mkdir -p $QMK_FIRMWARE_DIR/keyboards/ferris/keymaps/$LAYOUT/
cp layouts/$LAYOUT/keymap.c $QMK_FIRMWARE_DIR/keyboards/ferris/keymaps/$LAYOUT/keymap.c
cp layouts/$LAYOUT/$LAYOUT_FILE $QMK_FIRMWARE_DIR/keyboards/ferris/keymaps/$LAYOUT/$LAYOUT_FILE

cd $QMK_FIRMWARE_DIR
qmk compile -kb ferris/0_2/compact -km $LAYOUT
cd $CURRENTDIR
{% endhighlight %}

#### Flash
{% highlight bash %}
#!/bin/sh

source build.sh
qmk flash -kb ferris/0_2/compact -km $LAYOUT
{% endhighlight %}

[ferris_url]: https://github.com/pierrechevalier83/ferris
[layout_url]: https://config.qmk.fm/#/ferris/0_2/compact/LAYOUT_split_3x5_2
[qmk_url]: https://qmk.fm/
[ben_vallack]: https://www.youtube.com/watch?v=8wZ8FRwOzhU
[emacs]: http://github.com/arjtala/dotfiles_emacs
[hmk]: https://happyhackingkb.com/jp/
[qmk_0_2]: https://github.com/qmk/qmk_firmware/pull/12133
