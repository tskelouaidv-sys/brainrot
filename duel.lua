local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

if _G.BrainrotHubLoaded then
    pcall(function() _G.BrainrotHub:Destroy() end)
end
_G.BrainrotHubLoaded = true

local InfiniteJump = false
local AutoGuard = false
local SpeedValue = 60

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
_G.BrainrotHub = ScreenGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BRAINROT HUB"
Title.TextColor3 = Color3.fromRGB(100, 150, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    _G.BrainrotHubLoaded = false
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -45)
Sidebar.Position = UDim2.new(0, 8, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

local SidebarPad = Instance.new("UIPadding")
SidebarPad.PaddingTop = UDim.new(0, 8)
SidebarPad.PaddingLeft = UDim.new(0, 6)
SidebarPad.PaddingRight = UDim.new(0, 6)
SidebarPad.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -155, 1, -50)
Content.Position = UDim2.new(0, 145, 0, 42)
Content.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

local pages = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.new(0, 6, 0, 6)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.Visible = false
    page.Parent = Content
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    pages[name] = page
    return page
end

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = createPage(name)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, b in pairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
                b.TextColor3 = Color3.fromRGB(200, 200, 220)
            end
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    return page
end

local function addToggle(parent, label, default, callback)
    local state = default or false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    btn.Text = ""
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = btn

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 60, 0, 24)
    status.Position = UDim2.new(1, -68, 0, 6)
    status.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 40, 40)
    status.Text = state and "ON" or "OFF"
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.Font = Enum.Font.GothamBold
    status.TextSize = 12
    status.Parent = btn
    Instance.new("UICorner", status).CornerRadius = UDim.new(0, 5)

    btn.MouseButton1Click:Connect(function()
        state = not state
        status.Text = state and "ON" or "OFF"
        status.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 40, 40)
        if callback then callback(state) end
    end)
end

local function addButton(parent, label, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    btn.Text = label
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
end

local combatPage = createTab("COMBAT")
local stealPage = createTab("STEAL")
local movePage = createTab("MOVEMENT")
local miscPage = createTab("MISC")
local visualPage = createTab("VISUAL")
local interfacePage = createTab("INTERFACE")

UserInputService.JumpRequest:Connect(function()
    if InfiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

addToggle(combatPage, "Auto Guard", false, function(state)
    AutoGuard = state
    if state then
        task.spawn(function()
            while AutoGuard do
                local char = LocalPlayer.Character
                if char then
                    for _, obj in ipairs(char:GetChildren()) do
                        if obj:IsA("Tool") and (obj.Name:lower():find("guard") or obj.Name:lower():find("shield")) then
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            if hum then hum:EquipTool(obj) end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)

addToggle(combatPage, "Infinite Jump", false, function(state)
    InfiniteJump = state
end)

addButton(combatPage, "Reset Character", function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
end)

addToggle(stealPage, "Auto Steal", false, function(state) print("Auto Steal :", state) end)
addToggle(stealPage, "Auto Collect", false, function(state) print("Auto Collect :", state) end)

addToggle(movePage, "Infinite Jump", false, function(state) InfiniteJump = state end)

addButton(movePage, "Speed +10", function()
    SpeedValue = SpeedValue + 10
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = SpeedValue end
end)

addButton(movePage, "Speed -10", function()
    SpeedValue = math.max(16, SpeedValue - 10)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = SpeedValue end
end)

addButton(movePage, "Reset Speed", function()
    SpeedValue = 16
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end)

addButton(miscPage, "Full Bright", function()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 3
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
end)

addButton(miscPage, "Anti AFK", function()
    LocalPlayer.Idled:Connect(function()
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
    print("Anti-AFK activé")
end)

addToggle(visualPage, "ESP Joueurs", false, function(state) print("ESP :", state) end)
addToggle(visualPage, "Highlight Brainrots", false, function(state) print("Highlight :", state) end)

addButton(interfacePage, "Recharger le script", function()
    ScreenGui:Destroy()
    _G.BrainrotHubLoaded = false
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tskelouaidv-sys/brainrot/main/duel.lua"))()
end)

combatPage.Visible = true
for _, b in pairs(Sidebar:GetChildren()) do
    if b:IsA("TextButton") and b.Text == "COMBAT" then
        b.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local dragging, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
