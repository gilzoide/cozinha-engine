--[[
-- This is the part that handles how files in the `script_folder` are treated
-- as type prototypes (like classes, y'know).
--]]

local lfs = love.filesystem
local defaults = require 'cozinha.defaults'
local Transform = require 'cozinha.Transform'

local prototype = {}

local function create_new(proto)
	-- Make sure the required functions exist
	for k, v in pairs(defaults) do
		proto[k] = proto[k] or v
	end
	-- And create the constructor
	function proto.new(...)
		local self = {__index = proto, children = {}, transform = Transform.new()}
		setmetatable(self, self)
		self:init(...)
		return self
	end
end

local function create_proto(file, proto_name)
	local proto = {__index = _ENV}
	setmetatable(proto, proto)
	local f = assert(loadfile(file))
	setfenv(f, proto)()
	create_new(proto)
	-- register prototype globally
	_ENV[proto_name] = proto
end

local function import_drectory(dir_name)
	assert(lfs.isDirectory(dir_name), string.format("Couldn't find folder %q", dir_name))
	local filesTable = lfs.getDirectoryItems(dir_name)
	for _, file in ipairs(filesTable) do
		file = dir_name .. "/" .. file
		if lfs.isFile(file) then
			local proto = file:match("%d*%-?([^/]+)%.lua$")
			if proto then
				create_proto(file, proto)
			end
		end
	end
end

function prototype.readScripts()
	import_drectory("cozinha/scripts")
	import_drectory(script_folder)
end

return prototype
