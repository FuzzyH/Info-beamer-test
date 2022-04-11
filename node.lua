gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local font = resource.load_font("UniversforUniS55Rm-Regular.ttf")


function node.render()

    font:write(120, 320, "no HTML :(", 100, 1,1,1,1)
end

