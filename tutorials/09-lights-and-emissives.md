# 9. Lights and emissives in depth

![Level](https://img.shields.io/badge/level-intermediate-d29922) ![Needs](https://img.shields.io/badge/needs-CSP-e8590c)

CSP knows two different things that both get called "lights":

| | What it is | Section prefix |
|---|---|---|
| **Emissive** | A mesh that glows. It does not light up anything around it. | `EMISSIVE_...` |
| **Dynamic light** | A real light source that lights the road, other cars or the interior. | `LIGHT_...` |

A headlight usually needs both: the glowing lens (emissive) and the beam on the road (light). CSP guesses a lot of this from `lights.ini` and from your emissives, so start with emissives and only add `LIGHT_` sections when the guessed light is wrong.

Source: CSP wiki pages [Emissive objects](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Emissive-objects) and [Lights](https://github.com/ac-custom-shaders-patch/acc-extension-config/wiki/Cars-%E2%80%93-Lights).

## Emissives

```ini
[EMISSIVE_REVERSE_0]
NAME = _ext_REVERSE_LIGHTS  ; mesh name(s), MESHES works too
COLOR = 25, 25, 25          ; color when the condition is met
OFF_COLOR = 0, 0, 0         ; color otherwise (default 0)
LAG = 0.8                   ; 0 = switch instantly
SIMULATE_HEATING = 0.3      ; bulb effect: goes through an orange tint when switching
LOCATION = REAR             ; used for damage and for guessing lights
```

> [!TIP]
> A fourth value in any color multiplies the first three. `COLOR = 1, 0.2, 0, 20` is the same orange as `1, 0.2, 0` but 20 times brighter.

### Exterior types

| Section | Glows when | Default location |
|---|---|---|
| `EMISSIVE_LIGHT_N` | Headlights are on | FRONT |
| `EMISSIVE_BRAKE_N` | Brake lights are on | REAR |
| `EMISSIVE_REVERSE_N` | Reverse gear | REAR |
| `EMISSIVE_TURNSIGNAL_LEFT_N` / `_RIGHT_N` | Turn signal (split front and rear meshes so guessing works) | |
| `EMISSIVE_CORNERINGLAMP_LEFT_N` / `_RIGHT_N` | Steering past `STEER_THRESHOLD` degrees | |
| `EMISSIVE_LOWBEAM_N` / `EMISSIVE_HIGHBEAM_N` | Low or high beam only | |
| `EMISSIVE_EXTRA_A_N` ... `_D_N` | Extra switch A to D (works in replays and online) | |

### Dashboard indicators

These default to location `NONE`, so they never create a dynamic light.

| Section | Meaning |
|---|---|
| `EMISSIVE_HAZARD_N` | Hazards |
| `EMISSIVE_HANDBRAKE_N` | Handbrake |
| `EMISSIVE_BATTERY_N` | Battery |
| `EMISSIVE_TYRES_N` | Flat tyre, with `PRESSURE_THRESHOLD` |
| `EMISSIVE_ABS_N` | ABS is switched on |
| `EMISSIVE_TRACTIONCONTROL_N` | TC is switched on |
| `EMISSIVE_TRACTIONCONTROL_INACTION_N` | TC is working right now |
| `EMISSIVE_TURNSIGNAL_N` | Combined turn signal indicator |
| `EMISSIVE_ENGINE_DAMAGE_N` | Check engine, with `ENGINE_LIFE_THRESHOLD` |
| `EMISSIVE_ENGINE_TEMP_N` | Engine temperature, with `TEMP_MIN`, `TEMP_MAX`, `TEMP_EXP` |
| `EMISSIVE_GEAR_R_N`, `_N_N`, `_D_N`, `_1_N` ... `_9_N` | A specific gear |
| `EMISSIVE_OPENDOORS_N` | Doors open |

> [!NOTE]
> A TC light usually warns that TC is **off**. Use `COLOR = 0, 0, 0` and `OFF_COLOR = 25, 0, 0` to turn the logic around.

### Any input as a trigger

With `INPUT` an emissive can react to almost anything the car knows. It switches on when the value goes over `INPUT_THRESHOLD`:

```ini
[EMISSIVE_...]
INPUT = BODY_DAMAGE
INPUT_THRESHOLD = 20
NAME = _ext_DAMAGE_LIGHT
COLOR = 25, 0, 0
```

Add `USE_SMOOTH_TRANSITION = 1` to use the value directly instead of on/off, for example for a glow that grows with RPM. `FORCE_OFF_INPUT = HAZARD` switches the emissive off while another input is active. The full list of inputs is in [tutorial 10](10-switches-and-animations.md#inputs-you-can-use).

### One mesh, several jobs

Fallback colors let one mesh act as tail light, brake light and turn signal at the same time. CSP checks them from top to bottom and uses the first that applies:

1. `COLOR` (the emissive's own condition is on)
2. `FALLBACK_BRAKES_COLOR` (brakes on)
3. `FALLBACK_HIGHBEAM_COLOR`
4. `FALLBACK_LOWBEAM_COLOR`
5. `FALLBACK_HEADLIGHTS_COLOR`
6. `FALLBACK_DRL_COLOR` (daytime running lights)
7. `FALLBACK_IDLE_COLOR` (engine running)
8. `FALLBACK_BASE_COLOR`
9. `OFF_COLOR`

With `FALLBACK_BRAKES_COLOR_HIGHER = 1` the brake color wins even over the main color. That gives you a reverse light that turns red as soon as you brake.

```ini
[EMISSIVE_TURNSIGNAL_LEFT_0]
NAME = rear_light_left
COLOR = 20, 8, 0                   ; turn signal
FALLBACK_BRAKES_COLOR = 15, 0, 0   ; brake light
FALLBACK_HEADLIGHTS_COLOR = 3, 0, 0 ; tail light
```

### Blinking

There are two ways:

**A, for turn signals.** Always finishes the blink cycle.

```ini
BLINK_REPEAT = 1
BLINK_FREQENCY_HZ = 2.4            ; spelled like this in CSP
BLINK_FREQENCY_HAZARDS_HZ = 2      ; optional different rate for hazards
```

**B, for visual effects** like fading neon. Stops immediately and supports a LUT:

```ini
BLINKING_PATTERN = (|0=1|0.5=0.8|1=1|2=0.6|3=0.8|3.5=1)
BLINKING_DURATION = 2              ; optional, normalizes the pattern to 2 seconds
```

### Sequential turn signals

Split the turn signal mesh into pieces and list them:

```ini
[EMISSIVE_TURNSIGNAL_LEFT_0]
RANGE_PREFIX = _ext_turnsig_left_  ; finds _ext_turnsig_left_0, _1, _2
RANGE_START_INDEX = 0
RANGE_END_INDEX = 2
RANGE_DELAY = 0.1                  ; seconds between pieces
SMOOTH_IN = 1
SMOOTH_OUT = 0
COLOR = 20, 8, 0
```

Use `RANGE_NAMES = a, b, c` instead if your pieces are not numbered.

### Other useful keys

- `TOGGLE_VISIBILITY = 1` hides the mesh while the emissive is off (`TOGGLE_VISIBILITY_INVERSE = 1` for the opposite).
- `ONLY_WITH_HEADLIGHTS = 1` only lets it glow with headlights on.
- `CAST_LIGHT = 0` stops CSP from guessing a dynamic light from this emissive.

## Dynamic lights

Each light type has a shared section and indexed ones. The shared section is only a fallback for index 0. Up to four lights per type (0 to 3):

| Type | Shared | Indexed |
|---|---|---|
| Headlights | `LIGHT_HEADLIGHTS` | `LIGHT_HEADLIGHT_0` ... |
| Brake lights | `LIGHT_BRAKES` | `LIGHT_BRAKE_0` ... |
| Reverse | `LIGHT_REVERSE` | `LIGHT_REVERSE_0` ... |
| Turn signals | `LIGHT_TURNSIGNALS_LEFT` / `_RIGHT` | `LIGHT_TURNSIGNAL_LEFT_0` ... |
| Cornering | `LIGHT_CORNERINGLAMP_LEFT` / `_RIGHT` | `LIGHT_CORNERINGLAMP_LEFT_0` ... |
| Door lights | `LIGHT_OPENDOORS` | `LIGHT_OPENDOORS_0` ... |

The most common adjustments:

```ini
[LIGHT_HEADLIGHTS]
POSITION = 0, 0.7, 1.8      ; in car space (x right, y up, z forward)
MIRROR = 0.7                ; creates the second light at x = -0.7, 0 to disable
DIRECTION = 0, -0.2, 1
SPOT = 48                   ; cone angle in degrees, 0 = point light
SPOT_SHARPNESS = 0          ; 0 soft edge, 1 hard edge
COLOR = 1, 1, 1, 10
RANGE = 240                 ; meters
FADE_AT = 450               ; start fading the light source at this distance
VOLUMETRIC_LIGHT = 1        ; light shafts in fog (costs performance)
```

> [!IMPORTANT]
> `SELF_LIGHTNING` (the typo is kept for compatibility) decides whether a light lights up its own car. Headlights default to `0` so the beam does not light the bodywork. Brake and reverse lights default to `EXTERIORONLY`: you see the red glow on the bumper from outside, but it does not bleed into the cockpit. Use `1` for interior and door lights.

### Line lights and extra lights

Any light becomes a line light with two endpoints, nice for LED strips:

```ini
[LIGHT_EXTRA_...]
LINE_FROM = 0.422, 0.1, -0.9
LINE_TO = 0.422, 0.1, 0.9
COLOR = 10
DIRECTION = 0, -1, 0
SPOT = 210
BIND_TO_EXTRA_A = 1         ; underglow on Extra A
```

`LIGHT_EXTRA_...` sections are free lights for underglow, neons or dashboard light. They can follow `BIND_TO_HEADLIGHTS`, `BIND_TO_HIGHBEAM`, `BIND_TO_LOWBEAM`, `BIND_TO_BRAKELIGHTS` or `BIND_TO_EXTRA_A` (also B to D), and support `LAG_ON` / `LAG_OFF`.

> [!TIP]
> To keep an extra light in sync with a glowing mesh, use `BOUND_TO = mesh_name` instead of giving both their own blinking pattern.

### License plate light

Guessed from meshes that use `Plate_D.dds` and `Plate_NM.dds`. Change the layout with:

```ini
[LIGHT_LICENSEPLATE]
LAYOUT = TWO_ON_TOP   ; AT_SIDES, ONE_ON_TOP, TWO_ON_BOTTOM, ONE_ON_BOTTOM, NONE
```

---

[← 8. Quick UV seams](08-uv-seams.md) · [Index](../README.md) · [10. Switches and animations →](10-switches-and-animations.md)
