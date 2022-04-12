local api, CHILDS, CONTENTS = ...


local anims = require(api.localized "anims")
local utf8 = require "utf8"
local font
local font_size = 100
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

function draw_dadjoke(x1, y1, width, height)
    if jokes["joke"] ~= nil then
        -- log("Renderer", "before wrapper")
        local lines = utility.wrap(jokes["joke"], font, font_size, width)
        for idx = 1, #lines do
            local line = lines[idx]
            -- log("Renderer", "lines: " ..line)
            font:write(x1, y1+idx*font_size+margin, line, font_size, x1,y1,x1+width, y1+height)
        end
    else
        log("Renderer", "Table is nil")
    end
end

function M.task(starts, ends, config, x1, y1, x2, y2)
    for now in api.frame_between(starts, ends) do
        api.screen.set_scissor(x1, y1, x2, y2)
        draw_dadjoke(x1, y1, x2-x1, y2-y1)
        api.screen.set_scissor()
    end
end

return M
