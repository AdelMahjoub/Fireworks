window = require("window")
getVector = require("vector")
getParticle = require("particle")
getFirework = require("firework")

local firstFrameSkipped = false
local fireworks = {}
local totalFireworks = 20
local fireworksLaunched = 0
local time = love.timer.getTime()
local delay = 0.5

local rocketsOnScreen = 0
local sparksOnScreen = 0

function love.load()
   
end

function love.update(dt)
    
    if not firstFrameSkipped then
        return
    end
    
    if fireworksLaunched < totalFireworks then 
        if (love.timer.getTime() - time) >= delay then
            fireworks[#fireworks + 1] = getFirework()
            time = love.timer.getTime()
            fireworksLaunched = fireworksLaunched + 1
        end 
    end
    
    for i, firework in ipairs(fireworks) do
        firework.update(dt)
    end
    
    rocketsOnScreen = 0
    sparksOnScreen = 0
    for i, firework in ipairs(fireworks) do
        if (firework.rocket.position.getY() < window.height and firework.rocket.position.getY() > firework.y) then
            rocketsOnScreen = rocketsOnScreen + 1
        end
        for i, particle in ipairs(firework.particles) do
            if particle.isVisible then
                sparksOnScreen = sparksOnScreen + 1
            end 
        end
    end
end

function love.draw()
    love.graphics.print(("FPS: %d\tROCKETS: %d\tSPARKS: %d"):format(love.timer.getFPS(), rocketsOnScreen, sparksOnScreen), 10, window.height - 20)
    if not firstFrameSkipped then
        firstFrameSkipped = true
        return 
    end
    love.graphics.setColor(250, love.math.random(255), love.math.random(255))
    for i, firework in ipairs(fireworks) do
        firework.draw()
    end
end