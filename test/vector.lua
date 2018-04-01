local getVector = require("../vector")

local function test()
    local vector = getVector()
    assert(type(vector) == "table", "getVector() should return a table.")
    
    assert(vector.x == 0, "vector.x default value should be 0.")
    assert(vector.y == 0, "vector.y default value should be 0.")
    
    assert(type(vector.getX) == "function", "vector.getX should be function.")
    assert(type(vector.getY) == "function", "vector.getY should be function.")
    assert(type(vector.getLength) == "function", "vector.getLength should be function.")
    assert(type(vector.getAngle) == "function", "vector.getAngle should be function.")
    assert(type(vector.setX) == "function", "vector.setX should be function.")
    assert(type(vector.setY) == "function", "vector.setY should be function.")
    assert(type(vector.setLength) == "function", "vector.setLength should be function.")
    assert(type(vector.setAngle) == "function", "vector.setAngle should be function.")
    assert(type(vector.add) == "function", "vector.add should be function.")
    assert(type(vector.substract) == "function", "vector.substract should be function.")
    assert(type(vector.multiply) == "function", "vector.multiply should be function.")
    assert(type(vector.divide) == "function", "vector.divide should be function.")
    assert(type(vector.addTo) == "function", "vector.addTo should be function.")
    assert(type(vector.substractFrom) == "function", "vector.substractFrom should be function.")
    assert(type(vector.multiplyBy) == "function", "vector.multiplyBy should be function.")
    assert(type(vector.divideBy) == "function", "vector.divideBy should be function.")
    
    vector.setX(10)
    vector.setY(11)
    assert(vector.x == 10, "vector.setX(value) should set vector.x to 'value'")
    assert(vector.y == 11, "vector.setY(value) should set vector.y to 'value'")
    assert(vector.getX() == vector.x, "vector.getX() should return vector.x")
    assert(vector.getY() == vector.y, "vector.getY() should return vector.y")
    assert(vector.getLength() == math.sqrt(vector.x ^ 2 + vector.y ^ 2), ("v(%d,%d) magnitude should be equal to math.sqrt(%d ^ 2 + %d ^2)"):format(vector.x, vector.y, vector.x, vector.y))
    assert(vector.getAngle() == math.atan2(vector.y, vector.x), ("v(%d,%d) angle should be equal to math.atan2(vector.x, vector.y)"):format(vector.x, vector.y, vector.y, vector.x))
    
    vector.setLength(20)
    assert(vector.getLength() == 20, "vector.getLength() should return the length set by vector.setLength(length)")
    
    vector.setAngle(math.pi)
    assert(vector.getAngle() == math.pi, "vector.getAngle() should return the angle set by vector.setAngle(angle)")
    
    vector.setX(-10)
    vector.setY(-10)
    local vector2 = getVector(10, 10)
    
    local vsum = vector.add(vector2)
    assert(type(vsum) == "table", "vector.add(v) should return a table (vector).")
    assert(vsum ~= vector, "vector.add(v) should return a new vector.")
    assert(vsum ~= vector2, "vector.add(v) should return a new vector.")
    assert(vsum.x == vector.x + vector2.x, "if vsum = vector.add(v) then vsum.x should be equal to vector.x + v.x")
    assert(vsum.y == vector.y + vector2.y, "if vsum = vector.add(v) then vsum.y should be equal to vector.y + v.y")
    
    local vsub = vector.substract(vector2)
    assert(type(vsub) == "table", "vector.substract(v) should return a table (vector).")
    assert(vsub ~= vector, "vector.substract(v) should return a new vector.")
    assert(vsub ~= vector2, "vector.substract(v) should return a new vector.")
    assert(vsub.x == vector.x - vector2.x, "if vsub = vector.substract(v) then vsub.x should be equal to vector.x - v.x")
    assert(vsub.y == vector.y - vector2.y, "if vsub = vector.substract(v) then vsub.y should be equal to vector.y - v.y")
    
    local scalar = 5
    local vmult = vector.multiply(scalar)
    assert(type(vmult) == "table", "vector.multiply(scalar) should return a table (vector).")
    assert(vmult ~= vector, "vector.multiply(scalar) should return a new vector.")
    assert(vmult.x == vector.x * scalar, "if vmult = vector.multiply(scalar) then vmult.x should be equal to vector.x * scalar")
    assert(vmult.y == vector.y * scalar, "if vmult = vector.multiply(scalar) then vmult.y should be equal to vector.y * scalar")
    
    local vdiv = vector.divide(scalar)
    assert(type(vdiv) == "table", "vector.divide(scalar) should return a table (vector).")
    assert(vdiv ~= vector, "vector.divide(scalar) should return a new vector.")
    assert(vdiv.x == vector.x / scalar, "if vdiv = vector.divide(scalar) then vdiv.x should be equal to vector.x / scalar")
    assert(vdiv.y == vector.y / scalar, "if vdiv = vector.divide(scalar) then vdiv.y should be equal to vector.y / scalar")
    
    local v = getVector(-17, 23)
    local v2 = getVector(5, 6)
    local oldX = v.getX()
    local oldY = v.getY()
    v.addTo(v2)
    assert(v.x == oldX + v2.getX() and v.y == oldY + v2.getY(), "v.addTo(v2) should mutate v.x to v.x + v2.x and v.y to v.y + v2.y")
    
    oldX = v.getX()
    oldY = v.getY()
    v.substractFrom(v2)
    assert(v.x == oldX - v2.getX() and v.y == oldY - v2.getY(), "v.substractFrom(v2) should mutate v.x to v.x - v2.x and v.y to v.y - v2.y")
    
    oldX = v.getX()
    oldY = v.getY()
    scalar = 3
    v.multiplyBy(scalar)
    assert(v.x == oldX * scalar and v.y == oldY * scalar, "v.multiplyBy(scalar) should mutate v.x to v.x * scalar and v.y to v.y * scalar")
    
    oldX = v.getX()
    oldY = v.getY()
    scalar = 6
    v.divideBy(scalar)
    assert(v.x == oldX / scalar and v.y == oldY / scalar, "v.divideBy(scalar) should mutate v.x to v.x / scalar and v.y to v.y / scalar")
    
    print("All vector tests passed !")
end

return test
