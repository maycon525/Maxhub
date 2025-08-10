--// GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Botão X
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", closeBtn)

-- Botão flutuante pra abrir de novo
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(60, 200, 255)
openBtn.Text = ":)"
openBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", openBtn)
openBtn.Visible = false

-- Função criar botão de função
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

-- Fechar e abrir menu
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
end)
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    openBtn.Visible = false
end)

-- Funções
bSpeed.MouseButton1Click:Connect(function()
    local h = hum()
    if h then h.WalkSpeed = 50 end
end)

bJump.MouseButton1Click:Connect(function()
    local h = hum()
    if h then h.JumpPower = 120 end
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

-- NoClip
local noclip = false
bClip.MouseButton1Click:Connect(function()
    noclip = not noclip
    RS:BindToRenderStep("noclip", 1, function()
        if noclip and p.Character then
            for _, v in pairs(p.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
    if not noclip then RS:UnbindFromRenderStep("noclip") end
end)

-- Invisibility Toggle
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
