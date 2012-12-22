local io = io
local math = math
local naughty = naughty
local beautiful = beautiful
local tonumber = tonumber
local tostring = tostring
local print = print
local pairs = pairs
require("lfs")
local lfs = lfs
local string = string
local pcall = pcall

module("battery")
function get_bat_state ()
    local s = nil
    for file in lfs.dir("/sys/class/power_supply") do
	    if string.find(file, "BAT") ~= nil then
		    s = file
		    break
	    end
    end
    if s == nil then return "",-2 end
    local fcur = io.open("/sys/class/power_supply/"..s.."/charge_now")
    if fcur == nil then
	    return "", -2
    end
    local fcap = io.open("/sys/class/power_supply/"..s.."/charge_full")
    if fcap == nil then
	    fcur:close()
	    return "", -2
    end
    local fsta = io.open("/sys/class/power_supply/"..s.."/status")
    if fsta == nil then
	    fcur:close()
	    fcap:close()
	    return "", -2
    end
    local cur = fcur:read()
    local cap = fcap:read()
    local sta = fsta:read()
    fcur:close()
    fcap:close()
    fsta:close()
    local battery = math.floor(cur * 100 / cap)
    if sta:match("Charging") then
        dir = 1
    elseif sta:match("Discharging") then
        dir = -1
    else
        dir = 0
    end
    return battery, dir
end

function batclosure (adapter)
    return function ()
        local status, battery, dir = pcall(get_bat_state)
	   if dir == -2 or status == false then
		  return ""
	   elseif dir == -1 then
            dirsign = "↓"
        elseif dir == 1 then
            dirsign = "↑"
        else
            dirsign = "⚡"
        end
        return " "..dirsign..battery.."%"
    end
end
