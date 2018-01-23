--[[
-- 2D vectors
--]]

local Vec = {}
Vec.__index = Vec

local function is_Vec(obj) return getmetatable(obj) == Vec end

function Vec.new(x, y)
	return setmetatable({x = x or 0, y = y or 0}, Vec)
end

function Vec.__add(self, other)
	local x, y
	if is_Vec(other) then x, y = other.x, other.y else x, y = other, other end
	return Vec.new(self.x + x, self.y + y)
end
function Vec.__sub(self, other)
	local x, y
	if is_Vec(other) then x, y = other.x, other.y else x, y = other, other end
	return Vec.new(self.x - x, self.y - y)
end
function Vec.__mul(self, other)
	local x, y
	if is_Vec(other) then x, y = other.x, other.y else x, y = other, other end
	return Vec.new(self.x * x, self.y * y)
end
function Vec.__unm(self)
	return Vec.new(-self.x, -self.y)
end

function Vec.xy(self)
	return self.x, self.y
end
function Vec.clone(self)
	return Vec.new(self.x, self.y)
end

function Vec.norm(self)
	return (self.x * self.x + self.y * self.y) ^ 0.5
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

return Vec
