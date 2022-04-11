gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS45LtObl-Rg.ttf")

function node.render()
    font:write(120, 320, "Hello World", 100, 1,1,1,1)
end