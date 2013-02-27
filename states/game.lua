Gamestate.game = Gamestate.new()
local state = Gamestate.game

require '.classes.Board'

local currentPlayer = 0
local gameEnd = false
local winner = 0

function state:enter(previous)
    self:startGame()
    if previous == Gamestate.menu or previous == Gamestate.gameover then
        self:startGame()
    end
end

function state:startGame()
    board = Board()
    board:load()
    currentPlayer = 2
    Timer.clear()
end

function state:endGame(type, player)
    gameEnd = true
    winner = player
end

function state:update(dt)
    board:update()
end

function state:draw()
    board:draw()

    -- draw current player in the top left
    if currentPlayer == 1 then
        love.graphics.setColor(window.textColor)
        love.graphics.print("Player:", 10, 40)
        love.graphics.setColor(255, 255, 0)
        love.graphics.circle("fill", 65, 47, 8, 100)
    elseif currentPlayer == 2 then
        love.graphics.setColor(window.textColor)
        love.graphics.print("Player:", 10, 40)
        love.graphics.setColor(255, 0, 0)
        love.graphics.circle("fill", 65, 47, 8, 100)
    end

    if gameEnd and winner ~= 0 then
        love.graphics.print("Winner: "..winner, 300, 10)
    elseif gameEnd and winner == 0 then
        love.graphics.print("Draw", 300, 10)
    end
end

function state:switchPlayer()
    if currentPlayer == 1 then
        currentPlayer = 2
    else
        currentPlayer = 1
    end
end

function state:mousepressed(x, y, button)
    if button == "l" then
        Signals.emit("leftmousepressed", currentPlayer)
    end
end

Signals.register("coin_inserted", function()
    state:switchPlayer()
end)

Signals.register("game_over", function(state, player)
    state:endGame(state, player)
end)