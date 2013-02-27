Class = require ".libraries.hump.class"
Vector = require ".libraries.hump.vector"

Board = Class{function(self)
    self.grid = {}
    self.columns = 10
    self.rows = 7
    self.selectedColumn = 0
    self.offset = {x = 50, y = 50}
    self.circleArgs = {}
end}

function Board:load()
    -- Create an empty board
    for column=1,self.columns do
        self.grid[column] = {}
        for row=1,self.rows do
            self.grid[column][row] = {
                                        player = 0,
                                        position = Vector(column * 60 + self.offset.x,
                                                            row * 60 + self.offset.y)
                                     }
        end
    end
end

function Board:update(currentPlayer)
    if not gameEnd then
        --check if the last player has won
        if currentPlayer == 1 then lastPlayer = 2
        elseif currentPlayer == 2 then lastPlayer = 1 end

        if self:isWinner(lastPlayer) then
            Gamestate.switch(menu, lastPlayer)
        end
    end
end

function Board:draw()

    -- draw player coins
    for row=1,self.columns do
        for column=1,self.rows do
            local cell = self.grid[row][column]
            self.circleArgs = {"fill", cell.position.x, cell.position.y, 25, 100}

            if cell.player == 1 then
                love.graphics.setColor(game.player1Color)
                love.graphics.circle(unpack(self.circleArgs))
            elseif cell.player == 2 then
                love.graphics.setColor(game.player2Color)
                love.graphics.circle(unpack(self.circleArgs))
            else
                love.graphics.setColor(255, 255, 255, 180)
                love.graphics.circle("line", cell.position.x, cell.position.y, 25, 100)
            end
        end
    end

    self:highlightColumn();
end

function Board:highlightColumn()
    -- draw active column indicator
    for row=1,self.columns do
        for column=1,self.rows do
            local cell = self.grid[row][column]

            if window.mousePos:dist(cell.position) <= 25 then
                love.graphics.line(cell.position.x, 60 + self.offset.y-80,
                                   cell.position.x, 60 + self.offset.y-40)
                self.selectedColumn = row
            end
        end
    end
end

function Board:insertCoin(player)
    if self.selectedColumn ~= nil then
        for i = self.rows, 1, -1 do
            if self.grid[self.selectedColumn][i].player == 0 then
                self.grid[self.selectedColumn][i].player = player
                Signals.emit("coin_inserted")
                break
            end
        end
    end
end

function Board:isWinner(player)
    -- check horizontal spaces


    for column = 1, self.columns-3 do
        for row = 1, self.rows do
            if self.grid[column][row].player == player and
                self.grid[column+1][row].player == player and
                self.grid[column+2][row].player == player and
                self.grid[column+3][row].player == player then
                return true
            end
        end
    end
    -- check vertical spaces
    for column = 1, self.columns do
        for row = 1, self.rows-3 do
            if self.grid[column][row].player == player and
                self.grid[column][row+1].player == player and
                self.grid[column][row+2].player == player and
                self.grid[column][row+3].player == player then
                return true
             end
        end
    end
    -- check / diagonal spaces
    for column = 1, self.columns-3 do
        for row = 4, self.rows do
            if self.grid[column][row].player == player and
                self.grid[column+1][row-1].player == player and
                self.grid[column+2][row-2].player == player and
                self.grid[column+3][row-3].player == player then
                return true
            end
        end
    end
    -- check \ diagonal spaces
    for column = 1, self.columns-3 do
        for row = 1, self.rows-3 do
            if self.grid[column][row].player == player and
                self.grid[column+1][row+1].player == player and
                self.grid[column+2][row+2].player == player and
                self.grid[column+3][row+3].player == player then
                return true
            end
        end
    end
    return false
end

Signals.register('leftmousepressed', function(player)
    board:insertCoin(player)
end)