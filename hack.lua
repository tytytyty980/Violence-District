-- Violence District Hack
-- Простой чит для Roblox Violence District

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Violence District Hack", "Midnight")

local enabled = false
local esp_enabled = false

local main_tab = window:NewTab("Main")
local main_section = main_tab:NewSection("Main")

main_section:NewToggle("Enable Hack", "Включить чит", function(state)
    enabled = state
end)

main_section:NewToggle("ESP", "Показывать выживших", function(state)
    esp_enabled = state
end)

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

spawn(esp_survivors)

print("Violence District Hack loaded!")
