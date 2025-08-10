--========================================================
--  MaxHub v2.0 - AntiKick + Boosts + UI Flutuante
--========================================================

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

-- 📦 VARIÁVEIS GLOBAIS
local player = game.Players.LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

--========================================================
--  INTERFACE PRINCIPAL
--========================================================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3
