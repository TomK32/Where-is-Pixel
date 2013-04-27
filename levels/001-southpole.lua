
local Background = require 'entities/background'

return {
  name = 'South Pole',
  pixel_size = 4,
  entities = {
    background = class("PoleBackground", Background):include({
      drawPixel = function(self, x, y)
        local p = self.level.pixel_size
        local c = math.ceil(SimplexNoise.Noise2D(math.floor(x / p), math.floor( y / p)) * 20)
        -- slightly blue-whiteish
        love.graphics.setColor( 205 + c, 205 + c, 235 + c, 255)
        love.graphics.rectangle('fill', x * p, y * p, p, p)
      end
    }),
    pole = class("Pole", Entity):include({
      onInitialize = function(self)
        self.position = { x = self.level.width / 2, y = self.level.height / 2, z = 5 }
      end,
      drawContent = function(self)
        love.graphics.setColor( 0, 0, 0, 255)
        love.graphics.rectangle('fill', 0, 0, self.level.pixel_size, self.level.pixel_size * 2)
      end
    })
  },
  onUpdate = nil
}
