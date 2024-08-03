local loop = {}
--bloxo save

loop.cache = {}
loop.cnc = nil

function loop:AddFunction(f)
	if type("f") ~= "string" then return end

	local r = table.find(loop.cache, f)

	if r ~= nil then return end
	
	if loop.cnc == nil then
		loop:init()
	end
	
	table.insert(loop.cache, f)
end

function loop:RemoveFunction(f)
	if type("f") ~= "string" then return end

	local r = table.find(loop.cache, f)
	
	if r ~= nil then 
		table.remove(loop.cache, r)
	end
	
	if #loop.cache == 0 then
		loop:stop()
	end
end

function loop:init()
	loop.cnc = game:GetService("RunService").Heartbeat:Connect(function(dt)
		for _, v in pairs(loop.cache) do
			v(dt)
		end
	end)
end

function loop:stop()
	if loop.cnc ~= nil then
		loop.cnc:Disconnect()
	end
end

return loop
