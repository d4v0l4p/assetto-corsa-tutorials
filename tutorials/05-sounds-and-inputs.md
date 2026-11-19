# 5. Sounds and inputs in car scripts

Not every script needs a screen. For logic like warning sounds, CSP runs car scripts registered with a `[SCRIPT_...]` section:

```ini
[SCRIPT_...]
SCRIPT = seatbelt.lua
```

The file sits in `extension/`. Like display scripts, it defines `script.update(dt)`, which CSP calls every frame with the time since the last frame in seconds.

Do not confuse this with `data/script.lua`. That one is a physics script, runs in a different environment and is checked by online servers.

## Playing a sound

`ui.MediaPlayer` plays wav, mp3 and other common formats. Paths are relative to the `extension` folder:

```lua
local chime = ui.MediaPlayer()
chime:setSource('sounds/chime.wav')
chime:setVolume(ac.getAudioVolume('main') * 0.5)   -- follow the game's master volume
chime:setLooping(false)

local function restart(player)
  player:pause()
  player:setCurrentTime(0)
  player:play()
end
```

Create the player once at the top of the file, not inside `script.update`. Creating a new player every frame quickly breaks sound and costs performance.

## Reacting to the view

Interior sounds should usually stop when you switch to an outside camera:

```lua
function script.update(dt)
  local inCockpit = ac.isInteriorView()
  -- ...
end
```

## Extra buttons

`car.extraA` to `car.extraF` are the Extra switches that players bind in the controls settings. They are toggles: the value flips each time the button is pressed. To react to the moment it changes, remember the last value:

```lua
local car = ac.getCar(0)
local lastExtraA = car.extraA

function script.update(dt)
  if car.extraA ~= lastExtraA then
    lastExtraA = car.extraA
    -- toggle something here
  end
end
```

`ac.getCar(0)` is the player's car. In display scripts the `car` global already points to the right car, in other scripts get it this way.

## Timing without timers

For blinking or repeating patterns, add up `dt` and use the remainder:

```lua
local t = 0
function script.update(dt)
  t = t + dt
  local on = (t % 1.0) < 0.5   -- on for 0.5 s, off for 0.5 s
end
```

This keeps working at any frame rate. Reset `t` to 0 when the effect stops, so it always starts in the same phase.

A complete seatbelt chime that uses all of this is in [`examples/seatbelt-chime`](../examples/seatbelt-chime).

Next: [troubleshooting](06-troubleshooting.md).
