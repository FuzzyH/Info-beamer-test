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
local font = resource.load_font("default-font.ttf")
local font_size = 100
local r, g, b = 1, 1, 1

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
    r,g,b = parse_rgb(config.color or "#ffffff")
end)

-- other functions


function wrap(str, font, size, max_w)
    local lines = {}
    local space_w = font:width(" ", size)

    local remaining = max_w
    local line = {}
    local tokens = {}
    for token in utf8.gmatch(str, "%S+") do
        local w = font:width(token, size)
        if w >= max_w then
            while #token > 0 do
                local cut = #token
                for take = 1, #token do
                    local sub_token = utf8.sub(token, 1, take)
                    w = font:width(sub_token, size)
                    if w >= max_w then
                        cut = take-1
                        break
                    end
                end
                tokens[#tokens+1] = utf8.sub(token, 1, cut)
                token = utf8.sub(token, cut+1)
            end
        else
            tokens[#tokens+1] = token
        end
    end
    for _, token in ipairs(tokens) do
        local w = font:width(token, size)
        if remaining - w < 0 then
            lines[#lines+1] = table.concat(line, "")
            line = {}
            remaining = max_w
        end
        line[#line+1] = token
        line[#line+1] = " "
        remaining = remaining - w - space_w
    end
    if #line > 0 then
        lines[#lines+1] = table.concat(line, "")
    end
    return lines
end

function parse_rgb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255
end

function draw_dadjoke(x1, y1, width, height)
    if jokes["joke"] ~= nil then
        local lines = wrap(jokes["joke"], font, font_size, width)
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

