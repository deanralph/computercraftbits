-- Globals
xyzd = { -- x y z relatie to point of origin
    x = 1,
    y = 1,
    z = 1,
    d = 1 -- direction relative to point of origin 1 = forward, 2 = left, 3 = backwards, 4 = right
}

blocksMined = 0
width  = tonumber(args[1])
length = tonumber(args[2])
height = tonumber(args[3])
totalblocks = length * width * height

-- Functions
function drawHeader()
    term.clear()
    term.setCursorPos(1, 1)
    print("-- Scootercorp Digger01 --")
    print("")
    print("* Current Fuel Level: " .. turtle.getFuelLevel())
    print("* Blocks Mined: " .. blocksMined)
    print("* Relative XYZ: " .. xyzd["x"] .. "," .. xyzd["y"] .. "," ..xyzd["z"])
end

function updateHeader()
    term.setCursorPos(3, 22)
    term.write(turtle.getFuelLevel() .. "     ")
    term.setCursorPos(4, 17)
    term.write(blocksMined .. "     ")
    term.setCursorPos(5, 17)
    term.write(xyzd["x"] .. "," .. xyzd["y"] .. "," ..xyzd["z"] .. "     ")    
end


function digForwards()
    while turtle.detect() do
        if turtle.dig() then
            blocksMined = blocksMined + 1
        end
    end
    if turtle.forward() then
        if xyzd["d"] == 1 then
            xyzd["x"] = xyzd["x"] + 1
        elseif xyzd["d"] == 3 then
            xyzd["x"] = xyzd["x"] - 1
        elseif xyzd["d"] == 2 then
            xyzd["y"] = xyzd["y"] + 1
        elseif xyzd["d"] == 4 then
            xyzd["y"] = xyzd["y"] - 1
        end
    end
    updateHeader()
end

function turnTurtle(direction, flip)
    if flip then
        direction = direction + 2
        if direction > 4 then direction = direction - 4 end
    end
    while xyzd["d"] ~= direction do 
        if xyzd["d"] > direction then  
            turtle.turnLeft() xyzd["d"] = xyzd["d"] - 1 
        elseif xyzd["d"] < direction then
            turtle.turnRight()
            xyzd["d"] = xyzd["d"] + 1 
        end 
    end 
end

function moveUp()
    while turtle.detectUp() do
        turtle.digUp()
    end
    turtle.up()
    xyzd["z"] = xyzd["z"] + 1
end

function moveDown()
    while turtle.detectDown() do
        turtle.digDown()
    end
    turtle.down()
    xyzd["z"] = xyzd["z"] - 1
end

function digLine()
    for i = 1, length -1 do
        digForwards()
    end
end

function digLayer(reverse)
    for row = 1, width do
        digLine(length - 1)
        if row < width then
            if row % 2 == 1 then
                turnToFace(4,reverse)
                digMoveForward()
                turnToFace(3)
            else
                turnToFace(2,reverse)
                digMoveForward()
                turnToFace(1)
            end
        end
    end
end

function moveToOrigin()
    -- Move X back to 1
    if xyzd.x > 1 then
        turnTurtle(3) -- face -X if 1=+X, 3=-X
        for _ = 1, xyzd.x - 1 do
            digForwards()
        end
    elseif xyzd.x < 1 then
        turnTurtle(1) -- +X
        for _ = 1, 1 - xyzd.x do
            digForwards()
        end
    end

    -- Move Y back to 1
    if xyzd.y > 1 then
        turnTurtle(4) -- -Y
        for _ = 1, xyzd.y - 1 do
            digForwards()
        end
    elseif xyzd.y < 1 then
        turnTurtle(2) -- +Y
        for _ = 1, 1 - xyzd.y do
            digForwards()
        end
    end

    -- Move Z back to 1
    while xyzd.z > 1 do
        moveDown()
    end

    -- Face +X (or whatever your “default” is)
    turnTurtle(1)
end

function excavationLoop()
    for layer = 1, height do
        if layer %2 == 1 then
            rev = true
        else 
            rev = false
        end
        digLayer(rev)
        if layer ~= height then
            moveUp()
        end
    end
    moveToOrigin()
end

-- Main
drawHeader()
if not (width and length and height) then
    print("Usage: turtle_program <width> <length> <height>")
    exit()
end
if turtle.getFuelLevel() < totalblocks then
    print("Fuel Estimate too low, refuel and try again...")
    exit()
end

excavationLoop()