--[[
-- Positions, Rotations, Scaling, important stuff =)
--]]

local Vec = require 'cozinha.Vec'

local Transform = {}
Transform.__index = Transform

if jit then
	local ffi = require 'ffi'
	ffi.cdef[[
	typedef struct {
		cozinha_Vec pos;
		double rot;
		cozinha_Vec scl;
	} cozinha_Transform;
	]]
	local cozinha_Transform
	function Transform.new(pos, rot, scl)
		return cozinha_Transform(pos or Vec.new(), rot or 0, scl or Vec.new(1, 1))
	end
	cozinha_Transform = ffi.metatype("cozinha_Transform", Transform)
	function Transform.is(obj) ffi.istype(cozinha_Transform, obj) end
else
	function Transform.new(pos, rot, scl)
		return setmetatable({
			pos = pos or Vec.new(),
			rot = rot or 0,
			scl = scl or Vec.new(1, 1)
		}, Transform)
	end
	function Transform.is(obj) return getmetatable(obj) == Transform end
end

function Transform.__add(self, other)
	local t = Transform.new()
	t.pos = self.pos + other.pos
	t.rot = self.rot + other.rot
	t.scl = self.scl + other.scl
	return t
end

function Transform.__tostring(self)
	return string.format("Transform(%s, %g, %s)", self.pos, self.rot, self.scl)
end

function Transform.translate(self, x, y)
	if Vec.is(x) then x, y = x:xy()
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
	if Vec.is(sx) then sx, sy = sx:xy()
	else sx = sx or 1; sy = sy or sx
	end
	self.scl.x, self.scl.y = self.scl.x * sx, self.scl.y * sy
	return self
end

return Transform
