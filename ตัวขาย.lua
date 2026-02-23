-- [[ REMOTE HUB ACTIVATED ]] --
local _0x1=loadstring(game:HttpGet(("\104\116\116\112\115\58\47\47\103\105\116\104\117\98\46\99\111\109\47\100\97\119\105\100\45\115\99\114\105\112\116\115\47\70\108\117\101\110\116\47\114\101\108\101\97\115\101\115\47\108\97\116\101\115\116\47\100\111\119\110\108\111\97\100\47\109\97\105\110\46\108\117\97")))()
local _0x2=_0x1:CreateWindow({Title="REMOTE HUB",SubTitle="by UGO132RE",TabWidth=160,Size=UDim2.fromOffset(580,520),Acrylic=false,Theme="Dark",MinimizeKey=Enum.KeyCode.LeftControl})
local _0x3={d=_0x2:AddTab({Title="Home",Icon="home"}),e=_0x2:AddTab({Title="Visuals",Icon="eye"}),f=_0x2:AddTab({Title="Pull Player",Icon="user-plus"}),g=_0x2:AddTab({Title="Misc",Icon="component"})}

local _0xH={i=false,j=150,k=1,lvl=1,team=true,rgb=false}
local _0xL={m=false,n=false,o=Color3.fromRGB(255,0,0)}
local _0xP=5;local _0xQ={}local _0xR={s=false,t=false}local _0xS={t=false}
local _0xF=Drawing.new("Circle")_0xF.Visible=false;_0xF.Thickness=1;_0xF.Radius=_0xH.j;_0xF.Filled=false;_0xF.Color=_0xL.o

local function _0xV()local w=Drawing.new("Line")w.Visible=false;w.Thickness=1.5;w.Color=_0xL.o;return w end
local function _0xX(y)
    if y==game.Players.LocalPlayer then return end;
    local z=Instance.new("Highlight")z.Name="RH_HL"
    local A={B=_0xV(),C=_0xV(),D=_0xV(),E=_0xV(),F=_0xV(),G=_0xV(),H=_0xV(),I=_0xV(),J=_0xV(),Sky=_0xV()}
    game:GetService("RunService").RenderStepped:Connect(function()
        local _0xColor = _0xH.rgb and Color3.fromHSV(tick()%5/5,1,1) or _0xL.o
        if y.Character and y.Character:FindFirstChild("HumanoidRootPart") and y.Character.Humanoid.Health>0 then 
            z.Parent=y.Character;z.Enabled=_0xL.m;z.FillColor=_0xColor;
            if _0xL.n then 
                local function K(part)
                    local M=y.Character:FindFirstChild(part)
                    if M then 
                        local N,O=workspace.CurrentCamera:WorldToViewportPoint(M.Position)
                        return Vector2.new(N.X,N.Y),O,M.Position 
                    end;return nil,false 
                end;
                local P,Q,HPos=K("Head")
                if Q then 
                    A.Sky.From=P;A.Sky.To=Vector2.new(P.X,0)A.Sky.Color=_0xColor;A.Sky.Visible=true 
                else A.Sky.Visible=false end 
            else z.Enabled=false;for _,am in pairs(A)do am.Visible=false end end 
        else z.Enabled=false;for _,am in pairs(A)do am.Visible=false end end 
    end)
end

local function _0xAS(at)
    if not at or at==game.Players.LocalPlayer then return end;_0xQ[at.UserId]=true;
    task.spawn(function()
        while _0xQ[at.UserId]and at.Parent do 
            pcall(function()
                local au=game.Players.LocalPlayer.Character.HumanoidRootPart;local av=at.Character.HumanoidRootPart;
                if au and av then av.CFrame=au.CFrame*CFrame.new(0,0,-_0xP)av.Velocity=Vector3.new(0,0,0)end 
            end)task.wait()
        end 
    end)
end

_0x3.d:AddSection("Aimbot")
_0x3.d:AddDropdown("D1",{Title="Intensity",Values={"Level 1","Level 2"},Default="Level 1",Callback=function(v)_0xH.lvl=(v=="Level 1" and 1 or 2)end})
_0x3.d:AddToggle("T1",{Title="Player Aimbot",Default=false,Callback=function(v)_0xH.i=v;_0xF.Visible=(v or _0xS.t)end})
_0x3.d:AddToggle("T2",{Title="NPC Aimbot",Default=false,Callback=function(v)_0xS.t=v;_0xF.Visible=(_0xH.i or v)end})
_0x3.d:AddToggle("T_Team",{Title="Team Check",Default=true,Callback=function(v)_0xH.team=v end})
_0x3.d:AddToggle("T_RGB",{Title="RGB LED Mode",Default=false,Callback=function(v)_0xH.rgb=v end})
_0x3.d:AddInput("I1",{Title="FOV Size",Default="150",Numeric=true,Finished=true,Callback=function(v)local n=tonumber(v)if n then _0xH.j=n;_0xF.Radius=n end end})

_0x3.d:AddSection("Character")
_0x3.d:AddInput("I2",{Title="Speed",Default="16",Numeric=true,Finished=true,Callback=function(v)if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=tonumber(v)or 16 end end})
_0x3.d:AddToggle("T3",{Title="Inf Jump",Default=false,Callback=function(v)_0xR.t=v end})
_0x3.d:AddToggle("T4",{Title="Noclip",Default=false,Callback=function(v)_0xR.s=v end})

_0x3.e:AddSection("Visuals")
_0x3.e:AddToggle("T5",{Title="Chams",Default=false,Callback=function(v)_0xL.m=v end})
_0x3.e:AddToggle("T6",{Title="Skeleton + Sky",Default=false,Callback=function(v)_0xL.n=v end})
_0x3.e:AddColorpicker("C1",{Title="ESP Color",Default=Color3.fromRGB(255,0,0),Callback=function(v)_0xL.o=v end})

_0x3.f:AddSection("Pull System")
local _0xPL={};for _,p in pairs(game.Players:GetPlayers())do if p~=game.Players.LocalPlayer then table.insert(_0xPL,p.Name)end end
local _0xPD=_0x3.f:AddDropdown("D2",{Title="Select Player",Values=_0xPL,Default="",Callback=function(v)_0xTargetP=v end})
_0x3.f:AddButton({Title="Pull Selected",Callback=function()if _0xTargetP then _0xAS(game.Players:FindFirstChild(_0xTargetP))end end})
_0x3.f:AddButton({Title="Pull All",Callback=function()for _,p in pairs(game.Players:GetPlayers())do _0xAS(p)end end})
_0x3.f:AddButton({Title="Release All",Callback=function()_0xQ={}end})

_0x3.g:AddSection("Misc")
_0x3.g:AddButton({Title="Rejoin Server",Callback=function()game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)end})
_0x3.g:AddButton({Title="Infinite Yield",Callback=function()loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))()end})

game:GetService("RunService").RenderStepped:Connect(function()
    local cam=workspace.CurrentCamera;local _0xColor=_0xH.rgb and Color3.fromHSV(tick()%5/5,1,1) or _0xL.o
    _0xF.Position=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2);_0xF.Color=_0xColor
    
    local function GT(npc)
        local t=nil;local m=_0xH.j
        if not npc then 
            for _,p in pairs(game.Players:GetPlayers()) do 
                if p~=game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health>0 then 
                    if _0xH.team and p.Team==game.Players.LocalPlayer.Team then continue end
                    local s,o=cam:WorldToViewportPoint(p.Character.Head.Position)
                    if o then local d=(Vector2.new(s.X,s.Y)-_0xF.Position).Magnitude;if d<m then m=d;t=p.Character.Head end end 
                end 
            end 
        else 
            for _,v in pairs(workspace:GetDescendants()) do 
                if v:IsA("Model") and v:FindFirstChild("Head") and v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health>0 and not game.Players:GetPlayerFromCharacter(v) then 
                    local s,o=cam:WorldToViewportPoint(v.Head.Position)
                    if o then local d=(Vector2.new(s.X,s.Y)-_0xF.Position).Magnitude;if d<m then m=d;t=v.Head end end 
                end 
            end 
        end return t 
    end
    local ft=(_0xH.i and GT(false))or(_0xS.t and GT(true))
    if ft then cam.CFrame=CFrame.new(cam.CFrame.Position,ft.Position)end
    if _0xR.s and game.Players.LocalPlayer.Character then for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()if _0xR.t and game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")end end)
for _,p in pairs(game.Players:GetPlayers())do _0xX(p)end;game.Players.PlayerAdded:Connect(_0xX)
_0x3.d:Select()
