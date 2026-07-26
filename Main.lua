-- [[ 1. THÔNG BÁO BẮT ĐẦU LOAD ]]
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "★ MRGHOST HUB VIP ★",
        Text = "⚡ Đang tải dữ liệu, vui lòng chờ...",
        Duration = 3
    })
end)

-- [[ KHỐI LỆNH TẢI SCRIPT AN TOÀN ]]
local success, err = pcall(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    -- CẤU HÌNH TRẠNG THÁI
    local Config = {
        SpeedEnabled = false,
        PotarJumpEnabled = false,
        FullBright = false,
        EspEnabled = false,
        TracersEnabled = false,
        CamJumpEnabled = false,
        SpeedValue = 45,
        JumpSpeedValue = 60 -- Tốc độ nhảy riêng biệt
    }

    local ActiveTracers = {}

    -- HÀM KÉO DI CHUYỂN MENU SIÊU MƯỢT
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

    -- TẠO GUI CHÍNH
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MrGhostHubVIP"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    -- NÚT BẬT TẮT MENU 👻
    local ToggleButton = Instance.new("TextButton", ScreenGui)
    ToggleButton.Position = UDim2.new(0.04, 0, 0.28, 0); ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25); ToggleButton.Text = "👻"; ToggleButton.TextSize = 28; ToggleButton.Font = Enum.Font.FredokaOne
    makeDraggable(ToggleButton)
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
    local ToggleStroke = Instance.new("UIStroke", ToggleButton)
    ToggleStroke.Thickness = 3; ToggleStroke.Color = Color3.fromRGB(168, 85, 247)

    -- KHUNG MENU CHÍNH
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Position = UDim2.new(0.32, 0, 0.16, 0); MainFrame.Size = UDim2.new(0, 345, 0, 450)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20); MainFrame.BackgroundTransparency = 0.1; MainFrame.Visible = true
    makeDraggable(MainFrame)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 18)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(168, 85, 247); MainStroke.Thickness = 2.5

    -- TIÊU ĐỀ MENU SANG TRỌNG
    local TitleFrame = Instance.new("Frame", MainFrame)
    TitleFrame.Size = UDim2.new(1, 0, 0, 55); TitleFrame.BackgroundTransparency = 1

    local Title = Instance.new("TextLabel", TitleFrame)
    Title.Size = UDim2.new(1, 0, 0.7, 0); Title.BackgroundTransparency = 1
    Title.Text = "★ MRGHOST HUB VIP ★"; Title.TextColor3 = Color3.fromRGB(216, 180, 254); Title.TextSize = 20; Title.Font = Enum.Font.FredokaOne

    local SubTitle = Instance.new("TextLabel", TitleFrame)
    SubTitle.Position = UDim2.new(0, 0, 0.62, 0); SubTitle.Size = UDim2.new(1, 0, 0.38, 0); SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "━━━━ Evade Cyber Edition ━━━━"; SubTitle.TextColor3 = Color3.fromRGB(168, 85, 247); SubTitle.TextSize = 11; SubTitle.Font = Enum.Font.FredokaOne

    -- DANH SÁCH CUỘN
    local Scroll = Instance.new("ScrollingFrame", MainFrame)
    Scroll.Size = UDim2.new(1, -24, 1, -68); Scroll.Position = UDim2.new(0, 12, 0, 60)
    Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 3; Scroll.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
    local Layout = Instance.new("UIListLayout", Scroll)
    Layout.Padding = UDim.new(0, 10); Layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- NÚT NHẢY CHUỘT TÚI 🦘 TRÊN MÀN HÌNH
    local QuickJumpButton = Instance.new("TextButton", ScreenGui)
    QuickJumpButton.Position = UDim2.new(0.70, 0, 0.16, 0); QuickJumpButton.Size = UDim2.new(0, 64, 0, 64)
    QuickJumpButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25); QuickJumpButton.Text = "🦘"; QuickJumpButton.TextSize = 30; QuickJumpButton.Font = Enum.Font.FredokaOne
    makeDraggable(QuickJumpButton)
    Instance.new("UICorner", QuickJumpButton).CornerRadius = UDim.new(0, 20)
    local QuickJumpStroke = Instance.new("UIStroke", QuickJumpButton)
    QuickJumpStroke.Thickness = 3; QuickJumpStroke.Color = Color3.fromRGB(168, 85, 247)

    -- HÀM TẠO NÚT TOGGLE CAO CẤP
    local function AddButton(TextName, ConfigKey, Icon, CustomFunc)
        local Btn = Instance.new("TextButton", Scroll)
        Btn.Size = UDim2.new(1, 0, 0, 44)
        Btn.BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(24, 24, 38)
        Btn.Text = Icon .. "  " .. TextName .. "  [" .. (Config[ConfigKey] and "ON 🟢" or "OFF 🔴") .. "]"
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.Font = Enum.Font.FredokaOne; Btn.TextSize = 13.5
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)

        local BtnStroke = Instance.new("UIStroke", Btn)
        BtnStroke.Color = Config[ConfigKey] and Color3.fromRGB(236, 201, 255) or Color3.fromRGB(45, 45, 65)
        BtnStroke.Thickness = 1.5

        Btn.MouseButton1Click:Connect(function()
            Config[ConfigKey] = not Config[ConfigKey]
            
            TweenService:Create(Btn, TweenInfo.new(0.25), {
                BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(24, 24, 38)
            }):Play()

            BtnStroke.Color = Config[ConfigKey] and Color3.fromRGB(236, 201, 255) or Color3.fromRGB(45, 45, 65)
            Btn.Text = Icon .. "  " .. TextName .. "  [" .. (Config[ConfigKey] and "ON 🟢" or "OFF 🔴") .. "]"
            
            if CustomFunc then CustomFunc(Config[ConfigKey]) end
        end)
    end

    -- HÀM TẠO TEXTBOX LỌC CHỈ CHO NHẬP SỐ
    local function AddTextBox(TextName, ConfigKey, Icon, Callback)
        local Frame = Instance.new("Frame", Scroll)
        Frame.Size = UDim2.new(1, 0, 0, 44)
        Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
        local FrameStroke = Instance.new("UIStroke", Frame)
        FrameStroke.Color = Color3.fromRGB(45, 45, 65); FrameStroke.Thickness = 1.5

        local Label = Instance.new("TextLabel", Frame)
        Label.Size = UDim2.new(0.62, 0, 1, 0); Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1; Label.Text = Icon .. " " .. TextName; Label.TextColor3 = Color3.fromRGB(240, 240, 255)
        Label.Font = Enum.Font.FredokaOne; Label.TextSize = 13.5; Label.TextXAlignment = Enum.TextXAlignment.Left

        local Box = Instance.new("TextBox", Frame)
        Box.Size = UDim2.new(0.32, -8, 0.68, 0); Box.Position = UDim2.new(0.68, -4, 0.16, 0)
        Box.BackgroundColor3 = Color3.fromRGB(10, 10, 18); Box.Text = tostring(Config[ConfigKey])
        Box.TextColor3 = Color3.fromRGB(216, 180, 254); Box.Font = Enum.Font.FredokaOne; Box.TextSize = 14
        Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 8)
        local BoxStroke = Instance.new("UIStroke", Box)
        BoxStroke.Color = Color3.fromRGB(168, 85, 247); BoxStroke.Thickness = 1.2

        Box:GetPropertyChangedSignal("Text"):Connect(function()
            Box.Text = Box.Text:gsub("%D", "") -- Chặn ký tự đặc biệt
        end)

        Box.FocusLost:Connect(function()
            local num = tonumber(Box.Text)
            if num then
                if num > 1000 then num = 1000 end -- Giới hạn Max 1000
                Box.Text = tostring(num)
                Config[ConfigKey] = num
                if Callback then Callback(num) end
            else
                Box.Text = tostring(Config[ConfigKey])
            end
        end)
    end

    -- DANH SÁCH CHỨC NĂNG
    AddButton("Tăng Tốc Độ", "SpeedEnabled", "🚀")
    AddTextBox("Tốc Độ Chạy", "SpeedValue", "⚡")
    AddTextBox("Tốc Độ Jump", "JumpSpeedValue", "🦘") -- Tách riêng Tốc độ Jump
    AddButton("Potar Jump (Auto Bhop)", "PotarJumpEnabled", "🐰")
    AddButton("ESP Xuyên Tường", "EspEnabled", "👁️", function(state)
        if not state then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "GhostESP" and v:IsA("Highlight") then v:Destroy() end
            end
        end
    end)
    AddButton("Đường Kẻ Tracer (Top)", "TracersEnabled", "📍", function(state)
        if not state then
            for _, line in pairs(ActiveTracers) do pcall(function() line:Remove() end) end
            ActiveTracers = {}
        end
    end)
    AddButton("Nhìn Trong Tối (Full Bright)", "FullBright", "💡", function(state)
        Lighting.Brightness = state and 2 or 1
        Lighting.ClockTime = state and 14 or 12
    end)

    -- SỰ KIỆN NÚT 👻 MỞ BẢNG
    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- NÚT CHUỘT TÚI 🦘 TOGGLE
    QuickJumpButton.MouseButton1Click:Connect(function()
        Config.CamJumpEnabled = not Config.CamJumpEnabled
        if Config.CamJumpEnabled then
            QuickJumpButton.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
        else
            QuickJumpButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        end
    end)

    -- VIỀN NEON CHUYỂN MÀU MƯỢT MÀ
    task.spawn(function()
        while task.wait() do
            for hue = 0, 1, 0.008 do
                local color = Color3.fromHSV(hue, 0.75, 1)
                MainStroke.Color = color
                ToggleStroke.Color = color
                QuickJumpStroke.Color = color
                task.wait(0.02)
            end
        end
    end)

    -- VÒNG LẶP ESP HIGHLIGHT
    task.spawn(function()
        while task.wait(1) do
            if Config.EspEnabled then
                for _, v in pairs(workspace:GetChildren()) do
                    if v:FindFirstChildOfClass("Humanoid") and v ~= LocalPlayer.Character then
                        if not v:FindFirstChild("GhostESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "GhostESP"
                            hl.FillColor = Color3.fromRGB(168, 85, 247)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.FillTransparency = 0.4
                            hl.OutlineTransparency = 0
                            hl.Parent = v
                        end
                    end
                end
            end
        end
    end)

    -- LOGIC CẬP NHẬT TỐC ĐỘ DI CHUYỂN VÀ JUMP
    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            
            if hum and hrp then
                -- WalkSpeed chỉ đổi khi bật "Tăng Tốc Độ"
                if Config.SpeedEnabled then
                    hum.WalkSpeed = Config.SpeedValue
                end

                -- Potar Jump dùng Tốc độ Jump riêng
                if Config.PotarJumpEnabled and hum.MoveDirection.Magnitude > 0 then
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        local moveDir = hum.MoveDirection
                        hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * Config.JumpSpeedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Z * Config.JumpSpeedValue)
                    end
                end

                -- Nút Cam Jump 🦘 dùng Tốc độ Jump riêng
                if Config.CamJumpEnabled then
                    if hum.FloorMaterial ~= Enum.Material.Air then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                    local camLook = Camera.CFrame.LookVector
                    local moveDir = Vector3.new(camLook.X, 0, camLook.Z).Unit
                    hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * Config.JumpSpeedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Z * Config.JumpSpeedValue)
                end
            end
        end

        -- TRACERS (TOP-CENTER)
        if Config.TracersEnabled and Drawing then
            for model, line in pairs(ActiveTracers) do
                if not model or not model.Parent or not model:FindFirstChildOfClass("Humanoid") then
                    pcall(function() line:Remove() end)
                    ActiveTracers[model] = nil
                end
            end

            for _, v in pairs(workspace:GetChildren()) do
                if v:FindFirstChildOfClass("Humanoid") and v ~= LocalPlayer.Character then
                    local targetHrp = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Torso") or v:FindFirstChild("Head")
                    if targetHrp then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(targetHrp.Position)
                        if onScreen then
                            local line = ActiveTracers[v]
                            if not line then
                                line = Drawing.new("Line")
                                line.Thickness = 2
                                line.Color = Color3.fromRGB(216, 180, 254)
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
            end
        else
            for _, line in pairs(ActiveTracers) do line.Visible = false end
        end
    end)
end)

-- [[ KIỂM TRA KẾT QUẢ VÀ THÔNG BÁO ]]
if success then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "★ MRGHOST HUB VIP ★",
            Text = "✨ Đã kích hoạt Full Light thành công!",
            Duration = 5
        })
    end)
    print("[★ MRGHOST HUB VIP ★] Loaded successfully!")
else
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "★ MRGHOST HUB ★",
            Text = "script ko hoạt động đc",
            Duration = 5
        })
    end)
    warn("[★ MRGHOST HUB ★] Load failed: " .. tostring(err))
end
 
