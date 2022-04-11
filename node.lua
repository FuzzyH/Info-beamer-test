gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")
local curl = require "luacurl"
local c = curl.new()

function node.render()
    json = CURL_GET("https://icanhazdadjoke.com/")
    font:write(120, 320, json, 100, 1,1,1,1)
end

function CURL_GET(url)
    c:setopt(curl.OPT_URL, url)
    --c:setopt(curl.OPT_PROXY, "http://myproxy.com:8080")
    c:setopt(curl.OPT_HTTPHEADER, "Connection: Keep-Alive", "Accept-Language: de-DE", "application/json")
    c:setopt(curl.OPT_CONNECTTIMEOUT, 30 )
    c:setopt(curl.OPT_FOLLOWLOCATION, true) -- REALLY IMPORTANT ELSE FAIL
    c:setopt(curl.OPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36")
    c:setopt(curl.OPT_SSL_VERIFYPEER, false) -- REALLY IMPORTANT ELSE NOTHING HAPPENS -.-
    c:setopt(curl.OPT_ENCODING, "utf8") -- could be important
    local t = {} -- this will collect resulting chunks
    c:setopt(curl.OPT_WRITEFUNCTION, function (param, buf)
        table.insert(t, buf) -- store a chunk of data received
        return #buf
    end)
    c:setopt(curl.OPT_PROGRESSFUNCTION, function(param, dltotal, dlnow)
        print('%', url, dltotal, dlnow) -- do your fancy reporting here
    end)
    c:setopt(curl.OPT_NOPROGRESS, false) -- use this to activate progress
    assert(c:perform())
    return table.concat(t) -- return the whole data as a string
end