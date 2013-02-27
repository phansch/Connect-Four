function love.conf(t)
    t.title = "Connect-Four"
    t.author = "Philipp Hansch"
    t.version = "0.8.0"
    t.url = "http://phansch.net"
    --t.release = true

    t.screen.width = 800
    t.screen.height = 600

    -- disabling modules that are not required for this project
    t.modules.joystick = false
    t.modules.physics = false
end