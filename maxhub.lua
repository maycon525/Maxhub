local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Botão de Fechar
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn)
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

local function criarBotao(txt, y)
    local b = Instance.new("TextButton", frame)
    b.Text = txt
    b.Size = UDim2.new(0.8, 0, 0.15, 0)
    b.Position = UDim2.new(0.1, 0, y, 0)
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    return b
end

local p = game.Players.LocalPlayer
local function hum()
    return p.Character and p.Character:FindFirstChildWhichIsA("Humanoid")
end

-- Botões
local bSpeed = criarBotao("Speed", 0.15)
local bJump = criarBotao("Jump", 0.35)
local bFly = criarBotao("Fly", 0.55)
local bClip = criarBotao("NoClip", 0.75)
local bInvis = criarBotao("Invisibility", 0.95)

-- Speed toggle
local speedOn = false
bSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    local h = hum()
    if h then
        h.WalkSpeed = speedOn and 50 or 16
    end
end)

-- Jump toggle
local jumpOn = false
bJump.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    local h = hum()
    if h then
        h.JumpPower = jumpOn and 120 or 50
    end
end)

-- Fly toggle
local flying = false
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local bp, bg
bFly.MouseButton1Click:Connect(function()
    flying = not flying
    local char = p.Character
    if flying then
        bp = Instance.new("BodyPosition", char.HumanoidRootPart)
        bp.MaxForce = Vector3.new(4000, 4000, 4000)
        bg = Instance.new("BodyGyro", char.HumanoidRootPart)
        bg.MaxTorque = Vector3.new(4000, 4000, 4000)
        RS:BindToRenderStep("fly", 0, function()
            bp.Position = bp.Position + (workspace.CurrentCamera.CFrame.LookVector * (UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0) * 2)
        end)
    else
        RS:UnbindFromRenderStep("fly")
        if bp then bp:Destroy() end
        if bg then bg:Destroy() end
    end
end)

-- NoClip toggle
local noclip = false
bClip.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        RS:BindToRenderStep("noclip", 1, function()
            if p.Character then
                for _, v in pairs(p.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        RS:UnbindFromRenderStep("noclip")
    end
end)

-- Invisibility toggle
local invis = false
bInvis.MouseButton1Click:Connect(function()
    if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return end
    invis = not invis
    for _, part in pairs(p.Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = invis and 1 or 0
        elseif part:IsA("Decal") then
            part.Transparency = invis and 1 or 0
        end
    end
end)
