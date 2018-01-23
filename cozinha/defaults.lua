--[[
-- Set of defaults for functions in prototypes
--]]

local defaults = {}

--- Emits a message, if object supports it.
-- 
-- @return[0] `true` if message is supported
-- @return[0] Function result
-- @return[1] `false` otherwise
function defaults.emit(obj, f, ...)
	if obj[f] then return true, obj[f](obj, ...)
	else return false
	end
end

--- Append a child at end of the tree.
function defaults.add_child(self, obj)
	table.insert(self.children, obj)
	return obj
end

return defaults
