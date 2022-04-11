gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")

local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

local jokes 
util.json_watch("dadjokes.json", function (dadjokes)
    jokes = dadjokes
end)

function node.render()
    log("Renderer", "jokes jokes jokes")
    log("Renderer", "jokes: "..jokes.."")
    font:write(120, 320, ""..jokes["joke"].."", 100, 1,1,1,1)
end

