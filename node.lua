gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")
local json = require(json)

local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

local jokes 
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = json.decode(dadjokes)
end)

function node.render()
    log("Renderer", "Rendering")
    log("Renderer", "jokes: "..jokes["0"].."")
    font:write(120, 320, ""..jokes[0]["joke"].."", 100, 1,1,1,1)
end

