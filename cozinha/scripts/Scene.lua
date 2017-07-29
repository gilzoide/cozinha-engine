local lfs = love.filesystem

function from_file(file_name)
	file_name = scene_folder .. "/" .. file_name
	assert(lfs.isFile(file_name), string.format("Couldn't find scene %q", file_name))
	local old_scene = _G.scene
	local new_scene = new()
	_G.scene = new_scene
	assert(loadfile(file_name))()
	_G.scene = old_scene
	return new_scene
end
