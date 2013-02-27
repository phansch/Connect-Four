game = {}

require '.classes.Board'

local currentPlayer = 0
local gameEnd = false
local winner = 0
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
    gameEnd = false
    winner = 0
    Timer.clear()
end

function game:endGame(player)
    gameEnd = true
    winner = player
end

function game:update(dt)
    board:update(currentPlayer)

    if totalTurns == 10 * 7 then
        Signals.emit("game_over", 0)
    end
end

function game:draw()
    if not gameEnd then
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
    end

    if gameEnd and winner ~= 0 then
        love.graphics.setColor(window.textColor)
        love.graphics.print("Winner: ", 300, 10)
        if winner == 1 then
            love.graphics.setColor(255, 255, 0)
            love.graphics.circle("fill", 360, 15, 8, 100)
        elseif winner == 2 then
            love.graphics.setColor(255, 0, 0)
            love.graphics.circle("fill", 360, 15, 8, 100)
        end
    elseif gameEnd and winner == 0 then
        love.graphics.setColor(window.textColor)
        love.graphics.print("Draw", 300, 10)
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

Signals.register("game_over", function(player)
    game:endGame(player)
end)