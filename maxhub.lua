local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

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
local bSpeed = criarBotao("Speed", 0.05)
local bJump = criarBotao("Jump", 0.25)
local bFly = criarBotao("Fly", 0.45)
local bClip = criarBotao("NoClip", 0.65)
local bInvis = criarBotao("Invisibility", 0.85)

-- Toggles
local speedOn, jumpOn, noclipOn, invisOn = false, false, false, false

-- Speed Toggle
bSpeed.MouseButton1Click:Connect(function()
    local h = hum()
    if not h then return end
    speedOn = not speedOn
    h.WalkSpeed = speedOn and 50 or 16
end)

-- Jump Toggle
bJump.MouseButton1Click:Connect(function()
    local h = hum()
    if not h then return end
    jumpOn = not jumpOn
    h.JumpPower = jumpOn and 120 or 50
end)

-- Fly simples
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

-- NoClip Toggle
bClip.MouseButton1Click:Connect(function()
    noclipOn = not noclipOn
    if noclipOn then
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

-- Invisibility Toggle
bInvis.MouseButton1Click:Connect(function()
    if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return end
    invisOn = not invisOn
    for _, part in pairs(p.Character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = invisOn and 1 or 0
        elseif part:IsA("Decal") then
            part.Transparency = invisOn and 1 or 0
        end
    end
end)
