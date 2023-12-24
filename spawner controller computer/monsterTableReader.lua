--Local references to the monster table and the last update time
local latestTableUpdate = ""
local monsterTable = nil

--Reads the given file
    --fileName: the file to read
local function readFile(fileName)
    --If the file exists
    if fs.exists(fileName) then
        --Open the file in read mode to get the update time and the monster table
        local file = fs.open(fileName, "r")

        --Read one line at the time.  The first line should be the last update time.
        local firstLine = file.readLine()

        --lua uses "~=" for checking not-equality, not "!="
        --If we were able to read the first line, and it's different than the last update time
        if firstLine ~= nil and latestTableUpdate ~= firstLine then
            --Read and parse the monster table
            local monsterTableAsString = file.readLine()
            --print(firstLine)
            --print(monsterTableAsString)
            --The monster table is stored as JSON
            monsterTable = textutils.unserializeJSON(monsterTableAsString)
        end
        
        --Close the file
        file.close()
    end
    
    return monsterTable
end

--Try reading the file for the monster table, and don't stop until it succeeds
local function getMonsterTableFromDisk()
    --The file name to read - must be the same as on the display computer.
    local fileName = "/disk/monsterTable.txt"
    local didGetFile = false

    --Keep trying until we get the file
    while didGetFile == false do
        --Try to read the file
        local didSucceed, returnedValue = pcall(readFile, fileName)
        --If we could read the file and could get the table, return it
        if didSucceed == true and returnedValue ~= nil then
            return returnedValue
        elseif returnedValue ~= nil then
            --some error occurred - print it and try again later
            print(returnedValue)
        end
        
        --Wait a second to try to read the file again
        os.sleep(1)
    end    
end

return { getMonsterTableFromDisk = getMonsterTableFromDisk }