--[[ 175 Script BLEU - Speed + Jump + Fly + Noclip + Anti-Ragdoll ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local SPEED_NORMAL, SPEED_BOOST = 16, 100
local JUMP_NORMAL, JUMP_BOOST = 50, 120
local boostActif, infJumpActif = false, false
local flyActif, noclipActif, antiRagdollActif = false, false, false

local function getHum()
    local c = LocalPlayer.Character
    return c and c:FindFirstChildOfClass("Humanoid") or nil
end

local function setSpeed(v)
    local h = getHum(); if h then h.WalkSpeed = v end
end

local function setJump(p)
    local h = getHum(); if h then h.JumpPower = p end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    setSpeed(boostActif and SPEED_BOOST or SPEED_NORMAL)
    setJump(infJumpActif and JUMP_BOOST or JUMP_NORMAL)
    if flyActif then flyActif = false end
end)

UserInputService.JumpRequest:Connect(function()
    if not infJumpActif then return end
    local h = getHum()
    if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

RunService.Stepped:Connect(function()
    if not noclipActif then return end
    local c = LocalPlayer.Character
    if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end)

local flyBV, flyBG
local function activerFly()
    local c = LocalPlayer.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = getHum()
    if not hrp or not hum then return end
    flyBV = Instance.new("BodyVelocity", hrp)
    flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
    flyBV.Velocity = Vector3.zero
    flyBG = Instance.new("BodyGyro", hrp)
    flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
    flyBG.P = 1000
    hum.PlatformStand = true
end

local function desactiverFly()
    if flyBV then flyBV:Destroy(); flyBV = nil end
    if flyBG then flyBG:Destroy(); flyBG = nil end
    local h = getHum(); if h then h.PlatformStand = false end
end

RunService.RenderStepped:Connect(function()
    if not flyActif then return end
    local c = LocalPlayer.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp or not flyBV then return end
    local cam = workspace.CurrentCamera
    local dir = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end
    flyBV.Velocity = dir * 60
    flyBG.CFrame = cam.CFrame
end)

RunService.Heartbeat:Connect(function()
    if not antiRagdollActif then return end
    local h = getHum()
    if h then
        h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    end
end)

local FOND = Color3.fromRGB(15,22,40)
local PANNEAU = Color3.fromRGB(25,40,75)
local CARTE = Color3.fromRGB(35,60,120)
local TEXTE = Color3.fromRGB(255,255,255)
local ACCENT = Color3.fromRGB(0,140,255)
local BORDURE = Color3.fromRGB(0,160,255)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Script175Bleu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local function creerPanneau(nom, titre, pos, taille)
    local f = Instance.new("Frame", ScreenGui)
    f.Name = nom; f.Position = pos; f.Size = taille
    f.BackgroundColor3 = FOND; f.BorderSizePixel = 0
    f.Active = true; f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)
    local s = Instance.new("UIStroke", f); s.Color = BORDURE; s.Thickness = 2
    local h = Instance.new("Frame", f)
    h.Size = UDim2.new(1,0,0,40); h.BackgroundColor3 = PANNEAU
    h.BorderSizePixel = 0
    Instance.new("UICorner", h).CornerRadius = UDim.new(0,12)
    local t = Instance.new("TextLabel", h)
    t.Size = UDim2.new(1,-80,1,0); t.Position = UDim2.new(0,15,0,0)
    t.BackgroundTransparency = 1; t.Text = titre
    t.TextColor3 = TEXTE; t.Font = Enum.Font.GothamBold
    t.TextSize = 18; t.TextXAlignment = Enum.TextXAlignment.Left
    local bx = Instance.new("TextButton", h)
    bx.Size = UDim2.new(0,30,0,30); bx.Position = UDim2.new(1,-35,0,5)
    bx.BackgroundColor3 = CARTE; bx.Text = "X"
    bx.TextColor3 = TEXTE; bx.Font = Enum.Font.GothamBold; bx.TextSize = 16
    Instance.new("UICorner", bx).CornerRadius = UDim.new(0,6)
    bx.MouseButton1Click:Connect(function() f.Visible = false end)
    local c = Instance.new("Frame", f)
    c.Size = UDim2.new(1,-20,1,-50); c.Position = UDim2.new(0,10,0,45)
    c.BackgroundTransparency = 1
    return f, c
end

local function creerToggle(parent, txt, desc, y, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,0,0,60); f.Position = UDim2.new(0,0,0,y)
    f.BackgroundColor3 = CARTE; f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)
    local s = Instance.new("UIStroke", f); s.Color = ACCENT
    s.Thickness = 1; s.Transparency = 0.5
    local t1 = Instance.new("TextLabel", f)
    t1.Size = UDim2.new(1,-80,0,25); t1.Position = UDim2.new(0,15,0,5)
    t1.BackgroundTransparency = 1; t1.Text = txt; t1.TextColor3 = TEXTE
    t1.Font = Enum.Font.GothamBold; t1.TextSize = 15
    t1.TextXAlignment = Enum.TextXAlignment.Left
    local t2 = Instance.new("TextLabel", f)
    t2.Size = UDim2.new(1,-80,0,20); t2.Position = UDim2.new(0,15,0,30)
    t2.BackgroundTransparency = 1; t2.Text = desc
    t2.TextColor3 = Color3.fromRGB(160,200,255); t2.Font = Enum.Font.Gotham
    t2.TextSize = 12; t2.TextXAlignment = Enum.TextXAlignment.Left
    local tg = Instance.new("Frame", f)
    tg.Size = UDim2.new(0,50,0,26); tg.Position = UDim2.new(1,-65,0.5,-13)
    tg.BackgroundColor3 = Color3.fromRGB(70,80,100); tg.BorderSizePixel = 0
    Instance.new("UICorner", tg).CornerRadius = UDim.new(1,0)
    local d = Instance.new("Frame", tg)
    d.Size = UDim2.new(0,20,0,20); d.Position = UDim2.new(0,3,0.5,-10)
    d.BackgroundColor3 = Color3.fromRGB(255,255,255); d.BorderSizePixel = 0
    Instance.new("UICorner", d).CornerRadius = UDim.new(1,0)
    local st = false
    local btn = Instance.new("TextButton", tg)
    btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""
    btn.MouseButton1Click:Connect(function()
        st = not st
        if st then
            tg.BackgroundColor3 = ACCENT
            d.Position = UDim2.new(1,-23,0.5,-10)
        else
            tg.BackgroundColor3 = Color3.fromRGB(70,80,100)
            d.Position = UDim2.new(0,3,0.5,-10)
        end
        if cb then cb(st) end
    end)
end

local function creerBouton(parent, txt, pos, taille, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = taille; b.Position = pos
    b.BackgroundColor3 = PANNEAU; b.Text = txt
    b.TextColor3 = TEXTE; b.Font = Enum.Font.GothamBold
    b.TextSize = 14; b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    local s = Instance.new("UIStroke", b); s.Color = ACCENT; s.Thickness = 1.5
    b.MouseButton1Click:Connect(cb)
    return b
end

local _, cB = creerPanneau("Brainrots","Brainrots",UDim2.new(0,20,0.5,-180),UDim2.new(0,240,0,300))
local b1 = Instance.new("Frame", cB)
b1.Size = UDim2.new(1,0,0,100); b1.BackgroundColor3 = CARTE
b1.BorderSizePixel = 0
Instance.new("UICorner", b1).CornerRadius = UDim.new(0,10)
local b1s = Instance.new("UIStroke", b1); b1s.Color = ACCENT; b1s.Thickness = 1.5
local b1n = Instance.new("TextLabel", b1)
b1n.Size = UDim2.new(1,0,0,55); b1n.Position = UDim2.new(0,0,0,10)
b1n.BackgroundTransparency = 1; b1n.Text = "Ketupat\nKepat"
b1n.TextColor3 = TEXTE; b1n.Font = Enum.Font.GothamBold; b1n.TextSize = 16
local b1sl = Instance.new("TextLabel", b1)
b1sl.Size = UDim2.new(1,0,0,25); b1sl.Position = UDim2.new(0,0,0,70)
b1sl.BackgroundTransparency = 1; b1sl.Text = "Slot 1"
b1sl.TextColor3 = ACCENT; b1sl.Font = Enum.Font.GothamBold; b1sl.TextSize = 15
local b2 = Instance.new("Frame", cB)
b2.Size = UDim2.new(1,0,0,80); b2.Position = UDim2.new(0,0,0,110)
b2.BackgroundColor3 = CARTE; b2.BorderSizePixel = 0
Instance.new("UICorner", b2).CornerRadius = UDim.new(0,10)
local b2s = Instance.new("UIStroke", b2); b2s.Color = ACCENT; b2s.Thickness = 1.5
local b2n = Instance.new("TextLabel", b2)
b2n.Size = UDim2.new(1,0,1,0); b2n.BackgroundTransparency = 1
b2n.Text = "Ketupat\nKepat"; b2n.TextColor3 = TEXTE
b2n.Font = Enum.Font.GothamBold; b2n.TextSize = 15

local _, cS = creerPanneau("Settings","Settings",UDim2.new(0,280,0.5,-280),UDim2.new(0,280,0,560))
creerToggle(cS,"Anti Ragdoll","No te tira ragdoll al",0,function(s) antiRagdollActif = s end)
creerToggle(cS,"Bypass Ragdoll","Te tira ragdoll (tecnica)",70,function(s) print("Bypass:",s) end)
creerToggle(cS,"Speed Boost","100 walk speed (RightShift)",140,function(s)
    boostActif = s; setSpeed(s and SPEED_BOOST or SPEED_NORMAL)
end)
creerToggle(cS,"Infinite Jump","Saut infini (RightControl)",210,function(s)
    infJumpActif = s; setJump(s and JUMP_BOOST or JUMP_NORMAL)
end)
creerToggle(cS,"Fly","Voler (F)",280,function(s)
    flyActif = s; if s then activerFly() else desactiverFly() end
end)
creerToggle(cS,"Noclip","Traverser les murs (N)",350,function(s) noclipActif = s end)

local mLine = Instance.new("Frame", cS)
mLine.Size = UDim2.new(1,0,0,30); mLine.Position = UDim2.new(0,0,0,420)
mLine.BackgroundTransparency = 1
local mLbl = Instance.new("TextLabel", mLine)
mLbl.Size = UDim2.new(0,70,0,25); mLbl.Position = UDim2.new(0.5,-35,0,0)
mLbl.BackgroundColor3 = CARTE; mLbl.Text = "MISC"
mLbl.TextColor3 = TEXTE; mLbl.Font = Enum.Font.GothamBold; mLbl.TextSize = 12
Instance.new("UICorner", mLbl).CornerRadius = UDim.new(0,5)

creerToggle(cS,"AP ESP","Tag les joueurs avec AP",460,function(s) print("ESP:",s) end)

local pF, cF = creerPanneau("Flash175","● 175 Flash",UDim2.new(0,20,1,-180),UDim2.new(0,540,0,160))
local petits = {"R","B","S","L"}
local couleurs = {Color3.fromRGB(255,100,100),Color3.fromRGB(100,180,255),Color3.fromRGB(100,255,130),Color3.fromRGB(255,220,100)}
for i, l in ipairs(petits) do
    local btn = Instance.new("TextButton", pF)
    btn.Size = UDim2.new(0,32,0,28); btn.Position = UDim2.new(0,270+(i-1)*36,0,6)
    btn.BackgroundColor3 = CARTE; btn.Text = l
    btn.TextColor3 = couleurs[i]; btn.Font = Enum.Font.GothamBold; btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
end

local flashActif = false
creerBouton(cF,"FLASH",UDim2.new(0,0,0,10),UDim2.new(0,165,0,45),function()
    flashActif = not flashActif
    setSpeed(flashActif and SPEED_BOOST or SPEED_NORMAL)
    boostActif = flashActif
end)
creerBouton(cF,"BLOCK",UDim2.new(0,175,0,10),UDim2.new(0,165,0,45),function()
    setSpeed(SPEED_NORMAL); boostActif = false; flashActif = false
end)
creerBouton(cF,"RESET",UDim2.new(0,350,0,10),UDim2.new(0,165,0,45),function()
    boostActif = false; flashActif = false; infJumpActif = false
    flyActif = false; noclipActif = false; antiRagdollActif = false
    desactiverFly(); setSpeed(SPEED_NORMAL); setJump(JUMP_NORMAL)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        boostActif = not boostActif
        setSpeed(boostActif and SPEED_BOOST or SPEED_NORMAL)
    elseif input.KeyCode == Enum.KeyCode.RightControl then
        infJumpActif = not infJumpActif
        setJump(infJumpActif and JUMP_BOOST or JUMP_NORMAL)
    elseif input.KeyCode == Enum.KeyCode.F then
        flyActif = not flyActif
        if flyActif then activerFly() else desactiverFly() end
    elseif input.KeyCode == Enum.KeyCode.N then
        noclipActif = not noclipActif
    end
end)

print("[175 Bleu] Script charge !")
