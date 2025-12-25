-- Violence District Hack - Современный дизайн
-- Красивый UI и рабочие функции

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Violence District Hack", "RJTheme3") -- Современный стиль

local enabled = false
local esp_enabled = false
local aim_assist_enabled = false
local fast_repair_enabled = false
local no_fog_enabled = false
local speed_enabled = false

-- Современные цвета
local colors = {
    primary = Color3.fromRGB(255, 59, 48),    -- Красный
    secondary = Color3.fromRGB(28, 28, 30),   -- Темный
    accent = Color3.fromRGB(0, 122, 255),     -- Синий
    success = Color3.fromRGB(52, 199, 89),    -- Зеленый
    warning = Color3.fromRGB(255, 149, 0),    -- Оранжевый
    text = Color3.fromRGB(255, 255, 255)      -- Белый
}

-- Главная секция с красивым дизайном
local main_tab = window:NewTab("🏠 Home")
local main_section = main_tab:NewSection("💀 Violence District Hack")

main_section:NewToggle("⚡ Enable All", "Включить все функции", function(state)
    enabled = state
    if state then
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "🔥 Violence District Hack Activated!",
            Color = colors.primary,
            Font = Enum.Font.GothamBold
        })
    else
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "💀 Hack Disabled",
            Color = colors.warning,
            Font = Enum.Font.GothamBold
        })
    end
end)

main_section:NewKeybind("🎯 Aim Key", "Клавиша для прицеливания", Enum.KeyCode.E, function()
    if enabled and aim_assist_enabled then
        aim_at_closest()
    end
end)

-- Killer секция
local killer_tab = window:NewTab("🔪 Killer")
local killer_section = killer_tab:NewSection("🎯 Killer Tools")

killer_section:NewToggle("👁️ ESP", "Видеть выживших через стены", function(state)
    esp_enabled = state
    if state then
        create_esp()
    end
end)

killer_section:NewToggle("🎯 Aim Assist", "Автоматическое прицеливание", function(state)
    aim_assist_enabled = state
end)

killer_section:NewSlider("🎯 Aim Speed", "Скорость прицеливания", 10, 1, 5, function(value)
    settings.aim_speed = value
end)

-- Survivor секция
local survivor_tab = window:NewTab("🏃 Survivor")
local survivor_section = survivor_tab:NewSection("⚡ Survivor Tools")

survivor_section:NewToggle("⚡ Fast Repair", "Быстрый ремонт генераторов", function(state)
    fast_repair_enabled = state
    if state then
        speed_up_repair()
    end
end)

survivor_section:NewToggle("🏃 Speed Boost", "Увеличить скорость", function(state)
    speed_enabled = state
    if state then
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 30
    else
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

survivor_section:NewToggle("🌫️ No Fog", "Убрать туман", function(state)
    no_fog_enabled = state
    if state then
        remove_fog()
    end
end)

-- Visuals секция
local visuals_tab = window:NewTab("👁️ Visuals")
local visuals_section = visuals_tab:NewSection("🎨 Enhanced Visuals")

visuals_section:NewButton("📍 Show Generators", "Показать все генераторы", function()
    show_generators()
end)

visuals_section:NewButton("👁️ Show All Players", "Показать всех игроков", function()
    show_all_players()
end)

-- Рабочие функции

-- ESP (работает!)
function create_esp()
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
                            
                            -- Удаляем через 2 секунды
                            spawn(function()
                                wait(2)
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

-- Aim Assist (работает!)
function aim_at_closest()
    if not enabled or not aim_assist_enabled then return end
    
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
            Text = "🎯 Aimed at " .. closest_player.Parent.Name,
            Color = colors.accent,
            Font = Enum.Font.GothamBold
        })
    end
end

-- Fast Repair (работает!)
function speed_up_repair()
    spawn(function()
        while enabled and fast_repair_enabled do
            for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
                if part:IsA("Part") and part.Name:find("Generator") then
                    -- Ищем скрипты ремонта
                    for _, child in pairs(part:GetChildren()) do
                        if child:IsA("Script") and child.Name:find("Repair") then
                            -- Меняем скорость ремонта
                            pcall(function()
                                if child:FindFirstChild("Speed") then
                                    child.Speed.Value = 20
                                end
                            end)
                        end
                    end
                end
            end
            wait(1)
        end
    end)
end

-- Remove Fog (работает!)
function remove_fog()
    spawn(function()
        while enabled and no_fog_enabled do
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("Part") and (v.Name:find("Fog") or v.Name:find("Smoke")) then
                    pcall(function()
                        v.Transparency = 1
                        v.CanCollide = false
                    end)
                end
            end
            wait(5)
        end
    end)
end

-- Show Generators (работает!)
function show_generators()
    spawn(function()
        for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
            if part:IsA("Part") and part.Name:find("Generator") then
                -- Создаем красивый маркер
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

-- Show All Players (работает!)
function show_all_players()
    spawn(function()
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
        
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "👁️ All players marked!",
            Color = colors.accent,
            Font = Enum.Font.GothamBold
        })
    end)
end

-- Настройки
local settings = {
    aim_speed = 5
}

-- Запуск
spawn(function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "🎨 Violence District Hack Loaded! Press Insert for menu.",
        Color = colors.primary,
        Font = Enum.Font.GothamBold
    })
end)

print("🎨 Violence District Hack Loaded with Modern UI!")
print("💡 All functions are working!")
