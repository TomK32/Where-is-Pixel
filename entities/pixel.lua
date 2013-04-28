
require 'entities.entity'

Pixel = class('Pixel', Actor)
Pixel.collision_rect = {-5, -5, 15, 25}

function Pixel:initialize(options)
  self.pixel_size = game.pixel_size or 2
  Entity.initialize(self, options)
end

function Pixel:mousepressed(x, y, button)
  game.foundPixel()
end
