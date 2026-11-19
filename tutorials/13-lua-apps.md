# 13. Lua apps

![Level](https://img.shields.io/badge/level-intermediate-d29922) ![Needs](https://img.shields.io/badge/needs-CSP%200.1.76%2B-e8590c)

Since CSP 0.1.76 you can write in-game apps in Lua (Lua 5.1 with LuaJIT) instead of Python. They are faster, have access to far more of the game and use the same API as car scripts.

Source: Lua SDK wiki page [Lua apps](https://github.com/ac-custom-shaders-patch/acc-lua-sdk/wiki/Lua-apps). A ready to use example is in [`examples/lua-app-top-speed`](../examples/lua-app-top-speed).

## Folder layout

```
assettocorsa/apps/lua/MyFirstApp/
  manifest.ini       app name, windows, callbacks
  MyFirstApp.lua     the script, same name as the folder
  icon.png           taskbar icon
```

## manifest.ini

```ini
[ABOUT]
NAME = Hello World App
AUTHOR = Your name
VERSION = 1.0
DESCRIPTION = My first Lua app for Assetto Corsa

[CORE]
LAZY = FULL

[WINDOW_...]
ID = main
NAME = Hello World
ICON = icon.png
FUNCTION_MAIN = windowMain
FUNCTION_SETTINGS = windowSettings
SIZE = 400, 200
FLAGS = SETTINGS
```

### LAZY: when the app is loaded

| Value | Behaviour |
|---|---|
| `NONE` (default) | Loaded with the game, runs until it closes |
| `PARTIAL` | Loaded the first time a window opens, then keeps running |
| `FULL` | Loaded when a window opens, unloaded completely when all windows are closed |

> [!WARNING]
> When an app unloads, all its variables are gone. Keep anything you need later in `ac.storage()`, or use `PARTIAL` if the user could lose unsaved work by closing the window.

### Window flags

A selection of the values for `FLAGS` (comma separated):

| Flag | Effect |
|---|---|
| `SETTINGS` | Adds a settings button that opens `FUNCTION_SETTINGS` |
| `AUTO_RESIZE` | Window grows and shrinks with its content |
| `FIXED_SIZE` | User cannot resize |
| `NO_BACKGROUND` | Transparent background, for HUD style apps |
| `NO_TITLE_BAR` | Hides the title bar |
| `FADING` | Fades out when not in use, like the chat app |
| `HIDDEN_OFFLINE` / `HIDDEN_ONLINE` | Only show the window online or offline |
| `HIDDEN_RENDER_VR` | Hide in VR |
| `MAIN` | Marks the main window if there are several |

Other window keys: `MIN_SIZE`, `MAX_SIZE`, `PADDING`, `FUNCTION_ON_SHOW`, `FUNCTION_ON_HIDE`, `FUNCTION_ICON` (draws a dynamic icon).

## The script

```lua
function script.windowMain(dt)
  ui.text('Hello world!')
end

function script.windowSettings(dt)
  -- settings window content
end

function script.update(dt)
  -- every frame, even when no window is open. Keep it light.
end
```

### How the UI works

CSP uses [Dear ImGui](https://github.com/ocornut/imgui), an **immediate mode** UI. You do not create a button once and keep it around. Every frame you call `ui.button('Label')`, which draws the button at the cursor and returns `true` in the frame it was clicked:

```lua
local count = 0

function script.windowMain(dt)
  ui.text('Clicked ' .. count .. ' times')
  if ui.button('Click me') then
    count = count + 1
  end
end
```

## More callbacks

```ini
[SIM_CALLBACKS]
FRAME_BEGIN = onFrameBegin   ; before the scene renders (move the camera here)
UPDATE = onSimUpdate         ; after a full simulation update

[RENDER_CALLBACKS]
OPAQUE = draw3D              ; after opaque geometry, for debug shapes in the world
TRANSPARENT = draw3D

[UI_CALLBACKS]
IN_GAME = drawHud            ; full screen UI, e.g. a custom HUD
```

> [!NOTE]
> `IN_GAME` does not run inside a window. Create one first with `ui.transparentWindow()` or `ui.toolWindow()` before drawing.

## Permissions

Lua apps, like other scripts the user installs on purpose, have full I/O: they can read and write files, start processes and use sockets. Car, track and online scripts do **not** have that access. Content Manager warns about this when installing scripts.

## Learn from the built-in apps

The apps in CSP's App Shelf are open source in [app-csp-defaults](https://github.com/ac-custom-shaders-patch/app-csp-defaults), for example Radar, Flashlight, Internet Radio, Rally Copilot, Setup Exchange, Time Shift and Web Browser. The [Paintshop](https://github.com/ac-custom-shaders-patch/app-paintshop) app is a bigger example with brushes, mirroring and pen pressure.

---

[← 12. Advanced configs with INIpp](12-inipp.md) · [Index](../README.md) · [14. Lua: moving parts and materials →](14-lua-scene-objects.md)
