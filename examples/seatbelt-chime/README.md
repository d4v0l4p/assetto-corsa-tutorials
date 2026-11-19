# Example: seatbelt chime

Plays a chime every 1.5 seconds while the car is in neutral and you are in a cockpit camera. Switching to an outside camera or putting it in gear stops it.

## Install

1. Copy `seatbelt.lua` into `content/cars/<your_car>/extension/`.
2. Put a short sound at `extension/sounds/seatbelt.wav`. This repository does not include one: record your own or use a sound you have the rights to.
3. Add to `extension/ext_config.ini`:

   ```ini
   [SCRIPT_...]
   SCRIPT = seatbelt.lua
   ```

## Adjust it

- `PERIOD` sets the time between chimes, `VOLUME` the loudness.
- To use a different condition, change the `active` line, for example `car.speedKmh < 5` instead of neutral.
