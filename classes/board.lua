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
    for row=1,self.columns do
        self.grid[row] = {}
        for column=1,self.rows do
            self.grid[row][column] = {
                                        player = 0, position = Vector(row * 60 + self.offset.x, column * 60 + self.offset.y)
                                     }
        end
    end
end

function Board:update()

end

function Board:draw()
    -- draw board surface
    love.graphics.setBackgroundColor(0, 0, 255)

    -- draw player coins
    for row=1,self.columns do
        for column=1,self.rows do
            local cell = self.grid[row][column]
            self.circleArgs = {"fill", cell.position.x, cell.position.y, 25, 100}

            if cell.player == 1 then
                love.graphics.setColor(255, 255, 0)
                love.graphics.circle(unpack(self.circleArgs))
            elseif cell.player == 2 then
                love.graphics.setColor(255, 0, 0)
                love.graphics.circle(unpack(self.circleArgs))
            else
                love.graphics.setColor(255, 255, 255, 100)
                love.graphics.circle(unpack(self.circleArgs))
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
                love.graphics.print(row, 10, 10)
                love.graphics.line(cell.position.x, 60 + self.offset.y-80, cell.position.x,60 + self.offset.y-40)
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

Signals.register('leftmousepressed', function(player)
    board:insertCoin(player)
end)