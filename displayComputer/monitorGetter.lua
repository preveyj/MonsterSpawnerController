local periphGetter = require("getPeripheralByType")

--Get a reference to an attached monitor
local function getTheMonitor()
    --List attached peripherals
    availablePeripherals = peripheral.getNames()

    --Get the first monitor attached
    foundMonitor = periphGetter.getPeripheralByType("monitor")

    --Check the monitor size - I might reduce this to 2x3
    width, height = foundMonitor.getSize()

    --If the monitor isn't big enough, throw an error
    if (width < 29) or (height < 19) then
        error("The attached monitor must be at least 3x3!")
    end

    --If it is, return the reference to the monitor
    return foundMonitor
end

return { getTheMonitor = getTheMonitor }