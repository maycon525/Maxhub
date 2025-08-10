-- 🛡️ PROTEÇÃO ANTI-KICK
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
Frame.Position = UDim2.new
