local function getParticle(x, y, speed, direction)
    
    local particle = {}
    particle.position = getVector(x,y)
    particle.velocity = getVector()
    particle.velocity.setLength(speed)
    particle.velocity.setAngle(direction)
    
    particle.accelerate = function(v)
        particle.velocity.addTo(v)
    end
    
    particle.update = function()
        particle.position.addTo(particle.velocity)
    end
    
    return particle
end

return getParticle