--[[
-- Positions, Rotations, Scaling, important stuff =)
--]]

local Vec = require 'cozinha.Vec'

local Transform = {}
Transform.__index = Transform

function Transform.new()
	return setmetatable({pos = Vec.new()}, Transform)
end

function Transform.__add(self, other)
	local t = Transform.new()
	t.pos = self.pos + other.pos
	return t
end

return Transform
