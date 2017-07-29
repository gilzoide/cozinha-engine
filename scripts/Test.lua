--[[
-- Example of a Script Object: a floating text that moves with the keyboard
-- arrows.
--]]
function init(self)
	self.text = self:add_child(Text.new("oi", 10, 10))
	self.speed = 100
end

function update(self, dt)
	local inc = Vec.new()
	if love.keyboard.isDown "up" then
		inc.y = -1
	elseif love.keyboard.isDown "down" then
		inc.y = 1
	end
	if love.keyboard.isDown "left" then
		inc.x = -1
	elseif love.keyboard.isDown "right" then
		inc.x = 1
	end
	inc:normalize()
	self.transform.pos:translate(inc * (self.speed * dt))
end
