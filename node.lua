gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")
local json = require "json"

local jokes 
util.file_watch("dadjokes.json", function (content)
    jokes = json.decode(content)
end)

function node.render()

    font:write(120, 320, jokes, 100, 1,1,1,1)
end

