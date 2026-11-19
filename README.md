# Assetto Corsa Tutorials and Resources

Practical guides for modding Assetto Corsa with Custom Shaders Patch (CSP): installing mods, understanding a car folder, writing `ext_config.ini`, and building animated in-car screens with Lua.

Everything here comes from working on real car mods. The examples are small on purpose, so you can copy them into your own car and change them from there.

## Tutorials

| # | Topic | What you learn |
|---|-------|----------------|
| 1 | [Installing mods](tutorials/01-installing-mods.md) | Content Manager, CSP, where cars and tracks go, fixing broken installs |
| 2 | [The car folder](tutorials/02-car-folder.md) | What `data`, `extension`, `skins`, `sfx` and `ui` are for, and which files you can safely edit |
| 3 | [ext_config.ini basics](tutorials/03-ext-config-basics.md) | Sections, includes, emissive lights, shader replacements, finding mesh names |
| 4 | [Scriptable displays with Lua](tutorials/04-scriptable-displays.md) | Draw a working speed/gear/RPM screen on any mesh in the car |
| 5 | [Sounds and inputs in car scripts](tutorials/05-sounds-and-inputs.md) | Play a warning chime, toggle things with the Extra buttons |
| 6 | [Troubleshooting](tutorials/06-troubleshooting.md) | Black screens, scripts that do nothing, where to find the logs |
| 7 | [Animating doors (Blender)](tutorials/07-animating-doors.md) | Empty hierarchy (`BODY_HR`, `COCKPIT_HR`, `STEER_HR`), keyframes, ksanim export |
| 8 | [Quick UV seams (Blender)](tutorials/08-uv-seams.md) | Boundary loop seams for body panels, tips for liveries |

## Video tutorials

[`resources/video-tutorials.md`](resources/video-tutorials.md) is a sorted list of YouTube tutorials: LODs, colliders, steering wheel side swap, rims, air suspension, flames, bones and weight painting, baking, UVs and liveries, and car conversions from other games.

## Reference

- [`reference/csp-pbr-materials.ini`](reference/csp-pbr-materials.ini) - all CSP carpaint, interior and glass PBR templates with defaults and an explanation of every value. Copy a block into your `ext_config.ini` and keep only what you change.

## Examples

- [`examples/scriptable-display`](examples/scriptable-display) - complete digital cluster: speed, gear, RPM bar, fuel, blinking shift light
- [`examples/seatbelt-chime`](examples/seatbelt-chime) - looping warning sound that only plays in the cockpit view

Copy the folder contents into `content/cars/<your_car>/extension/` and follow the README in each example.

## Resources

### Tools

- [Content Manager](https://assettocorsa.club/content-manager.html) - the launcher almost everyone uses. Installs mods by drag and drop, has a showroom and a CSP settings page.
- [Custom Shaders Patch](https://acstuff.club/patch/) - extends the game with new shaders, lights, weather and the Lua scripting used in these tutorials. Installed through Content Manager.
- [actools on GitHub](https://github.com/gro-ove/actools) - source code of Content Manager.
- Kunos SDK - ships with the game in `assettocorsa/sdk`. Contains the ksEditor (`sdk/editor`) for kn5 models and materials, and the audio SDK (`sdk/audio`) for FMOD car sounds.

### Documentation

- [CSP config wiki](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki) - reference for `ext_config.ini` sections.
- [CSP config repository](https://github.com/ac-custom-shaders-patch/acc-extension-config) - the configs CSP ships with. Good to look at how real cars are set up.
- [CSP Lua SDK](https://github.com/ac-custom-shaders-patch/acc-lua-sdk) and its [wiki](https://github.com/ac-custom-shaders-patch/acc-lua-sdk/wiki) - definitions of every Lua function. Point your editor at it for autocomplete (see tutorial 4).

More tools (ksanim exporter, PureRef, converters) are listed in [`resources/video-tutorials.md`](resources/video-tutorials.md#tools).

### Content and community

- [Assetto Corsa on Steam](https://store.steampowered.com/app/244210/)
- [Official Assetto Corsa forum](https://www.assettocorsa.net/forum/) - includes the modding section with Kunos documentation.
- [Shutoko Revival Project](https://shutokorevivalproject.com/) - the well known Tokyo highway map.
- [Overtake (formerly RaceDepartment)](https://www.overtake.gg/) - large mod database and forum.
- [Peter Boese on Patreon](https://www.patreon.com/peterboese) - author of the Pure weather and lighting mod.

## Contributing

Found a mistake or have a trick worth sharing? Open an issue or a pull request. Please test changes in game first and mention your CSP version.

## License

Code examples are under the MIT license (see [LICENSE](LICENSE)). Assetto Corsa is a trademark of Kunos Simulazioni. This repository is not affiliated with Kunos or the CSP project.
