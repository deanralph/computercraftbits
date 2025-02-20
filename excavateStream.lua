-- Varaiables
directions = {"Forward", "Right", "Backward", "Left"} -- All directions relative to starting direction
x = 0
y = 0
z = 0
facing = 1 -- 1: Forward, 2: Right, 3: Backwards, 4: Left

-- Functions
local fucntion printHeader()
    print("-------------------------------")
    print("      ExavateStream 4031")
    print(" A DriftStream product 2025 TM")
    print("-------------------------------")
end

local function getInput(prompt)
    print(prompt)
end

local function turnToFace(targetDirection)
    while (direction ~= targetDirection) 
    do
        if (direction > targetDirection) 
        then
            turtle.turnLeft()
            direction = direction - 1
        elseif (direction < targetDirection) 
        then
            turtle.turnRight()
            direction = direction + 1
        end
    end
end

local fucntion printLocation()
    print("Current Possition: X: " ..x.. " Y: " ..y.. " Z: " ..z.. " facing: " ..direction[facing])
end

local function digMoveForward()
    while turtle.detect() do
        turtle.dig()
    end
    turtle.forward()
    if facing == 0 
    then
        z = z + 1
    elseif facing == 1 
    then
        x = x + 1
    elseif facing == 2 
    then
        z = z - 1
    elseif facing == 3 
    then
        x = x - 1
    end
end

local function moveUp()
    while turtle.detectUp() 
    do
        turtle.digUp()
    end
    turtle.up()
    y = y + 1
end

-- Main code

printHeader()
printLocation()
moveUp()
printLocation()
digMoveForward()