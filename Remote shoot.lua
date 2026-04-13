local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE Hub | MM2 FIXED",
   LoadingTitle = "Fixing Remote Systems...",
   LoadingSubtitle = "by REMOTE HUbB",
   ConfigurationSaving = { Enabled = false }
})

local Settings = {
    SilentAim = false,
    FOV = 150,
    ESP = false,
    TargetPart = "UpperTorso"
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Transparency = 0.7
FOVCircle.Visible = false

-- [[ FUNCTIONS ]] --
local function getPlayerRole(player)
    if not player or not player.Character then return "Innocent", Color3.fromRGB(0, 255, 0) end
    if player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife") then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    elseif player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun") then
        return "Sheriff", Color3.fromRGB(0, 0, 255)
    end
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

-- [[ SILENT AIM (FIXED VERSION) ]] --
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- ตรวจสอบว่าเป็นการยิงปืน (Remote: Shoot)
    if not checkcaller() and method == "FireServer" and self.Name == "Shoot" and Settings.SilentAim then
        local target = nil
        local maxDist = Settings.FOV
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()

        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild(Settings.TargetPart) then
                local role, _ = getPlayerRole(p)
                -- ยิงเฉพาะฆาตกร (หรือเปลี่ยนเป็นยิงทุกคนถ้าต้องการ)
                if role == "Murderer" then 
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

        -- ถ้าเจอเป้าหมาย ให้เปลี่ยนค่ากระสุน
        if target then
            local lpChar = game.Players.LocalPlayer.Character
            if lpChar and lpChar:FindFirstChild("HumanoidRootPart") then
                -- Args[1] ต้องเป็น CFrame ที่หันหน้าไปหาเป้าหมาย
                args[1] = CFrame.new(lpChar.HumanoidRootPart.Position, target.Position)
                -- Args[2] ต้องเป็นตำแหน่ง Vector3 ของเป้าหมาย
                args[2] = target.Position
                
                return self.FireServer(self, unpack(args)) -- ใช้ FireServer โดยตรงเพื่อลดโอกาสรวน
            end
        end
    end

    return oldNamecall(self, ...)
end)

-- [[ UI TABS ]] --
local MainTab = Window:CreateTab("Combat", 4483362458)

MainTab:CreateToggle({
   Name = "Silent Aim (Murderer Only)",
   CurrentValue = false,
   Callback = function(v) Settings.SilentAim = v end,
})

MainTab:CreateSlider({
   Name = "FOV Size",
   Range = {50, 800},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) Settings.FOV = v end,
})

local VisualTab = Window:CreateTab("Visuals", 4483362458)

VisualTab:CreateToggle({
   Name = "Role ESP (Chams)",
   CurrentValue = false,
   Callback = function(v) Settings.ESP = v end,
})

-- [[ LOOP UPDATES ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    -- Update FOV
    FOVCircle.Visible = Settings.SilentAim
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()

    -- Update ESP
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local highlight = p.Character:FindFirstChild("DolaHighlight")
            
            if Settings.ESP then
                if not highlight then
                    highlight = Instance.new("Highlight", p.Character)
                    highlight.Name = "DolaHighlight"
                end
                local _, roleColor = getPlayerRole(p)
                highlight.FillColor = roleColor
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Enabled = true
            else
                if highlight then highlight.Enabled = false end
            end
        end
    end
end)

Rayfield:Notify({Title = "Dola Hub", Content = "Script Fixed & Loaded", Duration = 3})
