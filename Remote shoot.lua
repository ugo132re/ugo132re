-- [[ REMOTE HUB: MURDER MYSTERY ELITE (FULL CHAMS + SILENT AIM V2) ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE HUB | MM2 SPECIAL",
   LoadingTitle = "Initializing Remote Hub...",
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

local function getMurderer()
    for _, v in pairs(game.Players:GetPlayers()) do
        local role = getRole(v)
        if role == "Murderer" then return v end
    end
    return nil
end

local function isInsideFOV(pos)
    local screenPos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pos)
    if onScreen then
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        return dist <= Settings.FOV
    end
    return false
end

-- [[ CHAMS SYSTEM (HIGHLIGHT) ]] --
local function applyChams(player)
    local function addHighlight(character)
        if player == game.Players.LocalPlayer then return end
        if character:FindFirstChild("RemoteHubHighlight") then character.RemoteHubHighlight:Destroy() end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "RemoteHubHighlight"
        highlight.Parent = character
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
    end
    if player.Character then addHighlight(player.Character) end
    player.CharacterAdded:Connect(addHighlight)
end

for _, p in pairs(game.Players:GetPlayers()) do applyChams(p) end
game.Players.PlayerAdded:Connect(applyChams)

game:GetService("RunService").Heartbeat:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("RemoteHubHighlight") then
            local roleName, roleColor = getRole(p)
            local highlight = p.Character.RemoteHubHighlight
            highlight.Enabled = Settings.ESP
            highlight.FillColor = roleColor
        end
    end
end)

-- [[ UI TABS ]] --
local MainTab = Window:CreateTab("Main Settings", 4483362458)

MainTab:CreateToggle({
   Name = "Enable Player Chams",
   CurrentValue = true,
   Callback = function(v) Settings.ESP = v end,
})

MainTab:CreateToggle({
   Name = "Silent Aim (Lock Murderer)",
   CurrentValue = true,
   Callback = function(v) Settings.SilentAim = v end,
})

MainTab:CreateSlider({
   Name = "FOV Size",
   Range = {50, 600},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) Settings.FOV = v end,
})

-- [[ THE CORE: REMOTE HOOK V2 ]] --
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- เช็คทั้งชื่อ 'Shoot' และ 'Action' เพื่อความครอบคลุม
    if Settings.SilentAim and (self.Name == "Shoot" or self.Name == "Action") and method == "FireServer" then
        local murderer = getMurderer()
        
        if murderer and murderer.Character and murderer.Character:FindFirstChild(Settings.TargetPart) then
            local targetPos = murderer.Character[Settings.TargetPart].Position
            
            if isInsideFOV(targetPos) then
                -- แก้ไขแค่จุดปลายทาง (Argument ตัวที่ 2) แต่คงจุดกำเนิดเดิมไว้
                if args[2] and typeof(args[2]) == "CFrame" then
                    args[2] = murderer.Character[Settings.TargetPart].CFrame
                end
                -- ส่งค่าที่แก้ไขแล้วกลับไป
                return oldNamecall(self, unpack(args))
            end
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

-- FOV Circle Loop
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
    FOVCircle.Visible = Settings.SilentAim
end)

Rayfield:Notify({Title = "REMOTE HUB", Content = "Script Fully Loaded!", Duration = 3})
