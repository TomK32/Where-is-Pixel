anim8 = require 'lib/anim8'

function createAnimation(image_path, animation_options, grid_options)
  local image = love.graphics.newImage(image_path)
  if not grid_options then
    grid_options = {48, 48}
  end
  local grid = anim8.newGrid(grid_options[1], grid_options[2], image:getWidth(), image:getHeight())
  local animation = anim8.newAnimation(image, animation_options[1], grid(animation_options[2]), animation_options[3])
  return animation
end

