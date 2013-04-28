--
-- Where is Pixel?
--
-- (C) 2013 Thomas R. Koll

require 'lib/middleclass'
require 'game'
require 'views/view'
require 'views/credits_view'
require 'game_states/state'
require 'game_states/intro'
require 'game_states/start_menu'
require 'game_states/level_state'
require 'game_states/finish'
tween = require 'lib/tween'

function love.load()
  local modes = love.graphics.getModes()
  table.sort(modes, function(a, b) return a.width*a.height > b.width*b.height end)
  local preferred_mode = modes[1]
  for i, mode in ipairs(modes) do
    if math.abs(9/16 - mode.height / mode.width) < 0.1 and (mode.height >= 480 or mode.width >= 854) then
      preferred_mode = mode
    end
  end
  game:setMode(preferred_mode)

  game.current_state = Intro(game.startMenu)

  game.playMusic(game.sounds.music[1])
  --game:start()
end

function love.draw()
  if not game.current_state then return end
  game.current_state:draw()

  if not madeScreenshot and game.debug then
    madeScreenshot = true
    makeScreenshot()
  end
end

function love.keypressed(key)
  if key == 'f2' then
    makeScreenshot()
  end
  if not game.current_state then return end
  game.current_state:keypressed(key)
end
function love.mousepressed(x,y,button)
  if game.current_state.mousepressed then
    game.current_state:mousepressed(x,y,button)
  end
end
function love.update(dt)
  dt = 0.015
  if not game.current_state then return end
  game:update(dt)
  tween.update(dt)
  game.current_state:update(dt)
end

function love.quit()
  if game.debug then
    makeScreenshot()
  end
end

function makeScreenshot()
  love.graphics.newScreenshot():encode(os.time() .. '.png', 'png')
end

function openURL(url)
  if love._os == 'OS X' then
    os.execute('open "' .. url .. '"')
  elseif love._os == 'Windows' then
    os.execute('start "' .. url .. '"')
  elseif love._os == 'Linux' then
    os.execute('xdg-open "' .. url .. '"')
  end
end

