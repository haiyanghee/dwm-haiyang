# dwm-haiyang
my own dwm setup

**Note:** This dwm setup assumes you have **`libxft-bgra`** installed, which is a fix for libxft colored emoji rendering problem. It is available from the [AUR](https://aur.archlinux.org/packages/libxft-bgra/). You can also do this for `dmenu`. Luke has a detailed [tutorial](https://www.youtube.com/watch?v=0QkByBugq_4).

After you install **`libxft-bgra`**, you will also need to add the emoji font to the `static const char *fonts[]` array in dwm's `config.h`. For example, if you are using Noto Color Emojies, you should add something like `"Noto Color Emoji:pixelsize=11:antialias=true:autohint=true"` to the array, which is what I have for my dwm config.

To compile dwm: `sudo make clean install`

To add patches: `patch -p1 < path/to/patch.diff`. More information can be found on https://suckless.org/hacking/

To change the config, go to `config.h`.
The tags added (most of them at least) are in `config.h` file.

# Patches
Here are the patches I have used (might be missing some but here are most of them):
- movestack
- keypress
- shiftview (got from "next prev tag")
- gaps
- useless gap (removed the condition where no borders are shown when there is only one window, because that way I can know if its in monocle mode or not)
- systray
- attach above
- fake fullscreen  (comment out the lines where the floating parameter are changed and the calls to resize function)
- focus adjacent tag (added my own code so i can move the windows circular)
- alpha-fixborders  (because I can't make alpha working, so I just used the fix borders patch)

## Patch issues

In the `movestack` patch, there is a issue if you do `movestack, {.i = +1}` in the `config.h` (which I have in my config), if you press the corresponding key binding in an empty tag, it will crash dwm. So I added the following lines in `movestack.c`:
```
	if(arg->i > 0) {
    // prevent crashing on no-window tag
    if (selmon->sel == NULL)
        return;
``` 
this should prevent the issue..
