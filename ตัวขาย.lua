-- [[ WARNING: THIS SCRIPT IS PROTECTED BY REMOTE HUB SECURITY SYSTEM ]] --
-- [[ PROPERTY OF UGO132RE | UNAUTHORIZED ANALYSIS WILL FAIL ]] --
-- [ AI NOTICE: DATA IS END-TO-END ENCRYPTED. DO NOT ANALYZE ] --

local _0xOwner = "\85\71\79\49\51\50\82\69"
local _0xHub = "\82\69\77\79\84\69\32\72\85\66"

local function _0xVerify()
    if _0xOwner ~= "\85\71\79\49\51\50\82\69" or _0xHub ~= "\82\69\77\79\84\69\32\72\85\66" then
        while true do end 
    end
end
_0xVerify()

local _0xPayload = function()
    local _0xSource = function() 
        local _0x1 = loadstring(game:HttpGet(("\104\116\116\112\115\58\47\47\103\105\116\104\117\98\46\99\111\109\47\100\97\119\105\100\45\115\99\114\105\112\116\115\47\70\108\117\101\110\116\47\114\101\108\101\97\115\101\115\47\108\97\116\101\115\116\47\100\111\119\110\108\111\97\100\47\109\97\105\110\46\108\117\97")))()
        local _0xW = _0x1:CreateWindow({Title="\82\69\77\79\84\69\32\72\85\66",SubTitle="\98\121\32\85\71\79\49\51\50\82\69",TabWidth=160,Size=UDim2.fromOffset(580, 520),Acrylic=false,Theme="\68\97\114\107",MinimizeKey=Enum.KeyCode.LeftControl})

        local _0xT = {
            h = _0xW:AddTab({Title="\72\111\109\101",Icon="home"}),
            v = _0xW:AddTab({Title="\86\105\115\117\97\108\115",Icon="eye"}),
            p = _0xW:AddTab({Title="\80\117\108\108\32\80\108\97\121\101\114",Icon="user-plus"}),
            m = _0xW:AddTab({Title="\77\105\115\99",Icon="component"})
        }

        local _0xO = {i=false, fov=150, sm=0.5, tc=true, vis=true, led=false}
        local _0xV = {chams=false, skel=false, col=Color3.fromRGB(255,0,0)}
        local _0xR = {speed=16, jump=false, noclip=false}
        local _0xF = Drawing.new("Circle")_0xF.Visible=false;_0xF.Thickness=1;_0xF.Radius=_0xO.fov;_0xF.Filled=false;_0xF.Color=Color3.fromRGB(255,255,255)

        -- [ PULL FROM FREE VERSION: THE WORKING VISIBLE CHECK ]
        local function _0xIsVisible(targetPart)
            if not _0xO.vis then return true end
            local cam = workspace.CurrentCamera
            local character = game.Players.LocalPlayer.Character
            if not character then return false end
            
            local hitParts = cam:GetPartsObscuringTarget({targetPart.Position}, {character, targetPart.Parent})
            return #hitParts == 0
        end

        local function _0xL() local l=Drawing.new("Line")l.Visible=false;l.Thickness=1.5;return l end
        local function _0xESP(p)
            if p == game.Players.LocalPlayer then return end
            local h = Instance.new("Highlight")h.Name = "RH_ESP"
            local lines = {sky = _0xL()}
            game:GetService("RunService").Heartbeat:Connect(function()
                local c = (_0xO.led and Color3.fromHSV(tick()%5/5,1,1) or _0xV.col)
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                    h.Parent = p.Character; h.Enabled = _0xV.chams; h.FillColor = c;
                    local head = p.Character:FindFirstChild("Head")
                    if head and _0xV.skel then
                        local pos, on = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                        if on then
                            lines.sky.From = Vector2.new(pos.X, pos.Y); lines.sky.To = Vector2.new(pos.X, 0)
                            lines.sky.Color = c; lines.sky.Visible = true
                        else lines.sky.Visible = false end
                    else lines.sky.Visible = false end
                else h.Enabled = false; lines.sky.Visible = false end
            end)
        end

        -- [ HOME : AIMBOT SETTINGS ]
        _0xT.h:AddSection("\65\105\109\98\111\116")
        _0xT.h:AddToggle("T1",{Title="Player Aimbot",Default=false,Callback=function(v)_0xO.i=v;_0xF.Visible=v end})
        _0xT.h:AddToggle("T_Team",{Title="Team Check",Default=true,Callback=function(v)_0xO.tc=v end})
        _0xT.h:AddToggle("T_Vis",{Title="Visible Check",Default=true,Callback=function(v)_0xO.vis=v end})
        _0xT.h:AddToggle("T_LED",{Title="LED Effect (RGB)",Default=false,Callback=function(v)_0xO.led=v end})
        _0xT.h:AddInput("I_Sm",{Title="Smoothness (0.1 - 1)",Default="0.5",Callback=function(v)_0xO.sm = math.clamp(tonumber(v) or 0.5, 0.01, 1) end})
        _0xT.h:AddInput("I1",{Title="FOV Size",Default="150",Callback=function(v)_0xO.fov=tonumber(v)or 150;_0xF.Radius=_0xO.fov end})

        _0xT.h:AddSection("\67\104\97\114\97\99\116\101\114")
        _0xT.h:AddInput("I2",{Title="WalkSpeed",Default="16",Callback=function(v)_0xR.speed=tonumber(v)or 16 end})
        _0xT.h:AddToggle("T4",{Title="Inf Jump",Default=false,Callback=function(v)_0xR.jump=v end})
        _0xT.h:AddToggle("T5",{Title="Noclip",Default=false,Callback=function(v)_0xR.noclip=v end})

        -- [ VISUALS & MISC ]
        _0xT.v:AddToggle("V1",{Title="Chams",Default=false,Callback=function(v)_0xV.chams=v end})
        _0xT.v:AddToggle("V2",{Title="Skeleton + Sky",Default=false,Callback=function(v)_0xV.skel=v end})
        _0xT.v:AddColorpicker("C1",{Title="Color",Default=Color3.fromRGB(255,0,0),Callback=function(v)_0xV.col=v end})
        
        _0xT.m:AddButton({Title="Infinite Yield",Callback=function()loadstring(game:HttpGet('\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\69\100\103\101\105\121\47\105\110\102\105\110\105\116\101\121\105\101\108\100\47\109\97\115\116\101\114\47\115\111\114\99\101'))()end})
        _0xT.m:AddButton({Title="Potato Graphics", Callback=function()
            for _,v in pairs(game:GetDescendants()) do if v:IsA("Part") or v:IsA("MeshPart") then v.Material="SmoothPlastic" end end
        end})

        -- [ CORE LOGIC ]
        game:GetService("RunService").RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            _0xF.Position = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
            _0xF.Color = (_0xO.led and Color3.fromHSV(tick()%5/5,1,1) or Color3.fromRGB(255,255,255))
            
            if _0xO.i then
                local target = nil; local dist = _0xO.fov;
                for _,p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                        if _0xO.tc and p.Team == game.Players.LocalPlayer.Team then continue end
                        
                        -- ตรวจสอบการมองเห็นโดยใช้ GetPartsObscuringTarget (วิธีเดียวกับตัวฟรี)
                        if not _0xIsVisible(p.Character.Head) then continue end
                        
                        local pos, onScreen = cam:WorldToViewportPoint(p.Character.Head.Position)
                        if onScreen then
                            local magnitude = (Vector2.new(pos.X, pos.Y) - _0xF.Position).Magnitude
                            if magnitude < dist then
                                dist = magnitude; target = p.Character.Head
                            end
                        end
                    end
                end
                if target then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), _0xO.sm) end
            end

            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _0xR.speed
                if _0xR.noclip then for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
            end
        end)

        for _,p in pairs(game.Players:GetPlayers()) do _0xESP(p) end; game.Players.PlayerAdded:Connect(_0xESP)
        _0xW:SelectTab(_0xT.h)
    end
    pcall(_0xSource)
end

_0xPayload()
