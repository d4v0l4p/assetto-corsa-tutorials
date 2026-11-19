-- Top Speed: a small CSP Lua app.
-- Shows the current speed and the highest speed since the last reset.
-- Settings are saved between sessions with ac.storage.

local settings = ac.storage({
  useMph = false,
  decimals = 0,
})

local car = ac.getCar(0)
local topKmh = 0

local function format(kmh)
  local value, unit = kmh, 'km/h'
  if settings.useMph then
    value, unit = kmh * 0.621371, 'mph'
  end
  return string.format('%.' .. settings.decimals .. 'f %s', value, unit)
end

function script.update(dt)
  if car.speedKmh > topKmh then
    topKmh = car.speedKmh
  end
end

function script.windowMain(dt)
  ui.pushFont(ui.Font.Huge)
  ui.text(format(car.speedKmh))
  ui.popFont()

  ui.separator()
  ui.text('Top: ' .. format(topKmh))
  ui.sameLine(0, 12)
  if ui.button('Reset') then
    topKmh = 0
  end
end

function script.windowSettings(dt)
  if ui.checkbox('Show mph', settings.useMph) then
    settings.useMph = not settings.useMph
  end
  settings.decimals = math.round(ui.slider('##decimals', settings.decimals, 0, 2, 'Decimals: %.0f'))
end
