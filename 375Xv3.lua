--[[
╔═══════════════════════════════════════════════════════════╗
║               🎭  3 7 5 X   J ' R  🎭                    ║
║               Version Complète — ROUGE                    ║
╚═══════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

if pg:FindFirstChild("H375X") then pg.H375X:Destroy() end

local RED = Color3.fromRGB(255, 40, 40)
local DARK_RED = Color3.fromRGB(120, 0, 0)

-- ÉTAT
local S = {
    InfJump = false,
    BoxESP = false,
    Tracers = false,
    AnimPack = 1,
    SpeedBoost = 60
}

local AnimPacks = {"Zombie", "Vampire", "Adidas"}

-- ===== FONCTIONS =====
local function SetSpeed(v)
    local c = player.Character
    if c and c:FindFirstChild("Humanoid") then c.Humanoid.WalkSpeed = v end
end

local function TpDown()
    local c = player.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame - Vector3.new(0, 20, 0)
    end
end

local function Respawn()
    if player.Character then player.Character:BreakJoints() end
end

local function BatTP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local tool = plr.Character:FindFirstChildOfClass("Tool")
            if tool and string.find(tool.Name:lower(), "bat") then
                local mH = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local hH = plr.Character:FindFirstChild("HumanoidRootPart")
                if mH and hH then mH.CFrame = hH.CFrame + hH.CFrame.LookVector * 8 end
                break
            end
        end
    end
end

local function DropBR()
    local c = player.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame + Vector3.new(0, 15, 0)
    end
end

local function AutoPlay()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local mH = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local hH = plr.Character:FindFirstChild("HumanoidRootPart")
            if mH and hH then
                local dir = (hH.Position - mH.Position).Unit
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(1e5, 0, 1e5)
                bv.Velocity = dir * S.SpeedBoost
                bv.Parent = mH
                wait(0.5)
                if bv then bv:Destroy() end
            end
            break
        end
    end
end

local function ToggleESP()
    S.BoxESP = not S.BoxESP
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local hl = plr.Character:FindFirstChild("H375ESP")
            if S.BoxESP then
                if not hl then
                    local h = Instance.new("Highlight")
                    h.Name = "H375ESP"
                    h.FillColor = RED
                    h.OutlineColor = Color3.fromRGB(255, 255, 255)
                    h.Parent = plr.Character
                end
            else
                if hl then hl:Destroy() end
            end
        end
    end
end

UIS.JumpRequest:Connect(function()
    if S.InfJump then
        local c = player.Character
        if c and c:FindFirstChild("Humanoid") then
            c.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ===== INTERFACE =====
local sg = Instance.new("ScreenGui")
sg.Name = "H375X"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = pg

-- Bouton MENU
local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 90, 0, 90)
mb.Position = UDim2.new(0, 15, 0.5, -45)
mb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mb.Text = "MENU"
mb.TextColor3 = RED
mb.TextSize = 16
mb.Font = Enum.Font.GothamBold
mb.Parent = sg
Instance.new("UICorner", mb).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", mb)
ms.Color = RED
ms.Thickness = 2

-- Boutons carrés droite
local rp = Instance.new("Frame")
rp.Size = UDim2.new(0, 300, 0, 420)
rp.Position = UDim2.new(1, -315, 0.5, -210)
rp.BackgroundTransparency = 1
rp.Parent = sg
local grid = Instance.new("UIGridLayout", rp)
grid.CellSize = UDim2.new(0, 90, 0, 70)
grid.CellPadding = UDim2.new(0, 8, 0, 8)

local function Square(t1, t2, cb)
    local b = Instance.new("TextButton")
    b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b.Text = ""
    b.Parent = rp
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke", b)
    s.Color = RED
    s.Thickness = 2
    local l = Instance.new("TextLabel", b)
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = t1 .. "\n" .. t2
    l.TextColor3 = RED
    l.TextSize = 12
    l.Font = Enum.Font.GothamBold
    b.MouseButton1Click:Connect(cb)
end

Square("BAT", "TP", BatTP)
Square("DROP", "BR", DropBR)
Square("BAT", "AIMBOT", function() end)
Square("TP", "DOWN", TpDown)
Square("CARRY", "SPD", function() SetSpeed(30) end)
Square("LAGGER", "CARRY", function() SetSpeed(24.5) end)
Square("LAGGER", "SPD", function() SetSpeed(15) end)
Square("ANTI BAT", "BYPASS", function() end)
Square("RESET", "", Respawn)
Square("AUTO", "PLAY", AutoPlay)

-- ===== MENU PRINCIPAL =====
local mm = Instance.new("Frame")
mm.Size = UDim2.new(0, 500, 0, 440)
mm.Position = UDim2.new(0.5, -250, 0.5, -220)
mm.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
mm.BorderSizePixel = 0
mm.Visible = false
mm.Parent = sg
Instance.new("UICorner", mm).CornerRadius = UDim.new(0, 12)
local mms = Instance.new("UIStroke", mm)
mms.Color = RED
mms.Thickness = 2

-- Titre
local mt = Instance.new("TextLabel")
mt.Size = UDim2.new(1, 0, 0, 40)
mt.BackgroundColor3 = DARK_RED
mt.BorderSizePixel = 0
mt.Text = "  375X J'R"
mt.TextColor3 = RED
mt.TextSize = 16
mt.Font = Enum.Font.GothamBold
mt.TextXAlignment = Enum.TextXAlignment.Left
mt.Parent = mm
Instance.new("UICorner", mt).CornerRadius = UDim.new(0, 12)

-- Contenu scrollable
local cf = Instance.new("ScrollingFrame")
cf.Size = UDim2.new(1, -20, 1, -50)
cf.Position = UDim2.new(0, 10, 0, 45)
cf.BackgroundTransparency = 1
cf.BorderSizePixel = 0
cf.ScrollBarThickness = 3
cf.Parent = mm
local cl = Instance.new("UIListLayout", cf)
cl.Padding = UDim.new(0, 6)

-- Fonction Bouton Menu
local function MB(txt, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    b.Text = txt
    b.TextColor3 = RED
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.Parent = cf
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
end

-- Fonction Toggle
local function MT(txt, init, cb)
    local r = Instance.new("Frame")
    r.Size = UDim2.new(1, -5, 0, 35)
    r.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    r.BorderSizePixel = 0
    r.Parent = cf
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 6)
    local l = Instance.new("TextLabel", r)
    l.Size = UDim2.new(0.7, 0, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.TextSize = 12
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    local b = Instance.new("TextButton", r)
    b.Size = UDim2.new(0, 40, 0, 22)
    b.Position = UDim2.new(1, -50, 0, 6)
    b.BackgroundColor3 = init and RED or Color3.fromRGB(60, 60, 60)
    b.Text = ""
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 11)
    local st = init
    b.MouseButton1Click:Connect(function()
        st = not st
        b.BackgroundColor3 = st and RED or Color3.fromRGB(60, 60, 60)
        if cb then cb(st) end
    end)
end

-- Boutons vitesse
MB("CRAZY SPEED (30)", function() SetSpeed(30) end)
MB("SPEED LAGGER (15)", function() SetSpeed(15) end)
MB("LAGGER CARRY (24.5)", function() SetSpeed(24.5) end)
MB("NORMAL (60)", function() SetSpeed(60) end)
MB("⬇️ TP DOWN", TpDown)
MB("🔄 RESET", Respawn)

-- Séparateur
local sep = Instance.new("TextLabel", cf)
sep.Size = UDim2.new(1, -5, 0, 20)
sep.BackgroundTransparency = 1
sep.Text = "─── OPTIONS ───"
sep.TextColor3 = Color3.fromRGB(150, 100, 100)
sep.TextSize = 11
sep.Font = Enum.Font.GothamBold

-- Toggles
MT("🦘 INFINITE JUMP", false, function(v) S.InfJump = v end)
MT("👁️ BOX ESP", false, function(v) if v then S.BoxESP = false ToggleESP() else ToggleESP() end end)
MT("📏 TRACERS", false, function(v) S.Tracers = v end)

-- ANIM PACK
local ar = Instance.new("Frame", cf)
ar.Size = UDim2.new(1, -5, 0, 35)
ar.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
ar.BorderSizePixel = 0
Instance.new("UICorner", ar).CornerRadius = UDim.new(0, 6)
local al = Instance.new("TextLabel", ar)
al.Size = UDim2.new(0.5, 0, 1, 0)
al.Position = UDim2.new(0, 10, 0, 0)
al.BackgroundTransparency = 1
al.Text = "ANIM PACK"
al.TextColor3 = Color3.fromRGB(255, 255, 255)
al.TextSize = 12
al.Font = Enum.Font.GothamBold
al.TextXAlignment = Enum.TextXAlignment.Left
local alb = Instance.new("TextButton", ar)
alb.Size = UDim2.new(0, 30, 0, 28)
alb.Position = UDim2.new(0.55, 0, 0, 3)
alb.BackgroundColor3 = DARK_RED
alb.Text = "<"
alb.TextColor3 = RED
alb.TextSize = 16
alb.Font = Enum.Font.GothamBold
Instance.new("UICorner", alb).CornerRadius = UDim.new(0, 6)
local ad = Instance.new("TextLabel", ar)
ad.Size = UDim2.new(0, 70, 0, 28)
ad.Position = UDim2.new(0.55, 32, 0, 3)
ad.BackgroundColor3 = DARK_RED
ad.Text = "Zombie"
ad.TextColor3 = RED
ad.TextSize = 12
ad.Font = Enum.Font.GothamBold
Instance.new("UICorner", ad).CornerRadius = UDim.new(0, 6)
local arb = Instance.new("TextButton", ar)
arb.Size = UDim2.new(0, 30, 0, 28)
arb.Position = UDim2.new(0.55, 106, 0, 3)
arb.BackgroundColor3 = DARK_RED
arb.Text = ">"
arb.TextColor3 = RED
arb.TextSize = 16
arb.Font = Enum.Font.GothamBold
Instance.new("UICorner", arb).CornerRadius = UDim.new(0, 6)

alb.MouseButton1Click:Connect(function()
    S.AnimPack = S.AnimPack - 1
    if S.AnimPack < 1 then S.AnimPack = #AnimPacks end
    ad.Text = AnimPacks[S.AnimPack]
end)
arb.MouseButton1Click:Connect(function()
    S.AnimPack = S.AnimPack + 1
    if S.AnimPack > #AnimPacks then S.AnimPack = 1 end
    ad.Text = AnimPacks[S.AnimPack]
end)

-- Ouvrir/Fermer
mb.MouseButton1Click:Connect(function()
    mm.Visible = not mm.Visible
end)

-- DÉPLACEMENT
local drag, ds, sp = false, nil, nil
mt.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = true
        ds = i.Position
        sp = mm.Position
    end
end)
mt.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - ds
        mm.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)
mt.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = false
    end
end)

print("✅ 375X J'R COMPLET chargé !")
