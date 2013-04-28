
FinishView = class("FinishView", View)
FinishView.gui = require 'lib/quickie'

function FinishView:initialize(message, allow_progress, pixel)
  View:initialize(self)
  self.message = message or 'Finish'
  self.allow_progress = allow_progress
  self.display.width = game.graphics.mode.width / 2
  self.display.height = 100
  self.pixel = pixel

  self.x = (game.graphics.mode.width / 2 ) - self.display.width / 2
  self.y = (game.graphics.mode.height / 2 ) - self.display.height / 2
end

function FinishView:drawContent()
  love.graphics.setFont(game.fonts.regular)
  love.graphics.setColor(255, 255, 255, 150)
  love.graphics.rectangle('fill', self.x - 10, self.y, self.display.width, 100)
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.rectangle('line', self.x - 10, self.y, self.display.width, 100)

  love.graphics.push()
  love.graphics.translate(self.pixel.position.x, self.pixel.position.y)
  self.pixel:drawCollisionRect()

  love.graphics.pop()

  love.graphics.print(self.message, self.x, self.y + 10)
  self.gui.core.draw()
end

function FinishView:update()
  self.gui.group.push({grow = "right", pos = {self.x, self.y + 2 * game.fonts.lineHeight}})

  --love.graphics.setColor(255,255,255,255)
  if self.allow_progress then
    if game:hasNextLevel() then
      if self.gui.Button({text = 'Next level'}) then
        game:nextLevel()
      end
    else
      if self.gui.Button({text = "That's all folks!"}) then
        openURL(game.paypal_url)
      end
    end
  else
    if self.gui.Button({text = 'Play again'}) then
      game:start()
    end
  end
  self.gui.group.push({grow = "right", pos = {self.display.width / 5, 0 }})
  if self.gui.Button({text = 'Back to main menu'}) then
    game:startMenu()
  end
end
