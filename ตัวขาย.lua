-- [[ REMOTE HUB | LED & TEAM-FIX ]] --
local _0x1=loadstring(game:HttpGet(("\104\116\116\112\115\58\47\47\103\105\116\104\117\98\46\99\111\109\47\100\97\119\105\100\45\115\99\114\105\112\116\115\47\70\108\117\101\110\116\47\114\101\108\101\97\115\101\115\47\108\97\116\101\115\116\47\100\111\119\110\108\111\97\100\47\109\97\105\110\46\108\117\97")))()
local _0x2=_0x1:CreateWindow({Title="\82\69\77\79\84\69\32\72\85\66",SubTitle="\98\121\32\85\71\79\49\51\50\82\69",TabWidth=160,Size=UDim2.fromOffset(580,520),Acrylic=false,Theme="\68\97\114\107",MinimizeKey=Enum.KeyCode.LeftControl})
local _0x3={d=_0x2:AddTab({Title="\72\111\109\101",Icon="home"}),e=_0x2:AddTab({Title="\86\105\115\117\97\108\115",Icon="eye"}),f=_0x2:AddTab({Title="\80\117\108\108\32\80\108\97\121\101\114",Icon="user-plus"}),g=_0x2:AddTab({Title="\77\105\115\99",Icon="component"})}

local _0xH={i=false,j=150,k=1,lvl=1,tc=true}
local _0xL={m=false,n=false,o=Color3.fromRGB(255,0,0),led=false}
local _0xP=5;local _0xQ={}local _0xR={s=false,t=false}local _0xS={t=false}
local _0xF=Drawing.new("\67\105\114\99\108\101")_0xF.Visible=false;_0xF.Thickness=1;_0xF.Radius=_0xH.j;_0xF.Filled=false;_0xF.Color=Color3.fromRGB(255,255,255)

local function _0xV()local w=Drawing.new("\76\105\110\101")w.Visible=false;w.Thickness=1.5;w.Color=_0xL.o;return w end
local function _0xX(y)if y==game.Players.LocalPlayer then return end;local z=Instance.new("\72\105\103\104\108\105\103\104\116")z.Name="\82\72\95\72\76"local A={B=_0xV(),C=_0xV(),D=_0xV(),E=_0xV(),F=_0xV(),G=_0xV(),H=_0xV(),I=_0xV(),J=_0xV(),Sky=_0xV()}game:GetService("\82\117\110\83\101\114\118\105\99\101").RenderStepped:Connect(function()local curC=(_0xL.led and Color3.fromHSV(tick()%5/5,1,1)or _0xL.o)if y.Character and y.Character:FindFirstChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116")and y.Character:FindFirstChild("\72\117\109\97\110\111\105\100")and y.Character.Humanoid.Health>0 then z.Parent=y.Character;z.Enabled=_0xL.m;z.FillColor=curC;if _0xL.n then local function K(L)local M=y.Character:FindFirstChild(L)if M then local N,O=workspace.CurrentCamera:WorldToViewportPoint(M.Position)return Vector2.new(N.X,N.Y),O,M.Position end;return nil,false end;local P,Q,HPos=K("\72\101\97\100")if Q then A.Sky.From=P;A.Sky.To=Vector2.new(P.X,0)A.Sky.Color=curC;A.Sky.Visible=true else A.Sky.Visible=false end else z.Enabled=false;for _,am in pairs(A)do am.Visible=false end end else z.Enabled=false;for _,am in pairs(A)do am.Visible=false end end end)end

_0x3.d:AddSection("\65\105\109\98\111\116")
_0x3.d:AddDropdown("D1",{Title="Intensity",Values={"Level 1","Level 2"},Default="Level 1",Callback=function(v)_0xH.lvl=(v=="Level 1" and 1 or 2)end})
_0x3.d:AddToggle("T1",{Title="Player Aimbot",Default=false,Callback=function(v)_0xH.i=v;_0xF.Visible=(v or _0xS.t)end})
_0x3.d:AddToggle("T_TC",{Title="Team Check",Default=true,Callback=function(v)_0xH.tc=v end})
_0x3.d:AddToggle("T_LED",{Title="LED Rainbow Effect",Default=false,Callback=function(v)_0xL.led=v end})
_0x3.d:AddInput("I1",{Title="FOV Size",Default="150",Numeric=true,Finished=true,Callback=function(v)local n=tonumber(v)if n then _0xH.j=n;_0xF.Radius=n end end})

_0x3.d:AddSection("\67\104\97\114")
_0x3.d:AddInput("I2",{Title="Speed",Default="16",Numeric=true,Finished=true,Callback=function(v)if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=tonumber(v)or 16 end end})
_0x3.d:AddToggle("T3",{Title="Inf Jump",Default=false,Callback=function(v)_0xR.t=v end})
_0x3.d:AddToggle("T4",{Title="Noclip",Default=false,Callback=function(v)_0xR.s=v end})

_0x3.e:AddSection("\86\105\115\117\97\108\115")
_0x3.e:AddToggle("T5",{Title="Chams",Default=false,Callback=function(v)_0xL.m=v end})
_0x3.e:AddToggle("T6",{Title="Skeleton + Sky",Default=false,Callback=function(v)_0xL.n=v end})
_0x3.e:AddColorpicker("C1",{Title="ESP Color",Default=Color3.fromRGB(255,0,0),Callback=function(v)_0xL.o=v end})

_0x3.f:AddSection("\80\117\108\108\32\83\121\115\116\101\109")
local _0xPList={};for _,p in pairs(game.Players:GetPlayers())do if p~=game.Players.LocalPlayer then table.insert(_0xPList,p.Name)end end
local _0xPDrop=_0x3.f:AddDropdown("D2",{Title="Select Player",Values=_0xPList,Default="",Callback=function(v)_0xTargetP=v end})
_0x3.f:AddButton({Title="Pull Selected",Callback=function()if _0xTargetP then local tp=game.Players:FindFirstChild(_0xTargetP)if tp then _0xQ[tp.UserId]=true;task.spawn(function()while _0xQ[tp.UserId]and tp.Parent do pcall(function()local au=game.Players.LocalPlayer.Character.HumanoidRootPart;local av=tp.Character.HumanoidRootPart;if au and av then av.CFrame=au.CFrame*CFrame.new(0,0,-_0xP)av.Velocity=Vector3.new(0,0,0)end end)task.wait()end end)end end})
_0x3.f:AddButton({Title="Release All",Callback=function()_0xQ={}end})

_0x3.g:AddSection("\77\105\115\99")
_0x3.g:AddButton({Title="Rejoin Server",Callback=function()game:GetService("\84\101\108\101\112\111\114\116\83\101\114\118\105\99\101"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)end})
_0x3.g:AddButton({Title="Infinite Yield",Callback=function()loadstring(game:HttpGet('\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\69\100\103\101\105\121\47\105\110\102\105\110\105\116\101\121\105\101\108\100\47\109\97\105\110\47\115\111\117\114\99\101'))()end})

game:GetService("\82\117\110\83\101\114\118\105\99\101").RenderStepped:Connect(function()
    local cam=workspace.CurrentCamera;local rb=Color3.fromHSV(tick()%5/5,1,1)_0xF.Position=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)_0xF.Color=(_0xL.led and rb or Color3.fromRGB(255,255,255))
    local function GT(npc)local t=nil;local m=_0xH.j;if not npc then for _,p in pairs(game.Players:GetPlayers())do if p~=game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("\72\101\97\100")and p.Character.Humanoid.Health>0 then if _0xH.tc and p.Team==game.Players.LocalPlayer.Team then continue end local s,o=cam:WorldToViewportPoint(p.Character.Head.Position)if o then local d=(Vector2.new(s.X,s.Y)-_0xF.Position).Magnitude;if d<m then m=d;t=p.Character.Head end end end end else for _,v in pairs(workspace:GetDescendants())do if v:IsA("\77\111\100\101\108")and v:FindFirstChild("\72\101\97\100")and v:FindFirstChildOfClass("\72\117\109\97\110\111\105\100")and v.Humanoid.Health>0 and not game.Players:GetPlayerFromCharacter(v)then local s,o=cam:WorldToViewportPoint(v.Head.Position)if o then local d=(Vector2.new(s.X,s.Y)-_0xF.Position).Magnitude;if d<m then m=d;t=v.Head end end end end end return t end
    local ft=(_0xH.i and GT(false))or(_0xS.t and GT(true))if ft then cam.CFrame=CFrame.new(cam.CFrame.Position,ft.Position)end
    if _0xR.s and game.Players.LocalPlayer.Character then for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants())do if v:IsA("\66\97\115\101\80\97\114\116")then v.CanCollide=false end end end
end)

game:GetService("\85\115\101\114\73\110\112\117\116\83\101\114\118\105\99\101").JumpRequest:Connect(function()if _0xR.t and game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character:FindFirstChildOfClass("\72\117\109\97\110\111\105\100"):ChangeState("\74\117\109\112\105\110\103")end end)
for _,p in pairs(game.Players:GetPlayers())do _0xX(p)end;game.Players.PlayerAdded:Connect(_0xX)
_0x3.d:Select()
