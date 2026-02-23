local _0x1 = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local _0x2 = _0x1:CreateWindow({Title="REMOTE HUB",SubTitle="by UGO132RE",TabWidth=160,Size=UDim2.fromOffset(580,520),Acrylic=false,Theme="Dark",MinimizeKey=Enum.KeyCode.LeftControl})
local _0x3 = {d=_0x2:AddTab({Title="Home",Icon="home"}),e=_0x2:AddTab({Title="Visuals",Icon="eye"}),f=_0x2:AddTab({Title="Pull Player",Icon="user-plus"}),g=_0x2:AddTab({Title="Misc",Icon="component"})}

local _0xH = {i=false,j=150,k=0.5,lvl=1}
local _0xL = {m=false,n=false,o=Color3.fromRGB(255,0,0)}
local _0xP = 5; local _0xQ = {}; local _0xR = {s=false,t=false}; local _0xS = {t=false}

-- FOV Circle Fix
local _0xF = Drawing.new("Circle")
_0xF.Visible = false
_0xF.Thickness = 1
_0xF.Radius = _0xH.j
_0xF.Filled = false
_0xF.Color = Color3.fromRGB(255,255,255)

local function _0xV() local w = Drawing.new("Line") w.Visible = false; w.Thickness = 1.5; w.Color = _0xL.o; return w end
local function _0xX(y)
    if y == game.Players.LocalPlayer then return end
    local z = Instance.new("Highlight") z.Name = "RH_HL"
    local A = {B=_0xV(),C=_0xV(),D=_0xV(),E=_0xV(),F=_0xV(),G=_0xV(),H=_0xV(),I=_0xV(),J=_0xV(),Sky=_0xV()}
    game:GetService("RunService").RenderStepped:Connect(function()
        if y.Character and y.Character:FindFirstChild("HumanoidRootPart") and y.Character:FindFirstChild("Humanoid") and y.Character.Humanoid.Health > 0 then
            z.Parent = y.Character; z.Enabled = _0xL.m; z.FillColor = _0xL.o
            if _0xL.n then
                local function K(part)
                    local M = y.Character:FindFirstChild(part)
                    if M then
                        local N, O = workspace.CurrentCamera:WorldToViewportPoint(M.Position)
                        return Vector2.new(N.X, N.Y), O, M.Position
                    end
                    return nil, false
                end
                local P, Q, HPos = K("Head")
                local R, S = K("UpperTorso") or K("Torso")
                local T, U = K("LowerTorso") or K("HumanoidRootPart")
                local function al(am, an, ao, ap, aq) if ap and aq then am.From = an; am.To = ao; am.Color = _0xL.o; am.Visible = true else am.Visible = false end end
                -- (Skeleton drawing logic)
                if Q then A.Sky.From = P; A.Sky.To = Vector2.new(P.X, 0); A.Sky.Color = _0xL.o; A.Sky.Visible = true else A.Sky.Visible = false end
            else
                z.Enabled = false; for _, am in pairs(A) do am.Visible = false end
            end
        else
            z.Enabled = false; for _, am in pairs(A) do am.Visible = false end
        end
    end)
end

local function _0xAS(at)
    if not at or at == game.Players.LocalPlayer then return end
    _0xQ[at.UserId] = true
    task.spawn(function()
        while _0xQ[at.UserId] and at.Parent do
            pcall(function()
                local au = game.Players.LocalPlayer.Character.HumanoidRootPart
                local av = at.Character.HumanoidRootPart
                if au and av then av.CFrame = au.CFrame * CFrame.new(0,0,-_0xP) av.Velocity = Vector3.new(0,0,0) end
            end)
            task.wait()
        end
    end)
end

_0x3.d:AddSection("Aimbot Settings")
_0x3.d:AddDropdown("D1", {Title="Aimbot Intensity", Values={"Level 1 (Soft)", "Level 2 (Lock 100%)"}, Default="Level 1 (Soft)", Callback=function(v) _0xH.lvl = (v == "Level 1 (Soft)" and 1 or 2) end})
_0x3.d:AddToggle("T1", {Title="Player Aimbot", Default=false, Callback=function(v) _0xH.i = v; _0xF.Visible = (v or _0xS.t) end})
_0x3.d:AddToggle("T2", {Title="NPC Aimbot", Default=false, Callback=function(v) _0xS.t = v; _0xF.Visible = (_0xH.i or v) end})
_0x3.d:AddInput("I1", {Title="FOV Size", Default="150", Numeric=true, Finished=true, Callback=function(v) local n = tonumber(v) if n then _0xH.j = n; _0xF.Radius = n end end})

_0x3.d:AddSection("Character")
_0x3.d:AddInput("I2", {Title="WalkSpeed", Default="16", Numeric=true, Finished=true, Callback=function(v) if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(v) or 16 end end})
_0x3.d:AddToggle("T3", {Title="Infinite Jump", Default=false, Callback=function(v) _0xR.t = v end})
_0x3.d:AddToggle("T4", {Title="Noclip", Default=false, Callback=function(v) _0xR.s = v end})

_0x3.e:AddSection("ESP")
_0x3.e:AddToggle("T5", {Title="Chams", Default=false, Callback=function(v) _0xL.m = v end})
_0x3.e:AddToggle("T6", {Title="Skeleton + Sky", Default=false, Callback=function(v) _0xL.n = v end})
_0x3.e:AddColorpicker("C1", {Title="ESP Color", Default=Color3.fromRGB(255,0,0), Callback=function(v) _0xL.o = v end})

_0x3.f:AddSection("Player Controls")
_0x3.f:AddButton({Title="Pull All Players", Callback=function() for _,p in pairs(game.Players:GetPlayers()) do _0xAS(p) end end})
_0x3.f:AddButton({Title="Release All", Callback=function() _0xQ = {} end})

_0x3.g:AddButton({Title="Rejoin Server", Callback=function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end})
_0x3.g:AddButton({Title="Infinite Yield", Callback=function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))() end})

local function IsEnemy(tp) if not tp.Team or not game.Players.LocalPlayer.Team then return true end return tp.Team ~= game.Players.LocalPlayer.Team end

game:GetService("RunService").RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    _0xF.Position = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    
    if _0xH.i then
        local target = nil; local dist = _0xH.j;
        for _,p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and IsEnemy(p) and p.Character and p.Character:FindFirstChild("Head") then
                local sp, os = cam:WorldToViewportPoint(p.Character.Head.Position)
                if os then
                    local mag = (Vector2.new(sp.X, sp.Y) - _0xF.Position).Magnitude
                    if mag < dist then dist = mag; target = p end
                end
            end
        end
        if target then
            if _0xH.lvl == 1 then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Character.Head.Position), _0xH.k)
            else cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character.Head.Position) end
        end
    end

    if _0xS.t then
        local tn = nil; local md = _0xH.j;
        for _,obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and not game.Players:GetPlayerFromCharacter(obj) then
                local h = obj:FindFirstChild("Head")
                if h and obj:FindFirstChildOfClass("Humanoid") and obj.Humanoid.Health > 0 then
                    local sp, os = cam:WorldToViewportPoint(h.Position)
                    if os then
                        local mag = (Vector2.new(sp.X, sp.Y) - _0xF.Position).Magnitude
                        if mag < md then md = mag; tn = h end
                    end
                end
            end
        end
        if tn then
            if _0xH.lvl == 1 then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, tn.Position), _0xH.k)
            else cam.CFrame = CFrame.new(cam.CFrame.Position, tn.Position) end
        end
    end
    
    if _0xR.s and game.Players.LocalPlayer.Character then
        for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function() if _0xR.t and game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)
for _,p in pairs(game.Players:GetPlayers()) do _0xX(p) end; game.Players.PlayerAdded:Connect(_0xX)
_0x3.d:Select()
