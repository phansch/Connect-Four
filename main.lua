Gamestate = require "libraries.hump.gamestate"
Signals = require "libraries.hump.signal"
Vector = require ".libraries.hump.vector"
Timer = require "libraries.hump.timer"
require "libraries.Helper"

--TODO: Move these somewhere else
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
window.mousePos = nil
window.center = Vector(window.width/2, window.height/2)

local game = require('states.game')

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(Gamestate.game)
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