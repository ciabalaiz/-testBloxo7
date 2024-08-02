local template = {
	animations = {};
	tools = {};
}

--bloxo save

function preload(v)
	local t = {}
	for _, ve in pairs(game.ReplicatedStorage.animations:GetChildren()) do
		if ve:IsA("Animation") then
			local track = v:FindFirstChildOfClass("Humanoid"):LoadAnimation(ve)
			t[ve.Name] = track
		else
			t[ve.Name] = {}
			for _, re in pairs(ve:GetDescendants()) do
				if re:IsA("Animation") then
					local track = v:FindFirstChildOfClass("Humanoid"):LoadAnimation(re)
					t[ve.Name][re.Name] = track
				end
			end
		end
	end
	return t
end

local data = {}

for _, v in pairs(workspace:GetChildren()) do
	if v:FindFirstChildOfClass("Humanoid") and v:IsA("Model") then
		data[v] = template
		data[v].animations = preload(v)
	end
end

workspace.ChildAdded:Connect(function(v)
	if v:FindFirstChildOfClass("Humanoid") and v:IsA("Model") then
		data[v] = template
		data[v].animations = preload(v)
	end
end)

game.Players.PlayerAdded:Connect(function(v)
	v.CharacterAdded:Connect(function()
		data[v.Character] = template
		data[v.Character].animations = preload(v.Character)
	end)
end)

game.Players.PlayerRemoving:Connect(function(v)
	data[v.Character] = nil
end)

return data
