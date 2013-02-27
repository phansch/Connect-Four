Gamestate = require "libraries.hump.gamestate"
Signals = require "libraries.hump.signal"
Vector = require ".libraries.hump.vector"
Timer = require "libraries.hump.timer"
require "libraries.Helper"
require "states.game"
require "states.menu"

--TODO: Move these somewhere else
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
window.mousePos = nil
window.center = Vector(window.width/2, window.height/2)
window.textColor = {255, 255, 255, 255}
window.bgColor = {14, 86, 167, 255}

game.player1Color = {255, 155, 1, 200}
game.player2Color = {1, 169, 118, 200}

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