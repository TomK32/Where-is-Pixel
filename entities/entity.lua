
Entity = class("Entity")
Entity.map = nil
Entity._type = nil

function Entity:initialize(options)
  self.creation_timer = 2 + 2 * math.random()
  self.creation_timer_start = self.creation_timer

  self.name = self.class.name
  self.moving_position = { x = 0, y = 0} -- for the walking animation
  if options then
    for k, v in pairs(options) do
      self[k] = v
    end
  end
  if self._type == nil then
    self._type = self.class.name
  end
  if self.onInitialize then
    self:onInitialize()
  end
  if not self.position then
    self.position = {x = 1, y = 1, z = 1}
  end
  if not self.position.width then
    self.position.width = 1
  end
  if not self.position.height then
    self.position.height = 1
  end
end

function Entity:draw()
  love.graphics.push()
  local options = 255
  if self.creation_timer and self.creation_timer > 0 then
    opacity = math.floor(math.max(0, 255 - 255 * self.creation_timer / self.creation_timer_start))
    self.moving_position = { x = 0, y = (self.creation_timer / self.creation_timer_start) / 2}
  end
  love.graphics.setColor(255,255,255,opacity)
  love.graphics.translate(self.position.x, self.position.y)
  if self.moving_position then
    love.graphics.translate(-self.moving_position.x, -self.moving_position.y)
  end
  if self.particles then
    love.graphics.draw(self.particles, 0, 0)
  end
  if self.canvas then
    love.graphics.draw(self.canvas, 0, 0)
  end
  self:drawContent()
  love.graphics.pop()
end

function Entity:drawContent()
end

function Entity:update(dt)
  if self.creation_timer and self.creation_timer > 0 then
    self.creation_timer = self.creation_timer - dt
  end
  if self.particles and self.particles.update then
    self.particles:update(dt)
  end
end

function Entity:includesPoint(x, y)
  if not self.collision_rect then
    self.collision_rect = {0,0,0,0}
  end
  local r = {
    self.position.x + self.collision_rect[1],
    self.position.y + self.collision_rect[2],
    self.position.x + self.collision_rect[3] + (self.width or 0),
    self.position.y + self.collision_rect[4] + (self.height or 0)
  }
  if r[1] <= x and r[2] <= y and
     r[3] >= x and r[4] >= y then
    return true
  end
  return false
end

function Entity:createParticles(image)
  local particles = love.graphics.newParticleSystem(image, 3)
  particles:setEmissionRate          (20)
  particles:setLifetime              (-1)
  particles:setParticleLife          (1.5)
  particles:setPosition              (game.tile_size.x / 2, game.tile_size.y / 2)
  particles:setDirection             (math.pi * 1.5)
  particles:setSpread                (1)
  particles:setSpeed                 (0, 30)
  particles:setGravity               (0)
  particles:setRadialAcceleration    (10)
  return particles
end
