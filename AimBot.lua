


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
local hotkey = Instance.new("TextBox")
local teams = Instance.new("TextButton")
local drag = Instance.new("UIDragDetector")
local strength = .5

local function Setup()
	
	
	gui.ResetOnSpawn = false
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

	ex2.Size = UDim2.new(.3, 0,0.25, 0)
	ex2.Position = UDim2.new(0, 0,0.7, 0)
	ex2.TextScaled = true
	ex2.RichText = true
	ex2.Text = "Hotkey"
	ex2.Parent = frame

	hotkey.Size = UDim2.new(.25, 0,0.25, 0)
	hotkey.Position = UDim2.new(0.35, 0,0.7, 0)
	hotkey.TextScaled = true
	hotkey.RichText = true
	hotkey.Text = "NO HOTKEY"
	hotkey.Name = "HotKey"
	hotkey.Parent = frame
	
	teams.Size = UDim2.new(.25, 0,0.25, 0)
	teams.Position = UDim2.new(0.7, 0,0.7, 0)
	teams.TextScaled = true
	teams.RichText = true
	teams.Text = "No Teams"
	teams.Name = "Teams"
	teams.Parent = frame


	drag.Parent = frame
	frame.Parent = gui

end


Setup()

task.wait(Setup())


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
		if rigs.Name ~= player.Character.Name and rigs.Character:FindFirstChild("HumanoidRootPart") and rigs.Character.Humanoid.Health >= 1 then
				
			local p = nil
		
			if teams.Text == "Teams" and rigs.Team == player.Team then
				p = nil
			else
				p = rigs.Character
				distance = (p.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
			end

			
			if p and distance < maxdistance then
				maxdistance = distance
				targetpos = p.HumanoidRootPart.Position
			end
		end
	end
	
	if targetpos ~= nil then
		return targetpos
	end
end




UIS.InputBegan:Connect(function(key, a)
	if hotkey.Text == "NO HOTKEY" then return end
	if a or key.KeyCode ~= Enum.KeyCode[hotkey.Text] then return end
		
		if enabled == false then
			enabled = true
		else
			enabled = false
		end
	
	while enabled == true do
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

UIS.InputBegan:Connect(function(input)
	local focused_textbox = UIS:GetFocusedTextBox()
	
	
	
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if focused_textbox ~= nil and focused_textbox.Name == "HotKey" then
			focused_textbox.Text = input.KeyCode.Name 
			focused_textbox:ReleaseFocus() 
		end
	end
end)

teams.Activated:Connect(function()
	if teams.Text == "No Teams" then
		teams.Text = "Teams"
	else
		teams.Text = "No Teams"
	end
end)


