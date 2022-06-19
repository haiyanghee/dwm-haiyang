# dwm-haiyang
my own dwm setup

**Note:** This `dwm` setup assumes you have **`libxft-bgra`** installed, which is a fix for `libxft` colored emoji rendering problem. It is available from the [AUR](https://aur.archlinux.org/packages/libxft-bgra/). You can also do this for `dmenu`. Luke has a detailed [tutorial](https://www.youtube.com/watch?v=0QkByBugq_4).

After you install **`libxft-bgra`**, you will also need to add the emoji font to the `static const char *fonts[]` array in `dwm`'s `config.h`. For example, if you are using Noto Color Emojies, you should add something like `"Noto Color Emoji:pixelsize=11:antialias=true:autohint=true"` to the array, which is what I have for my `dwm` config.

To install dwm: `sudo make clean install`

To add patches: `patch -p1 < path/to/patch.diff`. More information can be found on https://suckless.org/hacking/

To change the config, go to `config.h`.
The tags added (most of them at least) are in `config.h` file.

# Patches
Here are the patches I have used (might be missing some but here are most of them):
- hide other windows in monocle! Found in this [link](https://github.com/bakkeby/patches/blob/master/dwm/dwm-alpha_monocle_layout-6.2.diff) (original [Reddit link](https://www.reddit.com/r/suckless/comments/jiyl4h/hiding_background_windows_in_monocle_and_deck/))
    - this [link](https://github.com/theniceboy/dwm-hide-and-restore-win.diff) might also be useful for some people

- movestack
- keypress
- shiftview (got from "next prev tag")
- gaps
- useless gap (removed the condition where no borders are shown when there is only one window, because that way I can know if its in monocle mode or not)
- systray
- attach above
- pertag
- fake fullscreen  (comment out the lines where the floating parameter are changed and the calls to resize function)
- focus adjacent tag (added my own code so i can move the windows circular)
- alpha-fixborders  (because I can't make alpha working, so I just used the fix borders patch)
- zoomswap
- decoration hints (tbh idk what this really does)
- winview (pretty cool but not gona use often)
- sshawarespawn (if current terminal is ssh, will open new ssh term! very cool)
- restartsig (I like the signal approach to reload dwm)

## Patch issues

In the `movestack` patch, there is a issue if you do `movestack, {.i = +1}` in the `config.h` (which I have in my config), if you press the corresponding key binding in an empty tag, it will crash dwm. So I added the following lines in `movestack.c`:
```
	if(arg->i > 0) {
    // prevent crashing on no-window tag
    if (selmon->sel == NULL)
        return;
``` 
this should prevent the issue..

## TODOs
- I thought I fixed the full screen/monocle bug (where some apps like zoom or teams will go out of the screen with duo monitors, and it will go out by the size of the gap between windows), but I'm not sure if its an application thing since most apps work fine ... will look into it
- restart dwm (probably the signal patch is good enough)
- swallow (look into what does the dynamic swallow do, but I don't think I'll need it)
- scratch pad (good to have multiple ones, not sure if will get the dynamic one or not)
