local _0x1=loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\103\105\116\104\117\98\46\99\111\109\47\100\97\119\105\100\45\115\99\114\105\112\116\115\47\70\108\117\101\110\116\47\114\101\108\101\97\115\101\115\47\108\97\116\101\115\116\47\100\111\119\110\108\111\97\100\47\109\97\105\110\46\108\117\97"))()
local _0x2=_0x1:CreateWindow({Title="REMOTE HUB",SubTitle="by UGO132RE",TabWidth=160,Size=UDim2.fromOffset(580,520),Acrylic=false,Theme="Dark",MinimizeKey=Enum.KeyCode.LeftControl})
local _0x3={d=_0x2:AddTab({Title="Home",Icon="home"}),e=_0x2:AddTab({Title="Visuals",Icon="eye"}),f=_0x2:AddTab({Title="Pull Player",Icon="user-plus"}),g=_0x2:AddTab({Title="Misc",Icon="component"})}

local _0xH={i=false,j=150,k=0.5,lvl=1}
local _0xL={m=false,n=false,o=Color3.fromRGB(255,0,0)}
local _0xP=5;local _0xQ={}local _0xR={s=false,t=false}local _0xS={t=false}
local _0xF=Drawing.new("Circle")_0xF.Visible=false;_0xF.Thickness=1;_0xF.Radius=_0xH.j;_0xF.Filled=false;_0xF.Color=Color3.fromRGB(255,255,255)

local function _0xV()local w=Drawing.new("Line")w.Visible=false;w.Thickness=1.5;w.Color=_0xL.o;return w end
local function _0xX(y)if y==game.Players.LocalPlayer then return end;local z=Instance.new("Highlight")z.Name="RH_HL"local A={B=_0xV(),C=_0xV(),D=_0xV(),E=_0xV(),F=_0xV(),G=_0xV(),H=_0xV(),I=_0xV(),J=_0xV(),Sky=_0xV()}game:GetService("RunService").RenderStepped:Connect(function()if y.Character and y.Character:FindFirstChild("HumanoidRootPart")and y.Character:FindFirstChild("Humanoid")and y.Character.Humanoid.Health>0 then z.Parent=y.Character;z.Enabled=_0xL.m;z.FillColor=_0xL.o;if _0xL.n then local function K(L)local M=y.Character:FindFirstChild(L)if M then local N,O=workspace.CurrentCamera:WorldToViewportPoint(M.Position)return Vector2.new(N.X,N.Y),O,M.Position end;return nil,false end;local P,Q,HPos=K("Head")local R,S=K("UpperTorso")or K("Torso")local T,U=K("LowerTorso")or K("HumanoidRootPart")local V,W=K("LeftUpperArm")or K("Left Arm")local X,Y=K("RightUpperArm")or K("Right Arm")local Z,aa=K("LeftHand")or K("Left Arm")local ab,ac=K("RightHand")or K("Right Arm")local ad,ae=K("LeftUpperLeg")or K("Left Leg")local af,ag=K("RightUpperLeg")or K("Right Leg")local ah,ai=K("LeftFoot")or K("Left Leg")local aj,ak=K("RightFoot")or K("Right Leg")local function al(am,an,ao,ap,aq)if ap and aq then am.From=an;am.To=ao;am.Color=_0xL.o;am.Visible=true else am.Visible=false end end;al(A.B,P,R,Q,S)al(A.C,R,V,S,W)al(A.D,R,X,S,Y)al(A.E,V,Z,W,aa)al(A.F,X,ab,Y,ac)al(A.G,T,ad,U,ae)al(A.H,T,af,U,ag)al(A.I,ad,ah,ae,ai)al(A.J,af,aj,ag,ak)if Q then A.Sky.From=P;A.Sky.To=Vector2.new(P.X,0)A.Sky.Color=_0xL.o;A.Sky.Visible=true else A.Sky.Visible=false end else z.Enabled=false;for _,am in pairs(A)do am.Visible=false end end else z.Enabled=false;for _,am in pairs(A)do am.Visible=false end end end)end
local function _0xAS(at)if not at or at==game.Players.LocalPlayer then return end;_0xQ[at.UserId]=true;task.spawn(function()while _0xQ[at.UserId]and at.Parent do pcall(function()local au=game.Players.LocalPlayer.Character.HumanoidRootPart;local av=at.Character.HumanoidRootPart;if au and av then av.CFrame=au.CFrame*CFrame.new(0,0,-_0xP)av.Velocity=Vector3.new(0,0,0)end end)task.wait()end end)end

_0x3.d:AddSection("Aimbot Settings")
_0x3.d:AddDropdown("D1",{Title="Aimbot Intensity",Values={"Level 1 (Soft)","Level 2 (Lock 100%)"},Default="Level 1 (Soft)",Callback=function(v)if v=="Level 1 (Soft)"then _0xH.lvl=1 else _0xH.lvl=2 end end})
_0x3.d:AddToggle("T1",{Title="Player Aimbot",Default=false,Callback=function(v)_0xH.i=v;_0x1u2i3o.Visible=(v or _0xS.t)end})
_0x3.d:AddToggle("T2",{Title="NPC Aimbot",Default=false,Callback=function(v)_0xS.t=v;_0x1u2i3o.Visible=(_0xH.i or v)end})
_0x3.d:AddInput("I1",{Title="FOV Size",Default="150",Numeric=true,Finished=true,Callback=function(v)local n=tonumber(v)if n then _0xH.j=n;_0x1u2i3o.Radius=n end end})

_0x3.d:AddSection("Character")
_0x3.d:AddInput("I2",{Title="WalkSpeed",Default="16",Numeric=true,Finished=true,Callback=function(v)if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=tonumber(v)or 16 end end})
_0x3.d:AddToggle("T3",{Title="Infinite Jump",Default=false,Callback=function(v)_0xR.t=v end})
_0x3.d:AddToggle("T4",{Title="Noclip",Default=false,Callback=function(v)_0xR.s=v end})

_0x3.e:AddSection("ESP")
_0x3.e:AddToggle("T5",{Title="Chams",Default=false,Callback=function(v)_0xL.m=v end})
_0x3.e:AddToggle("T6",{Title="Skeleton + Sky",Default=false,Callback=function(v)_0xL.n=v end})
_0x3.e:AddColorpicker("C1",{Title="ESP Color",Default=Color3.fromRGB(255,0,0),Callback=function(v)_0xL.o=v end})

_0x3.f:AddSection("Player Controls")
_0x3.f:AddInput("I3",{Title="Pull Distance",Default="5",Numeric=true,Finished=true,Callback=function(v)_0xP=tonumber(v)or 5 end})
_0x3.f:AddButton({Title="Pull All Players",Callback=function()for _,p in pairs(game.Players:GetPlayers())do _0xAS(p)end end})
_0x3.f:AddButton({Title="Release All",Callback=function()_0xQ={}end})

_0x3.g:AddButton({Title="Rejoin Server",Callback=function()game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)end})
_0x3.g:AddButton({Title="Infinite Yield",Callback=function()loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))()end})

local function IsEnemy(tp)if not tp.Team or not game.Players.LocalPlayer.Team then return true end return tp.Team~=game.Players.LocalPlayer.Team end

game:GetService("RunService").RenderStepped:Connect(function()
    local cam=workspace.CurrentCamera;_0x1u2i3o=u or _0x1u2i3o;_0x1u2i3o.Position=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)
    if _0xH.i then 
        local target=nil;local dist=_0xH.j;
        for _,p in pairs(game.Players:GetPlayers())do 
            if p~=game.Players.LocalPlayer and IsEnemy(p)and p.Character and p.Character:FindFirstChild("Head")then 
                local sp,os=cam:WorldToViewportPoint(p.Character.Head.Position)
                if os then local mag=(Vector2.new(sp.X,sp.Y)-_0x1u2i3o.Position).Magnitude;if mag<dist then dist=mag;target=p end end 
            end 
        end
        if target then if _0xH.lvl==1 then cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,target.Character.Head.Position),_0xH.k)else cam.CFrame=CFrame.new(cam.CFrame.Position,target.Character.Head.Position)end end 
    end
    if _0xS.t then 
        local tn=nil;local md=_0xH.j;
        for _,obj in pairs(workspace:GetDescendants())do 
            if obj:IsA("Model")and not game.Players:GetPlayerFromCharacter(obj)then 
                local h=obj:FindFirstChild("Head")local hu=obj:FindFirstChildOfClass("Humanoid")
                if h and hu and hu.Health>0 then 
                    local sp,os=cam:WorldToViewportPoint(h.Position)
                    if os then local mag=(Vector2.new(sp.X,sp.Y)-_0x1u2i3o.Position).Magnitude;if mag<md then md=mag;tn=h end end 
                end 
            end 
        end
        if tn then if _0xH.lvl==1 then cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,tn.Position),_0xH.k)else cam.CFrame=CFrame.new(cam.CFrame.Position,tn.Position)end end 
    end
    if _0xR.s and game.Players.LocalPlayer.Character then for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()if _0xR.t and game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")end end)
for _,p in pairs(game.Players:GetPlayers())do _0xX(p)end;game.Players.PlayerAdded:Connect(_0xX)
_0x3.d:Select()
