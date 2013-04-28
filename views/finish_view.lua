
FinishView = class("FinishView", View)
FinishView.gui = require 'lib/quickie'

function FinishView:initialize(message, allow_progress)
  View:initialize(self)
  self.message = message or 'Finish'
  self.allow_progress = allow_progress
  self.x = self.display.width - #self.message * 20 - 220
  self.y = math.max(0, self.display.height - 150)
end

function FinishView:drawContent()
  love.graphics.setFont(game.fonts.regular)
  love.graphics.setColor(255, 255, 255, 150)
  love.graphics.rectangle('fill', self.x - 10, self.y, #self.message * 20 + 160, 100)
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.rectangle('line', self.x - 10, self.y, #self.message * 20 + 160, 100)

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
  self.gui.group.push({grow = "right", pos = {#self.message * 10, 0 }})
  if self.gui.Button({text = 'Back to main menu'}) then
    game:startMenu()
  end
end
