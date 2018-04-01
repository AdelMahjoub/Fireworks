local function getFirework()
    local firework = {}
    firework.isInitialized = false
    firework.x = nil
    firework.y = nil
    firework.particles = {}
    firework.totalParticles = 120
    firework.particlesSpeedRange = {min = 100, max = 300}
    firework.radius = 100
    firework.rangeX = {min = firework.radius, max = window.width - firework.radius}
    firework.rangeY = {min = firework.radius, max = 2 * firework.radius}
    firework.outOfBoundCount = 0
    firework.hasExploded = false
    firework.rocket = getParticle(0, window.height, 0, 0)
    firework.rocketSpeed = 800
    firework.gravity = getVector(0, 0.12)
    firework.color = {255, love.math.random(255), love.math.random(255)}

    function firework.setRandomPosition()
        firework.x = love.math.random(firework.rangeX.min, firework.rangeX.max)
        firework.y = love.math.random(firework.rangeY.min, firework.rangeY.max)
    end

    function firework.initParticles(dt) 
        for i = 1, firework.totalParticles do
            local speed = love.math.random(firework.particlesSpeedRange.min, firework.particlesSpeedRange.max) * dt
            local angle = love.math.random() * math.pi * 2
            firework.particles[i] = getParticle(firework.x, firework.y, speed, angle)
            firework.particles[i].isVisible = true
        end
    end

    function firework.resetParticles(dt)
        for i, particle in ipairs(firework.particles) do
            local speed = love.math.random(firework.particlesSpeedRange.min, firework.particlesSpeedRange.max) * dt
            local angle = love.math.random() * math.pi * 2
            particle.position.setX(firework.x)
            particle.position.setY(firework.y)
            particle.velocity.setLength(speed)
            particle.velocity.setAngle(angle)
            particle.isVisible = true
        end
    end

    function firework.resetRocket(dt)
        firework.setRandomPosition()
        firework.rocket.hasExploded = false
        firework.rocket.position.setX(firework.x)
        firework.rocket.position.setY(window.height)
        firework.rocket.velocity.setLength(firework.rocketSpeed * dt)
        firework.rocket.velocity.setAngle(-math.pi * 0.5)
    end

    function firework.update(dt)
        if not firework.isInitialized then
            firework.setRandomPosition()
            firework.resetRocket(dt)
            firework.initParticles(dt) 
            firework.isInitialized = true
        end
        
        if firework.rocket.position.getY() <= firework.y then
            firework.rocket.hasExploded = true
        end
        
        if not firework.rocket.hasExploded then
            firework.rocket.update()
            return
        end
        
        for i, particle in ipairs(firework.particles) do
            particle.accelerate(firework.gravity)
            particle.update()
        end
        
        for i, particle in ipairs(firework.particles) do
            local magnitude = math.sqrt(math.pow(particle.position.getX() - firework.x, 2) + math.pow(particle.position.getY() - firework.y, 2)) 
            if(magnitude >= firework.radius) then
                firework.outOfBoundCount = firework.outOfBoundCount + 1
                particle.isVisible = false
            end
        end
        
        if firework.outOfBoundCount >= firework.totalParticles then
            firework.setRandomPosition()
            firework.resetRocket(dt)
            firework.resetParticles(dt)
        end 
        firework.outOfBoundCount = 0
    end

    function firework.draw()
        love.graphics.setColor(firework.color)
        
        if not firework.rocket.hasExploded then
            love.graphics.circle("fill", firework.rocket.position.getX(), firework.rocket.position.getY(), 5)
            return
        end
        
        for i, particle in ipairs(firework.particles) do
            if particle.isVisible then
                
                love.graphics.circle("fill", particle.position.getX(), particle.position.getY(), 1)
                
            end
        end
    end
    
    return firework
end

return getFirework
