local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

if _G.BrainrotAll then pcall(function() _G.BrainrotAll:Destroy() end) end
_G.BrainrotAll = true

local SpeedValue = 60
local CarrySpeed = 30
local LaggerSpeed = 15
local TPHeight = 20
local INFJump = false
local AntiDie = false
local AntiRagdoll = false
local LaggerOn = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotAll"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
_G.BrainrotAll = ScreenGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 560, 0, 360)
Main.Position = UDim2.new(0, 20, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "BRAINROT HUB"
Title.TextColor3 = Color3.fromRGB(230, 230, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CloseBtn.Text = "−"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 36)
TabBar.Position = UDim2.new(0, 10, 0, 48)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabBar

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -96)
Content.Position = UDim2.new(0, 10, 0, 90)
Content.BackgroundTransparency = 1
Content.Parent = Main

local pages, tabs = {}, {}

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
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
    local s = Instance.new("TextLabel")
    s.Size = UDim2.new(1, 0, 0, 20)
    s.BackgroundTransparency = 1
    s.Text = "> " .. text
    s.TextColor3 = Color3.fromRGB(90, 140, 255)
    s.Font = Enum.Font.GothamBold
    s.TextSize = 11
    s.TextXAlignment = Enum.TextXAlignment.Left
    s.Parent = parent
end

local function addToggle(parent, label, callback)
    local state = false
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, -5, 0, 34)
    c.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
    c.Parent = parent
    Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -80, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = label
    l.TextColor3 = Color3.fromRGB(220, 220, 240)
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = c

    local sw = Instance.new("Frame")
    sw.Size = UDim2.new(0, 40, 0, 20)
    sw.Position = UDim2.new(1, -50, 0, 7)
    sw.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sw.Parent = c
    Instance.new("UICorner", sw).CornerRadius = UDim.new(0, 10)

    local k = Instance.new("Frame")
    k.Size = UDim2.new(0, 16, 0, 16)
    k.Position = UDim2.new(0, 2, 0, 2)
    k.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    k.Parent = sw
    Instance.new("UICorner", k).CornerRadius = UDim.new(0, 8)

    local cl = Instance.new("TextButton")
    cl.Size = UDim2.new(1, 0, 1, 0)
    cl.BackgroundTransparency = 1
    cl.Text = ""
    cl.Parent = c

    cl.MouseButton1Click:Connect(function()
        state = not state
        sw.BackgroundColor3 = state and Color3.fromRGB(60, 100, 220) or Color3.fromRGB(50, 50, 70)
        k.Position = state and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
        if callback then callback(state) end
    end)
end

local function addSlider(parent, label, min, max, default, step, callback)
    local value = default
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, -5, 0, 34)
    c.BackgroundColor3 = Color3.fromRGB(22, 22, 38)
    c.Parent = parent
    Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -160, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = label
    l.TextColor3 = Color3.fromRGB(220, 220, 240)
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = c

    local mi = Instance.new("TextButton")
    mi.Size = UDim2.new(0, 26, 0, 22)
    mi.Position = UDim2.new(1, -122, 0, 6)
    mi.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    mi.Text = "−"
    mi.TextColor3 = Color3.fromRGB(90, 140, 255)
    mi.Font = Enum.Font.GothamBold
    mi.TextSize = 15
    mi.Parent = c
    Instance.new("UICorner", mi).CornerRadius = UDim.new(0, 6)

    local vl = Instance.new("TextLabel")
    vl.Size = UDim2.new(0, 50, 0, 22)
    vl.Position = UDim2.new(1, -94, 0, 6)
    vl.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    vl.Text = tostring(value)
    vl.TextColor3 = Color3.fromRGB(90, 140, 255)
    vl.Font = Enum.Font.GothamBold
    vl.TextSize = 12
    vl.Parent = c
    Instance.new("UICorner", vl).CornerRadius = UDim.new(0, 6)

    local pl = Instance.new("TextButton")
    pl.Size = UDim2.new(0, 26, 0, 22)
    pl.Position = UDim2.new(1, -40, 0, 6)
    pl.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    pl.Text = "+"
    pl.TextColor3 = Color3.fromRGB(90, 140, 255)
    pl.Font = Enum.Font.GothamBold
    pl.TextSize = 15
    pl.Parent =
