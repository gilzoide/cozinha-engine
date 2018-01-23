--[[
-- LÖVE2D Drawable wrapper.
--]]

--- Drawable is like a virtual class, and may not be instantiated
function init(self)
	error('"Drawable" is not supposed to be instanced directly')
end

--- Draw `self.drawable` applying default Transform.
function draw(self)
	local ox, oy
	if self.offset ~= nil then
		ox, oy = self.offset:xy()
	end
	love.graphics.draw(self.drawable,
			self.transform.pos.x + Transform.pos.x,			   
			self.transform.pos.y + Transform.pos.y,			   
			self.transform.rot + Transform.rot,
			self.transform.scl.x + Transform.scl.x,
			self.transform.scl.y + Transform.scl.y,
			ox, oy)
end
