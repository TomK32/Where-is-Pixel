
-- Level 2
--
return {
  name = 'Arctic Sea',
  description = 'Pixel is swimming north to Australia.',
  pixel_size = 4,
  music = function() return love.audio.newSource('sounds/002-wizards-of-the-hands.it', 'stream') end,
  log_position = {1, 0},
  entities = {
    background = Background:subclass():include({
      drawPixel = function(self, x, y)
        local p = self.level.pixel_size
        local c = math.ceil(SimplexNoise.Noise2D(math.floor(x / p)/20, math.floor( y / p)) * 30)
        -- slightly blue-whiteish
        love.graphics.setColor( 40 + c, 40 + c, 205 + c, 255)
        love.graphics.rectangle('fill', x * p, y * p, p, p)
      end
    }),
    ship = Actor:subclass():include({
      onInitialize = function(self)
        self.position = { x = self.level.width / 4, y = self.level.height / 4, z = 5 }
        self:moveTo(self.level.width, self.level.height / 9, self.level.width / 2)
        self.animation = createAnimation('images/ship.png', {'loop', '1-3,1', 1.4}, {64, 32})
        self.collision_rect = { 0, 0, 32, 16}
      end
    }),
    ship2 = Actor:subclass():include({
      onInitialize = function(self)
        self.position = { x = self.level.width / 8, y = self.level.height / 2, z = 5 }
        self:moveTo(self.level.width, self.level.height / 3, self.level.width / 2)
        self.animation = createAnimation('images/ship.png', {'loop', '1-3,1', 1.4}, {64, 32})
        self.collision_rect = { 0, 0, 32, 16}
      end
    }),
    pixel = Pixel:subclass():include({
      onInitialize = function(self)
        self.position = { x = self.level.width * (0.25 + math.random()/2), y = self.level.height, z = 10 }
        self:moveTo(self.position.x * ( 0.5 + math.random() / 4), 0, 20)
      end
    })
  },
  onUpdate = nil
}
