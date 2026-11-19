-- Seatbelt chime: plays while the car is in neutral and the camera is in the cockpit.
-- Register in ext_config.ini with:
--   [SCRIPT_...]
--   SCRIPT = seatbelt.lua
-- and put your sound at extension/sounds/seatbelt.wav

local PERIOD = 1.5   -- seconds between two chimes
local VOLUME = 0.55  -- relative to the game's master volume

local chime = ui.MediaPlayer()
chime:setSource('sounds/seatbelt.wav')
chime:setVolume(ac.getAudioVolume('main') * VOLUME)
chime:setLooping(false)

local car = ac.getCar(0)
local t = 0
local wasOn = false

local function stop()
  chime:pause()
  chime:setCurrentTime(0)
end

function script.update(dt)
  local active = car.gear == 0 and ac.isInteriorView()
  if not active then
    if wasOn then stop() end
    t, wasOn = 0, false
    return
  end

  t = t + dt
  local on = (t % PERIOD) < PERIOD / 2
  if on and not wasOn then
    stop()
    chime:play()
  end
  wasOn = on
end
