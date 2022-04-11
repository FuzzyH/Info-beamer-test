gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")
local json = require "json"

local jokes 
util.json_watch("dadjokes.json", function (joke)
    jokes = json.decode(joke)
end)

function node.render()
    font:write(120, 320, ""..jokes[0].."", 100, 1,1,1,1)
end

