# dwm-haiyang
my own dwm setup

**Note:** This dwm setup assumes you have **`libxft-bgra`** installed, which is a fix for libxft colored emoji rendering problem. It is available from the [AUR](https://aur.archlinux.org/packages/libxft-bgra/). You can also do this for `dmenu`. Luke has a detailed [tutorial](https://www.youtube.com/watch?v=0QkByBugq_4).

After you install **`libxft-bgra`**, you will also need to add the emoji font to the `static const char *fonts[]` array in dwm's `config.h`. For example, if you are using Noto Color Emojies, you should add something like `"Noto Color Emoji:pixelsize=11:antialias=true:autohint=true"` to the array, which is what I have for my dwm config.

To compile dwm: `sudo make clean install`

To add patches: `patch -p1 < path/to/patch.diff`. More information can be found on https://suckless.org/hacking/

To change the config, go to `config.h`.
The tags added (most of them at least) are in `config.h` file.
