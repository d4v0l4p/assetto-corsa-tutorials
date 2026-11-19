# 4. Scriptable displays with Lua

![Level](https://img.shields.io/badge/level-intermediate-d29922) ![Needs](https://img.shields.io/badge/needs-CSP-e8590c)

A scriptable display lets a Lua script draw onto the texture of a mesh, for example the instrument cluster or the center screen. CSP calls the script every frame (or less often, if you tell it to) and the result is shown in game.

## 1. Register the display

In `extension/ext_config.ini`:

```ini
[SCRIPTABLE_DISPLAY_...]
MESHES = cluster_screen          ; mesh to draw on
RESOLUTION = 1024, 512           ; size of the texture in pixels
SCRIPT = cluster.lua             ; file in the extension folder
```

Useful extra keys:

| Key | Effect |
|-----|--------|
| `DISPLAY_POS`, `DISPLAY_SIZE` | Only draw into part of the texture, useful when the mesh UVs only cover a region |
| `SKIP_FRAMES = 1` | Update every second frame. Saves performance on screens that do not need 60 fps |
| `KEEP_BACKGROUND = 1` | Do not clear the texture before each frame. You then have to paint the background yourself |
| `INTERACTIVE = 1` | Track the mouse over the display (for touch screens). Costs extra performance |

The script can also be written inline as `SCRIPT = '...'`, but a separate file is easier to edit.

## 2. Find the right resolution

The script draws in texture pixels, so the resolution should match the texture the mesh uses. Look up the size of the mesh's emissive or diffuse texture (any image viewer shows it for `.dds` files). If you draw at a different aspect ratio, everything on the screen gets stretched.

To see where your pixels end up, draw a test grid first:

```lua
function script.update(dt)
  for x = 0, 1024, 128 do
    display.rect{ pos = vec2(x, 0), size = vec2(2, 512), color = rgbm(1, 0, 0, 1) }
  end
  for y = 0, 512, 128 do
    display.rect{ pos = vec2(0, y), size = vec2(1024, 2), color = rgbm(0, 1, 0, 1) }
  end
end
```

## 3. Draw something

Inside a display script two globals are ready to use:

- `car` - state of the car this display belongs to (`ac.StateCar`)
- `sim` - state of the simulation (`ac.StateSim`)

Fields you will use often: `car.speedKmh`, `car.rpm`, `car.rpmLimiter`, `car.gear` (`-1` reverse, `0` neutral), `car.fuel`, `car.maxFuel`, `car.waterTemperature`, `car.headlightsActive`, `car.extraA`.

Drawing functions from the `display` namespace:

```lua
display.rect{ pos = vec2(x, y), size = vec2(w, h), color = rgbm(r, g, b, a) }

display.image{ image = 'icons/abs.png', pos = vec2(x, y), size = vec2(w, h) }

display.text{
  text = '123',
  pos = vec2(x, y),
  letter = vec2(40, 80),     -- size of one character
  font = 'aria',             -- AC font from content/fonts, or a font folder next to the script
  color = rgbm(1, 1, 1, 1),
  alignment = 0.5,           -- 0 left, 0.5 center, 1 right
  width = 300,               -- needed for center and right alignment
}

display.horizontalBar{ pos = vec2(x, y), size = vec2(400, 30), total = 20, active = 12,
  activeColor = rgbm(1, 1, 1, 1), inactiveColor = rgbm(0.2, 0.2, 0.2, 1) }
```

Image paths are relative to the script's folder.

A minimal speedometer:

```lua
function script.update(dt)
  display.rect{ pos = vec2(0, 0), size = vec2(1024, 512), color = rgbm(0, 0, 0, 1) }
  display.text{
    text = string.format('%d', math.floor(car.speedKmh + 0.5)),
    pos = vec2(312, 180), letter = vec2(80, 160), alignment = 0.5, width = 400,
  }
end
```

A complete cluster with gear, RPM bar, fuel and shift light is in [`examples/scriptable-display`](../examples/scriptable-display).

## 4. Editor setup

Download the [CSP Lua SDK](https://github.com/ac-custom-shaders-patch/acc-lua-sdk) and open it as a library in VS Code with the Lua extension by sumneko (add the SDK folder to `Lua.workspace.library`). You then get autocomplete for `car.`, `display.` and everything else.

## Tips

- **Keep `script.update` light.** It runs every frame. Do string formatting and table building only when a value changes, and use `SKIP_FRAMES` where you can.
- **Timers.** `setInterval(function() ... end, seconds)` runs a function regularly, handy for blinking indicators.
- **Brightness.** The display texture is only as bright as the mesh's emissive setup. If the screen is too dark in game, make the mesh glow. `EMISSIVE_LIGHT` follows the headlights, so set `OFF_COLOR` to the same value as `COLOR` to keep the screen lit in daylight:

  ```ini
  [EMISSIVE_LIGHT_...]
  NAME = cluster_screen
  COLOR = 1, 1, 1, 2
  OFF_COLOR = 1, 1, 1, 2
  ```

  For a real LCD look with a pixel grid and viewing angle color shift, try the `Material_DigitalScreen` template from the [PBR reference](../reference/csp-pbr-materials.ini).
- **One script per screen.** Two `SCRIPTABLE_DISPLAY` sections on the same mesh fight over the texture and flicker.

---

[← 3. ext_config.ini basics](03-ext-config-basics.md) · [Index](../README.md) · [5. Sounds and inputs →](05-sounds-and-inputs.md)
