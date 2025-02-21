-- Varaiables
directions = {"Forward", "Right", "Backward", "Left"} -- All directions relative to starting direction
x = 0
y = 0
z = 0
facing = 1 -- 1: Forward, 2: Right, 3: Backwards, 4: Left

-- Functions
local fucntion printHeader()
    term.clear()
    term.setCursorPos(1, 1)
    print("-------------------------------")
    print("      ExavateStream 4031")
    print(" A DriftStream product 2025 TM")
    print("-------------------------------")
    print()
end

local function getInput(prompt)
    local input
    while true do
        term.write(prompt .. " ")  -- Display the prompt
        input = read()  -- Read user input

        local number = tonumber(input)  -- Convert to number
        if number and math.floor(number) == number then
            return number  -- Return valid integer
        else
            print("Invalid input. Please enter a whole number.")
        end
    end
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
    if facing == 1 
    then
        z = z + 1
    elseif facing == 2 
    then
        x = x + 1
    elseif facing == 3 
    then
        z = z - 1
    elseif facing == 4 
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

local function moveDown()
    while turtle.detectDown() 
    do
        turtle.digDown()
    end
    turtle.down()
    y = y - 1
end

local function moveToOrigin()
    -- Move to X = 0
    if x > 0 
    then
        turnToFace(4)
        for _ = 1, x 
        do 
            digMoveForward() 
        end
    elseif x < 0 
    then
        turnToFace(2)
        for _ = 1, -x 
        do
            digMoveForward()
        end
    end

    -- Move to Z = 0
    if z > 0 
    then
        turnToFace(3)
        for _ = 1, z 
        do 
            digMoveForward()
        end
    elseif z < 0 
    then
        turnToFace(1)
        for _ = 1, -z 
        do 
            digMoveForward() 
        end
    end

    -- Face +Z direction
    turnToFace(1)
end

-- Main code
printHeader()
printLocation()
moveUp()
printLocation()
digMoveForward()
printLocation()
moveToOrigin()
printLocation()
