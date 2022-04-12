gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")
local json = require(json)

local jokes
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = dadjokes
end)

local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

function node.render()

    log("Renderer", "Rendering")
    --log("Renderer", "jokes: " ..jokes.."")
    font:write(120, 320, "Test", 100, 1,1,1,1)
end

