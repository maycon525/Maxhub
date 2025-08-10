-- 🛡 PROTEÇÃO ANTI-KICK
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if tostring(method):lower() == "kick" then
        warn("🚫 Tentativa de kick bloqueada pelo MaxHub!")
        return
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- 🎨 INTERFACE
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- Painel Principal
local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "MaxHub"
Title.Size = UDim2.new(1, -30, 0.3, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Fechar
local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CloseButton)

-- Botão Speed
local SpeedButton = Instance.new("TextButton", Frame)
SpeedButton.Text = "🚀 Speed Boost"
SpeedButton.Size = UDim2.new(0.8, 0, 0.25, 0)
SpeedButton.Position = UDim2.new(0.1, 0, 0.45, 0)
SpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SpeedButton)

-- Botão Jump
local JumpButton = Instance.new("TextButton", Frame)
JumpButton.Text = "🦘 Jump Boost"
JumpButton.Size = UDim2.new(0.8, 0, 0.25, 0)
JumpButton.Position = UDim2.new(0.1, 0, 0.75, 0)
JumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JumpButton)

-- Botão Flutuante
local FloatButton = Instance.new("TextButton", ScreenGui)
FloatButton.Text = "MaxHub"
FloatButton.Size = UDim2.new(0, 100, 0, 40)
FloatButton.Position = UDim2.new(0.5, -50, 0.1, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
FloatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", FloatButton)
FloatButton.Visible = false

-- Função de arrastar botão flutuante
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    FloatButton.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

FloatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = FloatButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

FloatButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Lógica dos Botões
local player = game.Players.LocalPlayer
local function getHumanoid()
    return player.Character and player.Character:FindFirstChildOfClass("Humanoid")
end

SpeedButton.MouseButton1Click:Connect(function()
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.WalkSpeed = 50
        game.StarterGui:SetCore("SendNotification", {Title = "MaxHub", Text = "🚀 Speed Boost ativado!", Duration = 5})
    end
end)

JumpButton.MouseButton1Click:Connect(function()
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.JumpPower = 120
        game.StarterGui:SetCore("SendNotification", {Title = "MaxHub", Text = "🦘 Jump Boost ativado!", Duration = 5})
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    FloatButton.Visible = true
end)

FloatButton.MouseButton1Click:Connect(function()
    Frame.Visible = true
    FloatButton.Visible = false
end)
