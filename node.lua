gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

-- include libarys
local json = require "json"

-- include other files
local utility = require "utility"



-- variables:
local jokes
local border = math.floor(NATIVE_HEIGHT * 0.05)
local canvas_width = NATIVE_WIDTH - border
local canvas_height = NATIVE_HEIGHT - border

-- font
local font = resource.load_font("default-font.ttf")
local font_size = config.font_size
local font_color = config.color


-- Watchers
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = json.decode(dadjokes)
end)

-- Logging
local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

-- other functions

function draw_dadjoke(x1, y1, width, height)
    if jokes["joke"] ~= nil then
        -- log("Renderer", "before wrapper")
        local lines = utility.wrap(jokes["joke"], font, font_size, width)
        for idx = 1, #lines do
            local line = lines[idx]
            -- log("Renderer", "lines: " ..line)
            font:write(x1, y1+idx*font_size+margin, line, font_size, font_color)
        end
    else
        log("Renderer", "Table is nil")
    end
end


-- rendering
function node.render()
    draw_dadjoke(border, border, canvas_width, canvas_height)
end

