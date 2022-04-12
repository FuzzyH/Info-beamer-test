
local function wrap(str, font, size, max_w)
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