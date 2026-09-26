--[[
╔═══════════════════════════════════════════════════════════╗
║               🎭  3 7 5   J ' R  🎭                      ║
║               Version 5 — ROUGE                           ║
╚═══════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

if pg:FindFirstChild("H375X") then pg.H375X:Destroy() end

local RED = Color3.fromRGB(255, 40, 40)
local DARK_RED = Color3.fromRGB(120, 0, 0)
local BG = Color3.fromRGB(12, 12, 18)
local BG_PANEL = Color3.fromRGB(18, 18, 25)
local BG_BTN = Color3.fromRGB(25, 25, 35)
local TEXT_WHITE = Color3.fromRGB(255, 255, 255)
local TEXT_GRAY = Color3.fromRGB(180, 180, 200)
local DISCORD = "https://discord.gg/CGf9Cs3Kr"

local S = {
    SpeedBoost = 60,
    InfJump = false,
    BoxESP = false,
    Tracers = false
}

-- ============ FONCTIONS ============
local function SetSpeed(v)
    local c = player.Character
    if c and c:FindFirstChild("Humanoid") then
        c.Humanoid.WalkSpeed = v
    end
    local c2 = player.Character
    if c2 then
        local head = c2:FindFirstChild("Head")
        if head then
            local old = head:FindFirstChild("H375Speed")
            if old then old:Destroy() end
            local bb = Instance.new("BillboardGui")
            bb.Name = "H375Speed"
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = head
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = "⚡ " .. tostring(v)
            lbl.TextColor3 = RED
            lbl.TextSize = 24
            lbl.Font = Enum.Font.GothamBold
            lbl.TextStrokeTransparency = 0
            lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            lbl.Parent = bb
            wait(2)
            if bb and bb.Parent then bb:Destroy() end
        end
    end
end

local function ResetPlayer()
    local c = player.Character
    if c then
        local humanoid = c:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Health = 0 end
    end
end

local function TpDown()
    local c = player.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame - Vector3.new(0, 20, 0)
    end
end

local function BatTP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local bat = plr.Character:FindFirstChild("BAT")
            if not bat then
                local bp = plr:FindFirstChild("Backpack")
                if bp then bat = bp:FindFirstChild("BAT") end
            end
            if bat then
                local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local hisHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if myHrp and hisHrp then
                    myHrp.CFrame = hisHrp.CFrame + hisHrp.CFrame.LookVector * 3
                end
                break
            end
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

-- ============ ANIMATION ZOMBIE ============
local function ApplyAnimation()
    local c = player.Character
    if not c then return end
    local a = c:FindFirstChild("Animate")
    if not a then return end
    
    if a.idle and a.idle:FindFirstChild("Animation1") then
        a.idle.Animation1.AnimationId = "rbxassetid://616158929"
    end
    if a.idle and a.idle:FindFirstChild("Animation2") then
        a.idle.Animation2.AnimationId = "rbxassetid://616158929"
    end
    if a.walk and a.walk:FindFirstChild("WalkAnim") then
        a.walk.WalkAnim.AnimationId = "rbxassetid://616163682"
    end
    if a.run and a.run:FindFirstChild("RunAnim") then
        a.run.RunAnim.AnimationId = "rbxassetid://616163682"
    end
    if a.jump and a.jump:FindFirstChild("JumpAnim") then
        a.jump.JumpAnim.AnimationId = "rbxassetid://616161997"
    end
    if a.climb and a.climb:FindFirstChild("ClimbAnim") then
        a.climb.ClimbAnim.AnimationId = "rbxassetid://616157476"
    end
    if a.fall and a.fall:FindFirstChild("FallAnim") then
        a.fall.FallAnim.AnimationId = "rbxassetid://616160286"
    end
    if a.swim and a.swim:FindFirstChild("Swim") then
        a.swim.Swim.AnimationId = "rbxassetid://616165056"
    end
end

player.CharacterAdded:Connect(function()
    wait(2)
    ApplyAnimation()
    wait(1)
    local char = player.Character
    if char then
        local head = char:FindFirstChild("Head")
        if head and not head:FindFirstChild("H375Discord") then
            local bb = Instance.new("BillboardGui")
            bb.Name = "H375Discord"
            bb.Size = UDim2.new(0, 200, 0, 50)
            bb.StudsOffset = Vector3.new(0, 4, 0)
            bb.AlwaysOnTop = true
            bb.Parent = head
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = "📱 discord.gg/CGf9Cs3Kr"
            lbl.TextColor3 = RED
            lbl.TextSize = 16
            lbl.Font = Enum.Font.GothamBold
            lbl.TextStrokeTransparency = 0
            lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            lbl.Parent = bb
        end
    end
end)

-- INFINITE JUMP (SANS RESET)
spawn(function()
    while wait(0.1) do
        if S.InfJump then
            local c = player.Character
            if c then
                local humanoid = c:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.UseJumpPower = true
                    humanoid.JumpPower = 100
                end
            end
        end
    end
end)

-- ============ INTERFACE ============
local sg = Instance.new("ScreenGui")
sg.Name = "H375X"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = pg

local mb = Instance.new("TextButton")
mb.Size = UDim2.new(0, 55, 0, 55)
mb.Position = UDim2.new(0, 15, 0.5, -27)
mb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mb.Text = "MENU"
mb.TextColor3 = RED
mb.TextSize = 13
mb.Font = Enum.Font.GothamBold
mb.Parent = sg
Instance.new("UICorner", mb).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", mb)
ms.Color = RED
ms.Thickness = 2

local blur = Instance.new("Frame")
blur.Size = UDim2.new(1, 0, 1, 0)
blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blur.BackgroundTransparency = 0.5
blur.Visible = false
blur.Parent = sg

local mm = Instance.new("Frame")
mm.Size = UDim2.new(0, 520, 0, 400)
mm.Position = UDim2.new(0.5, -260, 0.5, -200)
mm.BackgroundColor3 = BG
mm.BorderSizePixel = 0
mm.Visible = false
mm.Parent = sg
Instance.new("UICorner", mm).CornerRadius = UDim.new(0, 12)
local mms = Instance.new("UIStroke", mm)
mms.Color = RED
mms.Thickness = 2

local mt = Instance.new("TextLabel")
mt.Size = UDim2.new(1, 0, 0, 40)
mt.BackgroundColor3 = DARK_RED
mt.BorderSizePixel = 0
mt.Text = "  375 J'R"
mt.TextColor3 = RED
mt.TextSize = 16
mt.Font = Enum.Font.GothamBold
mt.TextXAlignment = Enum.TextXAlignment.Left
mt.Parent = mm
Instance.new("UICorner", mt).CornerRadius = UDim.new(0, 12)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = RED
closeBtn.Text = "✖"
closeBtn.TextColor3 = TEXT_WHITE
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mm
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local side = Instance.new("Frame")
side.Size = UDim2.new(0, 130, 1, -85)
side.Position = UDim2.new(0, 5, 0, 45)
side.BackgroundColor3 = BG_PANEL
side.BorderSizePixel = 0
side.Parent = mm
Instance.new("UICorner", side).CornerRadius = UDim.new(0, 8)
local sideL = Instance.new("UIListLayout", side)
sideL.Padding = UDim.new(0, 3)
sideL.SortOrder = Enum.SortOrder.LayoutOrder

local panel = Instance.new("Frame")
panel.Size = UDim2.new(1, -145, 1, -85)
panel.Position = UDim2.new(0, 140, 0, 45)
panel.BackgroundColor3 = BG_PANEL
panel.BorderSizePixel = 0
panel.Parent = mm
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 8)

local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, -20, 0, 30)
panelTitle.Position = UDim2.new(0, 10, 0, 5)
panelTitle.BackgroundTransparency = 1
panelTitle.Text = "SPEED"
panelTitle.TextColor3 = RED
panelTitle.TextSize = 15
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextXAlignment = Enum.TextXAlignment.Left
panelTitle.Parent = panel

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -50)
content.Position = UDim2.new(0, 10, 0, 40)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.Parent = panel
local contentL = Instance.new("UIListLayout", content)
contentL.Padding = UDim.new(0, 6)
contentL.SortOrder = Enum.SortOrder.LayoutOrder

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -60, 0, 35)
footer.Position = UDim2.new(0, 10, 1, -40)
footer.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
footer.BorderSizePixel = 0
footer.Text = "375 J'R\n" .. DISCORD
footer.TextColor3 = RED
footer.TextSize = 10
footer.Font = Enum.Font.GothamBold
footer.TextWrapped = true
footer.Parent = mm
Instance.new("UICorner", footer).CornerRadius = UDim.new(0, 6)

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 40, 0, 35)
copyBtn.Position = UDim2.new(1, -50, 1, -40)
copyBtn.BackgroundColor3 = DARK_RED
copyBtn.Text = "📋"
copyBtn.TextColor3 = RED
copyBtn.TextSize = 16
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Parent = mm
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

local function MB(txt, cb)
    local b = Instance.new("TextButton")
    b.Size =
