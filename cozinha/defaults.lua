--[[
-- Set of defaults for functions in prototypes
--]]

local defaults = {}

function defaults.init() end

function defaults.update() end

function defaults.draw() end

-- Emits a message, if object supports it
function defaults.emit(obj, f, ...)
	if obj[f] then return obj[f](obj, ...) end
end

-- Append a child at `pos`, which defaults to the end of the tree
function defaults.add_child(self, obj)
	table.insert(self.children, obj)
	return obj
end

return defaults
