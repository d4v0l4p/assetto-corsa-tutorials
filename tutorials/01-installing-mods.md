# 1. Installing mods

![Level](https://img.shields.io/badge/level-beginner-2ea44f)

## What you need

1. **Assetto Corsa** from Steam. The base game is enough. The Ultimate Edition adds Kunos DLC cars and tracks that some mods depend on.
2. **Content Manager (CM)**. Download it from [assettocorsa.club](https://assettocorsa.club/content-manager.html), put `Content Manager.exe` in its own folder (not inside the game folder) and start it. On first start it asks for the game folder, usually:
   ```
   C:\Program Files (x86)\Steam\steamapps\common\assettocorsa
   ```
3. **Custom Shaders Patch (CSP)**. In CM go to *Settings > Custom Shaders Patch* and install the latest version. Most modern car mods need CSP, and everything in tutorials 3 to 6 does.

Optional but common: a weather and lighting mod such as Pure or Sol. Install it the same way as other mods and select it under *Settings > Custom Shaders Patch > Weather FX*.

## Installing a car or track

The easiest way: drag the downloaded `.zip`, `.rar` or `.7z` onto the Content Manager window. CM looks inside the archive, shows what it found and installs it to the right place. Click *Install*.

Manual install, if you prefer:

| Content | Goes to |
|---------|---------|
| Cars | `assettocorsa/content/cars/<car_folder>` |
| Tracks | `assettocorsa/content/tracks/<track_folder>` |
| Fonts | `assettocorsa/content/fonts` |
| Apps (Python) | `assettocorsa/apps/python/<app>` |
| Apps (Lua) | `assettocorsa/apps/lua/<app>` |

> [!TIP]
> A car folder is correct when it directly contains `data.acd` (or a `data` folder), one or more `.kn5` files and a `ui` folder. If you see another folder with the same name inside it, you unpacked one level too deep. Move the inner folder up.

## Typical problems

**The car does not show up in the list.** The folder is nested too deep, or `ui/ui_car.json` is missing or broken. CM shows broken cars with a warning icon in the car list.

**The game crashes when loading the car.** Usually a missing dependency: a newer CSP version, a track the car needs for something, or a sound bank (`sfx` folder) that was not included. Read the mod's description and check `Documents/Assetto Corsa/logs/log.txt`, the last lines usually name the file that failed.

**Black or missing textures.** The skin folder in `skins/` is empty or uses a different name than in `ui`. Try another skin first. If all skins are broken, the `.kn5` was packed without textures.

**Car is too fast, too slow or drives strangely.** Physics are in `data.acd`. Some mods only work properly with a specific CSP version because they use extended physics. Check the mod page.

## Keep a clean install

- Before you change a mod, copy its folder somewhere safe (outside `content/cars`, or CM lists the copy as a second car).
- Remove mods you do not use. Hundreds of cars make CM and the game start slower.
- Name your own edits clearly, for example `ext_config.backup_2026-11-19.ini`, so you can go back.

---

[Index](../README.md) · [2. The car folder →](02-car-folder.md)
