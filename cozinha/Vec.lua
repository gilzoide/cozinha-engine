--[[
-- 2D vectors
--]]

local Vec = {}
Vec.__index = Vec


if jit then
	local ffi = require 'ffi'
	ffi.cdef[[
	typedef struct { double x, y; } cozinha_Vec;
	]]
	local cozinha_Vec
	function Vec.new(x, y)
		return cozinha_Vec(x or 0, y or 0)
	end
	cozinha_Vec = ffi.metatype("cozinha_Vec", Vec)
	function Vec.is(obj) return ffi.istype(cozinha_Vec, obj) end
else
	function Vec.new(x, y)
		return setmetatable({x = x or 0, y = y or 0}, Vec)
	end
	function Vec.is(obj) return getmetatable(obj) == Vec end
end

function Vec.__add(a, b)
	return Vec.new(a.x + b.x, a.y + b.y)
end
function Vec.__sub(a, b)
	return Vec.new(a.x - b.x, a.y - b.y)
end
function Vec.__mul(a, b)
	local x1, y1, x2, y2
	if Vec.is(a) then x1, y1 = a.x, a.y else x1, y1 = a, a end
	if Vec.is(b) then x2, y2 = b.x, b.y else x2, y2 = b, b end
	return Vec.new(x1 * x2, y1 * y2)
end
function Vec.__div(a, b)
	local x1, y1, x2, y2
	if Vec.is(a) then x1, y1 = a.x, a.y else x1, y1 = a, a end
	if Vec.is(b) then x2, y2 = b.x, b.y else x2, y2 = b, b end
	return Vec.new(x1 / x2, y1 / y2)
end
function Vec.__unm(self)
	return Vec.new(-self.x, -self.y)
end

function Vec.__eq(a, b)
	return a.x == b.x and a.y == b.y
end

function Vec.xy(self)
	return self.x, self.y
end
function Vec.clone(self)
	return Vec.new(self.x, self.y)
end
function Vec.set(self, x, y)
	self.x, self.y = x, y
	return self
end

function Vec.norm(self)
	return math.sqrt(self.x * self.x + self.y * self.y)
end
function Vec.normalize(self)
	if self.x ~= 0 or self.y ~= 0 then
		local norm = self:norm()
		self.x = self.x / norm
		self.y = self.y / norm
	end
	return self
end
function Vec.normalized(self)
	return self:clone():normalize()
end

function Vec.__tostring(self)
	return string.format("Vec(%g, %g)", self.x, self.y)
end

return Vec
