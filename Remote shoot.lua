-- [[ REMOTE HUB: Murder Mystery Elite Edition ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "REMOTE HUB | V.Special",
   LoadingTitle = "Initializing Remote System...",
   LoadingSubtitle = "by UGO132RE",
   ConfigurationSaving = { Enabled = false }
})

-- [[ VARIABLES ]] --
local fovRadius = 150
local fovEnabled = true
local silentAimEnabled = true
local targetPart = "UpperTorso" -- ยิงไปที่ตัวตามที่นายต้องการ

-- FOV Circle Drawing
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5

-- [[ FUNCTIONS ]] --
local function getMurderer()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Knife") or (v.Backpack:FindFirstChild("Knife")) then
            return v
        end
    end
    return nil
end

local function isInsideFOV(pos)
    local screenPos, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pos)
    if onScreen then
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        return dist <= fovRadius
    end
    return false
end

-- [[ TABS ]] --
local MainTab = Window:CreateTab("Main Hacks", 4483362458)

MainTab:CreateSection("Role Revealer")

MainTab:CreateButton({
   Name = "Scan Roles (Show Who is Murderer)",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           local role = "Innocent"
           if v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife")) then
               role = "MURDERER 🔪"
           elseif v.Backpack:FindFirstChild("Gun") or (v.Character and v.Character:FindFirstChild("Gun")) then
               role = "SHERIFF 🔫"
           end
           Rayfield:Notify({Title = v.Name, Content = "Role: " .. role, Duration = 5})
       end
   end,
})

MainTab:CreateSection("Combat (Silent Aim)")

MainTab:CreateToggle({
   Name = "Enable Silent Aim (Murderer Focus)",
   CurrentValue = true,
   Callback = function(Value) silentAimEnabled = Value end,
})

MainTab:CreateSlider({
   Name = "FOV Radius",
   Range = {50, 800},
   Increment = 10,
   Suffix = "px",
   CurrentValue = 150,
   Callback = function(Value) fovRadius = Value end,
})

-- [[ REMOTE HOOKING (THE CORE) ]] --
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if silentAimEnabled and self.Name == "Shoot" and method == "FireServer" then
        local murderer = getMurderer()
        if murderer and murderer.Character and murderer.Character:FindFirstChild(targetPart) then
            local targetPos = murderer.Character[targetPart].Position
            if isInsideFOV(targetPos) then
                -- แก้ไข args ตัวที่ 2 (จุดกระทบ) ให้พุ่งไปที่ฆาตกรทันที
                args[2] = murderer.Character[targetPart].CFrame
                return oldNamecall(self, table.unpack(args))
            end
        end
    end
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

-- FOV Circle Loop
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Radius = fovRadius
    FOVCircle.Visible = fovEnabled
    FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
end)

Rayfield:Notify({Title = "REMOTE HUB Loaded", Content = "Ready for Hunting!", Duration = 5})
