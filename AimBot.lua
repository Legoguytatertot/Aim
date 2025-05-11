local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local enabled = nil
local target = nil
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local explain = Instance.new("TextLabel")
local ex2 = Instance.new("TextLabel")
local st = Instance.new("TextBox")
local drag = Instance.new("UIDragDetector")
local strength = nil

local function Setup()
	
	
	
gui.Name = "Aim"
gui.Parent = player.PlayerGui
frame.Draggable = true
frame.Size = UDim2.new(0.2, 0,0.3, 0)
frame.Position = UDim2.new(0.05, 0,0.3, 0)
frame.Style = "RobloxRound"

title.Size = UDim2.new(1, 0,0.2, 0)
title.TextScaled = true
title.RichText = true
title.Text = "AIMBOT"
title.Parent = frame

explain.Size = UDim2.new(.5, 0,0.25, 0)
explain.Position = UDim2.new(0, 0,0.3, 0)
explain.TextScaled = true
explain.RichText = true
explain.Text = "Strength Of Aimbot"
explain.Parent = frame

st.Size = UDim2.new(.5, 0,0.2, 0)
st.Position = UDim2.new(0.5, 0,0.3, 0)
st.TextScaled = true
st.RichText = true
st.Text = ".5"
st.Parent = frame

ex2.Size = UDim2.new(1, 0,0.25, 0)
ex2.Position = UDim2.new(0, 0,0.7, 0)
ex2.TextScaled = true
ex2.RichText = true
ex2.Text = "Press (F) for aimbot"
ex2.Parent = frame

drag.Parent = frame
frame.Parent = gui

end


Setup()





st.Changed:Connect(function()
	if type(tonumber(st.Text)) == "number" then
		strength = tonumber(st.Text)
		if strength > 1 then
			strength = 1
			st.Text = "1"
		end
	end
end)







local function ClosestEnemy()
	local targetpos = nil
	local distance = nil
	local maxdistance = math.huge
	
	
	for _, rigs in pairs(Players:GetPlayers()) do
		if rigs:IsA("Model") and rigs ~= player.Character and rigs:FindFirstChild("HumanoidRootPart") then
			distance = (rigs.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
			if distance < maxdistance then
				maxdistance = distance
				targetpos = rigs.HumanoidRootPart.Position
			end
		end
		
	end
	return targetpos
end






UIS.InputBegan:Connect(function(key, a)
	if a or key.KeyCode ~= Enum.KeyCode.F then return end
		if enabled == false then
			enabled = true
		else
			enabled = false
	end
	
	while enabled == false do
		target = ClosestEnemy()
		

		
		if target then
			local targetPos = target
			local cameraPos = camera.CFrame.Position
			local direction = (targetPos - cameraPos).Unit


			local newLookVector = camera.CFrame.LookVector:Lerp(direction, strength)
			camera.CFrame = CFrame.lookAt(camera.CFrame.Position, camera.CFrame.Position + newLookVector)
			
		end
		task.wait()
	end
end)
