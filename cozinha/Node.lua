--[[
-- Node: the base for all prototypes
--]]

local Node = {__index = _ENV, __cozinha = "Node"}

--- Emits a message, if object supports it.
-- 
-- @return[0] `true` if message is supported
-- @return[0] Function result
-- @return[1] `false` otherwise
function Node.emit(self, f, ...)
	if self[f] then return true, self[f](self, ...)
	else return false
	end
end

--- Append a child at end of the tree.
function Node.add_child(self, obj)
	assert(obj.__cozinha ~= nil, "Can only append cozinha scripts as child of Node")
	table.insert(self.children, obj)
	return obj
end

--- Append several children at end of the tree through varargs, useful on
-- building scenes.
function Node.add_children(self, ...)
	for _, c in ipairs{...} do
		self:add_child(c)
	end
	return obj
end

-- Wrapper for Transform methods, for chaining them directly from Node
function Node.translate(self, x, y)
	self.transform:translate(x, y)
	return self
end
function Node.rotate(self, rot)
	self.transform:rotate(rot)
	return self
end
function Node.scale(self, sx, sy)
	self.transform:scale(sx, sy)
	return self
end

return setmetatable(Node, Node)
