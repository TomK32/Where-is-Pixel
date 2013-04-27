require 'entities.entity'
Background = class('Background', Entity)

function Background:initialize(options)
  Entity.initialize(self, options)
  -- for procedually generated background images
  if self.drawPixel then
    self.canvas = love.graphics.newCanvas(self.level.width, self.level.height)
    self:drawPixels()
  end
  self.creation_timer = 0
end

function Background:drawPixels()
  love.graphics.setCanvas(self.canvas)
  for x = 0, math.floor(self.level.width / self.level.pixel_size) do
    for y = 0, self.level.height / self.level.pixel_size do
      self:drawPixel(x, y)
    end
  end
  love.graphics.setCanvas()
end

