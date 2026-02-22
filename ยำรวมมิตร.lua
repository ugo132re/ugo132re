local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "REMOTE HUB | Professional",
    SubTitle = "by UGO132RE",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 520),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Home", Icon = "home" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Pull = Window:AddTab({ Title = "Pull Player", Icon = "user-plus" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "component" })
}

-- [[ ⚙️ CONFIGURATION เดิม ]] --
local AimConfig = { Enabled = false, Fov = 150, Smoothness = 0.5 }
local ESPConfig = { Chams = false, Skeleton = false, Color = Color3.fromRGB(255, 0, 0) }
local pullDistance = 5 
local pullingPlayers = {} 
local MiscConfig = { Noclip = false, InfJump = false }

-- [[ 🎯 AIMBOT FOV RING (เดิม) ]] --
local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 1
FOVring.Radius = AimConfig.Fov
FOVring.Filled = false
FOVring.Color = Color3.fromRGB(255, 255, 255)

-- [[ 🎨 ESP LOGIC (เดิม) ]] --
local function CreateLine()
    local L = Drawing.new("Line")
    L.Visible = false
    L.Thickness = 1.5
    L.Color = ESPConfig.Color
    return L
end

local function HandleESP(P)
    if P == game.Players.LocalPlayer then return end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "RH_HL"
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    local Skeleton = {
        H2T = CreateLine(), T2LA = CreateLine(), T2RA = CreateLine(),
        LA2H = CreateLine(), RA2H = CreateLine(), T2LL = CreateLine(),
        T2RL = CreateLine(), LL2F = CreateLine(), RL2F = CreateLine()
    }

    game:GetService("RunService").RenderStepped:Connect(function()
        if P.Character and P.Character:FindFirstChild("HumanoidRootPart") and P.Character:FindFirstChild("Humanoid") and P.Character.Humanoid.Health > 0 then
            Highlight.Parent = P.Character
            Highlight.Enabled = ESPConfig.Chams
            Highlight.FillColor = ESPConfig.Color
            
            if ESPConfig.Skeleton then
                local function GetJoint(Name)
                    local Part = P.Character:FindFirstChild(Name)
                    if Part then
                        local Pos, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(Part.Position)
                        return Vector2.new(Pos.X, Pos.Y), OnScreen
                    end
                    return nil, false
                end

                local Head, oH = GetJoint("Head")
                local UpperTorso, oUT = GetJoint("UpperTorso") or GetJoint("Torso")
                local LowerTorso, oLT = GetJoint("LowerTorso") or GetJoint("HumanoidRootPart")
                local LShoulder, oLS = GetJoint("LeftUpperArm") or GetJoint("Left Arm")
                local RShoulder, oRS = GetJoint("RightUpperArm") or GetJoint("Right Arm")
                local LHand, oLH = GetJoint("LeftHand") or GetJoint("Left Arm")
                local RHand, oRH = GetJoint("RightHand") or GetJoint("Right Arm")
                local LHip, oLHP = GetJoint("LeftUpperLeg") or GetJoint("Left Leg")
                local RHip, oRHP = GetJoint("RightUpperLeg") or GetJoint("Right Leg")
                local LFoot, oLF = GetJoint("LeftFoot") or GetJoint("Left Leg")
                local RFoot, oRF = GetJoint("RightFoot") or GetJoint("Right Leg")

                local function Connect(Line, p1, p2, v1, v2)
                    if v1 and v2 then Line.From = p1 Line.To = p2 Line.Color = ESPConfig.Color Line.Visible = true else Line.Visible = false end
                end

                Connect(Skeleton.H2T, Head, UpperTorso, oH, oUT)
                Connect(Skeleton.T2LA, UpperTorso, LShoulder, oUT, oLS)
                Connect(Skeleton.T2RA, UpperTorso, RShoulder, oUT, oRS)
                Connect(Skeleton.LA2H, LShoulder, LHand, oLS, oLH)
                Connect(Skeleton.RA2H, RShoulder, RHand, oRS, oRH)
                Connect(Skeleton.T2LL, LowerTorso, LHip, oLT, oLHP)
                Connect(Skeleton.T2RL, LowerTorso, RHip, oLT, oRHP)
                Connect(Skeleton.LL2F, LHip, LFoot, oLHP, oLF)
                Connect(Skeleton.RL2F, RHip, RFoot, oRHP, oRF)
            else
                for _, L in pairs(Skeleton) do L.Visible = false end
            end
        else
            Highlight.Enabled = false
            for _, L in pairs(Skeleton) do L.Visible = false end
        end
    end)
end

-- [[ 🧲 PULL LOGIC (เดิม) ]] --
local function PullTarget(targetPlayer)
    if not targetPlayer or targetPlayer == game.Players.LocalPlayer then return end
    pullingPlayers[targetPlayer.UserId] = true
    task.spawn(function()
        while pullingPlayers[targetPlayer.UserId] and targetPlayer.Parent do
            pcall(function()
                local myRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
                local targetRoot = targetPlayer.Character.HumanoidRootPart
                if myRoot and targetRoot then
                    targetRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -pullDistance)
                    targetRoot.Velocity = Vector3.new(0, 0, 0)
                end
            end)
            task.wait()
        end
    end)
end

-- [[ 🏠 HOME TAB ]] --
Tabs.Main:AddSection("Stealth Aimbot")
Tabs.Main:AddToggle("AimToggle", { Title = "Enable Aimbot", Default = false, Callback = function(V) AimConfig.Enabled = V FOVring.Visible = V end })
Tabs.Main:AddInput("FovInput", { Title = "FOV Size", Default = "150", Numeric = true, Finished = true, Callback = function(V) local n = tonumber(V) if n then AimConfig.Fov = n FOVring.Radius = n end end })

Tabs.Main:AddSection("Character")
Tabs.Main:AddInput("SpeedInput", { Title = "WalkSpeed", Default = "16", Numeric = true, Finished = true, Callback = function(V) if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(V) or 16 end end })
Tabs.Main:AddToggle("InfJump", { Title = "Infinite Jump", Default = false, Callback = function(V) MiscConfig.InfJump = V end })
Tabs.Main:AddToggle("Noclip", { Title = "Noclip", Default = false, Callback = function(V) MiscConfig.Noclip = V end })

-- [[ 👁️ VISUALS TAB ]] --
Tabs.Visuals:AddToggle("ChamsToggle", { Title = "Enable Chams", Default = false, Callback = function(V) ESPConfig.Chams = V end })
Tabs.Visuals:AddToggle("SkeletonToggle", { Title = "Enable Skeleton", Default = false, Callback = function(V) ESPConfig.Skeleton = V end })
Tabs.Visuals:AddColorpicker("ESPColor", { Title = "ESP Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(V) ESPConfig.Color = V end })

-- [[ 👤 PULL TAB ]] --
Tabs.Pull:AddInput("PullDistInput", { Title = "Distance", Default = "5", Numeric = true, Finished = true, Callback = function(V) pullDistance = tonumber(V) or 5 end })
Tabs.Pull:AddButton({ Title = "Pull All", Callback = function() for _, p in ipairs(game.Players:GetPlayers()) do PullTarget(p) end end })
Tabs.Pull:AddButton({ Title = "Release All", Callback = function() pullingPlayers = {} end })

-- [[ 📦 MISC TAB ]] --
Tabs.Misc:AddSection("Server Tools")
Tabs.Misc:AddButton({ Title = "Rejoin Server", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end })
Tabs.Misc:AddButton({ Title = "Server Hop", Callback = function() 
    local Http = game:GetService("HttpService")
    local tps = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
    local s = Http:JSONDecode(game:HttpGet(Api))
    for _, v in pairs(s.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            tps:TeleportToPlaceInstance(game.PlaceId, v.id)
            break
        end
    end
end })

Tabs.Misc:AddSection("Utility")
Tabs.Misc:AddButton({ Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))() end })

-- [[ 🔄 SYSTEM LOOPS ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    if AimConfig.Enabled then
        local Camera = workspace.CurrentCamera
        FOVring.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local Target = nil
        local Distance = AimConfig.Fov
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
                if OnScreen then
                    local Mag = (Vector2.new(Pos.X, Pos.Y) - FOVring.Position).Magnitude
                    if Mag < Distance then Distance = Mag Target = v end
                end
            end
        end
        if Target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position), AimConfig.Smoothness) end
    end

    if MiscConfig.Noclip then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if MiscConfig.InfJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

for _, v in pairs(game.Players:GetPlayers()) do HandleESP(v) end
game.Players.PlayerAdded:Connect(HandleESP)
Tabs.Main:Select()
