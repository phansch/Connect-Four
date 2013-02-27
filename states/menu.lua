menu = {}

require "libraries.LoveFrames"

function menu:enter(previous, endData)

    self:createGUI()

    if endData then
        -- do extra stuff
    end

end

function menu:createGUI()

    local frame = loveframes.Create("frame")
    frame:SetSize(200, 120)
    frame:Center()
    frame:SetName("Connect-Four")
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)

    local button_start = loveframes.Create("button", frame)
    button_start:SetPos(frame.width/2 - button_start.width/2, frame.height/2 - button_start.height/2)
    button_start:SetText("Start game")
    button_start.OnClick = function()
        Gamestate.switch(game)
    end

    local button_quit = loveframes.Create("button", frame)
    button_quit:SetPos(frame.width/2 - button_quit.width/2, frame.height/2 - button_quit.height/2 + 30)
    button_quit:SetText("Exit game")
    button_quit.OnClick = function()
        love.event.quit()
    end
end

function menu:update(dt)
    loveframes.update(dt)
end

function menu:draw()
    loveframes.draw()
end

function menu:mousepressed(x, y, button)
    loveframes.mousepressed(x, y, button)
end

function menu:mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end