--TODO: move this and other generic settings to a settings.lua file
local bundledCableSide = "back"

--Spawn each monster in the given table
    --monstersToSpawn: a table of monsters to spawn
local function spawnMonsters(monstersToSpawn)
    --run each spawner for a set period of time
    for index, monster in ipairs(monstersToSpawn) do
        --zero out the signal first
        redstone.setBundledOutput(bundledCableSide, 0)

        --light up the appropriate monster's cable
        redstone.setBundledOutput(bundledCableSide, monster[2])

        --should we configure per-spawner timers?
        os.sleep(1)

        --finish spawning current monster
        redstone.setBundledOutput(bundledCableSide, 0)
    end
end

return { spawnMonsters = spawnMonsters }