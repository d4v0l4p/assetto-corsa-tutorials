# Example: Top Speed app

A small Lua app that shows your current speed and your top speed since the last reset. It has a settings window (km/h or mph, number of decimals) that is saved between sessions.

What it shows you:

- `manifest.ini` with one window and a settings button
- `ui.Font.Huge`, buttons, a checkbox and a slider
- `ac.storage` for saved settings
- `LAZY = PARTIAL`, so the top speed is kept when you close the window

## Install

Copy the `TopSpeed` folder to `assettocorsa/apps/lua/`, so you end up with:

```
assettocorsa/apps/lua/TopSpeed/manifest.ini
assettocorsa/apps/lua/TopSpeed/TopSpeed.lua
assettocorsa/apps/lua/TopSpeed/icon.png
```

Start a session and open *Top Speed* from the app bar on the right side of the screen.

See [tutorial 13](../../tutorials/13-lua-apps.md) for how it works.
