
return {
  name = 'South Pole',
  description = 'Can you find him here in this white desert?',
  pixel_size = 4,
  music = love.audio.newSource('levels/001-southpole.it', 'static'),
  entities = {
    background = Background:subclass():include({
      drawPixel = function(self, x, y)
        local p = self.level.pixel_size
        local c = math.ceil(SimplexNoise.Noise2D(math.floor(x / p), math.floor( y / p)) * 20)
        -- slightly blue-whiteish
        love.graphics.setColor( 205 + c, 205 + c, 235 + c, 255)
        love.graphics.rectangle('fill', x * p, y * p, p, p)
      end
    }),
    pole = Entity:subclass():include({
      onInitialize = function(self)
        self.position = { x = self.level.width / 2, y = self.level.height / 2, z = 5 }
      end,
      drawContent = function(self)
        local p = self.level.pixel_size
        love.graphics.setColor( 0, 0, 0, 255)
        love.graphics.rectangle('fill', 0, 0, p/2, p * 4)
        love.graphics.setColor( 255, 0, 0, 255)
        love.graphics.rectangle('fill', 0, p/2, p * 2, p)
      end
    }),
    pixel = Pixel:subclass():include({
      onInitialize = function(self)
        self.position = { x = 0, y = 0, z = 10 }
        self:moveTo(self.level.width / 2, self.level.height / 2, 20)
      end,
      drawContent = function(self)
        local p = self.level.pixel_size
        love.graphics.setColor( 0, 0, 0, 255)
        love.graphics.rectangle('fill', 0, 0, p, p)
        love.graphics.setColor( 200, 200, 200, 255)
        love.graphics.rectangle('fill', 0, p, p, p)
        love.graphics.setColor( 0, 200, 0, 255)
        love.graphics.rectangle('fill', 0, 2*p, p, p)
      end
    })
  },
  onUpdate = nil
}
