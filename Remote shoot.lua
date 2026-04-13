-- [[ REMOTE HUB: MURDER MYSTERY ELITE (FULL FIX EDITION) ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE HUB | MM2 ULTIMATE",
   LoadingTitle = "Fixing Systems...",
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

-- [[ FOV CIRCLE ]] --
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Transparency = 0.7
FOVCircle.Filled = false

-- [[ FUNCTIONS ]] --
local function getRole(player)
    if not player then return "Innocent", Color3.fromRGB(0, 255, 0) end
    if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    elseif player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
        return "Sheriff", Color3.fromRGB(0, 0, 255)
    end
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

-- [[ ESP FIXED SYSTEM ]] --
local function updateESP()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local roleName, roleColor = getRole(p)
            local char = p.Character
            
            -- สร้างหรือหา Highlight
            local highlight = char:FindFirstChild("REMOTE_ESP")
            if Settings.ESP then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "REMOTE_ESP"
                    highlight.Parent = char
                end
                highlight.FillColor = roleColor
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Enabled = true
            else
                if highlight then highlight.Enabled = false end
            end
        end
    end
end

-- [[ SILENT AIM FIXED (HOOKMETAMETHOD) ]] --
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- ตรวจสอบชื่อ Remote 'Shoot' หรือ 'Action' ตามที่นายเคยส่งมา
    if (self.Name == "Shoot" or self.Name == "Action") and method == "FireServer" and Settings.SilentAim then
        local target = nil
        local shortestDist = Settings.FOV

        -- หาฆาตกรที่อยู่ใน FOV
        for _, p in pairs(game.Players:GetPlayers()) do
            local role = getRole(p)
            if role == "Murderer" and p.Character and p.Character:FindFirstChild(Settings.TargetPart) then
                local pos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(p.Character[Settings.TargetPart].Position)
                local mouse = game:GetService("UserInputService"):GetMouseLocation()
                local dist = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                
                if onScreen and dist < shortestDist then
                    target = p.Character[Settings.TargetPart]
                    shortestDist = dist
                end
            end
        end

        -- ถ้าเจอฆาตกร ให้แก้แค่พิกัดเป้าหมาย (Args ตัวที่ 2)
        if target then
            if args[2] and typeof(args[2]) == "CFrame" then
                args[2] = target.CFrame
                return oldNamecall(self, unpack(args))
            end
        end
    end

    return oldNamecall(self, ...)
end)

-- [[ UI TABS ]] --
local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateToggle({
   Name = "Enable Player ESP (Chams)",
   CurrentValue = true,
   Callback = function(v) Settings.ESP = v end,
})

MainTab:CreateToggle({
   Name = "Silent Aim (Target Murderer)",
   CurrentValue = true,
   Callback = function(v) Settings.SilentAim = v end,
})

MainTab:CreateSlider({
   Name = "FOV Radius",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) Settings.FOV = v end,
})

-- [[ LOOPS ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    updateESP()
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
    FOVCircle.Visible = Settings.SilentAim
end)

Rayfield:Notify({Title = "REMOTE HUB LOADED", Content = "Systems Stabilized!", Duration = 5})
