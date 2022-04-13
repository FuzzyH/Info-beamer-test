gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

-- include libarys
local json = require "json"
local utf8 = require "utf8"

-- include other files
local utility = require "utility"

-- variables:
local jokes
local border = math.floor(NATIVE_HEIGHT * 0.05)
local canvas_width = NATIVE_WIDTH - border
local canvas_height = NATIVE_HEIGHT - border

-- font
local font = resource.load_font("Savor.ttf")
local font_size = 100
local r,g,b = 1,1,1

-- Watchers
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = json.decode(dadjokes)
end)

-- Logging
local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

-- updated config by event
node.event("config_updated", function(config)
    font_size = config.font_size
   -- r,g,b = parse_rgb(config.color or "#ffffff")
end)

-- other functions

function parse_rgb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255
end

function draw_dadjoke(x1, y1, width, height)
    if jokes["joke"] ~= nil then
        local lines = utility.wrap(jokes["joke"], font, font_size, width)
        for idx = 1, #lines do
            local line = lines[idx]
            log("Renderer", "lines: " ..line)
            font:write(x1, y1+idx*font_size+border, line, font_size, r, g, b, 1)
        end
    else
        log("node.lua", "Table is nil")
    end
end


-- rendering
function node.render()
    draw_dadjoke(border, border, canvas_width, canvas_height)
end

