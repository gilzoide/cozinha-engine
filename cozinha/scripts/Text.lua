extends(Drawable)

function init(self, font, text)
	font = font or love.graphics.getFont()
	self.drawable = love.graphics.newText(font, text)
end

