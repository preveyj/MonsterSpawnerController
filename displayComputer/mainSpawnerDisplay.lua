--Get stuff from other files to keep individual files small
local monitorController = require("monitorController")
local monsterTable = require("monsterTable")
local fileWriter = require("fileWriter")

--Display the spawner table on the monitor
monitorController.writeScreen(monsterTable.monsterTable)

--Listen for click events on the monitor
while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    --print("monitor clicked at x:" .. x .. ", y:" .. y)

    --If we clicked on one of the monster rows
    if y <= monsterTable.getTableLength() then
        
        --Swap the isSpawning bool on that monster's row
        monsterTable.monsterTable[y][3] = not monsterTable.monsterTable[y][3]

        --Update the monitor
        monitorController.writeScreen(monsterTable.monsterTable, theMonitor)

        --Output the table to the disk so the spawner controller can use it
        fileWriter.writeTableState(monsterTable.monsterTable)
    end
end

--redstone output timer


--two computers and a drive: 
    --one running the monitor and listening for click events
    --one running the spawner timeshare
    --the drive between them
    --monitor computer listens for click events, updates the monster table, saves it to the drive
    --spawner computer divides time between running the timeshare and checking for updates

    --use redstone wire for file locking - check for redstone signal, emit signal while writing, stop when done
        --if signal is detected, wait for 0.5 seconds then try again
        --that or just try-catch to handle collisions