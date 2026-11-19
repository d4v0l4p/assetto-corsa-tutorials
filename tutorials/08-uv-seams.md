# 8. Quick UV seams for car panels (Blender)

![Level](https://img.shields.io/badge/level-beginner-2ea44f) ![Tool](https://img.shields.io/badge/tool-Blender-f5792a)

A fast way to get usable UVs on body panels, for example for liveries or AO maps.

## Steps

1. Select your mesh, switch to **Edit Mode** and select all vertices (`A`).
2. Open the **Select** menu at the top and choose **Select Loops > Select Boundary Loop**.
3. With the boundary loops selected, open the **Edge** menu and click **Mark Seam**.
4. Unwrap (`U` > *Unwrap*).
5. Check the result: in the Shader Editor add a checker or "UV seamless" test texture to the material and look for stretching.

Marking the outer edge loop as the seam works well when the mesh is clean, without clipping or overlapping parts, even if it is triangulated. For complex parts you will still need to place seams by hand.

## Going further

- For a full introduction see *Blender 4.0: How to UV Unwrap Anything* in the [video list](../resources/video-tutorials.md#uv-ao-and-liveries).
- For drift cars there is a dedicated AO map tutorial in the same section.
- Planar UVs are an old approach. For high quality liveries, a proper UV layout painted in Substance Painter gives better results.
- RizomUV Bridge for Blender makes many unwraps easier, with a better live distortion and checkerboard preview and a live preview of shortest path selections.

---

[← 7. Animating doors](07-animating-doors.md) · [Index](../README.md) · [9. Lights and emissives →](09-lights-and-emissives.md)
