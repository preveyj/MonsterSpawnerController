--get the monitor
local monitor = peripheral.wrap("right")

--clear the screen and set colors
monitor.clear()
monitor.setBackgroundColor(colors.white)
monitor.setTextColor(colors.black)

--set cursor position to top left of monitor
monitor.setCursorPos(1,1)

--write the text
monitor.write("Hello World!")

--set up mouse event
while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    print("The monitor on side " .. side .. " was touched at (" .. x .. ", " .. y .. ")")
end
