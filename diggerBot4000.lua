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

function checkForChests():
    if turtle.getItemDetail(16).name == "minecraft:chest" then
        return False
    else
        return True
    end
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

function dumpInventory(origin):
    if xyzd["d"] == 1 then
        turnTurtle(3)
    elseif xyzd["d"] == 3 then
        turnTurtle(1)
    elseif xyzd["d"] == 2 then
        turnTurtle(4)
    elseif xyzd["d"] == 4 then
        turnTurtle(2)
    end
    turtle.select(16)
    turtle.place()
    for slot = 1, 15 do  -- slots 1-15 only
        turtle.select(slot)
        turtle.drop()   -- drops items in front
    end
    turnTurtle(origin)
end     

function digForwards()
    if turtle.dig() then
        blocksMined = blocksMined + 1
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
        return True
    else
        return False
    end
    drawHeader()
end

function drawHeader()
    os.clear()
    print("-- Scootercorp Excavator Machine 3006 --")
    print("")
    print("* Current Fule Level:" .. turtle.getFuelLevel())
    print("* Blocks Mined:" .. blocksMined)
    print("* Relative XYZ: " .. xyzd["x"] .. "," .. xyzd["y"] .. "," ..xyzd["z"])
end

function checkFuelLevel()
    totalblocks = length * width * height
    if turtle.getFuelLevel() >= totalblocks then
        return False
    else
        return Ture
    end
end

function digLine(leng)
    for i = 1, length - 1 do
        digForwards()
    end
end


-- Main

if not (width and length and height) then
    print("Usage: turtle_program <width> <length> <height>")
    exit()
end

if checkForChests() then
    print("Place Chests in slot 16 (thats the last slot =D )")
    exit()
end

if checkFuelLevel() then
    print("You dont look to have enough fuel for this opperation.... sowwie")
    exit()
end

drawHeader()
