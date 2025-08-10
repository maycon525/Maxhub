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
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)

-- Botões Speed e Jump
local function createButton(name, posY)
    local btn = Instance.new("TextButton", Frame)
    btn.Text = name
    btn.Size = UDim2.new(0.8, 0, 0.2, 0)
    btn.Position = UDim2.new(0.1, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn)
    return btn
end

local SpeedButton = createButton("🚀 Speed Boost", 0.35)
local JumpButton  = createButton("🦘 Jump Boost", 0.6)

-- Botão Flutuante
local FloatButton = Instance.new("TextButton", ScreenGui)
FloatButton.Text = "MaxHub"
FloatButton.Size = UDim2.new(0, 80, 0, 40)
FloatButton.Position = UDim2.new(0, 20, 0, 200)
FloatButton.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
FloatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatButton.Visible = false
Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(0, 10)

-- Mostrar e esconder interface
CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    FloatButton.Visible = true
end)
FloatButton.MouseButton1Click:Connect(function()
    Frame.Visible = true
    FloatButton.Visible = false
end)

-- Aplicar efeitos de Speed e Jump
local player = game.Players.LocalPlayer
local function getHumanoid()
    return player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
end

SpeedButton.MouseButton1Click:Connect(function()
    local h = getHumanoid()
    if h then
        h.WalkSpeed = 50
        game.StarterGui:SetCore("SendNotification", {Title = "MaxHub", Text = "🚀 Speed Boost ativado!", Duration = 5})
    end
end)

JumpButton.MouseButton1Click:Connect(function()
    local h = getHumanoid()
    if h then
        h.JumpPower = 120
        game.StarterGui:SetCore("SendNotification", {Title = "MaxHub", Text = "🦘 Jump Boost ativado!", Duration = 5})
    end
end)

-- Tornar interface e botão flutuante arrastáveis
local function makeDraggable(obj)
    local dragging, dragInput, inputStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            inputStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - inputStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(Frame)
makeDraggable(FloatButton)
