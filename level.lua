
Level = class("Level")

SimplexNoise = require("lib/SimplexNoise")
LuaBit = require("lib/LuaBit")

Level.levels = {
  require('levels/001-southpole'),
  require('levels/002-arctic-sea')
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

  self.log_position = self.log_position or {0, 1}
  self.layers = {}
  self.layer_indexes = {}
  self.entities = nil

  -- play it here instead of the LevelState in case the entities need some time to load
  if self.music then
    game.changeMusic(self.music)
  end

  for name, entity in pairs(level.entities) do
    if type(entity) == 'table' and type(entity[1]) == 'number' then
      for i=1, entity[1] do
        self:addEntity(entity[2]({level = self, id = i}))
      end
    else
      if entity.initialize then
        entity = entity({level = self})
      end
      self:addEntity(entity)
    end
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


function Level:eachEntity(callback)
  for i, layer in ipairs(self.layer_indexes) do
    entities = self.layers[layer]
    table.sort(entities, function(a, b) return a.position.y > b.position.y end)
    for i,entity in ipairs(entities) do
      callback(entity)
    end
  end
end
