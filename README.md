<p align="center">
  <img src="assets/banner.svg" alt="Assetto Corsa modding tutorials" width="100%">
</p>

<p align="center">
  <a href="#tutorials"><img src="https://img.shields.io/badge/tutorials-14-e8590c?style=for-the-badge" alt="14 tutorials"></a>
  <a href="#examples"><img src="https://img.shields.io/badge/examples-3-f59f00?style=for-the-badge" alt="3 examples"></a>
  <a href="https://acstuff.club/patch/"><img src="https://img.shields.io/badge/made%20for-CSP-30363d?style=for-the-badge" alt="Made for CSP"></a>
  <a href="https://github.com/ac-custom-shaders-patch/acc-lua-sdk"><img src="https://img.shields.io/badge/Lua-5.1%20%2F%20LuaJIT-000080?style=for-the-badge&logo=lua&logoColor=white" alt="Lua"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/d4v0l4p/assetto-corsa-tutorials?style=for-the-badge&color=2ea44f" alt="License"></a>
</p>

<p align="center">
  <b>Practical guides for modding Assetto Corsa with Custom Shaders Patch.</b><br>
  From installing your first mod to writing Lua apps, with small examples you can copy straight into your car.
</p>

---

## Where to start

<p align="center">
  <img src="assets/learning-path.svg" alt="Learning path: Start here, Make it shine, Script it, Build it" width="100%">
</p>

New to modding? Read the green column first. After that, pick the track that matches what you want to build.

## Tutorials

### Basics

| | Tutorial | What you learn |
|:-:|---|---|
| ![Beginner](https://img.shields.io/badge/-beginner-2ea44f) | [**1. Installing mods**](tutorials/01-installing-mods.md) | Content Manager, CSP, where cars and tracks go, fixing broken installs |
| ![Beginner](https://img.shields.io/badge/-beginner-2ea44f) | [**2. The car folder**](tutorials/02-car-folder.md) | What `data`, `extension`, `skins`, `sfx` and `ui` are for |
| ![Beginner](https://img.shields.io/badge/-beginner-2ea44f) | [**3. ext_config.ini basics**](tutorials/03-ext-config-basics.md) | Sections, includes, emissives, shader replacements, finding mesh names |
| ![Beginner](https://img.shields.io/badge/-beginner-2ea44f) | [**6. Troubleshooting**](tutorials/06-troubleshooting.md) | Black screens, scripts that do nothing, where the logs are |

### Lights, switches and effects

| | Tutorial | What you learn |
|:-:|---|---|
| ![Intermediate](https://img.shields.io/badge/-intermediate-d29922) | [**9. Lights and emissives**](tutorials/09-lights-and-emissives.md) | Every emissive type, fallback colors, sequential turn signals, dynamic lights, line lights |
| ![Intermediate](https://img.shields.io/badge/-intermediate-d29922) | [**10. Switches and animations**](tutorials/10-switches-and-animations.md) | Extra A to F, `ANIMATION_` sections, all inputs, wobbly bits |
| ![Beginner](https://img.shields.io/badge/-beginner-2ea44f) | [**11. Exhaust flames**](tutorials/11-exhaust-flames.md) | Antilag, flat shift, discharge, limiter and damage flames |
| ![Advanced](https://img.shields.io/badge/-advanced-cf222e) | [**12. Advanced configs with INIpp**](tutorials/12-inipp.md) | Variables, expressions, templates, optional sections |

### Lua scripting

| | Tutorial | What you learn |
|:-:|---|---|
| ![Intermediate](https://img.shields.io/badge/-intermediate-d29922) | [**4. Scriptable displays**](tutorials/04-scriptable-displays.md) | Draw a working speed/gear/RPM screen on any mesh |
| ![Intermediate](https://img.shields.io/badge/-intermediate-d29922) | [**5. Sounds and inputs**](tutorials/05-sounds-and-inputs.md) | Play sounds, react to Extra buttons and camera view |
| ![Intermediate](https://img.shields.io/badge/-intermediate-d29922) | [**13. Lua apps**](tutorials/13-lua-apps.md) | `manifest.ini`, windows, immediate mode UI, callbacks |
| ![Advanced](https://img.shields.io/badge/-advanced-cf222e) | [**14. Moving parts and materials**](tutorials/14-lua-scene-objects.md) | Needles, indicators, scrolling textures, clickable meshes, physics events, CSP's Lua rules |

### Modeling in Blender

| | Tutorial | What you learn |
|:-:|---|---|
| ![Intermediate](https://img.shields.io/badge/-intermediate-d29922) | [**7. Animating doors**](tutorials/07-animating-doors.md) | `BODY_HR` / `COCKPIT_HR` / `STEER_HR`, keyframes, ksanim export |
| ![Beginner](https://img.shields.io/badge/-beginner-2ea44f) | [**8. Quick UV seams**](tutorials/08-uv-seams.md) | Boundary loop seams for body panels, tips for liveries |

## Examples

<table>
<tr>
<td width="33%" valign="top">

### [Digital cluster](examples/scriptable-display)
Speed, gear, RPM bar, shift light and fuel gauge on a scriptable display.

`extension/` · Lua

</td>
<td width="33%" valign="top">

### [Seatbelt chime](examples/seatbelt-chime)
A warning sound that only plays in the cockpit view.

`extension/` · Lua

</td>
<td width="33%" valign="top">

### [Top Speed app](examples/lua-app-top-speed)
Lua app with a window, settings and saved preferences.

`apps/lua/` · Lua

</td>
</tr>
</table>

## Reference

| | |
|---|---|
| [**CSP PBR materials**](reference/csp-pbr-materials.ini) | Every carpaint, interior and glass template with defaults and an explanation of each value |
| [**CSP projects on GitHub**](resources/csp-github.md) | All 18 repositories of the CSP organization, sorted by what you use them for |
| [**Video tutorials and tools**](resources/video-tutorials.md) | YouTube tutorials for LODs, colliders, flames, Blender, baking, UVs and liveries |

## Resources

<details open>
<summary><b>Tools</b></summary>

- [Content Manager](https://assettocorsa.club/content-manager.html) - the launcher almost everyone uses. Installs mods by drag and drop, has a showroom and the CSP settings.
- [Custom Shaders Patch](https://acstuff.club/patch/) - new shaders, lights, weather and the Lua scripting used here. Installed through Content Manager.
- [Bakery (VAO baker)](https://github.com/ac-custom-shaders-patch/acc-bakeryoptix) - bakes vertex ambient occlusion for cars and tracks.
- [SDK shaders](https://github.com/ac-custom-shaders-patch/sdk-shaders) - CSP shaders for ksEditor.
- Kunos SDK - ships with the game in `assettocorsa/sdk`: ksEditor (`sdk/editor`) and the FMOD audio SDK (`sdk/audio`).

More in [video tutorials and tools](resources/video-tutorials.md#tools).

</details>

<details open>
<summary><b>Documentation</b></summary>

- [CSP config wiki](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki) - reference for every `ext_config.ini` section.
- [CSP configs](https://github.com/ac-custom-shaders-patch/acc-extension-config) - the configs CSP ships with. Great for seeing how real cars are set up.
- [CSP Lua SDK](https://github.com/ac-custom-shaders-patch/acc-lua-sdk) and its [wiki](https://github.com/ac-custom-shaders-patch/acc-lua-sdk/wiki) - every Lua function, for autocomplete in your editor.
- [CSP Lua examples](https://github.com/ac-custom-shaders-patch/acc-lua-examples) - car, physics, track, online and WeatherFX scripts.

</details>

<details>
<summary><b>Content and community</b></summary>

- [Assetto Corsa on Steam](https://store.steampowered.com/app/244210/)
- [Official Assetto Corsa forum](https://www.assettocorsa.net/forum/) - includes the modding section with Kunos documentation.
- [Shutoko Revival Project](https://shutokorevivalproject.com/) - the well known Tokyo highway map.
- [Overtake (formerly RaceDepartment)](https://www.overtake.gg/) - large mod database and forum.
- [Peter Boese on Patreon](https://www.patreon.com/peterboese) - author of the Pure weather and lighting mod.

</details>

## Contributing

Found a mistake or have a trick worth sharing? Open an issue or a pull request. Please test changes in game first and mention your CSP version.

## License

Code examples are under the [MIT license](LICENSE). The PBR reference and the tutorials based on the CSP wiki summarize documentation from the [Custom Shaders Patch project](https://github.com/ac-custom-shaders-patch).

Assetto Corsa is a trademark of Kunos Simulazioni. This repository is not affiliated with Kunos or the CSP project.
