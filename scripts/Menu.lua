local function list_nodes(obj)
	local title = string.format("%s @ x=%.2f, y=%.2f", obj.type, obj.transform.pos.x, obj.transform.pos.y)
	if nk.treePush('node', title) then
		for _, c in ipairs(obj.children) do
			list_nodes(c)
		end
		nk.treePop()
	end
end

function update(self, dt)
	if nk.windowBegin('Simple Example', 300, 300, 400, 400,
			'border', 'title', 'movable') then
		if nk.treePush('tab', 'Scene nodes') then
			list_nodes(current_scene)
		end
		nk.treePop()
	end
	nk.windowEnd()
end
