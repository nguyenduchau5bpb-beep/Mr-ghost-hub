-- =======================================================
-- 🔑 CẤU HÌNH KEY SYSTEM TTTT ULTRA VIP
-- =======================================================
local MY_PERMANENT_KEY = "TTTT"
local DISCORD_LINK = "https://discord.gg/xSECFRv9s"
local GG_NOTE_LINK = "https://fnote.net/notes/94LvGy"

local KEY_FILE = "MrGhost_Key.txt"
local TIME_FILE = "MrGhost_KeyTime.txt"

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- [[ 1. HÀM KIỂM TRẢ LƯU KEY 24 GIỜ ]]
local function IsKeyValid()
    if readfile and isfile and isfile(KEY_FILE) and isfile(TIME_FILE) then
        local savedKey = readfile(KEY_FILE)
        local savedTime = tonumber(readfile(TIME_FILE)) or 0
        local currentTime = os.time()

        if savedKey == MY_PERMANENT_KEY and (currentTime - savedTime < 86400) then
            return true
        end
    end
    return false
end

local function SaveKey24H(key)
    if writefile then
        writefile(KEY_FILE, key)
        writefile(TIME_FILE, tostring(os.time()))
    end
end

-- [[ 2. HÀM TẠO THÔNG BÁO CYBER NOTIFY ĐẲNG CẤP ]]
local function SendCyberNotify(titleText, descText, duration, isSuccess)
    task.spawn(function()
        local NotifyGui = CoreGui:FindFirstChild("MrGhostNotifyGui")
        if not NotifyGui then
            NotifyGui = Instance.new("ScreenGui")
            NotifyGui.Name = "MrGhostNotifyGui"
            pcall(function() NotifyGui.Parent = CoreGui end)
            if not NotifyGui.Parent then NotifyGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end
        end

        local sound = Instance.new("Sound")
        sound.SoundId = isSuccess and "rbxassetid://4590662766" or "rbxassetid://550209561"
        sound.Volume = 0.8
        sound.Parent = SoundService
        sound:Play()
        task.delay(1.5, function() sound:Destroy() end)

        local Card = Instance.new("Frame", NotifyGui)
        Card.Size = UDim2.new(0, 300, 0, 72)
        Card.Position = UDim2.new(1, 10, 0.75, 0)
        Card.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
        Card.BackgroundTransparency = 0.05
        Card.ClipsDescendants = true

        Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 16)
        local Stroke = Instance.new("UIStroke", Card)
        Stroke.Thickness = 2
        Stroke.Color = isSuccess and Color3.fromRGB(192, 132, 252) or Color3.fromRGB(248, 113, 113)

        local Icon = Instance.new("TextLabel", Card)
        Icon.Size = UDim2.new(0, 52, 1, 0)
        Icon.BackgroundTransparency = 1
        Icon.Text = isSuccess and "👑✨" or "💥⚠️"
        Icon.TextSize = 24

        local Title = Instance.new("TextLabel", Card)
        Title.Position = UDim2.new(0, 52, 0, 10)
        Title.Size = UDim2.new(1, -56, 0, 20)
        Title.BackgroundTransparency = 1
        Title.Text = titleText
        Title.TextColor3 = isSuccess and Color3.fromRGB(233, 213, 255) or Color3.fromRGB(254, 202, 202)
        Title.Font = Enum.Font.FredokaOne
        Title.TextSize = 14.5
        Title.TextXAlignment = Enum.TextXAlignment.Left

        local Desc = Instance.new("TextLabel", Card)
        Desc.Position = UDim2.new(0, 52, 0, 32)
        Desc.Size = UDim2.new(1, -56, 0, 32)
        Desc.BackgroundTransparency = 1
        Desc.Text = descText
        Desc.TextColor3 = Color3.fromRGB(226, 232, 240)
        Desc.Font = Enum.Font.SourceSansBold
        Desc.TextSize = 13.5
        Desc.TextWrapped = true
        Desc.TextXAlignment = Enum.TextXAlignment.Left

        local Bar = Instance.new("Frame", Card)
        Bar.Position = UDim2.new(0, 0, 1, -3)
        Bar.Size = UDim2.new(1, 0, 0, 3)
        Bar.BackgroundColor3 = Stroke.Color
        Bar.BorderSizePixel = 0

        TweenService:Create(Card, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -315, 0.75, 0)
        }):Play()

        TweenService:Create(Bar, TweenInfo.new(duration or 3, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 0, 3)
        }):Play()

        task.wait(duration or 3)
        local slideOut = TweenService:Create(Card, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 10, 0.75, 0)
        })
        slideOut:Play()
        slideOut.Completed:Connect(function() Card:Destroy() end)
    end)
end

-- [[ 3. SCRIPT CHÍNH (GIAO DIỆN CHÍNH SIÊU ĐẸP) ]]
local function LoadMainScript()
    SendCyberNotify("PROJECT TTTT 👑", "🔥 Cyber System đã kết nối! Chúc ông chơi vui vẻ!", 3.5, true)

    pcall(function()
        if CoreGui:FindFirstChild("MrGhostHubVIP") then CoreGui.MrGhostHubVIP:Destroy() end
        if game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("MrGhostHubVIP") then
            game:GetService("Players").LocalPlayer.PlayerGui.MrGhostHubVIP:Destroy()
        end
    end)

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    local Config = {
        SpeedEnabled = false,
        PotarJumpEnabled = false,
        FullBright = false,
        EspEnabled = false,
        TracersEnabled = false,
        CamJumpEnabled = false,
        SpeedValue = 45,
        JumpSpeedValue = 60
    }

    local ActiveTracers = {}

    local function makeDraggable(gui)
        local dragging, dragInput, dragStart, startPos
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true; dragStart = input.Position; startPos = gui.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MrGhostHubVIP"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local DefaultPosToggle = UDim2.new(0.04, 0, 0.28, 0)
    local DefaultPosQuickJump = UDim2.new(0.70, 0, 0.16, 0)
    local DefaultPosMainFrame = UDim2.new(0.32, 0, 0.16, 0)

    -- NÚT MỞ MENU ĐẸP LUNG LINH
    local ToggleButton = Instance.new("TextButton", ScreenGui)
    ToggleButton.Position = DefaultPosToggle; ToggleButton.Size = UDim2.new(0, 62, 0, 62)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 12, 28); ToggleButton.Text = "👑✨"; ToggleButton.TextSize = 28; ToggleButton.Font = Enum.Font.FredokaOne
    makeDraggable(ToggleButton)
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
    local ToggleStroke = Instance.new("UIStroke", ToggleButton)
    ToggleStroke.Thickness = 3; ToggleStroke.Color = Color3.fromRGB(192, 132, 252)

    -- KHUNG MENU CHÍNH
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Position = DefaultPosMainFrame; MainFrame.Size = UDim2.new(0, 360, 0, 470)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 18); MainFrame.BackgroundTransparency = 0.08; MainFrame.Visible = true
    makeDraggable(MainFrame)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(192, 132, 252); MainStroke.Thickness = 2.5

    -- HEADER CỰC "CHẤT" CHO TTTT
    local TitleFrame = Instance.new("Frame", MainFrame)
    TitleFrame.Size = UDim2.new(1, 0, 0, 65); TitleFrame.BackgroundTransparency = 1

    local Title = Instance.new("TextLabel", TitleFrame)
    Title.Size = UDim2.new(1, 0, 0.65, 0); Title.BackgroundTransparency = 1
    Title.Text = "★ MRGHOST HUB ★ [ TTTT ]"; Title.TextColor3 = Color3.fromRGB(233, 213, 255); Title.TextSize = 19; Title.Font = Enum.Font.FredokaOne

    local SubTitle = Instance.new("TextLabel", TitleFrame)
    SubTitle.Position = UDim2.new(0, 0, 0.62, 0); SubTitle.Size = UDim2.new(1, 0, 0.38, 0); SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "━━━━ 👑 SYSTEM POWERED BY TTTT 👑 ━━━━"; SubTitle.TextColor3 = Color3.fromRGB(192, 132, 252); SubTitle.TextSize = 11; SubTitle.Font = Enum.Font.FredokaOne

    local Scroll = Instance.new("ScrollingFrame", MainFrame)
    Scroll.Size = UDim2.new(1, -28, 1, -80); Scroll.Position = UDim2.new(0, 14, 0, 70)
    Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 4; Scroll.ScrollBarImageColor3 = Color3.fromRGB(192, 132, 252)
    local Layout = Instance.new("UIListLayout", Scroll)
    Layout.Padding = UDim.new(0, 10); Layout.SortOrder = Enum.SortOrder.LayoutOrder

    local QuickJumpButton = Instance.new("TextButton", ScreenGui)
    QuickJumpButton.Position = DefaultPosQuickJump; QuickJumpButton.Size = UDim2.new(0, 64, 0, 64)
    QuickJumpButton.BackgroundColor3 = Color3.fromRGB(15, 12, 28); QuickJumpButton.Text = "🦘💨"; QuickJumpButton.TextSize = 28; QuickJumpButton.Font = Enum.Font.FredokaOne
    makeDraggable(QuickJumpButton)
    Instance.new("UICorner", QuickJumpButton).CornerRadius = UDim.new(0, 20)
    local QuickJumpStroke = Instance.new("UIStroke", QuickJumpButton)
    QuickJumpStroke.Thickness = 3; QuickJumpStroke.Color = Color3.fromRGB(192, 132, 252)

    local function AddButton(TextName, ConfigKey, Icon, CustomFunc)
        local Btn = Instance.new("TextButton", Scroll)
        Btn.Size = UDim2.new(1, 0, 0, 46)
        Btn.BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(22, 22, 36)
        Btn.Text = Icon .. "  " .. TextName .. "  [" .. (Config[ConfigKey] and "ON 🟢" or "OFF 🔴") .. "]"
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.Font = Enum.Font.FredokaOne; Btn.TextSize = 13.5
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)

        local BtnStroke = Instance.new("UIStroke", Btn)
        BtnStroke.Color = Config[ConfigKey] and Color3.fromRGB(236, 201, 255) or Color3.fromRGB(45, 45, 68)
        BtnStroke.Thickness = 1.5

        Btn.MouseButton1Click:Connect(function()
            Config[ConfigKey] = not Config[ConfigKey]
            TweenService:Create(Btn, TweenInfo.new(0.25), {
                BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(22, 22, 36)
            }):Play()
            BtnStroke.Color = Config[ConfigKey] and Color3.fromRGB(236, 201, 255) or Color3.fromRGB(45, 45, 68)
            Btn.Text = Icon .. "  " .. TextName .. "  [" .. (Config[ConfigKey] and "ON 🟢" or "OFF 🔴") .. "]"
            if CustomFunc then CustomFunc(Config[ConfigKey]) end
        end)
    end

    local function AddActionButton(TextName, Icon, CustomFunc)
        local Btn = Instance.new("TextButton", Scroll)
        Btn.Size = UDim2.new(1, 0, 0, 46)
        Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
        Btn.Text = Icon .. "  " .. TextName
        Btn.TextColor3 = Color3.fromRGB(233, 213, 255); Btn.Font = Enum.Font.FredokaOne; Btn.TextSize = 13.5
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
        local BtnStroke = Instance.new("UIStroke", Btn)
        BtnStroke.Color = Color3.fromRGB(192, 132, 252); BtnStroke.Thickness = 1.5

        Btn.MouseButton1Click:Connect(function()
            if CustomFunc then CustomFunc() end
        end)
    end

    local function AddTextBox(TextName, ConfigKey, Icon, Callback)
        local Frame = Instance.new("Frame", Scroll)
        Frame.Size = UDim2.new(1, 0, 0, 46)
        Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
        local FrameStroke = Instance.new("UIStroke", Frame)
        FrameStroke.Color = Color3.fromRGB(45, 45, 68); FrameStroke.Thickness = 1.5

        local Label = Instance.new("TextLabel", Frame)
        Label.Size = UDim2.new(0.62, 0, 1, 0); Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1; Label.Text = Icon .. " " .. TextName; Label.TextColor3 = Color3.fromRGB(240, 240, 255)
        Label.Font = Enum.Font.FredokaOne; Label.TextSize = 13.5; Label.TextXAlignment = Enum.TextXAlignment.Left

        local Box = Instance.new("TextBox", Frame)
        Box.Size = UDim2.new(0.32, -8, 0.68, 0); Box.Position = UDim2.new(0.68, -4, 0.16, 0)
        Box.BackgroundColor3 = Color3.fromRGB(10, 10, 18); Box.Text = tostring(Config[ConfigKey])
        Box.TextColor3 = Color3.fromRGB(233, 213, 255); Box.Font = Enum.Font.FredokaOne; Box.TextSize = 14
        Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 8)
        local BoxStroke = Instance.new("UIStroke", Box)
        BoxStroke.Color = Color3.fromRGB(192, 132, 252); BoxStroke.Thickness = 1.2

        Box:GetPropertyChangedSignal("Text"):Connect(function() Box.Text = Box.Text:gsub("%D", "") end)
        Box.FocusLost:Connect(function()
            local num = tonumber(Box.Text)
            if num then
                if num > 1000 then num = 1000 end
                Box.Text = tostring(num)
                Config[ConfigKey] = num
                if Callback then Callback(num) end
            else Box.Text = tostring(Config[ConfigKey]) end
        end)
    end

    AddButton("Tăng Tốc Độ Chạy", "SpeedEnabled", "🚀💨")
    AddTextBox("Tốc Độ Chạy", "SpeedValue", "⚡")
    AddTextBox("Tốc Độ Jump", "JumpSpeedValue", "🦘✨")
    AddButton("Potar Jump (Auto Bhop)", "PotarJumpEnabled", "🐰💨")
    AddButton("ESP Xuyên Tường", "EspEnabled", "👁️‍🗨️", function(state)
        if not state then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "GhostESP" and v:IsA("Highlight") then v:Destroy() end
            end
        end
    end)
    AddButton("Đường Kẻ Tracer", "TracersEnabled", "📍", function(state)
        if not state then
            for _, line in pairs(ActiveTracers) do pcall(function() line:Remove() end) end
            ActiveTracers = {}
        end
    end)
    AddButton("Nhìn Trong Tối (Full Bright)", "FullBright", "💡✨", function(state)
        Lighting.Brightness = state and 2 or 1
        Lighting.ClockTime = state and 14 or 12
    end)

    AddActionButton("Reset Vị Trí Giao Diện", "🔄✨", function()
        ToggleButton.Position = DefaultPosToggle
        QuickJumpButton.Position = DefaultPosQuickJump
        MainFrame.Position = DefaultPosMainFrame
        MainFrame.Visible = true
        SendCyberNotify("HỆ THỐNG RESET", "🔄 Vị trí nút đã về mặc định!", 3, true)
    end)

    ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then MainFrame.Visible = not MainFrame.Visible end
    end)

    QuickJumpButton.MouseButton1Click:Connect(function()
        Config.CamJumpEnabled = not Config.CamJumpEnabled
        QuickJumpButton.BackgroundColor3 = Config.CamJumpEnabled and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(15, 12, 28)
    end)

    -- HIỆU ỨNG RAINBOW LED CHUYỂN MÀU MƯỢT MÀ
    task.spawn(function()
        while task.wait() do
            for hue = 0, 1, 0.006 do
                local color = Color3.fromHSV(hue, 0.7, 1)
                MainStroke.Color = color; ToggleStroke.Color = color; QuickJumpStroke.Color = color
                task.wait(0.02)
            end
        end
    end)

    local function GetTargets()
        local targets = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v ~= LocalPlayer.Character and v:FindFirstChildOfClass("Humanoid") then
                table.insert(targets, v)
            end
        end
        return targets
    end

    task.spawn(function()
        while task.wait(0.5) do
            if Config.EspEnabled then
                for _, v in pairs(GetTargets()) do
                    if not v:FindFirstChild("GhostESP") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "GhostESP"
                        hl.FillColor = Color3.fromRGB(192, 132, 252)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.4
                        hl.OutlineTransparency = 0
                        hl.Parent = v
                    end
                end
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            
            if hum and hrp then
                if Config.SpeedEnabled then
                    hum.WalkSpeed = Config.SpeedValue
                    if hum.MoveDirection.Magnitude > 0 then
                        hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (Config.SpeedValue / 40))
                    end
                end

                if Config.PotarJumpEnabled and hum.MoveDirection.Magnitude > 0 then
                    if hum.FloorMaterial ~= Enum.Material.Air then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                    hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (Config.JumpSpeedValue / 35))
                end

                if Config.CamJumpEnabled then
                    if hum.FloorMaterial ~= Enum.Material.Air then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                    local camLook = Camera.CFrame.LookVector
                    local dir = Vector3.new(camLook.X, 0, camLook.Z).Unit
                    hrp.CFrame = hrp.CFrame + (dir * (Config.JumpSpeedValue / 30))
                    hrp.AssemblyLinearVelocity = Vector3.new(dir.X * Config.JumpSpeedValue, hrp.AssemblyLinearVelocity.Y, dir.Z * Config.JumpSpeedValue)
                end
            end
        end
    end)

    RunService.RenderStepped:Connect(function()
        if Config.TracersEnabled and Drawing then
            for model, line in pairs(ActiveTracers) do
                if not model or not model.Parent or not model:FindFirstChildOfClass("Humanoid") then
                    pcall(function() line:Remove() end)
                    ActiveTracers[model] = nil
                end
            end

            for _, v in pairs(GetTargets()) do
                local targetHrp = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Torso") or v:FindFirstChild("Head") or v.PrimaryPart
                if targetHrp then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetHrp.Position)
                    if onScreen then
                        local line = ActiveTracers[v]
                        if not line then
                            line = Drawing.new("Line")
                            line.Thickness = 2
                            line.Color = Color3.fromRGB(233, 213, 255)
                            line.Transparency = 1
                            ActiveTracers[v] = line
                        end
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                        line.To = Vector2.new(screenPos.X, screenPos.Y)
                        line.Visible = true
                    elseif ActiveTracers[v] then
                        ActiveTracers[v].Visible = false
                    end
                end
            end
        else
            for _, line in pairs(ActiveTracers) do line.Visible = false end
        end
    end)
end

-- [[ 4. GIAO DIỆN KEY SYSTEM CYBER VIP (KEY: TTTT) ]]
if IsKeyValid() then
    LoadMainScript()
else
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "MrGhostKeyGui"
    pcall(function() KeyGui.Parent = CoreGui end)
    if not KeyGui.Parent then KeyGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 350, 0, 290)
    KeyFrame.Position = UDim2.new(0.5, -175, 0.5, -145)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
    KeyFrame.ClipsDescendants = true
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 18)
    
    local KeyStroke = Instance.new("UIStroke", KeyFrame)
    KeyStroke.Color = Color3.fromRGB(192, 132, 252)
    KeyStroke.Thickness = 2.5

    -- Rainbow LED cho Key UI
    task.spawn(function()
        while task.wait() do
            for hue = 0, 1, 0.01 do
                if KeyStroke and KeyStroke.Parent then
                    KeyStroke.Color = Color3.fromHSV(hue, 0.7, 1)
                end
                task.wait(0.03)
            end
        end
    end)

    local KeyTitle = Instance.new("TextLabel", KeyFrame)
    KeyTitle.Size = UDim2.new(1, 0, 0, 44)
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.Text = "🔑 KEY SYSTEM - TTTT VIP"
    KeyTitle.TextColor3 = Color3.fromRGB(233, 213, 255)
    KeyTitle.Font = Enum.Font.FredokaOne
    KeyTitle.TextSize = 17

    local KeySub = Instance.new("TextLabel", KeyFrame)
    KeySub.Position = UDim2.new(0, 0, 0, 36)
    KeySub.Size = UDim2.new(1, 0, 0, 18)
    KeySub.BackgroundTransparency = 1
    KeySub.Text = "✨ Key VV - Tự động lưu 24h không cần nhập lại!"
    KeySub.TextColor3 = Color3.fromRGB(160, 160, 195)
    KeySub.Font = Enum.Font.SourceSansBold
    KeySub.TextSize = 12.5

    -- DÒNG 1: DISCORD
    local DiscordBtn = Instance.new("TextButton", KeyFrame)
    DiscordBtn.Position = UDim2.new(0.08, 0, 0.22, 0)
    DiscordBtn.Size = UDim2.new(0.84, 0, 0, 38)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    DiscordBtn.Text = "🔵 Vào Discord Lấy Key (Copy Link)"
    DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.Font = Enum.Font.FredokaOne
    DiscordBtn.TextSize = 13
    Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 10)

    DiscordBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(DISCORD_LINK)
            SendCyberNotify("ĐÃ COPY LINK! 🔗", "Đã sao chép link Discord vào bộ nhớ tạm!", 3, true)
        end
    end)

    -- DÒNG 2: GOOGLE (FNOTE)
    local GgBtn = Instance.new("TextButton", KeyFrame)
    GgBtn.Position = UDim2.new(0.08, 0, 0.38, 0)
    GgBtn.Size = UDim2.new(0.84, 0, 0, 38)
    GgBtn.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
    GgBtn.Text = "🟢 Vào GG Lấy Key (Không Discord)"
    GgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GgBtn.Font = Enum.Font.FredokaOne
    GgBtn.TextSize = 13
    Instance.new("UICorner", GgBtn).CornerRadius = UDim.new(0, 10)

    GgBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(GG_NOTE_LINK)
            SendCyberNotify("ĐÃ COPY LINK! 🔗", "Đã sao chép link Google vào bộ nhớ tạm!", 3, true)
        end
    end)

    -- Ô NHẬP KEY
    local KeyBox = Instance.new("TextBox", KeyFrame)
    KeyBox.Position = UDim2.new(0.08, 0, 0.56, 0)
    KeyBox.Size = UDim2.new(0.84, 0, 0, 40)
    KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 34)
    KeyBox.PlaceholderText = "Nhập Key TTTT tại đây..."
    KeyBox.Text = ""
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.Font = Enum.Font.FredokaOne
    KeyBox.TextSize = 14
    Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)
    local BoxStroke = Instance.new("UIStroke", KeyBox)
    BoxStroke.Color = Color3.fromRGB(60, 60, 90)

    -- NÚT XÁC NHẬN
    local SubmitBtn = Instance.new("TextButton", KeyFrame)
    SubmitBtn.Position = UDim2.new(0.08, 0, 0.74, 0)
    SubmitBtn.Size = UDim2.new(0.84, 0, 0, 42)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
    SubmitBtn.Text = "XÁC NHẬN KEY 🚀"
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Font = Enum.Font.FredokaOne
    SubmitBtn.TextSize = 14.5
    Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 10)

    SubmitBtn.MouseButton1Click:Connect(function()
        local userInput = KeyBox.Text:gsub("%s+", "")
        if userInput == MY_PERMANENT_KEY then
            SaveKey24H(userInput)
            KeyGui:Destroy()
            LoadMainScript()
        else
            BoxStroke.Color = Color3.fromRGB(239, 68, 68)
            SendCyberNotify("KEY SAI! ❌", "Mật khẩu Key không chính xác!", 3, false)
            task.wait(1)
            BoxStroke.Color = Color3.fromRGB(60, 60, 90)
        end
    end)
end
 
