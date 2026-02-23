-- [[ REMOTE HUB RECOVERY V5 ]] --
repeat task.wait() until game:IsLoaded()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local _0xW = Fluent:CreateWindow({
    Title = "REMOTE HUB",
    SubTitle = "by UGO132RE",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 520),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local _0xT = {
    h = _0xW:AddTab({ Title = "Home", Icon = "home" }),
    v = _0xW:AddTab({ Title = "Visuals", Icon = "eye" }),
    p = _0xW:AddTab({ Title = "Pull Player", Icon = "user-plus" }),
    m = _0xW:AddTab({ Title = "Misc", Icon = "component" })
}

local _0xO = {i = false, fov = 150, lvl = 1, tc = true, led = false}
local _0xV = {chams = false, skel = false, col = Color3.fromRGB(255, 0, 0)}
local _0xR = {speed = 16, jump = false, noclip = false}
local _0xTarget = nil

local _0xF = Drawing.new("Circle")
_0xF.Visible = false
_0xF.Thickness = 1
_0xF.Radius = _0xO.fov
_0xF.Filled = false
_0xF.Color = Color3.fromRGB(255, 255, 255)

local function _0xL()
    local l = Drawing.new("Line")
    l.Visible = false
    l.Thickness = 1.5
    return l
end

local function _0xESP(p)
    if p == game.Players.LocalPlayer then return end
    local h = Instance.new("Highlight")
    h.Name = "RH_ESP"
    local lines = {sky = _0xL()}
    
    game:GetService("RunService").RenderStepped:Connect(function()
        local c = (_0xO.led and Color3.fromHSV(tick() % 5 / 5, 1, 1) or _0xV.col)
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            h.Parent = p.Character
            h.Enabled = _0xV.chams
            h.FillColor = c
            
            local head = p.Character:FindFirstChild("Head")
            if head and _0xV.skel then
                local pos, on = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                if on then
                    lines.sky.From = Vector2.new(pos.X, pos.Y)
                    lines.sky.To = Vector2.new(pos.X, 0)
                    lines.sky.Color = c
                    lines.sky.Visible = true
                else lines.sky.Visible = false end
            else lines.sky.Visible = false end
        else
            h.Enabled = false
            lines.sky.Visible = false
        end
    end)
end

-- [[ UI ELEMENTS ]] --
_0xT.h:AddSection("Aimbot")
_0xT.h:AddDropdown("D1", {Title = "Intensity", Values = {"Level 1", "Level 2"}, Default = "Level 1", Callback = function(v) _0xO.lvl = (v == "Level 1" and 1 or 2) end})
_0xT.h:AddToggle("T1", {Title = "Player Aimbot", Default = false, Callback = function(v) _0xO.i = v; _0xF.Visible = v end})
_0xT.h:AddToggle("T2", {Title = "Team Check", Default = true, Callback = function(v) _0xO.tc = v end})
_0xT.h:AddToggle("T3", {Title = "LED Effect", Default = false, Callback = function(v) _0xO.led = v end})
_0xT.h:AddInput("I1", {Title = "FOV Size", Default = "150", Callback = function(v) _0xO.fov = tonumber(v) or 150; _0xF.Radius = _0xO.fov end})

_0xT.h:AddSection("Character")
_0xT.h:AddInput("I2", {Title = "WalkSpeed", Default = "16", Callback = function(v) _0xR.speed = tonumber(v) or 16 end})
_0xT.h:AddToggle("T4", {Title = "Inf Jump", Default = false, Callback = function(v) _0xR.jump = v end})
_0xT.h:AddToggle("T5", {Title = "Noclip", Default = false, Callback = function(v) _0xR.noclip = v end})

_0xT.v:AddSection("Visuals")
_0xT.v:AddToggle("V1", {Title = "Chams", Default = false, Callback = function(v) _0xV.chams = v end})
_0xT.v:AddToggle("V2", {Title = "Skeleton + Sky", Default = false, Callback = function(v) _0xV.skel = v end})
_0xT.v:AddColorpicker("C1", {Title = "Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(v) _0xV.col = v end})

_0xT.p:AddSection("Pull System")
local _0xPL = {}
for _, p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer then table.insert(_0xPL, p.Name) end end
local _0xPD = _0xT.p:AddDropdown("D2", {Title = "Select Player", Values = _0xPL, Default = ""})
_0xT.p:AddButton({Title = "Pull Selected", Callback = function()
    local target = game.Players:FindFirstChild(_0xPD.Value)
    if target and target.Character then
        _G.Pulling = target.UserId
        task.spawn(function()
            while _G.Pulling == target.UserId do
                pcall(function()
                    target.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
                end)
                task.wait()
            end
        end)
    end
end})
_0xT.p:AddButton({Title = "Release", Callback = function() _G.Pulling = nil end})

_0xT.m:AddSection("Misc")
_0xT.m:AddButton({Title = "Rejoin", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end})
_0xT.m:AddButton({Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))() end})

-- [[ MAIN LOOP ]] --
game:GetService("RunService").RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    local rb = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    
    _0xF.Position = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    _0xF.Color = (_0xO.led and rb or Color3.fromRGB(255,255,255))
    
    if _0xO.i then
        local t = nil; local m = _0xO.fov
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                if _0xO.tc and p.Team == game.Players.LocalPlayer.Team then continue end
                local s, o = cam:WorldToViewportPoint(p.Character.Head.Position)
                if o then
                    local d = (Vector2.new(s.X, s.Y) - _0xF.Position).Magnitude
                    if d < m then m = d; t = p.Character.Head end
                end
            end
        end
        if t then cam.CFrame = CFrame.new(cam.CFrame.Position, t.Position) end
    end
    
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _0xR.speed
        if _0xR.noclip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _0xR.jump and game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

for _, p in pairs(game.Players:GetPlayers()) do _0xESP(p) end
game.Players.PlayerAdded:Connect(_0xESP)
_0xW:SelectTab(_0xT.h)
