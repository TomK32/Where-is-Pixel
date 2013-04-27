
Level = class("Level")

Level.levels = {
  require('levels/001-southpole')
}

function Level:initialize(level, seed)
  -- merge the level's values into this
  assert(Level.levels[level], 'Level ' .. level .. ' is missing')
  for k,v in pairs(Level.levels[level]) do
    self[k] = v
  end

  self.level = level
  self.seed = seed + level
  self.dt = 0
end

function Level:update(dt)
  self.dt = self.dt + dt
  for layer, entities in pairs(self.map.layers) do
    for i, entity in pairs(entities) do
      if game.stopped then return end
      entity:update(dt)
      if entity.dead == true then
        table.remove(self.map.layers[layer], i)
      end
    end
  end
  self.generator:update(dt)
end


