--[[
-- Positions, Rotations, Scaling, important stuff =)
--]]

local Vec = require 'cozinha.Vec'

local Transform = {}
Transform.__index = Transform

function Transform.new()
	return setmetatable({pos = Vec.new(), rot = 0, scl = Vec.new(1, 1)}, Transform)
end

function Transform.__add(self, other)
	local t = Transform.new()
	t.pos = self.pos + other.pos
	t.rot = self.rot + other.rot
	t.scl = self.scl + other.scl
	return t
end

function Transform.__tostring(self)
	return string.format("Transform(Vec.new(%g, %g), %g, Vec.new(%g, %g))",
			self.pos.x, self.pos.y, self.rot, self.scl.x, self.scl.y)
end

function Transform.translate(self, x, y)
	if getmetatable(x) == Vec then x, y = x:xy()
	else x, y = x or 0, y or 0
	end
	self.pos.x, self.pos.y = self.pos.x + x, self.pos.y + y
	return self
end

function Transform.rotate(self, rot)
	rot = rot or 0
	self.rot = self.rot + rot
	return self
end

function Transform.scale(self, sx, sy)
	if getmetatable(sx) == Vec then sx, sy = sx:xy()
	else sx = sx or 1; sy = sy or sx
	end
	self.scl.x, self.scl.y = self.scl.x * sx, self.scl.y * sy
	return self
end

return Transform
