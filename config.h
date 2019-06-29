/* See LICENSE file for copyright and license details. */

/*
  A list of patches that I have used:
  * movestack
  * keypress
  * shiftview (got from "next prev tag")
  * singlular borders
  * gaps
  * systray
  * attach above
  * fake fullscreen (does not work for me because im bad, so i modified the patch a bit to make it workign for me )
*/

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int gappx     = 3;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=11" };
static const char dmenufont[]       = "monospace:size=11";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_green[]        = "#22d661";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_green  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
	{ "chromium",  NULL,      NULL,       0,       		0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
//#define MODKEY Mod1Mask
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{KeyPress,  MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{KeyPress,  MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{KeyPress,  MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{KeyPress,  MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "umeWow",  NULL}; 
//static const char *scrShot[]  = { "scrot", "~/Screenshots/%s_%H%M_%d.%m.%Y_$wx$h.png", NULL}; 
//static const char *scrShotWindow[]  = { "scrot", "-u", "~/Screenshots/%s_%H%M_%d.%m.%Y_$wx$h.png", NULL}; 

static const char *scrShot[] = { "scrot", "%Y-%m-%d-%H%M%S.png", "-e", "mv $f ~/Screenshots", NULL };
static const char *scrShotWindow[]  = { "scrot", "-u", "%Y-%m-%d-%H%M%S.png", "-e", "mv $f ~/Screenshots", NULL }; 


static const char *chromecmd[]  = { "chromium",  NULL}; 

#include "movestack.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{KeyPress,  MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{KeyPress,  MODKEY,             			XK_Return, spawn,          {.v = termcmd } },
	{KeyPress,  MODKEY,             			XK_n, 		spawn,         {.v = chromecmd } },
	{KeyPress,  MODKEY,                       XK_b,      togglebar,      {0} },
	{KeyPress,  MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{KeyPress,  MODKEY,                       XK_k,      focusstack,     {.i = -1 } },


	{KeyPress,  MODKEY|ShiftMask,             XK_l,      shiftview,      {.i = +1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_h,      shiftview,      {.i = -1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_Right,  shiftview,      {.i = +1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_Left,   shiftview,      {.i = -1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_Down,   movestack,      {.i = +1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_Up,     movestack,      {.i = -1 } },
	{KeyPress,   0,              			  XK_Print,  spawn,      	{.v = scrShot} },
	{KeyPress,  MODKEY,               		  XK_Print,  spawn,      	{.v = scrShotWindow} },


	{KeyPress,  MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{KeyPress,  MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{KeyPress,  MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{KeyPress,  MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{KeyPress,  MODKEY|ShiftMask,                       XK_Return, zoom,           {0} },
	{KeyPress,  MODKEY,                       XK_Tab,    view,           {0} },
	{KeyPress,  MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{KeyPress,  MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{KeyPress,  MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{KeyPress,  MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{KeyPress,  MODKEY,                       XK_space,  setlayout,      {0} },
	{KeyPress,  MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{KeyPress,  MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{KeyPress,  MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{KeyPress,  MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{KeyPress,  MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{KeyPress, MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkTagBar,            0,              Button4,        shiftview,     { .i = -1 } },
	{ ClkTagBar,            0,              Button5,        shiftview,     { .i = +1 } },
};

