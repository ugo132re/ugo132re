-- [[ REMOTE HUB | TOTAL ANNIHILATION VERSION ]] --
local _0xO=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()local _0xX=_0xO:CreateWindow({Title="REMOTE HUB",SubTitle="by UGO132RE",TabWidth=160,Size=UDim2.fromOffset(580,520),Acrylic=false,Theme="Dark",MinimizeKey=Enum.KeyCode.LeftControl})local _0xH={_1=(_0xX:AddTab({Title="MAX POWER",Icon="zap"})),_2=(_0xX:AddTab({Title="Target Fly",Icon="user"})),_3=(_0xX:AddTab({Title="AFK System",Icon="coffee"}))}local _0xK={_A=100000,_B=false}local _0xM={_G=false,_H=nil,_I=false,_J=false}local _0xV=game:GetService("VirtualUser")local _0xR=game:GetService("RunService")local _0xRE=game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorageHolders"):WaitForChild("Events"):WaitForChild("AddXP")game:GetService("Players").LocalPlayer.Idled:Connect(function()if _0xM._J then _0xV:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)task.wait(1)_0xV:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)end end)

-- [[ ☢️ NUCLEAR XP INJECTION (100x MULTI-THREAD) ]] --
task.spawn(function()
    _0xR.RenderStepped:Connect(function()
        if _0xK._B then 
            -- อัดฉีด 100 รอบต่อเฟรม (ประมาณ 6,000+ ครั้งต่อวินาที)
            for i=1, 100 do 
                _0xRE:FireServer(_0xK._A)
            end
        end 
    end)
end)
task.spawn(function()
    while true do 
        if _0xK._B then 
            for i=1, 50 do _0xRE:FireServer(_0xK._A) end
        end
        task.wait(0.01) -- สายสำรองเพิ่มความรัว
    end
end)

_0xR.Heartbeat:Connect(function()local lp=game.Players.LocalPlayer;local char=lp.Character;if not char or not char:FindFirstChild("HumanoidRootPart")then return end;local hrp=char.HumanoidRootPart;if _0xM._I then hrp.CFrame=hrp.CFrame:Lerp(CFrame.new(hrp.Position.X,1500,hrp.Position.Z),0.05)elseif _0xM._G and _0xM._H then local t=game.Players:FindFirstChild(_0xM._H)if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")then hrp.CFrame=hrp.CFrame:Lerp(t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3),0.07)end end end)_0xH._1:AddSection("Nuclear XP Output")_0xH._1:AddToggle("T1",{Title="GOD MODE XP (NO LIMIT)",Description="ระวัง: ส่งข้อมูลวินาทีละ 1,000 ล้าน+ XP",Default=false,Callback=function(v)_0xK._B=v end})local _0xD=_0xH._2:AddDropdown("D1",{Title="Select Player",Values={},Multi=false,Default=nil,Callback=function(v)_0xM._H=v end})local function _0xU()local p={}for _,v in pairs(game.Players:GetPlayers())do if v~=game.Players.LocalPlayer then table.insert(p,v.Name)end end;_0xD:SetValues(p)end;_0xU()game.Players.PlayerAdded:Connect(_0xU)game.Players.PlayerRemoving:Connect(_0xU)_0xH._2:AddToggle("T3",{Title="Enable Target Fly",Default=false,Callback=function(v)_0xM._G=v;if v then _0xM._I=false end end})_0xH._3:AddSection("AFK Settings")_0xH._3:AddToggle("T4",{Title="Enable AFK (Fly Away)",Default=false,Callback=function(v)_0xM._I=v;if v then _0xM._G=false end end})_0xH._3:AddToggle("T5",{Title="Anti-AFK (Anti-Kick)",Default=false,Callback=function(v)_0xM._J=v end})_0xH._1:Select()
