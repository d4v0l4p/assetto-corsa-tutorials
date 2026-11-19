# 3. ext_config.ini basics

`content/cars/<car_id>/extension/ext_config.ini` tells CSP what to do with a car: which meshes glow, which shaders to swap, where screens are and which scripts run. It uses an extended INI format (CSP calls it INIpp).

Always keep a backup before editing, for example `ext_config.backup_2026-11-19.ini`. CSP only reads the file called `ext_config.ini`, so backups next to it do no harm.

## Sections and the `...` suffix

A section name says what kind of thing you are configuring. Many section types can appear several times. Instead of numbering them yourself (`_0`, `_1`, `_2`), write `...` and CSP numbers them for you:

```ini
[EMISSIVE_LIGHT_...]
NAME = dash_backlight
COLOR = 1, 1, 1, 3
OFF_COLOR = 0.5, 0.5, 0.5, 2

[EMISSIVE_LIGHT_...]
NAME = ambient_strip_left, ambient_strip_right
COLOR = 0, 0, 5
```

Lists are comma separated. `?` works as a wildcard in mesh and material names, for example `EXT_Glass?`.

## Includes

`[INCLUDE: file.ini]` pulls in another file. Paths starting with `common/` point to CSP's shared configs, others are relative to the car's `extension` folder:

```ini
[INCLUDE: common/materials_carpaint.ini]
[INCLUDE: common/materials_glass.ini]
[INCLUDE: my_lights.ini]
```

Splitting a big config into several files makes it much easier to find things later. Do not include the same file twice, the second copy does nothing useful and makes problems harder to trace.

## Common section types

| Section | Use |
|---------|-----|
| `EMISSIVE_LIGHT_...` | Make a mesh glow. Add `BIND_TO_HEADLIGHTS = 1` to light it with the headlights |
| `EMISSIVE_HIGHBEAM_...`, `EMISSIVE_REVERSE_...`, `EMISSIVE_TURNSIGNAL_LEFT_...` | Same, but bound to that car function |
| `EMISSIVE_EXTRA_A_...` | Glows while Extra A is switched on (also B to F) |
| `LIGHT_HEADLIGHT_...`, `LIGHT_BRAKE_...`, `LIGHT_EXTRA_...` | Real light sources that light up the world |
| `MATERIAL_ADJUSTMENT_...` | Change material values (specular, reflections) without editing the kn5 |
| `SHADER_REPLACEMENT_...` | Swap a material's shader or textures |
| `SCRIPTABLE_DISPLAY_...` | Draw a screen with Lua (tutorial 4) |

`COLOR` is red, green, blue and an optional fourth value for brightness. `COLOR = 1, 1, 1, 3` is white at brightness 3. `OFF_COLOR` is the glow when the function is off.

### Blinking

Emissive sections can blink without any script:

```ini
[EMISSIVE_EXTRA_A_...]
NAME = warning_led
COLOR = 1, 0.2, 0.1, 4
BLINKING_PATTERN = (|0=1|0=0|2=1)
BLINKING_DURATION = 0.5
```

### Swapping a texture

```ini
[SHADER_REPLACEMENT_...]
MATERIALS = ext_susp_disc
SHADER = ksBrakeDisc
FILL_MISSING_TEXTURES = 1
RESOURCE_4 = txGlow
RESOURCE_FILE_4 = brake_disc_glow.dds
```

`RESOURCE_FILE_4` is looked up in the `extension` folder.

## Finding mesh and material names

Every section needs the exact mesh (`NAME`, `MESHES`) or material (`MATERIALS`) name from the model. Ways to find them:

- **CSP Objects Inspector.** A CSP developer app (developer apps can be enabled in CM's CSP settings). Open it in game and pick a part of the car to see its mesh and material.
- **CM Custom Showroom.** Open the car's showroom in CM and use the object tree on the side.
- **ksEditor** from `assettocorsa/sdk/editor` lists all meshes and materials of a kn5.

Names on converted models are often very long, for example `lodAB_Interior_01a_A_L_ScreensA_1_NoFibre_NoSurface_NoSkin_Geo.002`. Copy them, do not type them.

## Applying changes

CSP reloads `ext_config.ini` when you restart the session. Many changes also apply live while the game runs, but if something does not update, restart the session before you start looking for a mistake.

Next: [scriptable displays](04-scriptable-displays.md).
