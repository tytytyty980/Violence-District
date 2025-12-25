-- Violence District Hack - Простой и рабочий
-- Только основные функции

-- UI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Violence District Hack", "RJTheme3")

-- Переменные
local enabled = false
local esp_enabled = false

-- Tabы
local main_tab = window:NewTab("Main")
local esp_tab = window:NewTab("ESP")

-- Main Section
local main_section = main_tab:NewSection("Violence District Hack")

main_section:NewToggle("Enable", "Включить чит", function(state)
    enabled = state
end)

-- ESP Section
local esp_section = esp_tab:NewSection("ESP")

esp_section:NewToggle("ESP", "Показывать игроков", function(state)
    esp_enabled = state
    if state then
        create_esp()
    end
end)

-- Функции
function create_esp()
    spawn(function()
        while enabled and esp_enabled do
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
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
            wait(1)
        end
    end)
end

print("Violence District Hack Loaded!")
