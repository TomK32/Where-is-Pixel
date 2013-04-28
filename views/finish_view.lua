
FinishView = class("FinishView", View)
FinishView.gui = require 'lib/quickie'

function FinishView:initialize(message, allow_progress)
  View:initialize(self)
  self.message = message or 'Finish'
  self.allow_progress = allow_progress
  self.x = self.display.width - #self.message * 20 - 220
  self.y = math.max(0, self.display.height - 130)
end

function FinishView:drawContent()
  love.graphics.setFont(game.fonts.regular)
  love.graphics.setColor(50, 0, 0, 200)
  love.graphics.rectangle('fill', self.x - 10, self.y - 50, #self.message * 20 + 160, 100)

  love.graphics.setColor(200, 255, 255, 255)
  love.graphics.print(self.message, self.x, self.y - 40)
  self.gui.core.draw()
end

function FinishView:update()
  self.gui.group.push({grow = "right", pos = {self.x + 40, self.y}})

  love.graphics.setColor(255,255,255,255)
  if self.allow_progress then
    if game:hasNextLevel() then
      if self.gui.Button({text = 'Next level'}) then
        game:nextLevel()
      end
    else
      self.gui.Label({text = "That's all folks!"})
    end
  else
    if self.gui.Button({text = 'Play again'}) then
      game:start()
    end
  end
  if self.gui.Button({text = 'Main menu'}) then
    game:startMenu()
  end
end
