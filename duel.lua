local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

if _G.BrainrotHub then pcall(function() _G.BrainrotHub:Destroy() end) end

local SpeedBoost = 60
local INFJump = false
local AntiDie = false
local BodyLock = false
local AntiRagdoll = false
local BoxESP = false
local AntiLag = false
local AutoSteal = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
_G.BrainrotHub = ScreenGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 620, 0, 400)
Main.Position = UDim2.new(0.5, -310, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(60, 100, 220)
Stroke.Thickness = 1.5
Stroke.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "BRAINROT HUB"
Title.TextColor3 = Color3.fromRGB(230, 230, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CloseBtn.Text = "−"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabBar

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -100)
Content.Position = UDim2.new(0, 10, 0, 92)
Content.BackgroundTransparency = 1
Content.Parent = Main

local pages = {}
local tabs = {}

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(60, 100, 220)
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    pages[name] = page
    tabs[name] = btn

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, t in pairs(tabs) do
            t.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
            t.TextColor3 = Color3.fromRGB(150, 150, 180)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(60, 100, 220)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return page
end

local function addSection(parent, text)
    local section = Instance.new("TextLabel")
    section.Size = UDim2.new(1, 0, 0, 22)
    section.BackgroundTransparency = 1
    section.Text = "> " .. text
    section.TextColor3 = Color3.fromRGB(90, 140, 255)
    section.Font = Enum.Font.GothamBold
    section.TextSize = 12
    section.TextXAlignment = Enum.TextXAlignment.Left
    section.Parent = parent
end

local function addToggle(parent, label, default, callback)
    local state = default or false
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -5, 0, 38)
    container.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
    container.BorderSizePixel = 0
    container.Parent = parent
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -90, 1, 0)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 44, 0, 22)
    switch.Position = UDim2.new(1, -56, 0, 8)
    switch.BackgroundColor3 = state and Color3.fromRGB(60, 100, 220) or Color3.fromRGB(50, 50, 70)
    switch.Parent = container
    Instance.new("UICorner", switch).CornerRadius = UDim.new(0, 11)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = state and UDim2.new(1, -21, 0, 2) or UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = switch
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 9)

    local click = Instance.new("TextButton")
    click.Size = UDim2.new(1, 0, 1, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.Parent = container

    click.MouseButton1Click:Connect(function()
        state = not state
        switch.BackgroundColor3 = state and Color3.fromRGB(60, 100, 220) or Color3.fromRGB(50, 50, 70)
        knob.Position = state and UDim2.new(1, -21, 0, 2) or UDim2.new(0, 2, 0, 2)
        if callback then callback(state) end
    end)
end

local function addSlider(parent, label, min, max, default, step, callback)
    local value = default or min
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -5, 0, 38)
    container.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
    container.BorderSizePixel = 0
    container.Parent = parent
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -180, 1, 0)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local minus = Instance.new("TextButton")
    minus.Size = UDim2.new(0, 28, 0, 24)
    minus.Position = UDim2.new(1, -134, 0, 7)
    minus.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    minus.Text = "−"
    minus.TextColor3 = Color3.fromRGB(90, 140, 255)
    minus.Font = Enum.Font.GothamBold
    minus.TextSize = 16
    minus.Parent = container
    Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 6)

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 55, 0, 24)
    valLbl.Position = UDim2.new(1, -102, 0, 7)
    valLbl.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    valLbl.Text = tostring(value)
    valLbl.TextColor3 = Color3.fromRGB(90, 140, 255)
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 13
    valLbl.Parent = container
    Instance.new("UICorner", valLbl).CornerRadius = UDim.new(0, 6)

    local plus = Instance.new("TextButton")
    plus.Size = UDim2.new(0, 28, 0, 24)
    plus.Position = UDim2.new(1, -42, 0, 7)
    plus.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    plus.Text = "+"
    plus.TextColor3 = Color3.fromRGB(90, 140, 255)
    plus.Font = Enum.Font.GothamBold
    plus.TextSize = 16
    plus.Parent = container
    Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 6)

    minus.MouseButton1Click:Connect(function()
        value = math.max(min, value - step)
        valLbl.Text = tostring(value)
        if callback then callback(value) end
    end)
    plus.MouseButton1Click:Connect(function()
        value = math.min(max, value + step)
        valLbl.Text = tostring(value)
        if callback then callback(value) end
    end)
end

local function addButton(parent, label, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 65)
    btn.Text = label
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
end

local movePage = createTab("MOVEMENT")
local combatPage = createTab("COMBAT")
local stealPage = createTab("STEAL")
local miscPage = createTab("MISC")
local visualPage = createTab("VISUAL")
local settingsPage = createTab("SETTINGS")

addSection(movePage, "MOUVEMENT")
addSlider(movePage, "Speed Boost", 16, 200, 60, 5, function(v) SpeedBoost = v end)
addToggle(movePage, "Lagger Mode", false, function(s) end)

addSection(combatPage, "COMBAT")
addToggle(combatPage, "Auto TP Down", false, function(s) end)
addToggle(combatPage, "Anti Die", false, function(s) AntiDie = s end)
addToggle(combatPage, "Bat Aimbot", false, function(s) end)
addToggle(combatPage, "Auto Swing", false, function(s) end)

addSection(stealPage, "AUTO STEAL")
addSlider(stealPage, "Radius", 10, 200, 60, 5, function(v) end)
addToggle(stealPage, "Auto Steal", false, function(s) AutoSteal = s end)

addSection(miscPage, "UTILITAIRES")
addToggle(miscPage, "INF JUMP", false, function(s) INFJump = s end)
addToggle(miscPage, "Body Lock", false, function(s) BodyLock = s end)
addToggle(miscPage, "Anti Ragdoll", false, function(s) AntiRagdoll = s end)
addButton(miscPage, "Reset Character", function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
end)

addSection(visualPage, "ESP")
addToggle(visualPage, "Box ESP", false, function(s) BoxESP = s end)
addToggle(visualPage, "Anti Lag", false, function(s) AntiLag = s end)

addSection(settingsPage, "UI")
addToggle(settingsPage, "Hide Buttons", false, function(s) end)
addButton(settingsPage, "Reset Keybinds", function() end)

UserInputService.JumpRequest:Connect(function()
    if INFJump then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.3)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = SpeedBoost end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if AntiDie then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        if AntiRagdoll then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
            end
        end
    end
end)

local espCache = {}
task.spawn(function()
    while true do
        task.wait(1)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if BoxESP then
                        if not espCache[plr] then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Size = Vector3.new(4, 6, 4)
                            box.Adornee = hrp
                            box.AlwaysOnTop = true
                            box.Transparency = 0.5
                            box.Color3 = Color3.fromRGB(255, 50, 50)
                            box.Parent = hrp
                            espCache[plr] = box
                        end
                    else
                        if espCache[plr] then
                            espCache[plr]:Destroy()
                            espCache[plr] = nil
                        end
                    end
                end
            end
        end
    end
end)

movePage.Visible = true
tabs["MOVEMENT"].BackgroundColor3 = Color3.fromRGB(60, 100, 220)
tabs["MOVEMENT"].TextColor3 = Color3.fromRGB(255, 255, 255)

local dragging, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("BRAINROT HUB chargé !")
