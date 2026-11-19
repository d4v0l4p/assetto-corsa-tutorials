# 3. ext_config.ini basics

![Level](https://img.shields.io/badge/level-beginner-2ea44f) ![Needs](https://img.shields.io/badge/needs-CSP-e10600)

`content/cars/<car_id>/extension/ext_config.ini` tells CSP what to do with a car: which meshes glow, which shaders to swap, where screens are and which scripts run. It uses an extended INI format (CSP calls it INIpp).

Always keep a backup before editing, for example `ext_config.backup_2026-11-19.ini`. CSP only reads the file called `ext_config.ini`, so backups next to it do no harm.

## Sections and the `...` suffix

A section name says what kind of thing you are configuring. Many section types can appear several times. Instead of numbering them yourself (`_0`, `_1`, `_2`), write `...` and CSP numbers them for you:

```ini
[EMISSIVE_BRAKE_...]
NAME = taillight_left, taillight_right
COLOR = 15, 0, 0

[EMISSIVE_REVERSE_...]
NAME = reverse_light
COLOR = 25, 25, 25
LAG = 0.2
```

Lists are comma separated. `?` works as a wildcard in mesh and material names, for example `EXT_Glass?`.

> [!NOTE]
> `ext_config.ini` is read by INIpp, CSP's own INI preprocessor. Everything in this tutorial is plain INI, the extra features (variables, templates) are in [tutorial 12](12-inipp.md).

## Includes

`[INCLUDE: file.ini]` pulls in another file. Paths starting with `common/` point to CSP's shared configs, others are relative to the car's `extension` folder:

```ini
[INCLUDE: common/materials_carpaint.ini]
[INCLUDE: common/materials_glass.ini]
[INCLUDE: my_lights.ini]
```

Splitting a big config into several files makes it much easier to find things later. Each file is only included once, a second `[INCLUDE]` of the same file is ignored.

## Common section types

| Section | Use |
|---------|-----|
| `EMISSIVE_LIGHT_...` | Glows with the headlights. `OFF_COLOR` sets the glow while they are off |
| `EMISSIVE_BRAKE_...`, `EMISSIVE_REVERSE_...`, `EMISSIVE_TURNSIGNAL_LEFT_...` | Glow with that car function |
| `EMISSIVE_EXTRA_A_...` | Glows while Extra A is switched on (also B, C, D) |
| `LIGHT_HEADLIGHTS`, `LIGHT_BRAKES`, `LIGHT_EXTRA_...` | Real light sources that light up the world |
| `MATERIAL_ADJUSTMENT_...` | Change material values (specular, reflections) without editing the kn5 |
| `SHADER_REPLACEMENT_...` | Swap a material's shader, textures or properties |
| `SCRIPTABLE_DISPLAY_...` | Draw a screen with Lua (tutorial 4) |

All emissive and light types are explained in [tutorial 9](09-lights-and-emissives.md).

`COLOR` is red, green, blue and an optional fourth value that multiplies the first three. `COLOR = 1, 1, 1, 3` is white at brightness 3. `OFF_COLOR` is the glow when the function is off.

### Blinking

Emissive sections can blink without any script:

```ini
[EMISSIVE_EXTRA_A_...]
NAME = warning_led
COLOR = 25, 4, 0
BLINKING_PATTERN = (|0=1|0.5=0.8|1=1|2=0.6|3=0.8|3.5=1)
BLINKING_DURATION = 2
```

### Changing a texture or a material value

```ini
[SHADER_REPLACEMENT_...]
MATERIALS = your_material_name
RESOURCE_0 = txDiffuse
RESOURCE_FILE_0 = custom_diffuse.dds    ; looked up in the extension folder
PROP_... = ksSpecular, 1.0
PROP_... = ksSpecularEXP, 50
```

> [!TIP]
> Target `MATERIALS` instead of `MESHES` where you can. When you change properties or textures by mesh, CSP has to create a new material for every mesh. (From the CSP [tips and tricks](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Tips-and-tricks).)

For materials there are ready-made PBR templates like `Material_CarPaint_Metallic` or `Material_Leather_v2`. They are all listed with every value in the [CSP PBR reference](../reference/csp-pbr-materials.ini).

## Two tips from the CSP author

- **Always have a proper `COCKPIT_HR` node.** CSP uses it all the time to tell interior from exterior: for guessing lights, interior masking and rear view mirror reflections.
- **Thin parts that should cast shadows from both sides** (light housings, panels):

  ```ini
  [SHADER_REPLACEMENT_...]
  MESHES = taillight_housing, boot_cover
  DOUBLE_FACE_SHADOW_BIASED = 1
  ```

  Do not overuse it, every mesh with it takes longer to draw into the shadow map.

## Finding mesh and material names

Every section needs the exact mesh (`NAME`, `MESHES`) or material (`MATERIALS`) name from the model. Ways to find them:

- **CSP Objects Inspector.** A CSP developer app (developer apps can be enabled in CM's CSP settings). Open it in game and pick a part of the car to see its mesh and material.
- **CM Custom Showroom.** Open the car's showroom in CM and use the object tree on the side.
- **ksEditor** from `assettocorsa/sdk/editor` lists all meshes and materials of a kn5.

> [!TIP]
> Names on converted models are often very long and full of numbers. Copy them, do not type them. A single wrong character and the section silently does nothing.

## Applying changes

CSP reloads `ext_config.ini` when you restart the session. Many changes also apply live while the game runs, but if something does not update, restart the session before you start looking for a mistake.

---

[← 2. The car folder](02-car-folder.md) · [Index](../README.md) · [4. Scriptable displays →](04-scriptable-displays.md)
