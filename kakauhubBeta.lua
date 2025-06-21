-- kakauHub UI Compacto + Busca Funcional + Scroll Correto

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinButton = Instance.new("TextButton")
local SearchBox = Instance.new("TextBox")
local CommandList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Configurações da GUI
ScreenGui.Name = "kakauHubUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 300) -- UI menor

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.Size = UDim2.new(1, 0, 0, 30)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.02, 0, 0, 0)
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Commands"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(0.9, 0, 0.1, 0)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

MinButton.Name = "MinButton"
MinButton.Parent = TopBar
MinButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinButton.Position = UDim2.new(0.8, 0, 0.1, 0)
MinButton.Size = UDim2.new(0, 20, 0, 20)
MinButton.Font = Enum.Font.SourceSansBold
MinButton.Text = "-"
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.TextSize = 14

SearchBox.Name = "SearchBox"
SearchBox.Parent = MainFrame
SearchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SearchBox.Position = UDim2.new(0.05, 0, 0.12, 0)
SearchBox.Size = UDim2.new(0.9, 0, 0, 25)
SearchBox.Font = Enum.Font.SourceSans
SearchBox.PlaceholderText = "Search..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 16

CommandList.Name = "CommandList"
CommandList.Parent = MainFrame
CommandList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CommandList.Position = UDim2.new(0.05, 0, 0.25, 0)
CommandList.Size = UDim2.new(0.9, 0, 0.7, 0)
CommandList.CanvasSize = UDim2.new(0, 0, 0, 0)
CommandList.ScrollBarThickness = 6
CommandList.AutomaticCanvasSize = Enum.AutomaticSize.Y
CommandList.CanvasSize = UDim2.new(0, 0, 0, 0)

UIListLayout.Parent = CommandList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Lista de comandos
local commands = {
    ";ice <player>",
    ";jail <player>",
    ";buffify <player>",
    ";wormify <player>",
    ";chibify <player>",
    ";plushify <player>",
    ";freakify <player>",
    ";frogify <player>",
    ";spongify <player>",
    ";bigify <player>",
    ";creepify <player>",
    ";dinofy <player>"
}

local buttons = {}

-- Função criar botões
local function CreateButton(name)
    local Button = Instance.new("TextButton")
    Button.Parent = CommandList
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Size = UDim2.new(1, -10, 0, 25)
    Button.Font = Enum.Font.SourceSans
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    buttons[name] = Button
end

for _, v in pairs(commands) do
    CreateButton(v)
end

-- Botões
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local minimized = false

MinButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    SearchBox.Visible = not minimized
    CommandList.Visible = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 280, 0, 30)
    else
        MainFrame.Size = UDim2.new(0, 280, 0, 300)
    end
end)

-- Pesquisa funcional
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local text = SearchBox.Text:lower()
    for name, button in pairs(buttons) do
        if string.find(name:lower(), text) then
            button.Visible = true
        else
            button.Visible = false
        end
    end
end)

-- Sistema de arrastar
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

