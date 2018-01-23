--[[
-- Love2D addon entrypoint
--]]

nk = require 'nuklear'

cozinha = {}

-- @note: _ENV references cozinha init environment
_ENV = getfenv()
local prototype = require 'cozinha.prototype'
local dbg = require 'cozinha.debugger'
Vec = require 'cozinha.Vec'

function love.load()
	script_folder = cozinha.script_folder or "scripts"
	scene_folder = cozinha.scene_folder or "scenes"
	main_scene = cozinha.main_scene or "main.lua"

	if cozinha.debug then
		dbg.call(prototype.readScripts)
	else
		prototype.readScripts()
	end
	current_scene = Scene.from_file(main_scene)
	nk.init()
end

-- Apply a function recursively using a Preorder path
local function apply_preorder(f, root, ...)
	local children = root.children
	for i = 1, #children do
		local c = children[i]
		_ENV.Transform = root.transform + c.transform
		apply_preorder(f, c, ...)
	end
	root:emit(f, ...)
end

function love.update(dt)
	nk.frameBegin()
	apply_preorder("update", current_scene, dt)
	nk.frameEnd()
end

function love.draw()
	apply_preorder("draw", current_scene)
	nk.draw()
end

-- Process Nuklear UI
function love.keypressed(key, scancode, isrepeat)
	nk.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
	nk.keyreleased(key, scancode)
end

function love.mousepressed(x, y, button, istouch)
	nk.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
	nk.mousereleased(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
	nk.mousemoved(x, y, dx, dy, istouch)
end

function love.textinput(text)
	nk.textinput(text)
end

function love.wheelmoved(x, y)
	nk.wheelmoved(x, y)
end

return cozinha

