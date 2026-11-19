# 2. The car folder

![Level](https://img.shields.io/badge/level-beginner-2ea44f)

Every car lives in `assettocorsa/content/cars/<car_id>/`. The folder name is the car ID. Scripts and configs refer to the car by it, so do not rename it after you started working on a car.

```
my_car/
  my_car.kn5            3D model shown at normal distance
  my_car_lod_b.kn5      optional lower detail models (lod_b, lod_c, ...)
  data.acd              packed physics data (or an unpacked data/ folder)
  data/                 unpacked physics, used instead of data.acd if present
  extension/            CSP config, Lua scripts, extra textures
  skins/                one folder per paint scheme
  sfx/                  FMOD sound banks (.bank) and GUIDs.txt
  ui/                   ui_car.json, badge.png, preview images per skin
  animations/           .ksanim files (doors, wipers, wing)
  driver3d.ini          driver model position
  body_shadow.png ...   baked shadows
```

## data / data.acd

`data.acd` is an encrypted archive of the `data` folder. Content Manager can unpack it (look for *Unpack data* on the car's page in CM), which creates a `data` folder next to it. To be sure the game reads your edited files and not the archive, rename `data.acd` to something like `data.acd.bak` while you work.

Files you will edit most:

| File | Contains |
|------|----------|
| `car.ini` | Mass, fuel, steering lock, inertia |
| `engine.ini` | Power curve reference, limiter, turbo |
| `power.lut` | Torque over RPM |
| `drivetrain.ini` | Gear ratios, differential, traction type |
| `suspensions.ini` | Geometry, springs, dampers |
| `tyres.ini` | Tyre model |
| `lights.ini` | Which meshes light up for headlights and brake lights |
| `digital_instruments.ini` | Simple built-in digital displays (the old way, before CSP) |

Physics edits only apply when you start a new session.

> [!WARNING]
> Online servers check the physics checksum. A car with modified physics will not be allowed on servers that use the original version.

## extension

This is where CSP looks for car specific things:

- `ext_config.ini` - the main CSP config for the car (tutorial 3)
- `*.lua` - scripts for displays, sounds and logic (tutorials 4 and 5)
- textures (`.dds`, `.png`) used by those configs and scripts

CSP also has its own built-in configs for many popular cars. If a car has no `extension` folder but still has CSP features, those come from CSP's shared config. A local `ext_config.ini` takes priority.

## skins

Each subfolder in `skins/` is one paint scheme. It contains textures that replace those in the `.kn5` with the same file name, plus `ui_skin.json` and `preview.jpg`. CM's *Skins* tab can generate previews for you.

## ui

`ui/ui_car.json` holds name, brand, class, specs and the power and torque curve shown in the menu. If this file is invalid JSON, the car disappears from the list. CM shows the error and can often fix it.

## sfx

Car sounds are an FMOD bank: `sfx/<car_id>.bank` plus `GUIDs.txt`. Many mods reuse sounds from a Kunos car. Then the bank and GUIDs only point to that car and are only a few KB. To make your own, use the audio SDK in `assettocorsa/sdk/audio`.

---

[← 1. Installing mods](01-installing-mods.md) · [Index](../README.md) · [3. ext_config.ini basics →](03-ext-config-basics.md)
