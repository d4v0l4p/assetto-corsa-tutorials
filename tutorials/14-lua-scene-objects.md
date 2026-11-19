# 14. Lua: moving parts and changing materials

![Level](https://img.shields.io/badge/level-advanced-cf222e) ![Needs](https://img.shields.io/badge/needs-CSP-e8590c)

Car scripts (registered with `[SCRIPT_...]`, see [tutorial 5](05-sounds-and-inputs.md)) can find meshes and nodes of the car and change them every frame: rotate a needle, play an animation, light up an indicator, scroll a texture.

Source: [acc-lua-examples/cars](https://github.com/ac-custom-shaders-patch/acc-lua-examples/tree/main/cars) and the Lua SDK wiki page [Important notes](https://github.com/ac-custom-shaders-patch/acc-lua-sdk/wiki/Important-notes).

## Finding things

```lua
local needle = ac.findNodes('MY_ARROW')          -- nodes: things you move
local lamp = ac.findMeshes('MY_INDICATOR')        -- meshes: things you change the look of
```

Both return a list (even for one match), and every method works on all matches at once. Do this **once** at the top of the script, not inside `script.update`.

## A needle

```lua
local needle = ac.findNodes('MY_ARROW')
local axis = vec3(0, 0, 1)   -- created once, not every frame

function script.update(dt)
  needle:setRotation(axis, math.rad(car.speedKmh))   -- 1 km/h = 1 degree
end
```

A real gauge also needs limits and a bit of lag, but this is the core.

## An indicator light

```lua
local indicator = ac.findMeshes('MY_INDICATOR')
local glow = rgb(10, 0, 0)

function script.update(dt)
  indicator:setMaterialProperty('ksEmissive', car.ballast > 0 and glow or rgb.colors.transparent)
end
```

`setMaterialProperty` changes any shader property, here the emissive color.

## A scrolling texture

With the UVFlow shader on a mesh you can move its texture, for example a belt that runs with engine RPM:

```lua
local belt = ac.findMeshes('MESH_NAME')
local offset = 0

function script.update(dt)
  offset = (offset + dt * car.rpm * 0.01) % 1
  belt:setMaterialProperty('uvOffsetX', offset)
end
```

## Play an animation once on Extra A

```lua
local root = ac.findNodes('luaRoot:yes')
local progress = -1

function script.update(dt)
  if car.extraA then
    if progress == -1 then progress = 0 end      -- start
  elseif progress > 1 then
    progress = -1                                -- done and released: reset
  end

  if progress >= 0 then
    progress = progress + dt
    root:setAnimation(__dirname .. '/my_anim.ksanim', math.min(progress, 1))
  end
end
```

`__dirname` is the folder of the script.

> [!TIP]
> For simple cases an `[ANIMATION_...]` section with `INPUT = EXTRA_A` ([tutorial 10](10-switches-and-animations.md)) does the same without any code. Use Lua when you need logic the config cannot express.

## Clickable meshes

```lua
function script.update(dt)
  if ac.isMeshClicked('BUTTON_MESH') then
    -- clicked this frame
  end
  if ac.isMeshPressed('BUTTON_MESH') then
    -- held down
  end
end
```

## Talking to the physics script

Visual car scripts cannot change physics. A physics script (`data/script.lua`, needs extended physics) can. They talk through shared events:

```lua
-- extension/my_script.lua (visual)
function script.update(dt)
  if ac.isMeshClicked('JUMP_BUTTON') then
    ac.broadcastSharedEvent('MyCarJump:' .. car.index, { force = 1e5 })
  end
end
```

```lua
-- data/script.lua (physics)
ac.onSharedEvent('MyCarJump:' .. car.index, function (data)
  ac.awakeCarPhysics()
  ac.addForce(vec3(), true, vec3(0, data.force, 0), true)
end)
```

Give the event a unique name, including the car index, so it cannot collide with other scripts. For values that change every frame, `ac.connect()` with a shared structure is faster than events.

## Rules from the CSP docs

These come from the SDK's [Important notes](https://github.com/ac-custom-shaders-patch/acc-lua-sdk/wiki/Important-notes) and save a lot of debugging:

- **Do not hardcode enum numbers.** Write `ui.StyleVar.FramePadding`, not `18`. Values have changed before. Combine flags with `bit.bor()`. (Exception: `ac.Wheel` 0 to 3 always means the four wheels.)
- **Do not add your own functions to `script`.** CSP may call new `script.something` functions in the future, for example physics scripts already get `script.reset()`. Keep your helpers as local functions.
- **Do not extend `table`, `math` or `string`.** CSP adds its own functions there, and yours could replace them.
- **Avoid anything starting with `_`**, like `__util`. It is internal and can change any time.
- **Do not pass extra arguments** to standard functions. Future versions may give those arguments a meaning.
- **Use timers for slow work.** If something only needs to happen once a second, use `setInterval()` and no `script.update` at all.
- **Save data with `stringify`** (or `stringify.binary`). It handles vectors and LUTs and is fast.
- **`ffi` is restricted.** `ffi.load()` does nothing. Move native code into a separate process if you really need it.
- **Shared libraries** live in `extension/internal/lua-shared` and load with `require('shared/...')`.

---

[← 13. Lua apps](13-lua-apps.md) · [Index](../README.md)
