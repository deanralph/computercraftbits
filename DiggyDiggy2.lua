-- Globals
xyzd = { -- x y z relatie to point of origin
    x = 1
    y = 1
    z = 1
    d = 1 -- direction relative to point of origin 1 = forward, 2 = left, 3 = backwards, 4 = right
}

blocksMined = 0

width  = tonumber(args[1])
length = tonumber(args[2])
height = tonumber(args[3])

-- Functions
function drawHeader()
    os.clear()
    print("-- Scootercorp Digger01 --")
    print("")
    print("* Current Fule Level:" .. turtle.getFuelLevel())
    print("* Blocks Mined:" .. blocksMined)
    print("* Relative XYZ: " .. xyzd["x"] .. "," .. xyzd["y"] .. "," ..xyzd["z"])
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
    drawHeader()
end

function turnTurtle(direction):
    while xyzd["d"] ~= direction do
        if xyzd["d"] > direction then
            turtle.turnLeft()
            xyzd["d"] = xyzd["d"] - 1
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
    for i = 1, length do
        digForwards()
    end
end

function digLayer()
    if xyzd["z"] % 2 == 1 then
        for row = 1, width do
            if row % 2 == 1 then
                turnTurtle(3)
                digLine(depth - 1)
                if row < width then
                    if row % 2 == 1 then
                        turnToFace(4)
                        digMoveForward()
                        turnToFace(1)
                    else
                        turnToFace(2)
                        digMoveForward()
                        turnToFace(3)
                    end
                end
            end
        end
    else
        for row = 1, width do
            if row % 2 == 1 then
                turnTurtle(3)
                digLine(depth - 1)
                if row < width then
                    if row % 2 == 1 then
                        turnToFace(2)
                        digMoveForward()
                        turnToFace(3)
                    else
                        turnToFace(4)
                        digMoveForward()
                        turnToFace(1)
                    end
                end
            end
        end
    end
end