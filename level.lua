
Level = class("Level")

SimplexNoise = require("lib/SimplexNoise")
LuaBit = require("lib/LuaBit")

Level.levels = {
  require('levels/001-southpole')
}

function Level:initialize(level, seed, width, height)
  self.seed = seed + level
  SimplexNoise.seedP(self.seed)
  self.width = width
  self.height = height

  -- merge the level's values into this
  assert(Level.levels[level], 'Level ' .. level .. ' is missing')
  level = Level.levels[level]
  for k,v in pairs(level) do
    self[k] = v
  end

  self.layers = {}
  self.layer_indexes = {}
  self.entities = {}

  for name, entity in pairs(level.entities) do
    if entity.initialize then
      entity = entity({level = self})
    end
    self:addEntity(entity)
  end

  self.dt = 0
end

function Level:update(dt)
  self.dt = self.dt + dt
  for layer, entities in pairs(self.layers) do
    for i, entity in pairs(entities) do
      if game.stopped then return end
      entity:update(dt)
      if entity.dead == true then
        table.remove(self.layers[layer], i)
      end
    end
  end
  if self.onUpdate then
    self:onUpdate(dt)
  end
end

function Level:addEntity(entity)
  entity.view = self.view
  if not entity.position then
    entity.position = {x = 0, y = 0, z = 0}
  end
  if not self.layers[entity.position.z] then
    self.layers[entity.position.z] = {}
  end
  table.insert(self.layer_indexes, entity.position.z)
  table.sort(self.layer_indexes, function(a,b) return a < b end)
  table.insert(self.layers[entity.position.z], entity)
end



