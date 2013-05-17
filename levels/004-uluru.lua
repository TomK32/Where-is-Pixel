
-- Level 3
-- The background image is based on following image and is there
-- for released under the same licenses as the original image
-- http://commons.wikimedia.org/wiki/File:Sydney_Opera_House_Sails_edit02.jpg
--
return {
  name = 'Uluru',
  description = "Ayers Rock, does Pixel it's against the law to climb it?",
  pixel_size = 4,
  timer = 60,
  music = function() return love.audio.newSource('sounds/004-the-guns-tubes.it', 'stream') end,
  log_position = {1, 0},
  entities = {
    background = Background:subclass():include({
      onInitialize = function(self)
        self.position = {x = 0, y = 0, z = 0}
        self.image = love.graphics.newImage('images/004-uluru.png')
      end
    }),
    pixel = Pixel:subclass():include({
      onInitialize = function(self)
        self.colors = {
          {100, 80, 0},
          {200, 180, 100},
          {0, 200, 50},
          {0, 0, 100},
          {60, 20, 0}
        }
        local f = self.level.width / 960
        self.position = { z = 10,
          x = f * (360 + math.random() / 2 * 720), y = self.level.height * 252/540 }
      end
    })
  },
  onUpdate = nil
}

