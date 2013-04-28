
require 'entities.entity'

Actor = class('Actor', Entity)
Actor.collision_rect = {0, 1, 1, 1}

function Actor:moveTo(x, y, time, method)
  if time == nil or time == 0 then
    self.position.x = x
    self.position.y = y
  else
    tween(time, self.position, {x = x, y = y}, method)
  end
end

