local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

if _G.BrainrotButtons then
    pcall(function() _G.BrainrotButtons:Destroy() end)
end
_G.BrainrotButtons = true

-- Variables
local INFJump = false
local SpeedValue = 60
local AutoTPDown = false
local TPHeight = 20

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotButtons"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
_G.BrainrotButtons = ScreenGui

-- Conteneur principal (colonne droite)
local Container = Instance.new("Frame")
Container.Size = UDim2.new(0, 260, 0, 500)
Container.Position = UDim2.new(1, -270, 0.5, -250)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0, 120, 0, 70)
Grid.CellPadding = UDim2.new(0, 8, 0, 8)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Container

-- Fonction pour créer un bouton
local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 70)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(100, 160, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = Container
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16)

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return btn
end

-- Toggle pour les boutons ON/OFF (change de couleur)
local function createToggleButton(text, default, callback)
    local state = default or false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 70)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 80, 40) or Color3.fromRGB(0, 0, 0)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(100, 160, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = Container
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16)

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 80, 40) or Color3.fromRGB(0, 0, 0)
        if callback then callback(state) end
    end)
    return btn
end

--------------------------------------------------
-- BOUTONS
--------------------------------------------------
createButton("AUTO\nPLAY", function() print("Auto Play") end)
createButton("BAT\nTP", function()
    -- TP vers le bat le plus proche (basique)
    print("Bat TP")
end)
createButton("DROP\nBR", function() print("Drop BR") end)
createButton("BAT\nAIMBOT", function() print("Bat Aimbot") end)
createButton("TP\nDOWN", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame * CFrame.new(0, -TPHeight, 0)
        end
    end
end)
createButton("CARRY\nSPD", function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 60 end
end)

createToggleButton("LAGGER\nCARRY", false, function(state)
    print("Lagger Carry :", state)
end)
createToggleButton("LAGGER\nSPD", false, function(state)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = state and 15 or 16 end
end)

createButton("RESET", function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
end)

createButton("ANTI BAT\nBYPASS", function() print("Anti Bat Bypass") end)
