-- [[ 1. THÔNG BÁO BẮT ĐẦU LOAD ]]
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "★ mrghost hub ★",
        Text = "Đang tải dữ liệu, vui lòng chờ...",
        Duration = 4
    })
end)

-- [[ KHỐI LỆNH TẢI SCRIPT AN TOÀN ]]
local success, err = pcall(function()
    -- [[ MRGHOST HUB - EVADE | MAIN.LUA OFFICIAL 5-STAR RELEASE ]] --
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
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
        SpeedValue = 45
    }

    local ActiveTracers = {}

    -- HÀM KÉO DI CHUYỂN MENU (HỖ TRỢ MỌI THIẾT BỊ)
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
    ScreenGui.Name = "MrGhostHubEvade"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    -- NÚT BẬT TẮT MENU 👻
    local ToggleButton = Instance.new("TextButton", ScreenGui)
    ToggleButton.Position = UDim2.new(0.05, 0, 0.3, 0); ToggleButton.Size = UDim2.new(0, 55, 0, 55)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30); ToggleButton.Text = "👻"; ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleButton.TextSize = 22; ToggleButton.Font = Enum.Font.SourceSansBold
    makeDraggable(ToggleButton)
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 30)

    -- KHUNG MENU CHÍNH
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0); MainFrame.Size = UDim2.new(0, 330, 0, 385)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Visible = true
    makeDraggable(MainFrame)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Color = Color3.fromRGB(138, 43, 226); UIStroke.Thickness = 2

    -- TIÊU ĐỀ MENU
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 45); Title.BackgroundTransparency = 1
    Title.Text = "mrghost hub -evade"; Title.TextColor3 = Color3.fromRGB(138, 43, 226); Title.TextSize = 21; Title.Font = Enum.Font.FredokaOne

    -- DANH SÁCH CHỨA NÚT CHỨC NĂNG
    local Scroll = Instance.new("ScrollingFrame", MainFrame)
    Scroll.Size = UDim2.new(1, -20, 1, -55); Scroll.Position = UDim2.new(0, 10, 0, 48)
    Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 4
    local Layout = Instance.new("UIListLayout", Scroll)
    Layout.Padding = UDim.new(0, 8); Layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- BẢNG STATS & NÚT NHẢY CHUỘT TÚI 🦘
    local StatsFrame = Instance.new("Frame", ScreenGui)
    StatsFrame.Position = UDim2.new(0.65, 0, 0.18, 0); StatsFrame.Size = UDim2.new(0, 140, 0, 32)
    StatsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25); StatsFrame.BackgroundTransparency = 0.3
    makeDraggable(StatsFrame)
    Instance.new("UICorner", StatsFrame).CornerRadius = UDim.new(0, 8)

    local StatsText = Instance.new("TextLabel", StatsFrame)
    StatsText.Size = UDim2.new(1, 0, 1, 0); StatsText.BackgroundTransparency = 1
    StatsText.Text = "Bị gục: 0"; StatsText.TextColor3 = Color3.fromRGB(255, 255, 255); StatsText.TextSize = 13; StatsText.Font = Enum.Font.FredokaOne

    local QuickJumpButton = Instance.new("TextButton", ScreenGui)
    QuickJumpButton.Position = UDim2.new(0.65, 148, 0.16, 0); QuickJumpButton.Size = UDim2.new(0, 60, 0, 60)
    QuickJumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40); QuickJumpButton.Text = "🦘"; QuickJumpButton.TextSize = 26; QuickJumpButton.Font = Enum.Font.SourceSansBold
    makeDraggable(QuickJumpButton)
    Instance.new("UICorner", QuickJumpButton).CornerRadius = UDim.new(0, 14)
    local QuickJumpStroke = Instance.new("UIStroke", QuickJumpButton)
    QuickJumpStroke.Thickness = 2

    -- HÀM TẠO NÚT TOGGLE TRONG MENU
    local function AddButton(TextName, ConfigKey, CustomFunc)
        local Btn = Instance.new("TextButton", Scroll)
        Btn.Size = UDim2.new(1, 0, 0, 40)
        Btn.BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(40, 40, 40)
        Btn.Text = TextName .. " : " .. (Config[ConfigKey] and "ON" or "OFF")
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.Font = Enum.Font.FredokaOne; Btn.TextSize = 14
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

        Btn.MouseButton1Click:Connect(function()
            Config[ConfigKey] = not Config[ConfigKey]
            Btn.BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(40, 40, 40)
            Btn.Text = TextName .. " : " .. (Config[ConfigKey] and "ON" or "OFF")
            if CustomFunc then CustomFunc(Config[ConfigKey]) end
        end)
    end

    -- HÀM TẠO TEXTBOX NHẬP TỐC ĐỘ
    local function AddTextBox(TextName, DefaultVal, Callback)
        local Frame = Instance.new("Frame", Scroll)
        Frame.Size = UDim2.new(1, 0, 0, 42)
        Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

        local Label = Instance.new("TextLabel", Frame)
        Label.Size = UDim2.new(0.6, 0, 1, 0); Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1; Label.Text = TextName; Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.FredokaOne; Label.TextSize = 13; Label.TextXAlignment = Enum.TextXAlignment.Left

        local Box = Instance.new("TextBox", Frame)
        Box.Size = UDim2.new(0.35, -10, 0.7, 0); Box.Position = UDim2.new(0.65, 0, 0.15, 0)
        Box.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Box.Text = tostring(DefaultVal)
        Box.TextColor3 = Color3.fromRGB(138, 43, 226); Box.Font = Enum.Font.FredokaOne; Box.TextSize = 14
        Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)

        Box.FocusLost:Connect(function()
            local num = tonumber(Box.Text)
            if num then
                Callback(num)
            else
                Box.Text = tostring(Config.SpeedValue)
            end
        end)
    end

    -- TẠO CÁC TÍNH NĂNG TRÊN MENU
    AddButton("Tăng Tốc Độ (Speed Boost)", "SpeedEnabled")
    AddTextBox("Tốc Độ (Speed Value)", Config.SpeedValue, function(val)
        Config.SpeedValue = val
    end)
    AddButton("Potar Jump (Auto Bhop)", "PotarJumpEnabled")
    AddButton("Hiện ESP Xuyên Tường", "EspEnabled", function(state)
        if not state then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "GhostESP" and v:IsA("Highlight") then
                    v:Destroy()
                end
            end
        end
    end)
    AddButton("Đường Kẻ Tracer (Top)", "TracersEnabled", function(state)
        if not state then
            for _, line in pairs(ActiveTracers) do
                pcall(function() line:Remove() end)
            end
            ActiveTracers = {}
        end
    end)
    AddButton("Nhìn Trong Tối (Full Bright)", "FullBright", function(state)
        Lighting.Brightness = state and 2 or 1
        Lighting.ClockTime = state and 14 or 12
    end)

    -- SỰ KIỆN CLICK NÚT 👻 MỞ BẢNG
    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- NÚT CHUỘT TÚI 🦘 (TOGGLE BẬT/TẮT)
    QuickJumpButton.MouseButton1Click:Connect(function()
        Config.CamJumpEnabled = not Config.CamJumpEnabled
        if Config.CamJumpEnabled then
            QuickJumpButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        else
            QuickJumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)

    -- VIỀN RGB 7 MÀU
    task.spawn(function()
        while task.wait() do
            for hue = 0, 1, 0.01 do
                QuickJumpStroke.Color = Color3.fromHSV(hue, 1, 1)
                task.wait(0.03)
            end
        end
    end)

    -- VÒNG LẶP CẬP NHẬT ESP HIGHLIGHT
    task.spawn(function()
        while task.wait(1) do
            if Config.EspEnabled then
                for _, v in pairs(workspace:GetChildren()) do
                    if v:FindFirstChildOfClass("Humanoid") and v ~= LocalPlayer.Character then
                        if not v:FindFirstChild("GhostESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "GhostESP"
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0
                            hl.Parent = v
                        end
                    end
                end
            end
        end
    end)

    -- LOGIC CẬP NHẬT ĐƯỜNG KẺ TRACER & DI CHUYỂN
    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            
            if hum and hrp then
                -- 1. WalkSpeed chỉ đổi khi bật nút Speed Boost
                if Config.SpeedEnabled then
                    hum.WalkSpeed = Config.SpeedValue
                end

                -- 2. Potar Jump dùng tốc độ ô Textbox
                if Config.PotarJumpEnabled and hum.MoveDirection.Magnitude > 0 then
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        local moveDir = hum.MoveDirection
                        hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * Config.SpeedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Z * Config.SpeedValue)
                    end
                end

                -- 3. Nút 🦘 (Cam Jump Toggle) dùng tốc độ ô Textbox
                if Config.CamJumpEnabled then
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                    local camLook = Camera.CFrame.LookVector
                    local moveDir = Vector3.new(camLook.X, 0, camLook.Z).Unit
                    hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * Config.SpeedValue, hrp.AssemblyLinearVelocity.Y, moveDir.Z * Config.SpeedValue)
                end
            end
        end

        -- XỬ LÝ VẼ ĐƯỜNG TRACER (TOP-CENTER) DỌN RÁC TỰ ĐỘNG
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
                                line.Thickness = 1.5
                                line.Color = Color3.fromRGB(0, 255, 255)
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
            for _, line in pairs(ActiveTracers) do
                line.Visible = false
            end
        end
    end)
end)

-- [[ KIỂM TRA KẾT QUẢ VÀ THÔNG BÁO ]]
if success then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "★ mrghost hub ★",
            Text = "Đã kích hoạt Full Light thành công!",
            Duration = 5
        })
    end)
    print("[★ mrghost hub ★] Loaded successfully on all clients!")
else
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "★ mrghost hub ★",
            Text = "script ko hoạt động đc",
            Duration = 5
        })
    end)
    warn("[★ mrghost hub ★] Load failed: " .. tostring(err))
end
 
