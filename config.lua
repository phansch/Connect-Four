-- Useful globals

-- Window settings
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
window.mousePos = nil
window.center = Vector(window.width/2, window.height/2)
window.textColor = {255, 255, 255, 255}
window.bgColor = {14, 86, 167, 255}

-- Game specific settings
game.player1Color = {255, 155, 1, 200}
game.player2Color = {1, 169, 118, 200}

-- Audio
sfx_coin_inserted = love.audio.newSource("audio/insert_coin.wav", "static")
love.audio.setVolume(0.2)