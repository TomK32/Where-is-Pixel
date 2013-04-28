
LogView = class("LogView", View)

function LogView:initialize(log)
  View.initialize(self)
  self.display.x = 30
  self.display.y = game.graphics.mode.height - game.fonts.lineHeight * 4
  self.display.height = 60
  self.display.width = 300
  self.log = log
end

function LogView:drawContent()
  love.graphics.setColor(0,0,0,200)
  love.graphics.rectangle('line', 0, 0, self.display.width, self.display.height)
  love.graphics.setColor(255,255,255,100)
  love.graphics.rectangle('fill', 0, 0, self.display.width, self.display.height)
  love.graphics.setFont(game.fonts.small)
    love.graphics.setColor(0,0,0,255)
  for i = math.max(1, #self.log - 3), 3 do
    love.graphics.print(self.log[i], 10, 5 + (i-1) * game.fonts.lineHeight * 0.5)
    love.graphics.setColor(50,50,50,255)
  end
  love.graphics.setColor(255,255,255,255)
end
