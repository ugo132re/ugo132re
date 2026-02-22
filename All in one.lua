local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "REMOTE HUB | Professional",
    SubTitle = "by UGO132RE",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Home", Icon = "home" })
}

-- [[ ⚙️ CONFIGURATION - เก็บค่าตัวแปร ]] --
local AimConfig = { Enabled = false, Fov = 150, Smoothness = 0.5 }
local Visuals = { Chams = false, Skeleton = false }

-- [[ 🎯 AIMBOT FOV - เหมือนเดิมเป๊ะ ]] --
local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 1
FOVring.Radius = AimConfig.Fov
FOVring.Filled = false
FOVring.Color = Color3.fromRGB(255, 255, 255)

-- [[ 🏠 UI CONTENT - สร้างปุ่มก่อนเริ่มระบบ ESP เพื่อป้องกันปุ่มหาย ]] --

Tabs.Main:AddSection("Stealth Aimbot")

Tabs.Main:AddToggle("AimToggle", { 
    Title = "Enable Aimbot", 
    Default = false, 
    Callback = function(Value) 
        AimConfig.Enabled = Value 
        FOVring.Visible = Value 
    end 
})

Tabs.Main:AddInput("FovInput", {
    Title = "FOV Size",
    Default = "150",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        local num = tonumber(Value)
        if num then AimConfig.Fov = num FOVring.Radius = num end
    end
})

Tabs.Main:AddSection("Visuals (ESP)")

Tabs.Main:AddToggle("ChamsToggle", { 
    Title = "Enable Chams (เรืองแสง)", 
    Default = false, 
    Callback = function(Value) Visuals.Chams = Value end 
})

Tabs.Main:AddToggle("SkeletonToggle", { 
    Title = "Enable Skeleton (โครงกระดูก)", 
    Default = false, 
    Callback = function(Value) Visuals.Skeleton = Value end 
})

Tabs.Main:AddSection("Character & Tools")

Tabs.Main:AddInput("SpeedInput", {
    Title = "WalkSpeed",
    Default = "16",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        local num = tonumber(Value)
        if num and game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = num
        end
    end
})

Tabs.Main:AddButton({ Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))() end })
Tabs.Main:AddButton({ Title = "Dark Dex V3", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"))() end })

-- [[ 👁️ ESP LOGIC - ทำงานเบื้องหลังหลังจากวาด UI เสร็จ ]] --
local function HandleESP(Player)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "RemoteHub_HL"
    Highlight.FillColor = Color3.fromRGB(255, 0, 0)
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    local Line = Drawing.new("Line")
    Line.Visible = false
    Line.Color = Color3.fromRGB(255, 255, 255)
    Line.Thickness = 1

    game:GetService("RunService").RenderStepped:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            -- Chams
            Highlight.Parent = Player.Character
            Highlight.Enabled = Visuals.Chams
            
            -- Skeleton (Simple Head to Torso)
            if Visuals.Skeleton then
                local Head = Player.Character:FindFirstChild("Head")
                local Torso = Player.Character:FindFirstChild("HumanoidRootPart")
                if Head and Torso then
                    local p1, o1 = workspace.CurrentCamera:WorldToViewportPoint(Head.Position)
                    local p2, o2 = workspace.CurrentCamera:WorldToViewportPoint(Torso.Position)
                    if o1 and o2 then
                        Line.From = Vector2.new(p1.X, p1.Y)
                        Line.To = Vector2.new(p2.X, p2.Y)
                        Line.Visible = true
                    else Line.Visible = false end
                else Line.Visible = false end
            else Line.Visible = false end
        else
            Highlight.Enabled = false
            Line.Visible = false
        end
    end)
end

for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then HandleESP(v) end
end
game.Players.PlayerAdded:Connect(HandleESP)

-- [[ 🔄 SAFE AIM LOOP - ก๊อปปี้จากสคริปต์ปกติของนาย ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    if AimConfig.Enabled then
        local Camera = workspace.CurrentCamera
        FOVring.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local Target = nil
        local Distance = AimConfig.Fov
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
                if OnScreen then
                    local Mag = (Vector2.new(Pos.X, Pos.Y) - FOVring.Position).Magnitude
                    if Mag < Distance then
                        Distance = Mag
                        Target = v
                    end
                end
            end
        end
        if Target then
            local TargetPos = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
            Camera.CFrame = Camera.CFrame:Lerp(TargetPos, AimConfig.Smoothness)
        end
    end
end)

Tabs.Main:Select()
