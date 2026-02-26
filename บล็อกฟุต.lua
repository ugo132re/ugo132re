-- OWNER: UGO132RE | BRAND: REMOTE HUB
-- FEATURE: ENHANCED KILL-AURA (ALL TARGETS IN RANGE)

local _0x1A = game:GetService("Players")
local _0x1B = _0x1A.LocalPlayer
local _0x1C = _0x1B:WaitForChild("PlayerGui")
local _0x1D = game:GetService("ReplicatedStorage")
local _0x1E = game:GetService("VirtualUser")

-- Config สำหรับ REMOTE HUB
local _0xCFG = { 
    E = false, 
    R = 400,   
    D = 0.000001,   
    K = "\52\49\56\53\54\50\55\99" 
}


local _0xHIT = _0x1D:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")

-- UI สำหรับ REMOTE HUB (อ้างอิงจาก V6 ของคุณ)
if _0x1C:FindFirstChild("REMOTE_HUB_V6") then _0x1C["REMOTE_HUB_V6"]:Destroy() end
local _0x2A = Instance.new("ScreenGui", _0x1C)
_0x2A.Name = "REMOTE_HUB_V6"

local _0x2B = Instance.new("Frame", _0x2A)
_0x2B.Size, _0x2B.Position = UDim2.new(0, 220, 0, 120), UDim2.new(0.5, -110, 0.4, -60)
_0x2B.BackgroundColor3, _0x2B.Active = Color3.fromRGB(15, 15, 15), true
Instance.new("UICorner", _0x2B).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", _0x2B).Color = Color3.fromRGB(0, 255, 0) 

local _0x2D = Instance.new("TextButton", _0x2B)
_0x2D.Size, _0x2D.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.4, 0)
_0x2D.Text = "Kill Aura: OFF"
_0x2D.Font = Enum.Font.GothamBold
_0x2D.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", _0x2D)

_0x2D.MouseButton1Click:Connect(function() 
    _0xCFG.E = not _0xCFG.E 
    _0x2D.Text = _0xCFG.E and "Kill Aura: ON" or "Kill Aura: OFF"
    _0x2D.BackgroundColor3 = _0xCFG.E and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
end)


task.spawn(function()
    while true do
        task.wait(_0xCFG.D)
        if _0xCFG.E and _0x1B.Character and _0x1B.Character:FindFirstChildOfClass("Tool") then
            local myPos = _0x1B.Character.PrimaryPart.Position
            
            
            for _, v in pairs(workspace:GetChildren()) do
                
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v ~= _0x1B.Character then
                    local targetPos = v.PrimaryPart and v.PrimaryPart.Position or v:FindFirstChild("Head") and v.Head.Position
                    
                    if targetPos and (myPos - targetPos).Magnitude <= _0xCFG.R then
                       
                        _0x1E:CaptureController()
                        _0x1E:ClickButton1(Vector2.new(0,0))
                        
                        
                        _0xHIT:FireServer(v:FindFirstChild("Head") or v.PrimaryPart, {}, _0xCFG.K)
                    end
                end
            end
            
            
            if workspace:FindFirstChild("Enemies") then
                for _, e in pairs(workspace.Enemies:GetChildren()) do
                    if e:FindFirstChild("Head") and e.Humanoid.Health > 0 then
                         if (myPos - e.Head.Position).Magnitude <= _0xCFG.R then
                            _0xHIT:FireServer(e.Head, {}, _0xCFG.K)
                         end
                    end
                end
            end
        end
    end
end)

-- ระบบขยับ GUI
_0x2B.Draggable = true 
