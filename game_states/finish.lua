
require 'views/finish_view'

Finish = class("Finish", State)

function Finish:initialize(message, allow_progress, level_view)
  self.view = FinishView(message, allow_progress)
  self.view.state = self
  self.level_view = level_view
  self.wait = 0.5
end

function Finish:draw()
  self.level_view:draw()
  self.view:draw()
end
function Finish:keypressed(key, unicode)
  if self.wait and self.wait > 0 then
    return
  end
  if key == 'escape' then
    game:startMenu()
  end
  self.view.gui.keyboard.pressed(key, code)
end
