
require 'level'
require 'views/level_view'
require 'views/log_view'

LevelState = class("LevelState", State)

function LevelState:initialize(level)
  self.level = Level(level, math.floor(math.random() * 100))
  self.log = {'Where is Pixel?'}
  self.log_view = LogView(self.log)
  self.view = LevelView(self.level)
  self.score_view = ScoreView()
  self.score_view.player = self.level.player
  self.view:update()
  love.graphics.setFont(game.fonts.small)
end

function LevelState:draw()
  self.view:draw()

  self.score_view:draw()

  self.log_view:draw()

  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
  love.graphics.print("x: " .. self.level.player.position.x .. ', y: ' .. self.level.player.position.y, 10, 35)
end

function LevelState:update(dt)
  dt = 0.05
  self.level:update(dt)
  self.view:update()
end
