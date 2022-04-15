local api, CHILDS, CONTENTS = ...

-- imports
local utility = require(api.localized "utility")
local anims = require(api.localized "anims")

local json require "json"
local utf8 = require "utf8"

--- Variables:
-- default font
local font = resource.load_font("default-font.ttf")
local font_size = 100
local r,g,b = 1, 1, 1
-- other
local margin = 10
local jokes


M = {}

-- Watchers
util.file_watch("dadjokes.json", function (dadjokes)
    jokes = json.decode(dadjokes)
end)


-- Logging
local function log(system, format, ...)
    return print(string.format("[%s] " .. format, system, ...))
end

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
        -- log("Renderer", "before wrapper")
        local lines = wrap(jokes["joke"], font, font_size, width)
        for idx = 1, #lines do
            local line = lines[idx]
            -- log("Renderer", "lines: " ..line)
            font:write(x1, y1+idx*font_size+margin, line, font_size, r, g, b, 1)
        end
    else
        log("Renderer", "Table is nil")
    end
end

function M.updated_config_json(config)
    print "config updated"
    font = resource.load_font(api.localized(config.font.asset_name))
    font_size = config.font_size
    r,g,b = parse_rgb(config.color)

end


function M.task(starts, ends, config, x1, y1, x2, y2)
    local boundingbox_height = y2-y1
    local boundingbox_width = x2-x1

    print("ACTUAL SCREEN SIZE " .. boundingbox_width .. "x" .. boundingbox_height)

    api.wait_t(starts-2.5)

    local a = anims.Area(boundingbox_width, boundingbox_height)
    local S = starts
    local E = ends

    local lines = wrap(
        jokes["joke"], font, font_size, boundingbox_width-2*margin
    )

    local function mk_content_box(x, y)                                              
        y = y + margin
        for idx = 1, #lines do
            local line = lines[idx]
            a.add(anims.moving_font(S, E, font, x+margin, y, line, font_size,
                r, g, b, a
            )); S=S+0.1; y=y+font_size
        end
    end

    local text_height = #lines*font_size + 2*margin

    print(boundingbox_width, boundingbox_height, text_height)

    local text_y = math.min(
        math.max(
            font_size*1.6+3*margin,
            130
        ),
        boundingbox_height-text_height
    )
    mk_content_box(0, text_y)

    for now in api.frame_between(starts, ends) do
        a.draw(now, x1, y1, x2, y2)
    end
end

return M
