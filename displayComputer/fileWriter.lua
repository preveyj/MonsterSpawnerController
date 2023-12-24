--Write the table to the given file name
    --monsterTable: the table to write
    --fileName: the filename to use
local function writeTheFile(monsterTable, fileName)

    --Get a handle to the file in write mode.  This wipes out whatever's originally there.
    local file = fs.open(fileName, "w")

    file.writeLine(os.date("!%F %R"))
    file.writeLine(textutils.serializeJSON(monsterTable))
    file.close()
end

--Write the monsterTable to the disk drive.
    --monsterTable: the monster table to write.
local function writeTableState(monsterTable)
    --The filename to use.  "/disk" is the path to the disk in the disk drive.
    local filenameToWrite = "/disk/monsterTable.txt"
    local writePending = true
    local errorCounter = 0

    --Try to write until we succeed
    while writePending do
        --pcall() is Lua's version of a try/catch block
        --Give it the name of a function to write followed by the parameters
        --It'll return first a boolean if the call was successful, followed by any other function returns
        if pcall(writeTheFile, monsterTable, filenameToWrite) then
            --If the write was successful, set writePending to false so we can finish the loop.
            writePending = false
        else
            -- maybe had a collision?  wait a second then try again
            os.sleep(1)
            --Increment the error counter
            errorCounter = errorCounter + 1
            
            --If we got to three errors, throw an exception
            if errorCounter > 3 then
                error("Unable to write to disk after three tries")
            end
        end
    end
end

return { writeTableState = writeTableState }