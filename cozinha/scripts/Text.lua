function init(self, text)
	self.text = text or ""
end

function draw(self)
	love.graphics.print(self.text, self.transform.pos.x + Transform.pos.x, self.transform.pos.y + Transform.pos.y)
end
