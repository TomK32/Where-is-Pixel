
LevelView = class("LevelView", View)
LevelView:include({
  level = nil,
  top_left = { x = 0, y = 0 }, -- offset
  scale = game.tile_size,
  canvas = nil,
})

function LevelView:initialize(level)
  View.initialize(self)
  self.level = level
  self.draw_cursor = false
  self.canvas = love.graphics.newCanvas(self.display.width, self.display.height)
end

function LevelView:drawContent()
  if self.canvas then
    love.graphics.draw(self.canvas, 0, 0)
  end
end

function LevelView:update()
  love.graphics.setCanvas(self.canvas)
  love.graphics.setColor(100,153,100,255)
  love.graphics.rectangle('fill', 0,0,self.display.width, self.display.height)

  for z, layer in ipairs(self.level.layer_indexes) do
    entities = self.level.layers[layer]
    table.sort(entities, function(a, b) return a.position.y > b.position.y end)
    for i, entity in ipairs(entities) do
      love.graphics.push()
      entity:draw()
      love.graphics.pop()
    end
  end
  love.graphics.setCanvas()
  return self.canvas
end

function LevelView:centerAt(position)
  x = position.x - math.floor(self:tiles_x() / 2)
  y = position.y - math.floor(self:tiles_y() / 2)
  if math.abs(self.top_left.x - x) >= 1 or math.abs(self.top_left.y - y) >= 1 then
    self.top_left = {x = x, y = y}
    self:fixTopLeft()
  end
  self:update()
end

function LevelView:moveTopLeft(offset, dontMoveCursor)
  self.top_left.x = self.top_left.x + 3 * offset.x
  self.top_left.y = self.top_left.y + 3 * offset.y
  fixTopLeft()
  if not dontMoveCursor then
    self:moveCursor({x = offset.x * 3, y = offset.y * 3}, true)
  end
end

function LevelView:fixTopLeft()
  max_x = math.floor(self.level.height - self:tiles_x())
  if self.top_left.x < 0 then
    self.top_left.x = 0
  elseif self.top_left.x > max_x then
    self.top_left.x = max_x + 1
  end
  max_y = math.floor(self.level.height - self:tiles_y())
  if self.top_left.y < 0 then
    self.top_left.y = 0
  elseif self.top_left.y > max_y then
    self.top_left.y = max_y + 1
  end
end
