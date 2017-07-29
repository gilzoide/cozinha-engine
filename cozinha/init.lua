--[[
-- Love2D addon entrypoint
--]]

cozinha = {}

_ENV = getfenv()
local prototype = require 'cozinha.prototype'
Vec = require 'cozinha.Vec'

function love.load()
	script_folder = cozinha.script_folder or "scripts"
	scene_folder = cozinha.scene_folder or "scenes"
	main_scene = cozinha.main_scene or "main.lua"

	prototype.readScripts()
	current_scene = Scene.from_file(main_scene)
end

-- Apply a function recursively using a Preorder path
local function apply_preorder(f, root, ...)
	local children = root.children
	for i = 1, #children do
		local c = children[i]
		_G.Transform = root.transform + c.transform
		apply_preorder(f, c, ...)
	end
	root[f](root, ...)
end

function love.update(dt)
	apply_preorder("update", current_scene, dt)
end

function love.draw()
	apply_preorder("draw", current_scene)
end

return cozinha

