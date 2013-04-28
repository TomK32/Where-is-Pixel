
require 'entities.entity'

Pixel = class('Pixel', Actor)
Pixel.collision_rect = {-5, -5, 15, 25}
Pixel.pixel_size = 2

function Pixel:mousepressed(x, y, button)
  game.foundPixel()
end
