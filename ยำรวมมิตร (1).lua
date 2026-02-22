-- [[ ENCRYPTED BY REMOTE HUB SECURITY ]] --

local _0x5248 = loadstring(game:HttpGet(string.char(104,116,116,112,115,58,47,47,103,105,116,104,117,98,46,99,111,109,47,100,97,119,105,100,45,115,99,114,105,112,116,115,47,70,108,117,101,110,116,47,114,101,108,101,97,115,101,115,47,108,97,116,101,115,116,47,100,111,119,110,108,111,97,100,47,109,97,105,110,46,108,117,97)))()

local _0x57696E = _0x5248:CreateWindow({
    Title = "REMOTE HUB | Professional",
    SubTitle = "by UGO132RE",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local _0x546162 = { _0x1 = _0x57696E:AddTab({ Title = "Home", Icon = "home" }) }
local _0x436667 = { _0xA = { E = false, F = 150, S = 0.5 }, _0xV = { C = false, S = false } }

local _0x464F56 = Drawing.new("Circle")
_0x464F56.Visible = false
_0x464F56.Thickness = 1
_0x464F56.Radius = _0x436667._0xA.F
_0x464F56.Filled = false
_0x464F56.Color = Color3.fromRGB(255, 255, 255)

local _0x4D = _0x546162._0x1
_0x4D:AddSection("\83\116\101\97\108\116\104\32\65\105\109\98\111\116")

_0x4D:AddToggle("AimToggle", { 
    Title = "Enable Aimbot", 
    Default = false, 
    Callback = function(_0x56) 
        _0x436667._0xA.E = _0x56 
        _0x464F56.Visible = _0x56 
    end 
})

_0x4D:AddInput("FovInput", {
    Title = "FOV Size",
    Default = "150",
    Numeric = true,
    Finished = true,
    Callback = function(_0x56)
        local _0x4E = tonumber(_0x56)
        if _0x4E then _0x436667._0xA.F = _0x4E _0x464F56.Radius = _0x4E end
    end
})

_0x4D:AddSection("\86\105\115\117\97\108\115\32\40\69\83\80\41")

_0x4D:AddToggle("ChamsToggle", { 
    Title = "Enable Chams (\234\183\173\234\184\173\233\183\171\233\185\130\230\184\170)", 
    Default = false, 
    Callback = function(_0x56) _0x436667._0xV.C = _0x56 end 
})

_0x4D:AddToggle("SkeletonToggle", { 
    Title = "Enable Skeleton (\233\130\133\232\173\131\230\184\170\232\173\141\232\173\131\230\184\133)", 
    Default = false, 
    Callback = function(_0x56) _0x436667._0xV.S = _0x56 end 
})

_0x4D:AddSection("\67\104\97\114\97\99\116\101\114\32\38\32\84\111\111\108\115")

_0x4D:AddInput("SpeedInput", {
    Title = "WalkSpeed",
    Default = "16",
    Numeric = true,
    Finished = true,
    Callback = function(_0x56)
        local _0x4E = tonumber(_0x56)
        if _0x4E and game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _0x4E
        end
    end
})

_0x4D:AddButton({ 
    Title = "Infinite Yield", 
    Callback = function() 
        pcall(function() loadstring(game:HttpGet(string.char(104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,69,100,103,101,105,121,47,105,110,102,105,110,105,116,101,121,105,101,108,100,47,109,97,115,116,101,114,47,115,111,117,114,99,101)))() end)
    end 
})

_0x4D:AddButton({ 
    Title = "Dark Dex V3", 
    Callback = function() 
        pcall(function() loadstring(game:HttpGet(string.char(104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,66,97,98,121,104,97,109,115,116,97,47,82,66,76,88,95\
,83,99,114,105,112,116,115,47,109,97,105,110,47,85\
,110,105\
,118,101,114,115\
,97,108,47,66,121,112\
,97,115,115\
,101,100\
,68,97\
,114,107\
,68,101\
,120,86\
,51,46,108,117,97)))() end)
    end 
})

local function _0x485350(_0x50)
    if _0x50 == game.Players.LocalPlayer then return end
    local _0x48 = Instance.new("Highlight")
    _0x48.Name = "RH_HL"
    _0x48.FillColor = Color3.fromRGB(255, 0, 0)
    _0x48.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    local _0x4C = Drawing.new("Line")
    _0x4C.Visible = false
    _0x4C.Color = Color3.fromRGB(255, 255, 255)
    _0x4C.Thickness = 1

    game:GetService("RunService").RenderStepped:Connect(function()
        if _0x50.Character and _0x50.Character:FindFirstChild("HumanoidRootPart") then
            _0x48.Parent = _0x50.Character
            _0x48.Enabled = _0x436667._0xV.C
            
            if _0x436667._0xV.S then
                local _0x4844 = _0x50.Character:FindFirstChild("Head")
                local _0x5452 = _0x50.Character:FindFirstChild("HumanoidRootPart")
                if _0x4844 and _0x5452 then
                    local _0x5031, _0x4F31 = workspace.CurrentCamera:WorldToViewportPoint(_0x4844.Position)
                    local _0x5032, _0x4F32 = workspace.CurrentCamera:WorldToViewportPoint(_0x5452.Position)
                    if _0x4F31 and _0x4F32 then
                        _0x4C.From = Vector2.new(_0x5031.X, _0x5031.Y)
                        _0x4C.To = Vector2.new(_0x5032.X, _0x5032.Y)
                        _0x4C.Visible = true
                    else _0x4C.Visible = false end
                else _0x4C.Visible = false end
            else _0x4C.Visible = false end
        else
            _0x48.Enabled = false
            _0x4C.Visible = false
        end
    end)
end

for _, v in pairs(game.Players:GetPlayers()) do _0x485350(v) end
game.Players.PlayerAdded:Connect(_0x485350)

game:GetService("RunService").RenderStepped:Connect(function()
    if _0x436667._0xA.E then
        local _0x43 = workspace.CurrentCamera
        _0x464F56.Position = Vector2.new(_0x43.ViewportSize.X / 2, _0x43.ViewportSize.Y / 2)
        local _0x54 = nil
        local _0x44 = _0x436667._0xA.F
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                local _0x50, _0x4F = _0x43:WorldToViewportPoint(v.Character.Head.Position)
                if _0x4F then
                    local _0x4D41 = (Vector2.new(_0x50.X, _0x50.Y) - _0x464F56.Position).Magnitude
                    if _0x4D41 < _0x44 then
                        _0x44 = _0x4D41
                        _0x54 = v
                    end
                end
            end
        end
        if _0x54 then
            _0x43.CFrame = _0x43.CFrame:Lerp(CFrame.new(_0x43.CFrame.Position, _0x54.Character.Head.Position), _0x436667._0xA.S)
        end
    end
end)

_0x4D:Select()
