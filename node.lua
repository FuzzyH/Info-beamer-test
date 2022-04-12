gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")
local json = require "json"
local j0
local jokes
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = json.decode(dadjokes)
end)

local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

function node.render()
    if jokes[0] ~= nil then
        j0 = jokes[0]
    else
        log("Renderer", "Table nil")
    end
   -- log("Renderer", "Rendering")
    log("Renderer", "jokes: " ..j0.."")
    font:write(120, 320, "Test", 100, 1,1,1,1)
end

