
require 'entities/pixel'
require 'entities/background'

require 'level'
require 'views/level_view'
require 'views/log_view'
LevelState = class("LevelState", State)

function LevelState:initialize(level)
  local height = game.graphics.mode.height - 16
  local width = game.graphics.mode.width - 16
  self.level = Level(level, math.floor(math.random() * 100), width, height)
  self.log = {'Where is Pixel?', self.level.name, self.level.description}
  self.log_view = LogView(self.log)
  self.view = LevelView(self.level)
  self.score_view = ScoreView()
  self.view:update()
  love.graphics.setFont(game.fonts.small)
end

function LevelState:draw()
  self.view:draw()

  --self.score_view:draw()

  self.log_view:draw()

  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

function LevelState:update(dt)
  dt = 0.05
  self.level:update(dt)
  self.view:update()
end

function LevelState:mousepressed(x, y, button)
  self.level:eachEntity( function(entity)
    if entity.mousepressed and entity.includesPoint and entity:includesPoint(x, y) then
      entity:mousepressed(x, y, button)
    end
  end)
end
