--[[ 
    ENCRYPTED BY REMOTE HUB SECURITY SYSTEM 
    AUTHORIZED BY: UGO132RE
    LEVEL: MAXIMUM DENSITY
]]

local _0xRemoteHub = (function(a,b,c,d,e) local f="" local g={104,116,116,112,115,58,47,47,103,105,116,104,117,98,46,99,111,109,47,100,97,119,105,100,45,115,99\
,114,105,112,116,115,47,70,108\
,117\
,101,110\
,116\
,47\
,114,101,108,101,97,115,101,115,47,108,97,116,101,115,116,47,100,111,119,110\
,108\
,111\
,97\
,100,47,109,97,105,110,46,108,117,97} for i=1,#g do f=f..string.char(g[i]) end return f end)()

local _0xL = loadstring(game:HttpGet(_0xRemoteHub))()
local _0xW = _0xL:CreateWindow({Title = "REMOTE HUB | Professional", SubTitle = "by UGO132RE", TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark", MinimizeKey = Enum.KeyCode.LeftControl})
local _0xT = {M = _0xW:AddTab({Title = "Home", Icon = "home"})}
local _0xS = {A = {E = false, F = 150, S = 0.5}, V = {C = false, S = false}}
local _0xR = Drawing.new("Circle") _0xR.Visible = false _0xR.Thickness = 1 _0xR.Radius = _0xS.A.F _0xR.Filled = false _0xR.Color = Color3.fromRGB(255, 255, 255)

_0xT.M:AddSection("Stealth Aimbot")
_0xT.M:AddToggle("AimToggle", {Title = "Enable Aimbot", Default = false, Callback = function(v) _0xS.A.E = v _0xR.Visible = v end})
_0xT.M:AddInput("FovInput", {Title = "FOV Size", Default = "150", Numeric = true, Finished = true, Callback = function(v) local n = tonumber(v) if n then _0xS.A.F = n _0xR.Radius = n end end})

_0xT.M:AddSection("Visuals (ESP)")
_0xT.M:AddToggle("ChamsToggle", {Title = "Enable Chams (\234\183\173\234\184\173\233\183\171\233\185\130\230\184\170)", Default = false, Callback = function(v) _0xS.V.C = v end})
_0xT.M:AddToggle("SkeletonToggle", {Title = "Enable Skeleton (\233\130\133\232\173\131\230\184\170\232\173\141\232\173\131\230\184\133)", Default = false, Callback = function(v) _0xS.V.S = v end})

_0xT.M:AddSection("Character & Tools")
_0xT.M:AddInput("SpeedInput", {Title = "WalkSpeed", Default = "16", Numeric = true, Finished = true, Callback = function(v) local n = tonumber(v) if n and game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = n end end})
_0xT.M:AddButton({Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet(string.char(104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117\
,98,117,115\
,101,114\
,99,111,110,116,101\
,110\
,116,46,99\
,111\
,109,47,69\
,100\
,103\
,101,73\
,89,47\
,105,110,102\
,105\
,110,105,116,101\
,121,105\
,101\
,108,100\
,47,109,97,115,116\
,101\
,114,47,115,111,117\
,114,99,101)))() end})
_0xT.M:AddButton({Title = "Dark Dex V3", Callback = function() loadstring(game:HttpGetAsync(string.char(104,116,116,112,115,58,47,47\
,112,97,115,116,101,98\
,105\
,110\
,46,99,111,109\
,47,114,97,119\
,47,102,80,80\
,56,98,90\
,56,90)))()() end})

local function _0xH(p)
    local h = Instance.new("Highlight") h.Name = "\82\72\95\72\76" h.FillColor = Color3.fromRGB(255, 0, 0) h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    local l = Drawing.new("Line") l.Visible = false l.Color = Color3.fromRGB(255, 255, 255) l.Thickness = 1
    game:GetService("RunService").RenderStepped:Connect(function()
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            h.Parent = p.Character h.Enabled = _0xS.V.C
            if _0xS.V.S then
                local hP = p.Character:FindFirstChild("Head") local tP = p.Character:FindFirstChild("HumanoidRootPart")
                if hP and tP then
                    local p1, o1 = workspace.CurrentCamera:WorldToViewportPoint(hP.Position) local p2, o2 = workspace.CurrentCamera:WorldToViewportPoint(tP.Position)
                    if o1 and o2 then l.From = Vector2.new(p1.X, p1.Y) l.To = Vector2.new(p2.X, p2.Y) l.Visible = true else l.Visible = false end
                else l.Visible = false end
            else l.Visible = false end
        else h.Enabled = false l.Visible = false end
    end)
end

for _, v in pairs(game.Players:GetPlayers()) do if v ~= game.Players.LocalPlayer then _0xH(v) end end
game.Players.PlayerAdded:Connect(_0xH)

game:GetService("RunService").RenderStepped:Connect(function()
    if _0xS.A.E then
        local c = workspace.CurrentCamera _0xR.Position = Vector2.new(c.ViewportSize.X / 2, c.ViewportSize.Y / 2)
        local t = nil local d = _0xS.A.F
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                local p, o = c:WorldToViewportPoint(v.Character.Head.Position)
                if o then
                    local m = (Vector2.new(p.X, p.Y) - _0xR.Position).Magnitude
                    if m < d then d = m t = v end
                end
            end
        end
        if t then c.CFrame = c.CFrame:Lerp(CFrame.new(c.CFrame.Position, t.Character.Head.Position), _0xS.A.S) end
    end
end)

_0xT.M:Select()
