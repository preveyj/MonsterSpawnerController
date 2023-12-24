--A table containing a list of monsters to spawn
local monsterTable = {}

--For each spawner, add a line with:
    --a name for the spawner (usually monster name)
    --a color (for the bundled cable output)
    --a boolean false (for whether the monster should be 'currently' spawning)
--We'll output a redstone signal by color to a Bundled Cable.
--colors constant: https://tweaked.cc/module/colors.html
--Right now it should be a max of 16 lines (only 16 colors)

--Lua tables are 1-indexed, so start with 1
monsterTable[1] = {"Creepers", colors.white, false}
monsterTable[2] = {"Spiders", colors.orange, false}
--monsterTable[3] = {"Illagers", colors.lime, false}

--Sadly, Lua doesn't have a function to just get the size of a table
local function getTableLength()
    local counter = 0
    for _ in pairs(monsterTable) do
        counter = counter + 1
    end
    return counter
end

--Make this table and the length function available to the controller file
return { monsterTable = monsterTable, getTableLength = getTableLength }