-- Simple digital cluster for a CSP scriptable display.
-- Texture layout: 1024 x 512. Change W/H and the positions below for your screen.
-- `car` is set by CSP for display scripts (state of the car the display belongs to).

local W, H = 1024, 512

local BG       = rgbm(0.02, 0.02, 0.03, 1)
local WHITE    = rgbm(1, 1, 1, 1)
local GREY     = rgbm(0.45, 0.45, 0.5, 1)
local DIM      = rgbm(0.15, 0.15, 0.18, 1)
local ORANGE   = rgbm(1, 0.45, 0.05, 1)
local RED      = rgbm(1, 0.1, 0.05, 1)

local SHIFT_AT = 0.92         -- shift light from 92 % of the limiter
local BLINK_HZ = 8

local GEARS = { [-1] = 'R', [0] = 'N' }

local blinkTime = 0

local function gearText(g)
  return GEARS[g] or tostring(g)
end

function script.update(dt)
  -- background
  display.rect{ pos = vec2(0, 0), size = vec2(W, H), color = BG }

  -- RPM bar across the top, 30 segments
  local limiter = math.max(car.rpmLimiter, 1000)
  local ratio = math.min(car.rpm / limiter, 1)
  local segments = 30
  local active = math.floor(ratio * segments + 0.5)
  local shift = ratio >= SHIFT_AT
  display.horizontalBar{
    pos = vec2(40, 30), size = vec2(W - 80, 36),
    delta = 6, total = segments, active = active,
    activeColor = shift and RED or WHITE, inactiveColor = DIM,
  }

  -- shift light: blinking frame when close to the limiter
  if shift then
    blinkTime = blinkTime + dt
    if (blinkTime * BLINK_HZ) % 1 < 0.5 then
      display.rect{ pos = vec2(0, 0), size = vec2(W, 8), color = RED }
      display.rect{ pos = vec2(0, H - 8), size = vec2(W, 8), color = RED }
    end
  else
    blinkTime = 0
  end

  -- speed in the center
  display.text{
    text = string.format('%d', math.floor(car.speedKmh + 0.5)),
    pos = vec2(W / 2 - 250, 140), letter = vec2(90, 180),
    alignment = 0.5, width = 500, color = WHITE,
  }
  display.text{
    text = 'km/h', pos = vec2(W / 2 - 100, 330), letter = vec2(24, 48),
    alignment = 0.5, width = 200, color = GREY,
  }

  -- gear on the right
  display.text{
    text = gearText(car.gear), pos = vec2(W - 220, 160), letter = vec2(80, 160),
    alignment = 0.5, width = 160, color = ORANGE,
  }

  -- fuel bar on the left
  local fuel = car.maxFuel > 0 and car.fuel / car.maxFuel or 0
  display.text{ text = 'FUEL', pos = vec2(60, 170), letter = vec2(20, 40), color = GREY }
  display.horizontalBar{
    pos = vec2(60, 220), size = vec2(160, 24), delta = 4,
    total = 8, active = math.floor(fuel * 8 + 0.5),
    activeColor = fuel < 0.15 and RED or WHITE, inactiveColor = DIM,
  }
  display.text{
    text = string.format('%d L', math.floor(car.fuel + 0.5)),
    pos = vec2(60, 260), letter = vec2(20, 40), color = WHITE,
  }
end
