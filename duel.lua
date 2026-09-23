local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if _G.DuelMenuLoaded then
    pcall(function() _G.DuelMenu:Destroy() end)
end
_G.DuelMenuLoaded = true

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DuelMenu"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
_G.DuelMenu = ScreenGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 420, 0, 600)
Main.Position = UDim2.new(0.5, -210, 0.5, -300)
Main.BackgroundTransparency = 1
Main.Parent = ScreenGui

local UIGrid = Instance.new("UIGridLayout")
UIGrid.CellSize = UDim2.new(0, 180, 0, 180)
UIGrid.CellPadding = UDim2.new(0, 20, 0, 20)
UIGrid.Parent = Main

local boutons = {
    "DROP\nBR",
    "BAT\nAIMBOT",
    "TP\nDOWN",
    "CARRY\nSPD",
    "LAGGER\nCARRY",
    "LAGGER\nSPD",
}

for i, texte in ipairs(boutons) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 180, 0, 180)
    Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Button.BorderSizePixel = 0
    Button.Text = texte
    Button.TextColor3 = Color3.fromRGB(255, 0, 0)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.LayoutOrder = i
    Button.Parent = Main

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        print("Bouton cliqué : " .. texte)
    end)
end
