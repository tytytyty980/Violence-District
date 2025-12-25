-- Violence District Hack - Простой и рабочий
-- Простой скрипт для Xeno Injector

-- Проверяем, загрузился ли скрипт
print("🔥 Violence District Hack Loaded!")

-- Создаем UI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Violence District Hack", "RJTheme3")

-- Переменные
local enabled = false
local esp_enabled = false
local aim_enabled = false
local speed_enabled = false

-- Tabы
local main_tab = window:NewTab("🏠 Main")
local esp_tab = window:NewTab("👁️ ESP")
local misc_tab = window:NewTab("⚡ Misc")

-- Main Section
local main_section = main_tab:NewSection("💀 Violence District Hack")

main_section:NewToggle("⚡ Enable", "Включить чит", function(state)
    enabled = state
    if state then
        print("🔥 Hack Enabled!")
    else
        print("💀 Hack Disabled!")
    end
end)

-- ESP Section
local esp_section = esp_tab:NewSection("👁️ ESP Functions")

esp_section:NewToggle("👁️ ESP", "Показывать игроков", function(state)
    esp_enabled = state
    if state then
        create_esp()
    end
end)

-- Misc Section
local misc_section = misc_tab:NewSection("⚡ Misc Functions")

misc_section:NewToggle("🏃 Speed", "Увеличить скорость", function(state)
    speed_enabled = state
    if state then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

misc_section:NewButton("🎯 Aim", "Прицелиться на ближайшего", function()
    if enabled then
        aim_at_player()
    end
end)

-- Функции

-- ESP (простой и рабочий)
function create_esp()
    spawn(function()
        while enabled and esp_enabled do
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local character = player.Character
                    if character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            -- Создаем ESP
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
            wait(1)
        end
    end)
end

-- Aim Assist (простой)
function aim_at_player()
    local closest = nil
    local closest_dist = math.huge
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local character = player.Character
            if character then
                local head = character:FindFirstChild("Head")
                if head then
                    local dist = (head.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude
                    if dist < closest_dist then
                        closest_dist = dist
                        closest = head
                    end
                end
            end
        end
    end
    
    if closest then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(
            game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
            closest.Position
        )
        print("🎯 Aimed at " .. closest.Parent.Name)
    end
end

-- Сообщение о загрузке
game.StarterGui:SetCore("ChatMakeSystemMessage", {
    Text = "🔥 Violence District Hack Loaded! Press Insert for menu.",
    Color = Color3.fromRGB(255, 0, 0),
    Font = Enum.Font.Code
})
