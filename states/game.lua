Gamestate.game = Gamestate.new()
local state = Gamestate.game

function state:enter(previous)
    if previous == Gamestate.menu or previous == Gamestate.gameover then
        self:startGame()
    end
end

function state:startGame()

end

function state:update(dt)

end

function state:draw()

end