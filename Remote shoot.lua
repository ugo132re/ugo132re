-- [[ REMOTE HUB: MURDER MYSTERY ELITE (FULL ESP + SILENT AIM) ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE HUB | MM2 SPECIAL",
   LoadingTitle = "Loading Remote Systems...",
   LoadingSubtitle = "by UGO132RE",
   ConfigurationSaving = { Enabled = false }
})

-- [[ SETTINGS ]] --
local Settings = {
    SilentAim = true,
    FOV = 150,
    ESP = true,
    TargetPart = "UpperTorso"
}

-- [[ FOV VISUAL ]] --
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Transparency = 0.7
FOVCircle.Filled = false

-- [[ FUNCTIONS ]] --
local function getRole(player)
    if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    elseif player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
        return "Sheriff", Color3.fromRGB(0, 0, 255)
    end
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

-- [[ ESP SYSTEM ]] --
local function createESP(player)
    local box = Drawing.new("Square")
    local text = Drawing.new("Text")
    
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if Settings.ESP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player ~= game.Players.LocalPlayer then
            local roleName, roleColor = getRole(player)
            local pos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            
            if onScreen then
                -- Setup Box
                box.Visible = true
                box.Size = Vector2.new(2000 / pos.Z, 2500 / pos.Z)
                box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
                box.Color = roleColor
                
                -- Setup Text
                text.Visible = true
                text.Text = string.format("[%s] %s", roleName, player.Name)
                text.Size = 16
                text.Center = true
                text.Outline = true
                text.Color = roleColor
                text.Position = Vector2.new(pos.X, pos.Y - (box.Size.Y / 2) - 20)
            else
                box.Visible = false
                text.Visible = false
            end
        else
            box.Visible = false
            text.Visible = false
            if not player.Parent then connection:Disconnect() box:Remove() text:Remove() end
        end
    end)
end

-- Run ESP for all players
for _, p in pairs(game.Players:GetPlayers()) do createESP(p) end
game.Players.PlayerAdded:Connect(createESP)

-- [[ COMBAT TABS ]] --
local MainTab = Window:CreateTab("Combat & ESP", 4483362458)

MainTab:CreateSection("ESP Settings")
MainTab:CreateToggle({
   Name = "Enable Player ESP",
   CurrentValue = true,
   Callback = function(v) Settings.ESP = v end,
})

MainTab:CreateSection("Silent Aim")
MainTab:CreateToggle({
   Name = "Silent Aim (Target Murderer)",
   CurrentValue = true,
   Callback = function(v) Settings.SilentAim = v end,
})

MainTab:CreateSlider({
   Name = "FOV Size",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) Settings.FOV = v end,
})

-- [[ THE FIX: REMOTE HOOKING ]] --
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if Settings.SilentAim and self.Name == "Shoot" and method == "FireServer" then
        -- หาฆาตกร
        local targetPlayer = nil
        for _, p in pairs(game.Players:GetPlayers()) do
            local role = getRole(p)
            if role == "Murderer" and p.Character and p.Character:FindFirstChild(Settings.TargetPart) then
                local screenPos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(p.Character[Settings.TargetPart].Position)
                local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                
                if onScreen and dist <= Settings.FOV then
                    targetPlayer = p
                    break
                end
            end
        end

        -- ถ้าเจอฆาตกรใน FOV ให้เปลี่ยนพิกัดยิง
        if targetPlayer then
            local newArgs = {
                game.Players.LocalPlayer.Character.Head.CFrame, -- จุดเริ่ม
                targetPlayer.Character[Settings.TargetPart].CFrame -- จุดจบที่ตัวฆาตกร
            }
            return oldNamecall(self, unpack(newArgs))
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

-- FOV Update Loop
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
    FOVCircle.Visible = Settings.SilentAim
end)

Rayfield:Notify({Title = "REMOTE HUB", Content = "ESP & Silent Aim Ready!", Duration = 3})
