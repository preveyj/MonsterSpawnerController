--This is the main file for the computer controlling the spawners.
--Read the file from the disk, update redstone signals via the bundled cable.

--Get functions from other files to keep individual files small
local monsterSpawner = require("spawnSorter")
local monsterReader = require("monsterTableReader")

--start a loop ->
    --step 1, read table from disk
    --step 2, give table to spawner timeshare scheduler and run a timeshare
while true do
    local theTable = monsterReader.getMonsterTableFromDisk()
    monsterSpawner.setupSpawnerTimeshare(theTable)
end