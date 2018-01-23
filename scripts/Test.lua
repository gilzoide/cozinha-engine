--[[
-- Example of a Script Object: a floating text that moves with the keyboard
-- arrows.
--]]
function init(self)
	self.text = self:add_child(Text.new(nil, "olar"))
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

	local rot = 0
	if love.keyboard.isDown "space" then
		rot = 10
	end

	self.transform:translate(inc * (self.speed * dt)):rotate(rot * dt)
end
