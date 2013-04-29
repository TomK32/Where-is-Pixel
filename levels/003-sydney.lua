
-- Level 3
-- The background image is based on following image and is there
-- for released under the same licenses as the original image
-- http://commons.wikimedia.org/wiki/File:Sydney_Opera_House_Sails_edit02.jpg
--
return {
  name = 'The Opera House in Sydney.',
  description = "Maybe he's at the waterside",
  pixel_size = 4,
  music = function() return love.audio.newSource('sounds/003-ocean-of-the-golem.it', 'stream') end,
  log_position = {1, 0},
  entities = {
    background = Background:subclass():include({
      onInitialize = function(self)
        self.position = {x = 0, y = 0, z = 0}
        self.image = love.graphics.newImage('images/003-sydney.png')
      end
    }),
    pixel = Pixel:subclass():include({
      onInitialize = function(self)
        local f = self.level.width / 960
        self.position = { z = 10,
          x = f * (120 + math.random() / 2 * 720), y = self.level.height * 460/540 }
        self:moveTo(f * (200 + math.random() / 2 * 720), self.position.y, 20)
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

