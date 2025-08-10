

-- PROTEÇÃO ANTI-KICK
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if tostring(method) == "Kick" or tostring(method) == "kick" then
        warn("🚫 Tentativa de kick bloqueada pelo MaxHub!")
        return
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- INTERFACE
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "MaxHub"
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1

local SpeedButton = Instance.new("TextButton", Frame)
SpeedButton.Text = "Speed Boost"
SpeedButton.Size = UDim2.new(0.8, 0, 0.25, 0)
SpeedButton.Position = UDim2.new(0.1, 0, 0.45, 0)
SpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SpeedButton)

local JumpButton = Instance.new("TextButton", Frame)
JumpButton.Text = "Jump Boost"
JumpButton.Size = UDim2.new(0.8, 0, 0.25, 0)
JumpButton.Position = UDim2.new(0.1, 0, 0.75, 0)
JumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JumpButton)

-- FUNÇÕES
local player = game.Players.LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

SpeedButton.MouseButton1Click:Connect(function()
    if humanoid then
        humanoid.WalkSpeed = 50
        game.StarterGui:SetCore("SendNotification", {
            Title = "MaxHub",
            Text = "🚀 Speed Boost ativado!",
            Duration = 5
        })
    end
end)

JumpButton.MouseButton1Click:Connect(function()
    if humanoid then
        humanoid.JumpPower = 120
        game.StarterGui:SetCore("SendNotification", {
            Title = "MaxHub",
            Text = "🦘 Jump Boost ativado!",
            Duration = 5
        })
    end
end)
