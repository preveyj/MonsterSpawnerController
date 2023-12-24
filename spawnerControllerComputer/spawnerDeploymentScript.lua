--Deployment script for the Spawner Controller Computer
--Use wget to grab files from Github

local githubRoot = "https://raw.githubusercontent.com/preveyj/MonsterSpawnerController/"
local branchName = "master"
local computerDirectory = "spawnerControllerComputer"
local commonUtilsDirectory = "commonUtils"
local expectedFileExtension = ".lua"

local specificFilesToGet = {"mainSpawnerController", "monsterTableReader", "spawnerScheduler", "spawnSorter" }
local commonFilesToGet = { "getPeripheralByType" }

--Run wGet to get the supplied file from the supplied path
    --fullPathWithoutFilename: should be a URL minus the end file name, like "http://www.someserver.com/blah/", and must end with a trailing slash
    --fileNameWithExtension: the actual filename to download and save onto the local computer
local function getFileWithWGet(fullPathWithoutFilename, fileNameWithExtension)
    --wget doesn't update in place, so we need to delete any existing files first
    if (fs.exists(fileNameWithExtension)) then
        fs.delete(fileNameWithExtension)
    end

    shell.run("wget", fullPathWithoutFilename .. fileNameWithExtension, fileNameWithExtension)
end

--Perform the deployment
local function runDeployment()

    --get each file in the computer-specific folder by wGet
    for _, fileName in pairs(specificFilesToGet) do
        --do the expected concatenation here 
        local filenameWithExtension = fileName .. expectedFileExtension
        local fullPath = githubRoot .. branchName .. "/" .. computerDirectory .. "/"

        getFileWithWGet(fullPath, filenameWithExtension)
    end

    --get each file in the common folder by wGet
    for _, fileName in pairs(commonFilesToGet) do
        local filenameWithExtension = fileName .. expectedFileExtension
        local fullPath = githubRoot .. branchName .. "/" .. commonUtilsDirectory .. "/"

        getFileWithWGet(fullPath, filenameWithExtension)
    end

    --Set a label on this computer
    shell.run("label", "set", computerDirectory)
end

runDeployment()