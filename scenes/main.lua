--[[
-- Example of a Scene, where the `scene` environment variable represents itself.
--]]
scene:add_children(
	Test.new(),
	Test.new(true):translate(100, 100)
)

