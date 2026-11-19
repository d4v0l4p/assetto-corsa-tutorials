# 6. Troubleshooting

![Level](https://img.shields.io/badge/level-beginner-2ea44f) ![Needs](https://img.shields.io/badge/needs-CSP-e10600)

## Where the logs are

| Log | Location |
|-----|----------|
| Game log | `Documents/Assetto Corsa/logs/log.txt` |
| CSP log | `Documents/Assetto Corsa/logs/custom_shaders_patch.log` |

Both are rewritten on every start, so look at them right after the problem happened. Search for your script's file name or for `error`.

From a Lua script you can write your own lines:

```lua
ac.log('speed: ' .. car.speedKmh)
ac.warn('something looks wrong')
ac.error('this should never happen')
```

The CSP *Lua Debug* developer app shows these messages live in game, together with errors from your scripts.

## The screen stays black or shows the original texture

1. **Wrong mesh name.** Check `MESHES` letter by letter, or better copy it again from the Objects Inspector. A typo fails silently.
2. **Script error.** If the script fails to load, nothing is drawn. Look in the Lua Debug app or the CSP log for the line number.
3. **Wrong resolution or region.** If you draw outside the area the mesh UVs use, you see nothing. Draw the test grid from tutorial 4.
4. **Two displays on one mesh.** Search `ext_config.ini` and all included files for the mesh name. Comment out duplicates with `;`.
5. **Too dark.** The script works but the mesh is not emissive. Add an `[EMISSIVE_LIGHT_...]` for it with `OFF_COLOR` equal to `COLOR`, otherwise it only glows with the headlights on.

## General CSP problems

From the [CSP troubleshooting page](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/General-%E2%80%93-Troubleshooting):

| Problem | Fix |
|---|---|
| Anything strange after an update | Run the Steam integrity check. It does not remove installed mods, it only restores changed game files |
| `Can't find "\python33\PyObject_CallFunction"` | Install (or reinstall) the Microsoft Visual C++ 2010 Redistributable x64 |
| Image flipped or split into two big triangles (AMD) | Enable *Resolve MSAA for color* in Extra FX settings |
| "GPU may be overheating or overclocked" | Disable *Use DXGI Flip Model* in CSP's General settings |
| Slight flicker on parts of a track or car | Disable *Use proper physically-based sampling* in Reflections FX |

## A section does nothing

- **Typo in the section name.** `[EMMISIVE_LIGHT_...]` is just ignored.
- **Wrong file.** CSP reads `extension/ext_config.ini` plus what it includes. A change in a backup copy has no effect.
- **Overwritten later.** If the same mesh is configured twice, the later section usually wins. Search the whole file.
- **Stray text after a value.** Comments start with `;`. Anything else after a value becomes part of it.

## The script runs but values look wrong

- `car.gear` is `-1` for reverse and `0` for neutral, so "first gear" is `1`.
- `car.rpm` can briefly go above `car.rpmLimiter` when the limiter cuts in. Clamp before you use it for a bar.
- Speed is `car.speedKmh`. For mph multiply by `0.621371`.

## Performance drops after adding a script

- Use `SKIP_FRAMES` on displays that do not need every frame.
- Cache values instead of recomputing strings and tables in every `script.update`.
- Combine many small images into one atlas and draw parts of it with `uvStart`/`uvEnd`.
- Large textures cost video memory. A 4096 x 4096 display is rarely needed.

## Still stuck?

Remove things until it works. Comment out half of your new sections, check again, and keep halving. It sounds slow but finds the problem faster than guessing.

---

[← 5. Sounds and inputs](05-sounds-and-inputs.md) · [Index](../README.md) · [7. Animating doors →](07-animating-doors.md)
