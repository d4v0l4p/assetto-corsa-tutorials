# Example: digital cluster

Speed, gear, a 30 segment RPM bar that turns red near the limiter, a blinking shift light and a fuel gauge.

## Install

1. Copy `cluster.lua` into `content/cars/<your_car>/extension/`.
2. Add this to `extension/ext_config.ini` and replace the mesh name with your screen's mesh (see tutorial 3 on how to find it):

   ```ini
   [SCRIPTABLE_DISPLAY_...]
   MESHES = your_cluster_mesh
   RESOLUTION = 1024, 512
   SCRIPT = cluster.lua

   [EMISSIVE_LIGHT_...]
   NAME = your_cluster_mesh
   COLOR = 1, 1, 1, 2
   ```

3. Start a session and look at the cluster.

## Adjust it

- Your screen has a different aspect ratio: change `W, H` at the top of the script and `RESOLUTION` in the config to the same values, then move the elements.
- Shift light too early or too late: change `SHIFT_AT` (0.92 = 92 % of the limiter).
- mph instead of km/h: use `car.speedKmh * 0.621371` and change the label.
