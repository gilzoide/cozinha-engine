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
	if Vec.is(self.offset) then
		ox, oy = self.offset:xy()
	end
	love.graphics.draw(self.drawable,
			self.transform.pos.x + cozinha.transform.pos.x,			   
			self.transform.pos.y + cozinha.transform.pos.y,			   
			self.transform.rot   + cozinha.transform.rot,
			self.transform.scl.x + cozinha.transform.scl.x,
			self.transform.scl.y + cozinha.transform.scl.y,
			ox, oy)
end
