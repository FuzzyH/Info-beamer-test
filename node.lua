gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")
local json = require "json"
local utils = require(api.localized "utils")


local jokes 
util.json_watch("dadjokes.json", function (dadjokes)
    jokes = dadjokes
end)

function node.render()
    font:write(120, 320, ""..jokes.."", 100, 1,1,1,1)
end

