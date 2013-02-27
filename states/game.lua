game = {}

require '.classes.Board'

local currentPlayer = 0
local totalTurns = 0

function game:enter(previous)
    if previous == menu then
        self:startGame()
    end
end

function game:startGame()
    board = Board()
    board:load()
    currentPlayer = 2
    Timer.clear()
    totalTurns = 0
end

function game:update(dt)
    board:update(currentPlayer)

    if totalTurns == 10 * 7 then
        Gamestate.switch(menu)
    end
end

function game:draw()
    board:draw()
    love.graphics.setFont(love.graphics.newFont(12))
    -- draw current player in the top left
    if currentPlayer == 1 then
        love.graphics.setColor(window.textColor)
        love.graphics.print("Player:", 10, 10)
        love.graphics.setColor(game.player1Color)
        love.graphics.circle("fill", 65, 17, 8, 100)
    elseif currentPlayer == 2 then
        love.graphics.setColor(window.textColor)
        love.graphics.print("Player:", 10, 10)
        love.graphics.setColor(game.player2Color)
        love.graphics.circle("fill", 65, 17, 8, 100)
    end
end

function game:switchPlayer()
    if currentPlayer == 1 then
        currentPlayer = 2
    else
        currentPlayer = 1
    end
    totalTurns = totalTurns + 1
end

function game:mousepressed(x, y, button)
    if button == "l" then
        Signals.emit("leftmousepressed", currentPlayer)
    end
end

Signals.register("coin_inserted", function()
    game:switchPlayer()
end)