

CreditsView = class("CreditsView", View)
CreditsView.gui = require 'lib/quickie'

function CreditsView:drawContent()
  love.graphics.setFont(game.fonts.regular)
  love.graphics.setColor(255,255,255,255)
  self.gui.core.draw()
end

function CreditsView:update(dt)
  local x = 100
  local y = math.max(0, self.display.height - 1.5 * 8 * game.fonts.lineHeight - 70)

  self.gui.group.push({grow = "down", pos = {x, y}})
  self.gui.Label({size = {'tight', 1.5 * 6 * game.fonts.lineHeight},
    text = "Where is Pixel? is a game by Ananasblau Games.\
\
Programming: Thomas R. Koll, http://ananasblau.com"})

  if self.gui.Button({text = 'Return to menu'}) then
    game:startMenu()
  end
end


