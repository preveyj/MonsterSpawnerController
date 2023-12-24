--Get a reference to the first attached peripheral by type
    --desiredType: the type of peripheral to get
local function getPeripheralByType(desiredType)
    --Get a list of attached peripherals
    availablePeripherals = peripheral.getNames()

    --Set up the return reference
    foundPeripheral = nil

    --get and return the first peripheral matching the type
    for index, name in ipairs(availablePeripherals) do
        if peripheral.getType(name) == desiredType then
            foundPeripheral = peripheral.wrap(name)
            break
        end
    end

    --If we couldn't find the desired peripheral, throw an error
    if foundPeripheral == nil then
        error("Peripheral type " .. desiredType .. " not found!")
    end

    return foundPeripheral
end

return { getPeripheralByType = getPeripheralByType}