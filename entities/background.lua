require 'entities.entity'
Background = class('Background', Entity)

function Background:initialize(options)
  Entity.initialize(self, options)
  self.width = self.width or self.level.width
  self.height = self.height or self.level.height

  if self.image and type(self.image) == 'Image' then
    self.scale = {self.image:getWidth() / self.width, self.image:getWidth() / self.height}
  end

  -- for procedually generated background images
  if self.drawPixel then
    self.canvas = love.graphics.newCanvas(self.width, self.height)
    self:drawPixels()
  end
end

function Background:drawPixels()
  love.graphics.setCanvas(self.canvas)
  p = (self.pixel_size or self.level.pixel_size)
  for x = 0, math.floor(self.width / p) do
    for y = 0, math.floor(self.height / p) do
      self:drawPixel(x, y)
    end
  end
  love.graphics.setCanvas()
end

