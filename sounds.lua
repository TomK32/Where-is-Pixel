
local sounds = {}

sounds.fx = {
  found_pixel = love.audio.newSource('sounds/hurray.mp3', 'static')
}

sounds.music = {
  love.audio.newSource('sounds/start_menu.it', 'stream'),
}

for i, sound in pairs(sounds.music) do
  sound:setLooping(true)
end

return sounds
