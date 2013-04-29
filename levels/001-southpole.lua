--
-- regarding positions:
--  0 background
--  5 other entities
-- 10 Pixel
-- 20 clouds
-- 99 ISS

-- NOTE: Always make sure the level doesn't load big chunky things liek sounds or things go bad.

-- Level 1

return {
  name = 'South Pole',
  description = 'Can you find him here in this white desert?',
  pixel_size = 4,
  music = function() return love.audio.newSource('sounds/001-broken-sisters.it', 'stream') end,
  entities = {
    background = Background:subclass():include({
      drawPixel = function(self, x, y)
        local p = self.level.pixel_size
        local c = math.ceil(SimplexNoise.Noise2D(math.floor(x / p), math.floor( y / p)) * 10)
        -- slightly blue-whiteish
        love.graphics.setColor( 240 + c, 240 + c, 245 + c, 255)
        love.graphics.rectangle('fill', x * p, y * p, p, p)
      end
    }),
    clouds = { 3, Background:subclass():include({
      blendMode = 'premultiplied',
      pixel_size = 8,
      scale = {16, 2},
      onInitialize = function(self)
        local p = self.pixel_size
        -- create smaller size
        self.width = self.level.width * 2
        self.height = self.level.height / 2
        SimplexNoise.seedP(self.id)
        self.position = {
            x = - self.width * math.abs(SimplexNoise.Noise2D(self.id, 1)*2),
            y = math.abs(math.floor(SimplexNoise.Noise2D(1, self.id) * self.level.height/self.id)),
            z = 20
        }
        -- move
        tween(20, self.position, {x = self.level.width, y = self.position.y - (3 + self.id)})
      end,
      drawPixel = function(self, x, y)
        local p = self.pixel_size
        local c = math.ceil(SimplexNoise.Noise2D(x / 40, y * 10) * 20)
        if c < 0 then return end
        -- slightly blue-whiteish
        love.graphics.setColor( 235 + c, 235 + c, 235 + c, 50)
        love.graphics.rectangle('fill', x * p, y * p, p, p)
      end

    })},
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
        local p = 4
        self.collision_rect = { - p, - p, 3 * p, 4 * p}
        self.position = { x = self.level.width * math.random(), y = 0, z = 10 }
        self:moveTo(self.level.width / 2, self.level.height / 2, 20)
      end,
      drawContent = function(self)

        local p = self.pixel_size
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
