local TweenService = game:GetService("TweenService")

local function createUI(instanceType, properties)
    local element = Instance.new(instanceType)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

local function addRoundCorners(element, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = element
end

-- Fonction pour ajouter un dégradé
local function addGradient(element, colors)
    local gradient = Instance.new("UIGradient")
    gradient.Color = colors
    gradient.Rotation = 45
    gradient.Parent = element
end

-- Configuration principale
local exec = createUI("ScreenGui", {
    Name = "exec",
    Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:FindFirstChild("PlayerGui"),
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    ResetOnSpawn = false
})

local Executor = createUI("Frame", {
    Parent = exec,
    Active = true,
    BackgroundColor3 = Color3.fromRGB(25, 25, 35),
    BackgroundTransparency = 0.12,
    ClipsDescendants = true,
    Draggable = true,
    Position = UDim2.new(0.308, 0, 2, 0),
    Size = UDim2.new(0, 481, 0, 287)
})
addRoundCorners(Executor, 20)
addGradient(Executor, ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}))

local Down = createUI("Frame", {
    Parent = Executor,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.7,
    Position = UDim2.new(0, 0, 0, 281),
    Size = UDim2.new(0, 480, 0, 6)
})
addRoundCorners(Down, 20)

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.Parent = Down
UIAspectRatioConstraint.AspectRatio = 80.000

local EditorScroller = createUI("ScrollingFrame", {
    Parent = Executor,
    Active = true,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.6,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 9, 0, 47),
    Size = UDim2.new(0, 465, 0, 191),
    ScrollBarThickness = 5
})

local Editor = createUI("TextBox", {
    Parent = EditorScroller,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 1.000,
    Size = UDim2.new(1, 0, 0, 191),
    ClearTextOnFocus = false,
    Font = Enum.Font.SourceSans,
    MultiLine = true,
    Text = "",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 20.000,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})

local UIListLayout = createUI("UIListLayout", {
    Parent = EditorScroller,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder
})

-- Configuration des boutons
local function createButton(name, parent, position, text)
    local button = createUI("TextButton", {
        Name = name,
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(35, 35, 50),
        BackgroundTransparency = 0.6,
        Position = position,
        Size = UDim2.new(0, 102, 0, 25),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20.000
    })
    addRoundCorners(button, 12)

    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 50))
    })
    buttonGradient.Rotation = 45
    buttonGradient.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), { BackgroundColor3 = Color3.fromRGB(45, 45, 65) }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), { BackgroundColor3 = Color3.fromRGB(35, 35, 50) }):Play()
    end)

    return button
end

local Clear = createButton("Clear", Executor, UDim2.new(0, 182, 0, 248), "Clear")
local Copy = createButton("Copy", Executor, UDim2.new(0, 294, 0, 248), "Copy")
local Execute = createButton("Execute", Executor, UDim2.new(0, 70, 0, 248), "Execute")

local TopBar = createUI("TextLabel", {
    Parent = Executor,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.6,
    Position = UDim2.new(0.002, 0, 0, 0),
    Size = UDim2.new(0, 481, 0, 35),
    Font = Enum.Font.SourceSansItalic,
    Text = "Honoka Executor",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 25.000
})
addRoundCorners(TopBar, 20)

local Exit = createUI("TextButton", {
    Parent = TopBar,
    BackgroundColor3 = Color3.fromRGB(12, 4, 20),
    BackgroundTransparency = 0.5,
    BorderSizePixel = 0,
    Position = UDim2.new(0.87, 0, 0.09, 0),
    Size = UDim2.new(0, 40, 0, 25),
    Font = Enum.Font.Gotham,
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 13.000
})

local Minimize = createUI("TextButton", {
    Parent = TopBar,
    BackgroundColor3 = Color3.fromRGB(12, 4, 20),
    BackgroundTransparency = 0.5,
    BorderSizePixel = 0,
    Position = UDim2.new(0.78, 0, 0, 0),
    Size = UDim2.new(0, 27, 0, 25),
    Font = Enum.Font.Gotham,
    Text = "□",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 25.000
})

-- Scripts:

local function TJUXECO_fake_script()
    Executor.Active = true
    Executor.Draggable = true
    exec.ResetOnSpawn = false
end
coroutine.wrap(TJUXECO_fake_script)()

local function CZXUM_fake_script()
    Executor:TweenPosition(UDim2.new(0.308, 0, 0.262, 0), "Out", "Quint", 1, true)
end
coroutine.wrap(CZXUM_fake_script)()

local function INJLLH_fake_script()
    Clear.MouseButton1Click:Connect(function()
        Editor.Text = ""
    end)
end
coroutine.wrap(INJLLH_fake_script)()

local function IQOSZN_fake_script()
    Copy.MouseButton1Click:Connect(function()
        setclipboard(Editor.Text)
    end)
end
coroutine.wrap(IQOSZN_fake_script)()

local function MVBS_fake_script()
    Execute.MouseButton1Click:Connect(function()
        assert(loadstring(Editor.Text))()
    end)
end
coroutine.wrap(MVBS_fake_script)()

local function VLSJXUV_fake_script()
    local editor = Editor

    local con1, con2 = nil, nil

    Exit.MouseButton1Click:Connect(function()
        if con1 then con1:Disconnect() con1 = nil end
        if con2 then con2:Disconnect() con2 = nil end
        Exit.Parent.Parent.Parent:Destroy()
    end)

    local function updTxtScale()
        local width = editor.AbsoluteSize.X
        local text = editor.Text
        local font = editor.Font
        local textSize = editor.TextSize
        local textBounds = game:GetService("TextService"):GetTextSize(text, textSize, font, Vector2.new(width, math.huge))

        if textBounds.Y <= 200 then
            editor.Size = UDim2.new(1, 0, 0, 200)
        else
            editor.Size = UDim2.new(1, 0, 0, textBounds.Y + 15)
        end
    end

    con1 = editor:GetPropertyChangedSignal("Text"):Connect(updTxtScale)

    con2 = game:GetService("RunService").Stepped:Connect(function()
        editor.Parent.CanvasSize = UDim2.new(0, 0, 0, editor.Parent:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y + 30)
    end)

    updTxtScale()
end
coroutine.wrap(VLSJXUV_fake_script)()

local function PWJRPAS_fake_script()
    local minimized = false
    Minimize.MouseButton1Click:Connect(function()
        if not minimized then
            minimized = true
            Minimize.Parent.Parent:TweenSize(UDim2.new(0, 481, 0, 35), "Out", "Quint", 1, true)
        else
            minimized = false
            Minimize.Parent.Parent:TweenSize(UDim2.new(0, 481, 0, 287), "Out", "Quint", 1, true)
        end
    end)
end
coroutine.wrap(PWJRPAS_fake_script)()
