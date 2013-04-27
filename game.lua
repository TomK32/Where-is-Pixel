
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
  url = 'http://ananasblau.com/where-is-pixel',
  levels = {

  },
  current_level = 1
}

function game:createFonts(offset)
  local font_file = 'fonts/Comfortaa-Regular.ttf'
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
  love.mouse.setVisible(false)
  game.current_state = LevelState(game.current_level)
end

function game:hasNextLevel()
  return self.current_level < #self.levels
end

function game:nextLevel()
  if self:hasNextLevel() then
    self.current_level = self.current_level + 1
  end
  game:start()
end

function game:finished(player, message, progress)
  love.mouse.setVisible(true)
  game.stopped = true
  game.current_state = FinishScreen(player, message, progress)
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
