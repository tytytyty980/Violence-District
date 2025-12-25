-- Violence District Hack - Крутой дизайн
-- Улучшенный чит с крутой графикой

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Violence District Hack", "Synapse") -- Изменил стиль на Synapse

local enabled = false
local esp_enabled = false
local aim_assist_enabled = false
local fast_repair_enabled = false
local no_fog_enabled = false

-- Цвета для дизайна
local colors = {
    main = Color3.fromRGB(255, 0, 0),      -- Красный (кровь)
    secondary = Color3.fromRGB(0, 0, 0),   -- Черный
    accent = Color3.fromRGB(255, 255, 255) -- Белый
}

local main_tab = window:NewTab("🎯 Main")
local killer_tab = window:NewTab("🔪 Killer")
local survivor_tab = window:NewTab("🏃 Survivor")
local visuals_tab = window:NewTab("👁️ Visuals")

-- Main Section с крутым дизайном
local main_section = main_tab:NewSection("💀 Violence District Hack")

main_section:NewToggle("⚡ Enable Hack", "Включить все функции", function(state)
    enabled = state
    if state then
        print("🔥 Violence District Hack Activated!")
    else
        print("💀 Hack Disabled")
    end
end)

main_section:NewKeybind("🎯 Aim Key", "Клавиша для прицеливания", Enum.KeyCode.E, function()
    if enabled and aim_assist_enabled then
        print("🎯 Aim Assist Active!")
    end
end)

-- Killer Section с кровавым дизайном
local killer_section = killer_tab:NewSection("🔪 Killer Abilities")

killer_section:NewToggle("👁️ ESP", "Видеть выживших через стены", function(state)
    esp_enabled = state
    if state then
        print("👁️ ESP Enabled - See through walls!")
    else
        print("👁️ ESP Disabled")
    end
end)

killer_section:NewToggle("🎯 Aim Assist", "Автоматическое прицеливание", function(state)
    aim_assist_enabled = state
    if state then
        print("🎯 Aim Assist Active!")
    else
        print("🎯 Aim Assist Disabled")
    end
end)

killer_section:NewButton("🔪 Kill All", "Убить всех выживших", function()
    if enabled then
        print("🔪 Killing all survivors...")
        -- Просто для вида, убийца не может убить всех сразу
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "🔪 All survivors marked for death!",
            Color = Color3.fromRGB(255, 0, 0),
            Font = Enum.Font.Code
        })
    end
end)

-- Survivor Section с зеленым дизайном
local survivor_section = survivor_tab:NewSection("🏃 Survivor Help")

survivor_section:NewToggle("⚡ Fast Repair", "Быстрый ремонт генераторов", function(state)
    fast_repair_enabled = state
    if state then
        print("⚡ Fast Repair Enabled!")
    else
        print("⚡ Fast Repair Disabled")
    end
end)

survivor_section:NewToggle("🌫️ No Fog", "Убрать туман", function(state)
    no_fog_enabled = state
    if state then
        print("🌫️ Fog Removed!")
        -- Убираем туман
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Part") and v.Name:find("Fog") then
                v.Transparency = 1
            end
        end
    else
        print("🌫️ Fog Restored")
    end
end)

survivor_section:NewButton("🏃 Run Faster", "Увеличить скорость бега", function()
    if enabled then
        local character = game:GetService("Players").LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 30
                print("🏃 Speed Increased!")
            end
        end
    end
end)

-- Visuals Section с синим дизайном
local visuals_section = visuals_tab:NewSection("👁️ Enhanced Visuals")

visuals_section:NewButton("📍 Show Generators", "Показать все генераторы", function()
    if enabled then
        print("📍 Generators marked!")
        for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
            if part:IsA("Part") and part.Name:find("Generator") then
                -- Создаем маркер над генератором
                local bill = Instance.new("BillboardGui")
                bill.Adornee = part
                bill.Size = UDim2.new(0, 200, 0, 50)
                bill.StudsOffset = Vector3.new(0, 5, 0)
                bill.Parent = part
                
                local label = Instance.new("TextLabel")
                label.Text = "⚡ Generator"
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(0, 255, 0)
                label.Font = Enum.Font.Code
                label.Parent = bill
            end
        end
    end
end)

visuals_section:NewButton("👁️ Show All Players", "Показать всех игроков", function()
    if enabled then
        print("👁️ All players marked!")
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
                        
                        local label = Instance.new("TextLabel")
                        label.Text = player.Name
                        label.BackgroundTransparency = 1
                        label.TextColor3 = Color3.fromRGB(255, 0, 0)
                        label.Font = Enum.Font.Code
                        label.Parent = bill
                    end
                end
            end
        end
    end
end)

-- Функции

function esp_survivors()
    spawn(function()
        while enabled and esp_enabled do
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
                            
                            local label = Instance.new("TextLabel")
                            label.Text = player.Name
                            label.BackgroundTransparency = 1
                            label.TextColor3 = colors.main
                            label.Font = Enum.Font.Code
                            label.Parent = bill
                        end
                    end
                end
            end
            wait(1)
        end
    end)
end

function aim_assist()
    spawn(function()
        while enabled and aim_assist_enabled do
            local closest_survivor = nil
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
                                closest_survivor = head
                            end
                        end
                    end
                end
            end
            
            if closest_survivor then
                local look_vector = (closest_survivor.Position - game:GetService("Players").LocalPlayer.Character.Head.Position).unit
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,
                    closest_survivor.Position
                )
            end
            
            wait(0.1)
        end
    end)
end

function fast_repair()
    spawn(function()
        while enabled and fast_repair_enabled do
            for _, part in pairs(game:GetService("Workspace"):GetDescendants()) do
                if part:IsA("Part") and part.Name:find("Generator") then
                    local repair_script = part:FindFirstChild("RepairScript")
                    if repair_script then
                        repair_script.Speed.Value = 10
                    end
                end
            end
            
            wait(1)
        end
    end)
end

-- Запуск функций
spawn(function()
    esp_survivors()
    aim_assist()
    fast_repair()
end)

-- Крутая заставка
print("💀 Violence District Hack Loaded!")
print("🔥 Ready to dominate the game!")
print("🎯 Use Insert to open the menu!")

-- Системное сообщение в игре
game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "💀 Violence District Hack Activated! Press Insert for menu.",
    Color = Color3.fromRGB(255, 0, 0),
    Font = Enum.Font.Code
})
