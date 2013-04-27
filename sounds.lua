
local sounds = {}

sounds.fx = {
}

sounds.music = {
}

for i, sound in pairs(sounds.music) do
  sound:setLooping(true)
end

return sounds
