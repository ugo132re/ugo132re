local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE Hub | MM2 ",
   LoadingTitle = "Initializing Systems...",
   LoadingSubtitle = "by REMOTE HuUB",
   ConfigurationSaving = { Enabled = false }
})

-- [[ SETTINGS ]] --
local Settings = {
    SilentAim = false,
    FOV = 150,
    ESP = false,
    TargetPart = "UpperTorso" -- เน้นยิงลำตัวตามคำขอ
}

-- [[ FOV CIRCLE ]] --
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Transparency = 0.7
FOVCircle.Filled = false
FOVCircle.Visible = false

-- [[ FUNCTIONS ]] --

-- ตรวจสอบบทบาทจากไอเทม
local function getPlayerRole(player)
    local character = player.Character
    local backpack = player.Backpack
    
    if not character or not backpack then return "Innocent", Color3.fromRGB(0, 255, 0) end
    
    -- เช็คฆาตกร (มีด)
    if backpack:FindFirstChild("Knife") or character:FindFirstChild("Knife") then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    -- เช็คนายอำเภอ (ปืน)
    elseif backpack:FindFirstChild("Gun") or character:FindFirstChild("Gun") then
        return "Sheriff", Color3.fromRGB(0, 0, 255)
    end
    
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

-- ระบบ ESP Highlight
local function applyESP(player)
    player.CharacterAdded:Connect(function(char)
        if Settings.ESP then
            task.wait(0.5)
            local highlight = Instance.new("Highlight")
            highlight.Name = "DolaESP"
            highlight.Parent = char
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end)
end

-- [[ SILENT AIM LOGIC ]] --
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if not checkcaller() and method == "FireServer" and self.Name == "Shoot" and Settings.SilentAim then
        local target = nil
        local maxDist = Settings.FOV
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()

        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild(Settings.TargetPart) then
                local role, _ = getPlayerRole(p)
                if role == "Murderer" then -- ล็อคเป้าเฉพาะฆาตกรเพื่อความปลอดภัย
                    local pos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(p.Character[Settings.TargetPart].Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                        if dist < maxDist then
                            target = p.Character[Settings.TargetPart]
                            maxDist = dist
                        end
                    end
                end
            end
        end

        if target then
            local origin = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            args[1] = CFrame.new(origin, target.Position)
            args[2] = target.Position
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)

-- [[ UI TABS ]] --
local MainTab = Window:CreateTab("Combat & Visuals", 4483362458)

MainTab:CreateToggle({
   Name = "Silent Aim (Target: Murderer)",
   CurrentValue = false,
   Callback = function(v) Settings.SilentAim = v end,
})

MainTab:CreateSlider({
   Name = "Silent Aim FOV",
   Range = {50, 800},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) Settings.FOV = v end,
})

MainTab:CreateToggle({
   Name = "Player Role ESP",
   CurrentValue = false,
   Callback = function(v) 
        Settings.ESP = v 
        -- ล้างหรือสร้าง ESP ทันทีเมื่อกดเปิด/ปิด
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character then
                local ex = p.Character:FindFirstChild("DolaESP")
                if ex then ex:Destroy() end
                
                if v and p ~= game.Players.LocalPlayer then
                    local h = Instance.new("Highlight", p.Character)
                    h.Name = "DolaESP"
                end
            end
        end
   end,
})

-- [[ LOOP UPDATES ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    -- อัปเดตวงกลม FOV
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
    FOVCircle.Visible = Settings.SilentAim

    -- อัปเดตสี ESP ตามบทบาทแบบ Real-time
    if Settings.ESP then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                local highlight = p.Character:FindFirstChild("DolaESP")
                if highlight then
                    local _, roleColor = getPlayerRole(p)
                    highlight.FillColor = roleColor
                    highlight.OutlineTransparency = 0
                    highlight.FillTransparency = 0.5
                end
            end
        end
    end
end)

-- จัดการผู้เล่นใหม่ที่เข้าเซิร์ฟเวอร์
game.Players.PlayerAdded:Connect(applyESP)
for _, p in pairs(game.Players:GetPlayers()) do applyESP(p) end

Rayfield:Notify({Title = "Dola Hub", Content = "Script Loaded Successfully!", Duration = 5})
