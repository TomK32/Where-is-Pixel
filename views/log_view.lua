
LogView = class("LogView", View)

-- see Lovel for default log_position
function LogView:initialize(log, position)
  View.initialize(self)
  self.display.height = 60
  self.display.width = 300
  self.display.x = nil
  self.display.y = nil
  if position then
    if position[1] ~= 0 then
      self.display.x = game.graphics.mode.width * position[1] - self.display.width - 10
    end
    if position[2] ~= 0 then
      self.display.y = game.graphics.mode.height * position[2] - self.display.height - 10
      print(position.y)
    end
  end
  self.display.x = self.display.x or 10
  self.display.y = self.display.y or 10
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
