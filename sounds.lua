
local sounds = {}

sounds.fx = {
}

sounds.music = {
  love.audio.newSource('sounds/start_menu.it', 'static'),
}

for i, sound in pairs(sounds.music) do
  sound:setLooping(true)
end

return sounds
