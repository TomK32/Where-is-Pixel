

IntroView = class("IntroView", View)

function IntroView:initialize()
  View.initialize(self)
  self.intro = love.graphics.newImage('images/intro.png')
  self.position = {x = game.graphics.mode.width / 2 - self.intro:getWidth() / 2,
    y = game.graphics.mode.height / 2 - self.intro:getHeight() / 2}
end

function IntroView:drawContent()
  game.clearScreen()
  love.graphics.setFont(game.fonts.regular)
  local c = 255 * math.min(1, (self.dt_timer/3))
  love.graphics.setColor(c,c,c, c)
  love.graphics.draw(self.intro, self.position.x, self.position.y)
end

function IntroView:update(dt)
  if not self.dt_timer then self.dt_timer = 0 end
  self.dt_timer = self.dt_timer + dt
end

