gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")

local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

local jokes 
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = dadjokes
end)

function node.render()

    log("Renderer", "jokes: "..jokes.."")
    font:write(120, 320, ""..jokes[0]["joke"].."", 100, 1,1,1,1)
end

