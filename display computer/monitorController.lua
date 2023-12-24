local monitorGetter = require("monitorGetter")

--This is used for controlling the monitor
local monitor

--Write a line with the monster's name, color, and spawning status
    --monsterName: string containing the name of the monster
    --monsterColor: number with the color assigned to the monster - should be one of the colors constant values
    --isSpawning: boolean recording whether the monster is currently spawning
local function writeLine(monsterName, monsterColor, isSpawning)
    local foregroundColor, backgroundColor

    --Black on white if it's spawning, white on black if it's not
    if isSpawning == true then
        foregroundColor = colors.black
        backgroundColor = colors.white
    else
        foregroundColor = colors.white
        backgroundColor = colors.black
    end

    --start with a single character in the monster's color
    monitor.setBackgroundColor(monsterColor)
    monitor.write(" ")

    --then, write the rest of the line
    monitor.setTextColor(foregroundColor)
    monitor.setBackgroundColor(backgroundColor)
    monitor.write(monsterName)

    --if monster name is shorter than monitor width, fill in the rest of the line
    local monitorWidth, monitorHeight = monitor.getSize()
    if string.len(monsterName) < monitorWidth then
        local remainingLineLength = monitorWidth -string.len(monsterName)

        while remainingLineLength > 0 do
            monitor.write(" ")
            remainingLineLength = remainingLineLength - 1
        end
    end
end

--Write the monster table to the screen
    --monsterTable: the table of monsters, cable colors, and spawn status booleans
    --theMonitor: a reference to the monitor to write to.
local function writeScreen(monsterTable)
    --print("called writeScreen")

    monitor = monitorGetter.getTheMonitor()
    --print("set the monitor")

    --Default to black background on the monitor
    monitor.setBackgroundColor(colors.black)
    --print("background color set")

    --Clear the screen
    monitor.clear()
    --print("monitor cleared")

    --Set the cursor back to column 1, row 1
    local currentRow = 1
    --print("set current row to 1")

    --For each line in monsterTable, write to the monitor
    for id, monster in ipairs(monsterTable) do
        --print("inside loop")

        --Set the cursor position to the beginning of the current line
        monitor.setCursorPos(1, currentRow)
        --print(monster)

        --Write that monster's line to the monitor
        writeLine(monster[1], monster[2], monster[3])

        --Increment the row counter
        currentRow = currentRow + 1
    end
end

--Make these functions available to mainSpawnerDisplay.lua
return { writeScreen = writeScreen, writeLine = writeLine }