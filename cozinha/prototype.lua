--[[
-- This is the part that handles how files in the `script_folder` are treated
-- as type prototypes (like classes, y'know).
--]]

local lfs = love.filesystem
local Node = require 'cozinha.Node'
local Transform = require 'cozinha.Transform'

local prototype = {}

local function setup_prototype(proto)
	-- And create the constructor
	function proto.new(...)
		local self = {__index = proto, children = {}, transform = Transform.new()}
		setmetatable(self, self)
		self:emit("init", ...)
		return self
	end
end

--- Check if there will be no extend cycle if `child` extends `base`.
-- 
-- Extending scripts by only setting `__index` may enter infinite loops if
-- there is a cycle.
local function check_uncyclic_extend(base, child)
	local visited = {
		[child.__cozinha] = true
	}
	local current = base
	while current ~= Node do
		if visited[current.__cozinha] then return false end
		visited[current.__cozinha] = true
		current = current.__index
	end
	return true
end

function extends(base)
	assert(base.__cozinha ~= nil, "Can only extend a cozinha prototype")
	local proto = getfenv(2)
	assert(proto.__cozinha ~= nil, "Only cozinha prototypes can be extended")
	-- verify that there is no extend cycle 
	assert(check_uncyclic_extend(base, proto), string.format(
	       "%q extending %q would form a cycle", proto.__cozinha, base.__cozinha))
	proto.__index = base
end

local function create_proto(file, proto_name)
	local f = assert(loadfile(file))
	assert(_ENV[proto_name] == nil,
	       string.format("%q cozinha script is already registered", proto_name))

	local proto = {__index = Node, __cozinha = proto_name}
	setmetatable(proto, proto)
	-- register prototype globally
	_ENV[proto_name] = proto
	-- prototype initial setup 
	setup_prototype(proto)

	setfenv(f, proto)()
end

local function import_directory(dir_name)
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
	import_directory("cozinha/scripts")
	import_directory(script_folder)
end

return prototype
