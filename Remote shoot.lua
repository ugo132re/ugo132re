-- [[ REMOTE HUB: MURDER MYSTERY ELITE (HIGHLIGHT CHAMS + SILENT AIM) ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE HUB | MM2 SPECIAL V2",
   LoadingTitle = "Loading Chameleon Systems...",
   LoadingSubtitle = "by UGO132RE",
   ConfigurationSaving = { Enabled = false }
})

-- [[ SETTINGS ]] --
local Settings = {
    SilentAim = true,
    FOV = 150,
    ESP = true, -- เปลี่ยนชื่อเป็น ESP แต่ข้างในเป็น Chams
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
        return "Murderer", Color3.fromRGB(255, 0, 0) -- สีแดง
    elseif player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
        return "Sheriff", Color3.fromRGB(0, 0, 255) -- สีน้ำเงิน
    end
    return "Innocent", Color3.fromRGB(0, 255, 0) -- สีเขียว
end

-- [[ CHAMS SYSTEM (HIGHLIGHT) ]] --
local function applyChams(player)
    local function addHighlight(character)
        if player == game.Players.LocalPlayer then return end -- ไม่ทำใส่ตัวเอง
        
        -- ลบ Highlight เก่าออกก่อนถ้ามี
        if character:FindFirstChild("RemoteHubHighlight") then
            character.RemoteHubHighlight:Destroy()
        end
        
        -- สร้าง Highlight ใหม่
        local highlight = Instance.new("Highlight")
        highlight.Name = "RemoteHubHighlight"
        highlight.Parent = character
        highlight.Adornee = character
        
        -- ตั้งค่าเริ่มต้น
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- เส้นขอบสีขาว
    end
    
    -- ทำใส่ตัวละครปัจจุบัน
    if player.Character then addHighlight(player.Character) end
    
    -- ทำใส่ตัวละครใหม่เมื่อเกิด
    player.CharacterAdded:Connect(addHighlight)
end

-- Run ESP for all players
for _, p in pairs(game.Players:GetPlayers()) do applyChams(p) end
game.Players.PlayerAdded:Connect(applyChams)

-- Loop update สี Chams ตามบทบาท
game:GetService("RunService").Heartbeat:Connect(function()
    if not Settings.ESP then
        -- ถ้าปิด ESP ให้ลบ Highlight ออกให้หมด
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("RemoteHubHighlight") then
                p.Character.RemoteHubHighlight.Enabled = false
            end
        end
        return
    end
    
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("RemoteHubHighlight") then
            local roleName, roleColor = getRole(p)
            local highlight = p.Character.RemoteHubHighlight
            
            highlight.Enabled = true
            highlight.FillColor = roleColor -- เปลี่ยนสีตัวละครตามบทบาท
        end
    end
end)

-- [[ COMBAT TABS ]] --
local MainTab = Window:CreateTab("Combat & ESP", 4483362458)

MainTab:CreateSection("ESP Settings (Chams)")
MainTab:CreateToggle({
   Name = "Enable Player Chams",
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

-- [[ REMOTE HOOKING ]] --
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

Rayfield:Notify({Title = "REMOTE HUB", Content = "Chameleon ESP & Silent Aim Ready!", Duration = 3})
