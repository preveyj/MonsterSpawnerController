local spawnerScheduler = require("spawnerScheduler")

--Set up the spawner rotation from the monsterTable
local function setupSpawnerTimeshare(monsterTable)
    --for each row in monsterTable where we want to spawn monsters,
    --give it to another function to do a short loop and provide redstone
    --signals on the color-coded cables
    local monstersToSpawn = {}
    local addedMonsters = 0

    for id, monster in ipairs(monsterTable) do
        --Check the isSpawning boolean
        if monster[3] == true then
            --Add it to the list of monsters for the current cycle
            table.insert(monstersToSpawn, monster)
            addedMonsters = addedMonsters + 1
        end
    end

    if addedMonsters > 0 then
        --spawn chosen monsters
        spawnerScheduler.spawnMonsters(monstersToSpawn)
    else
        --sleep for a second so the loop can pick up file changes
        os.sleep(1)
    end
end

return { setupSpawnerTimeshare = setupSpawnerTimeshare }