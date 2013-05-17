
require 'entities.entity'

Pixel = class('Pixel', Actor)

function Pixel:initialize(options)
  self.collision_rect = {-0.5, -0.5, 1, 3}
  self.scale = game.pixel_size or 2
  self.colors = {
    {100, 80, 0},
    {200, 180, 100},
    {200, 0, 50},
    {0, 100, 0},
    {0, 0, 0}
  }
  self.sections = { 0.2, 0.6, 1, 1, 0.2 } -- height of each section, should be 3 in sum
  Actor.initialize(self, options)
  self.collision_rect[3] = self.collision_rect[3] * self.scale
  self.collision_rect[4] = self.collision_rect[4] * self.scale
end

function Pixel:mousepressed(x, y, button)
  game.foundPixel(self)
end

function Pixel:drawContent()
  local s = self.scale
  -- describes the height of each section
  local a, b, c, d, e = unpack(self.sections)
  love.graphics.setColor( unpack(self.colors[1]))
  love.graphics.rectangle('fill', 0, 0, s, s * a)
  love.graphics.setColor( unpack(self.colors[2]))
  love.graphics.rectangle('fill', 0, s * a, s, s * b)
  love.graphics.setColor( unpack(self.colors[3]))
  love.graphics.rectangle('fill', 0, s * (a+b), s, s * c)
  love.graphics.setColor( unpack(self.colors[4]))
  love.graphics.rectangle('fill', 0, s * (a+b+c), s, s * d)
  love.graphics.setColor( unpack(self.colors[5]))
  love.graphics.rectangle('fill', 0, s * (a+b+c+d), s, s * e)
end
