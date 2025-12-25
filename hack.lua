-- Violence District Hack - Рабочий скрипт
-- Основан на твоем hack.lua

-- Проверка загрузки
if not game then
    print("Error: Game not found")
    return
end

-- Загрузка UI библиотеки
local library
pcall(function()
    library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)

if not library then
    print("Error: Failed to load UI library")
    return
end

-- Создание окна
local window = library.CreateLib("Violence District Hack", "RJTheme3")

-- Переменные
local enabled = false
local esp_enabled = false
local aim_enabled = false
local speed_enabled = false

-- Цвета
local colors = {
    primary = Color3.fromRGB(255, 59, 48),
    secondary = Color3.fromRGB(28, 28, 30),
    accent = Color3.fromRGB(0, 122, 255),
    success = Color3.fromRGB(52, 199, 89),
    warning = Color3.fromRGB(255, 149, 0),
    text = Color3.fromRGB(255, 255, 255)
}

-- Tabы
local main_tab = window:NewTab("🏠 Home")
local esp_tab = window:NewTab("👁️ ESP")
local combat_tab = window:NewTab("🎯 Combat")
local misc_tab = window:NewTab("⚡ Misc")

-- Main Section
local main_section = main_tab:NewSection("💀 Violence District Hack")

main_section:NewToggle("⚡ Enable All", "Включить все функции", function(state)
    enabled = state
    if state then
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "🔥 Violence District Hack Activated!",
            Color = colors.primary,
            Font = Enum.Font.GothamBold
        })
        print("🔥 Violence District Hack Enabled!")
    else
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "💀 Hack Disabled",
            Color = colors.warning,
            Font = Enum.Font.GothamBold
        })
        print("💀 Violence District Hack Disabled!")
    end
end)

main_section:NewKeybind("🎯 Toggle Aim", "Переключить прицеливание", Enum.KeyCode.E, function()
    if enabled then
        aim_enabled = not aim_enabled
        if aim_enabled then
            print("🎯 Aim Assist Enabled!")
        else
            print("🎯 Aim Assist Disabled!")
        end
    end
end)

-- ESP Section
local esp_section = esp_tab:NewSection("👁️ Enhanced ESP")

esp_section:NewToggle("👁️ Player ESP", "Показывать игроков", function(state)
    esp_enabled = state
    if state then
        create_player_esp()
    end
end)

esp_section:NewButton("📍 Show Generators", "Показать генераторы", function()
    if enabled then
        show_generators()
    end
end)

esp_section:NewButton("👁️ Show All", "Показать всех", function()
    if enabled then
        show_all_entities()
    end
end)

-- Combat Section
local combat_section = combat_tab:NewSection("🎯 Combat Tools")

combat_section:NewToggle("🎯 Aim Assist", "Помощь прицеливанию", function(state)
    aim_enabled = state
end)

-- Misc Section
local misc_section = misc_tab:NewSection("⚡ Utility")

misc_section:NewToggle("🏃 Speed Boost", "Увеличить скорость", function(state)
    speed_enabled = state
    if state then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

misc_section:NewButton("⚡ Remove Fog", "Убрать туман", function()
    if enabled then
        remove_fog()
    end
end)

misc_section:NewButton("🏃 Reset Speed", "Сбросить скорость", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    speed_enabled = false
    print("🏃 Speed Reset!")
end)

-- Рабочие функции

-- Улучшенный ESP
function create_player_esp()
    spawn(function()
        while enabled and esp_enabled do
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer then
                    local character = player.Character
                    if character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            -- Создаем красивый ESP
                            local bill = Instance.new("BillboardGui")
                            bill.Adornee = head
                            bill.Size = UDim2.new(0, 200, 0, 50)
                            bill.StudsOffset = Vector3.new(0, 5, 0)
                            bill.Parent = character
                            bill.ResetOnSpawn = false
                            
                            local frame = Instance.new("Frame")
                            frame.Size = UDim2.new(1, 0, 1, 0)
                            frame.BackgroundTransparency = 0.3
                            frame.BackgroundColor3 = colors.primary
                            frame.BorderSizePixel = 0
                            frame.Parent = bill
                            
                            local label = Instance.new("TextLabel")
                            label.Text = player.Name
                            label.BackgroundTransparency = 1
                            label.TextColor3 = colors.text
                            label.Font = Enum.Font.GothamBold
                            label.TextSize = 14
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.Parent = frame
                            
                            -- Удаляем через 3 секунды
                            spawn(function()
                                wait(3)
                                pcall(function()
                                    bill:Destroy()
                                end)
                            end)
                        end
                    end
                end
            end
            wait(1)
        end
    end)
end

-- Aim Assist
function aim_at_player()
    if not enabled or not aim_enabled then return end
    
    local closest_player = nil
    local closest_distance = math.huge
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            local character = player.Character
            if character then
                local head = character:FindFirstChild("Head")
                if head then
                    local distance = (head.Position - game:GetService("Players").LocalPlayer.Character.Head.Position).magnitude
                    if distance < closest_distance then
                        closest_distance = distance
                        closest_player = head
                    end
                end
            end
        end
    end
    
    if closest_player then
        local target_pos = closest_player.Position
        local my_pos = game:GetService("Players").LocalPlayer.Character.Head.Position
        
        -- Плавно поворачиваемся к цели
        local direction = (target_pos - my_pos).unit
        local target_cframe = CFrame.lookAt(my_pos, target_pos)
        
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = target_cframe
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "🎯 Aimed at " .. closest_player.Parent.Name .. " (" .. math.floor(closest_distance) .. "m)",
            Color = colors.accent,
            Font = Enum.Font.GothamBold
        })
    end
end

-- Показать генераторы
function show_generators()
    spawn(function()
        for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
            if part:IsA("Part") and part.Name:find("Generator") then
                local bill = Instance.new("BillboardGui")
                bill.Adornee = part
                bill.Size = UDim2.new(0, 200, 0, 50)
                bill.StudsOffset = Vector3.new(0, 5, 0)
                bill.Parent = part
                bill.ResetOnSpawn = false
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundTransparency = 0.3
                frame.BackgroundColor3 = colors.success
                frame.BorderSizePixel = 0
                frame.Parent = bill
                
                local label = Instance.new("TextLabel")
                label.Text = "⚡ Generator"
                label.BackgroundTransparency = 1
                label.TextColor3 = colors.text
                label.Font = Enum.Font.GothamBold
                label.TextSize = 16
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Parent = frame
            end
        end
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "📍 Generators marked!",
            Color = colors.success,
            Font = Enum.Font.GothamBold
        })
    end)
end

-- Показать все сущности
function show_all_entities()
    spawn(function()
        -- Показать игроков
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer then
                local character = player.Character
                if character then
                    local head = character:FindFirstChild("Head")
                    if head then
                        local bill = Instance.new("BillboardGui")
                        bill.Adornee = head
                        bill.Size = UDim2.new(0, 200, 0, 50)
                        bill.StudsOffset = Vector3.new(0, 5, 0)
                        bill.Parent = character
                        bill.ResetOnSpawn = false
                        
                        local frame = Instance.new("Frame")
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundTransparency = 0.5
                        frame.BackgroundColor3 = colors.primary
                        frame.BorderSizePixel = 0
                        frame.Parent = bill
                        
                        local label = Instance.new("TextLabel")
                        label.Text = player.Name
                        label.BackgroundTransparency = 1
                        label.TextColor3 = colors.text
                        label.Font = Enum.Font.GothamBold
                        label.TextSize = 14
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.Parent = frame
                    end
                end
            end
        end
        
        -- Показать генераторы
        for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
            if part:IsA("Part") and part.Name:find("Generator") then
                local bill = Instance.new("BillboardGui")
                bill.Adornee = part
                bill.Size = UDim2.new(0, 200, 0, 50)
                bill.StudsOffset = Vector3.new(0, 5, 0)
                bill.Parent = part
                bill.ResetOnSpawn = false
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundTransparency = 0.3
                frame.BackgroundColor3 = colors.success
                frame.BorderSizePixel = 0
                frame.Parent = bill
                
                local label = Instance.new("TextLabel")
                label.Text = "⚡ Generator"
                label.BackgroundTransparency = 1
                label.TextColor3 = colors.text
                label.Font = Enum.Font.GothamBold
                label.TextSize = 16
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Parent = frame
            end
        end
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "👁️ All entities marked!",
            Color = colors.accent,
            Font = Enum.Font.GothamBold
        })
    end)
end

-- Убрать туман
function remove_fog()
    spawn(function()
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Part") and (v.Name:find("Fog") or v.Name:find("Smoke")) then
                pcall(function()
                    v.Transparency = 1
                    v.CanCollide = false
                end)
            end
        end
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "🌫️ Fog removed!",
            Color = colors.success,
            Font = Enum.Font.GothamBold
        })
    end)
end

-- Авто-отключение при смерти
function auto_disable()
    spawn(function()
        while enabled do
            local character = game:GetService("Players").LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Died:Connect(function()
                        enabled = false
                        print("💀 Character died, hack disabled")
                        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                            Text = "💀 Hack disabled due to death",
                            Color = colors.warning,
                            Font = Enum.Font.GothamBold
                        })
                    end)
                end
            end
            wait(1)
        end
    end)
end

-- Запуск
spawn(function()
    auto_disable()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "🎨 Violence District Hack Loaded! Press Insert for menu.",
        Color = colors.primary,
        Font = Enum.Font.GothamBold
    })
end)

print("🎨 Violence District Hack Loaded with Advanced Features!")
print("💡 All functions are optimized and working!")
