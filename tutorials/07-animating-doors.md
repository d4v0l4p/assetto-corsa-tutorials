# 7. Animating doors and other parts (Blender)

![Level](https://img.shields.io/badge/level-intermediate-d29922) ![Tool](https://img.shields.io/badge/tool-Blender-f5792a)

Doors, hoods, wings and similar parts are animated with empties in Blender and exported as `.ksanim` files into the car's `animations` folder.

Before you start with bones (for example for a shifter), watch a weight painting introduction first. See [Blender basics](../resources/video-tutorials.md#blender-basics) in the video list.

## The hierarchy

The Kunos SDK expects a fixed structure. Besides the wheel hub empties there are two main empties:

| Empty | Contains |
|-------|----------|
| `BODY_HR` | All static exterior objects. Nothing under it rotates or belongs to a wheel hub. |
| `COCKPIT_HR` | All static interior objects in the cabin. |
| `STEER_HR` | Child of the cockpit. Rotates the steering wheel, so the steering wheel meshes go here and not directly under `COCKPIT_HR`. |

Every mesh you want to animate must be parented to its own empty, and that empty is parented to `BODY_HR` (exterior) or `COCKPIT_HR` (interior).

Example scene collection for front doors, where `DOOR_LF` and `DOOR_RF` are parented to `EXT_BODY`:

```
BODY_HR
  EXT_BODY
    DOOR_LF        <- empty, rotated 90 degrees on X
      door_lf_mesh
    DOOR_RF        <- empty, rotated 90 degrees on X
      door_rf_mesh
COCKPIT_HR
  STEER_HR
    steering_wheel_mesh
```

## Important: rotate the empty

The empty of an animated part must be rotated **90 degrees on the X axis**. If you skip this, the part moves along the wrong axis in game.

Place the empty at the hinge point. The part rotates around the empty's origin.

## Animate

1. Select the empty (not the mesh).
2. Go to frame 0 (or 1) and insert keyframes on all rotation values (`I` key).
3. Go to the last frame, rotate the empty to the fully open position and insert keyframes again. For doors that is usually a rotation on the Z axis.
4. Play the timeline to check the movement.

The frame range should go from 0 or 1 to 100 or 200. For doors 200 is recommended.

## Export

Use the [Blender ksanim/knh exporter](https://www.overtake.gg/downloads/blender-ksanim-knh-exporter.30388/) add-on. It cannot export root level nodes, only objects that have a parent, which the hierarchy above already gives you.

Put the exported `.ksanim` into `content/cars/<car_id>/animations/`. When the animation plays is set up in the car's config. Which file name and section a part needs depends on the part, the [CSP config wiki](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki) covers the CSP side.

## FBX export preset

For the model itself, save your FBX export settings as a preset so every export uses the same values. Blender looks for export presets in:

```
C:\Users\<YOUR_USERNAME>\AppData\Roaming\Blender Foundation\Blender\<version>\scripts\presets\operator\export_scene.fbx
```

Replace `<version>` with your Blender version, for example `5.0`. These presets are not related to the ksanim exporter, they are separate files.

---

[← 6. Troubleshooting](06-troubleshooting.md) · [Index](../README.md) · [8. Quick UV seams →](08-uv-seams.md)
