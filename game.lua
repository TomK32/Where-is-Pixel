
game = {
  title = 'Where is Pixel?',
  debug = false,
  graphics = {
    mode = { height = love.graphics.getHeight(), width = love.graphics.getWidth() }
  },
  fonts = {},
  sounds = require('sounds'),
  version = require('version'),
  name = 'Where is Pixel?',
  url = 'http://ananasblau.com/whereispixel',
  paypal_url = 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=UJ2S9DN8QHWZJ',
  volume = 1.0,
  found_pixel_messages = {
    'You found Pixel!',
    'Oh there is Pixel :)'
  },
  current_level = 1
}

function game:update(dt)
  if game.music_volume and game.music_volume ~= game.last_music_volume then
    game.music:setVolume(game.music_volume)
    game.last_music_volume = game.music_volume
  end
end

function game:createFonts(offset)
  local font_file = 'fonts/Orbitron Medium.ttf'
  self.fonts = {
    lineHeight = (20 + offset) * 1.7,
    small = love.graphics.newFont(font_file, 14 + offset),
    regular = love.graphics.newFont(font_file, 20 + offset),
    large = love.graphics.newFont(font_file, 24 + offset),
    very_large = love.graphics.newFont(font_file, 48 + offset)
  }
end

function game:setMode(mode)
  self.graphics.mode = mode
  love.graphics.setMode(mode.width, mode.height, mode.fullscreen or self.graphics.fullscreen)
  if self.graphics.mode.height < 600 then
    self:createFonts(-2)
  else
    self:createFonts(0)
  end
end


function game:startMenu()
  love.mouse.setVisible(true)
  game.current_state = StartMenu()
end

function game:start()
  game.stopped = false
  --love.mouse.setVisible(false)
  game.current_state = LevelState(game.current_level)
  game.level = game.current_state.level
end

-- pass nil to turn the music off
function game.changeMusic(new_music)
  if not game.music then
    game:playMusic(new_music)
  else
    tween(0.5, game, { music_volume = 0.0 }, 'linear', game.playMusic, new_music)
  end
end

function game.playMusic(music)
  if not music then return end
  if game.music then -- just in case
    love.audio.stop(game.music)
  end
  game.music = music
  game.music_volume = 0.0
  game.music:setVolume(0)
  love.audio.play(game.music)
  tween(2, game, {music_volume = game.volume})
end

function game:hasNextLevel()
  return self.current_level < #Level.levels
end

function game:nextLevel()
  if self:hasNextLevel() then
    self.current_level = self.current_level + 1
  end
  game:start()
end

function game.finished(message, progress)
  love.mouse.setVisible(true)
  game.stopped = true
  game.current_state = Finish(message, progress, game.current_state.view)
end

function game.foundPixel()
  game.finished(game.found_pixel_messages[(game.current_level % #game.found_pixel_messages) + 1], true)
end

function game.loadImage(image)
  return love.graphics.newImage(image)
end

function game:newVersion(version, url)
  game.current_state = NewVersion(version, url)
end

function game:showCredits()
  game.current_state = State(self, 'Credits', CreditsView())
end

function game.clearScreen(color, x, y, width, height)
  if not color then
    color = {50,103,200,255}
  end
  love.graphics.setColor(unpack(color))
  love.graphics.rectangle('fill', x or 0, y or 0, width or game.graphics.mode.width, height or game.graphics.mode.height)
end
