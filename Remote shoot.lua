-- [[ REMOTE HUB: MURDER MYSTERY ELITE (FULL FIX EDITION) ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE HUB | MM2 ULTIMATE",
   LoadingTitle = "Systems Stabilizing...",
   LoadingSubtitle = "by REMOTE HUB TEAM",
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
FOVCircle.Visible = false

-- [[ FUNCTIONS ]] --
local function getRole(player)
    if not player or not player:FindFirstChild("Backpack") then return "Innocent", Color3.fromRGB(0, 255, 0) end
    if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    elseif player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
        return "Sheriff", Color3.fromRGB(0, 0, 255)
    end
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

-- [[ ESP SYSTEM (OPTIMIZED) ]] --
local function manageESP(char, player)
    task.spawn(function()
        local highlight = char:FindFirstChild("REMOTE_HIGHLIGHT") or Instance.new("Highlight")
        highlight.Name = "REMOTE_HIGHLIGHT"
        highlight.Parent = char
        highlight.Adornee = char
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        
        while char and char.Parent and Settings.ESP do
            local _, roleColor = getRole(player)
            highlight.FillColor = roleColor
            highlight.Enabled = true
            task.wait(1) -- อัปเดตสีทุก 1 วินาทีเพื่อลดภาระเครื่อง
        end
        if highlight then highlight.Enabled = false end
    end)
end

-- Monitor Players
for _, p in pairs(game.Players:GetPlayers()) do
    if p ~= game.Players.LocalPlayer and p.Character then manageESP(p.Character, p) end
    p.CharacterAdded:Connect(function(c) manageESP(c, p) end)
end
game.Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c) manageESP(c, p) end)
end)

-- [[ SILENT AIM (RE-ENGINEERED) ]] --
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- ค้นหาชื่อ Remote ที่มีคำว่า Shoot หรือ Action (ยืดหยุ่นกว่าเดิม)
    if method == "FireServer" and (string.find(self.Name, "Shoot") or string.find(self.Name, "Action")) then
        if Settings.SilentAim then
            local targetPart = nil
            local shortestDist = Settings.FOV
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()

            for _, p in pairs(game.Players:GetPlayers()) do
                local role = getRole(p)
                if role == "Murderer" and p.Character and p.Character:FindFirstChild(Settings.TargetPart) then
                    local pos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(p.Character[Settings.TargetPart].Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                        if dist < shortestDist then
                            targetPart = p.Character[Settings.TargetPart]
                            shortestDist = dist
                        end
                    end
                end
            end

            -- ถ้าพบเป้าหมาย ให้แทนที่ค่าตำแหน่งปลายทาง
            if targetPart then
                -- แก้ไข args[2] โดยไม่สนใจประเภทข้อมูลเดิม (เผื่อเกมส่งเป็น Vector3 หรือ CFrame)
                if args[2] then
                    args[2] = targetPart.CFrame
                    return oldNamecall(self, unpack(args))
                end
            end
        end
    end

    return oldNamecall(self, ...)
end)

-- [[ UI TABS ]] --
local MainTab = Window:CreateTab("Main Settings", 4483362458)

MainTab:CreateToggle({
   Name = "Enable Player Chams (ESP)",
   CurrentValue = true,
   Callback = function(v) Settings.ESP = v end,
})

MainTab:CreateToggle({
   Name = "Murderer Silent Aim",
   CurrentValue = true,
   Callback = function(v) Settings.SilentAim = v end,
})

MainTab:CreateSlider({
   Name = "FOV Radius",
   Range = {50, 800},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) Settings.FOV = v end,
})

-- [[ LOOP UPDATES ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    if Settings.SilentAim then
        FOVCircle.Radius = Settings.FOV
        FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
end)

Rayfield:Notify({Title = "REMOTE HUB", Content = "Script Ready to Use", Duration = 5})
