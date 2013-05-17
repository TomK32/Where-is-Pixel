
require 'views/view'
gui = require 'lib/quickie'

StartMenuView = class("MenuView", View)
gui.core.style.color.hot.fg = {89,1,14}
gui.core.style.color.normal.bg = {80,180,80}
gui.core.style.color.normal.fg = {0,0,0}

StartMenuView.title = love.graphics.newImage('images/title.png')

StartMenuView.volume = { value = love.audio.getVolume(), min = 0.01, max = 1.0 }

function StartMenuView:drawContent()
  game.clearScreen()
  love.graphics.setFont(game.fonts.large)

  gui.core.draw()
  x = game.graphics.mode.width / 12 + 120
  y = 20

  love.graphics.setFont(game.fonts.very_large)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(self.title, x, y)

  love.graphics.push()
  love.graphics.setFont(game.fonts.large)
  love.graphics.translate(x, math.min(500, game.graphics.mode.height * 0.4))
  love.graphics.print("Yes, Pixel looks a bit funny.", 0, 0)
  love.graphics.translate(0, game.fonts.lineHeight)
  love.graphics.print("Pixel has no gender.", 0, 0)
  love.graphics.translate(0, 3 * game.fonts.lineHeight)
  love.graphics.print("A search game for today's pixel-head.", 0, 0)
  love.graphics.translate(0, game.fonts.lineHeight)
  love.graphics.print("Explore the world from you home computer.", 0, 0)
  love.graphics.translate(0, game.fonts.lineHeight)
  love.graphics.print("Your friend Pixel is already there, can you find him?", 0, 0)

  love.graphics.translate(0, 2 * game.fonts.lineHeight)
  love.graphics.setFont(game.fonts.small)
  love.graphics.print("PS: Want to make a level? Send a mail to info@ananasblau.com", 0, 0)

  love.graphics.pop()


  love.graphics.translate(game.graphics.mode.width / 3 * 2, game.graphics.mode.height / 4)
  if not self.pixel then
    self.pixel = Pixel({scale = 64})
  end
  self.pixel:draw()
end

function StartMenuView:update(dt)
  love.graphics.setFont(game.fonts.large)
  local x = game.fonts.lineHeight
  local y = game.graphics.mode.height / 4

  gui.group.push({grow = "down", pos = {x, y}})
  -- start the game
  if gui.Button({text = 'Hard'}) then
    game.pixel_size = 1
    game:start()
  end
  if gui.Button({text = 'Medium'}) then
    game.pixel_size = 2
    game:start()
  end
  if gui.Button({text = 'Easy'}) then
    game.pixel_size = 4
    game:start()
  end
  gui.group.push({grow = "down", pos = {0, 20}})

  -- fullscreen toggle
  if self.fullscreen then
    text = 'Windowed'
  else
    text = 'Fullscreen'
  end
  if gui.Button({text = text}) then
    self.fullscreen = not self.fullscreen
    love.graphics.setMode(love.graphics.getWidth(), love.graphics.getHeight(), self.fullscreen)
  end

  gui.group.push({grow = "down", pos = {0, 20}})
  gui.Label({text = "Volume"})
  if gui.Slider({info = self.volume}) then
    love.audio.setVolume(self.volume.value)
  end

  if gui.Button({text = "Credits"}) then
    game:showCredits()
  end

  if gui.Button({text = "Donate"}) then
    openURL(game.paypal_url)
  end

  if gui.Button({text = "More games"}) then
    openURL(game.more_games_url)
  end


end
