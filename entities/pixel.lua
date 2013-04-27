
require 'entities.entity'

Pixel = class('Pixel', Entity)
Pixel.collision_rect = {-5, -5, 15, 25}

function Pixel:moveTo(x, y, time, method)
  if time == nil or time == 0 then
    self.position.x = x
    self.position.y = y
  else
    tween(time, self.position, {x = x, y = y}, method)
  end
end

function Pixel:mousepressed(x, y, button)
  print("HURRAY")
end
