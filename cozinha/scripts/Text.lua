extends(Drawable)

function init(self, font, text, centered)
	font = font or love.graphics.getFont()
	self.text = love.graphics.newText(font, text)
	self.drawable = self.text
end

function setCentered(self, centered)
	self.offset = centered and Vec.new(self.text:getDimensions()) / 2
	return self
end

