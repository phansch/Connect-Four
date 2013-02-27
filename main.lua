Gamestate = require "libraries.hump.gamestate"
Signals = require "libraries.hump.signal"
Vector = require ".libraries.hump.vector"
Timer = require "libraries.hump.timer"
require "libraries.Helper"
require "states.game"
require "states.menu"

require "config"

function love.load()
    love.graphics.setBackgroundColor(window.bgColor)

    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function love.update(dt)
    Timer.update(dt)
    window.mousePos = Vector(love.mouse.getX(), love.mouse.getY())
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end