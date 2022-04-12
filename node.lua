-- setup
gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

-- include libarys
local api
local json = require "json"

-- include other files
local utility = require(api.localized "utility")
local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")

-- variables:
local jokes

-- Watchers
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = json.decode(dadjokes)
end)

-- Logging
local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

-- other functions

-- rendering
function node.render()
    --gl.clear(1,1,1,1)
    if jokes["joke"] ~= nil then
        font:write(100, 200, "" ..jokes["joke"].."", 50, 1,1,1,1)
    else
        log("Renderer", "Table nil")
    end
end

