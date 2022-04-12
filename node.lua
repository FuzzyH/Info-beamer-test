-- setup
gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

-- include libarys
local api = ...
local json = require "json"

-- include other files
local utility = require(api.localized "utility")
local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")

-- variables:
local jokes
local border = math.floor(NATIVE_HEIGHT * 0.05)
local canvas_width = NATIVE_WIDTH - border
local canvas_height = NATIVE_HEIGHT - border

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
    if jokes["joke"] ~= nil then
        local font_size = 100
        local lines = utility.wrap(jokes["joke"], font, font_size, canvas_width)
        for line in lines do
            log("Renderer", "lines: " ..line)
            font:write(border, border, line, font_size, 1,1,1,1)
        end
    else
        log("Renderer", "Table is nil")
    end
end

