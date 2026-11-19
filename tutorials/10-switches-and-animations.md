# 10. Extra switches, animations and wobbly bits

![Level](https://img.shields.io/badge/level-intermediate-d29922) ![Needs](https://img.shields.io/badge/needs-CSP-e8590c)

Source: CSP wiki pages [Extra switches](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Extra-switches), [Animations](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Animations), [Instruments inputs](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Instruments-inputs) and [Wobbly bits](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Wobbly-bits).

## Extra switches

Cars have up to six extra switches, Extra A to F. Players bind keys to them in Content Manager under the Patch section of the controls settings. In `controls.ini` they are called `__EXT_LIGHT_A`, `__EXT_LIGHT_B` and so on, because they were first meant for extra lights.

You can use them as input for emissives, instruments and animations, in Lua as `car.extraA` ... `car.extraF`, and in extended physics as `LIGHT_EXTRA_A` and so on.

Give the switches a name and rules:

```ini
[EXTRA_SWITCHES]
SWITCH_A = Light bar
SWITCH_B = Launch mode
SWITCH_B_FLAGS = STATIONARY_ONLY, REQUIRES_BRAKE
```

| Flag | Effect |
|---|---|
| `HOLD_MODE` | Only active while the key is held, instead of toggling |
| `STATIONARY_ONLY` | Can only change while the car stands still |
| `NEURAL_GEAR_ONLY` | Only in neutral (CSP spells it like this) |
| `REQUIRES_BRAKE` | Brake pedal must be pressed |
| `KEEP_ON_RESET` | Stays on when the car is teleported back to the pits |

The name in `SWITCH_A` is shown to players while the session loads, so they know what the button does.

## Animations

You no longer need fake wings to animate things. An `ANIMATION_` section plays a `.ksanim` from the car's `animations` folder (see [tutorial 7](07-animating-doors.md) for making one).

```ini
[ANIMATION_...]
INPUT = EXTRA_A             ; what starts it
FILE = light_bar.ksanim
TIME = 0.5                  ; seconds for the full animation
```

That is all you need. More options:

| Key | Default | Effect |
|---|---|---|
| `INPUT_AS_PROGRESS` | 0 | 1 = the input value **is** the animation position. Bound to `GAS`, a half pressed pedal shows 50 % |
| `LOOP_WHILE_ACTIVE` | 0 | 1 = loop while the input is on (wipers, fans) |
| `LOOP_KEEP_UNTIL_DONE` | 1 | With looping: finish the cycle and return to 0 % when stopped |
| `TICK_TOCK_MODE` | 0 | With looping: play 0 → 100 → 0 % instead of jumping back |
| `AFFECTS_INTERIOR_SHAPE` | 0 | Update the interior reflection mask while playing (slower) |
| `HOLD_STATE` | 1 | Keep the end state, for hoods and similar |

### Inputs you can use

The same input names work for emissives, animations and instruments. A selection:

| Group | Inputs |
|---|---|
| Driving | `SPEED`, `RPM`, `GEAR`, `STEER`, `GAS`, `BRAKE`, `CLUTCH`, `HANDBRAKE`, `TURBO`, `G_FORCE` |
| Engine | `FUEL`, `WATER_TEMPERATURE`, `ENGINE_LIFE`, `ENGINE_TORQUE`, `ENGINE_POWER` |
| Lights | `LIGHT` (headlights), `LOWBEAM`, `HIGHBEAM`, `DRL`, `BRAKE_LIGHTS`, `REVERSE`, `HAZARD`, `TURNSIGNAL_LEFT`, `TURNSIGNAL_RIGHT` |
| Switches | `EXTRA_A` ... `EXTRA_F`, `HORN`, `OPENDOORS`, `SEATBELT` |
| Gears | `GEAR_R`, `GEAR_N`, `GEAR_D`, `GEAR_1` ... `GEAR_9` |
| Assists | `ABS`, `ABS_INACTION`, `TRACTIONCONTROL`, `TRACTIONCONTROL_INACTION`, `SPEEDLIMITER`, `BRAKEBIAS` |
| Wheels (4 values) | `TYRE_WEAR`, `TYRE_PRESSURE`, `TYRE_TEMPERATURE`, `TYRE_DIRT`, `SUSP_TRAVEL`, `RIDE_HEIGHT` |
| Damage | `BODY_DAMAGE` (4 sides), `SUSP_DAMAGE`, `GEARBOX_DAMAGE` |
| Session | `LAP_TIME`, `LAP_TIME_BEST`, `LAP_TIME_LAST`, `LAP_COUNT`, `POSITION` |

The complete list is on the [Instruments inputs](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Instruments-inputs) wiki page.

> [!NOTE]
> `BRAKE` appears twice in the CSP list: once as the brake pedal (0 to 1) and once as an alias for the brake lights. Use `BRAKE_LIGHTS` when you mean the lights, so it is clear what you want.

### Shaping the input

Every input can be modified before it is used:

```ini
[ANIMATION_...]
INPUT = TYRE_PRESSURE
INPUT_SELECTOR = THIRD      ; for 4-value inputs: FIRST..FOURTH, MIN, MAX, AVG, SUM
INPUT_MIN = 10
INPUT_MAX = 40
INPUT_MULT = 1.0
INPUT_ADD = 0.0
INPUT_LUT = (| 0=0 | 10=20 |)
INPUT_LAG_UP = 0.9          ; smoothing while rising
INPUT_LAG_DOWN = 0.95       ; smoothing while falling
```

For on/off uses (emissives), `INPUT_THRESHOLD` sets the switch point, or use `INPUT_THRESHOLD_LOWER` and `INPUT_THRESHOLD_UPPER` for a range. `INPUT_DEBUG = 30` forces a test value, handy for checking a gauge without driving.

## Wobbly bits

Moves a node with G-forces and gravity. Good for a front splitter that shakes over bumps or a toy hanging from the mirror. It is not a physics simulation, just a spring you can tune.

```ini
[WOBBLY_BIT_0]
NAME = FRONT_SPOILER_LEFT_SIDE  ; node to move
CONNECTED_TO = 0, 0.148, 1.86   ; point it hangs from and rotates around
MAX_RANGE = 0.05                ; maximum movement
DAMPENING_LAG = 0.93            ; friction
G_GAIN = 2                      ; how much G-forces push it
GRAVITY_GAIN = 3
OFFSET_GAIN = 2000              ; spring force back to the rest position
```

For a part that should flap freely, start with `MAX_RANGE = 1`, `DAMPENING_LAG = 0.99`, `OFFSET_GAIN = 0`.

> [!TIP]
> If the part should bend instead of moving as a whole, it has to be skinned: bind one end to a bone and move the bone with the `WOBBLY_BIT` section. A rigid object only needs its parent node to wobble.

---

[← 9. Lights and emissives](09-lights-and-emissives.md) · [Index](../README.md) · [11. Exhaust flames →](11-exhaust-flames.md)
