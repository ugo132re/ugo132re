-- OWNER: UGO132RE | BRAND: REMOTE HUB
-- FEATURE: KILL-AURA + BRANDING FIXED

local _0x1A = game:GetService("Players")
local _0x1B = _0x1A.LocalPlayer
local _0x1C = _0x1B:WaitForChild("PlayerGui")
local _0x1D = game:GetService("ReplicatedStorage")
local _0x1E = game:GetService("VirtualUser")

local _0xCFG = { 
    E = false, 
    R = 300,   
    D = 0.000000001,  
    K = "\52\49\56\53\54\50\55\99" 
}

local _0xHIT = _0x1D:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")


if _0x1C:FindFirstChild("REMOTE_HUB_V6_FIXED") then _0x1C["REMOTE_HUB_V6_FIXED"]:Destroy() end
local _0x2A = Instance.new("ScreenGui", _0x1C)
_0x2A.Name = "REMOTE_HUB_V6_FIXED"
_0x2A.ResetOnSpawn = false


local _0x2B = Instance.new("Frame", _0x2A)
_0x2B.Size = UDim2.new(0, 220, 0, 150) 
_0x2B.Position = UDim2.new(0.5, -110, 0.4, -75)
_0x2B.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_0x2B.BorderSizePixel = 0
_0x2B.Active = true

local MainCorner = Instance.new("UICorner", _0x2B)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", _0x2B)
MainStroke.Color = Color3.fromRGB(0, 255, 0)
MainStroke.Thickness = 2


local _0xTitle = Instance.new("TextLabel", _0x2B)
_0xTitle.Size = UDim2.new(1, 0, 0, 40)
_0xTitle.Text = "REMOTE HUB"
_0xTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
_0xTitle.TextSize = 20
_0xTitle.Font = Enum.Font.GothamBold
_0xTitle.BackgroundTransparency = 1


local _0x2D = Instance.new("TextButton", _0x2B)
_0x2D.Size = UDim2.new(0.85, 0, 0, 50)
_0x2D.Position = UDim2.new(0.075, 0, 0.35, 10)
_0x2D.Text = "Kill Aura: OFF"
_0x2D.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
_0x2D.TextColor3 = Color3.new(1,1,1)
_0x2D.Font = Enum.Font.GothamBold
_0x2D.AutoButtonColor = false
Instance.new("UICorner", _0x2D)


local _0xBy = Instance.new("TextLabel", _0x2B)
_0xBy.Size = UDim2.new(0, 100, 0, 20)
_0xBy.Position = UDim2.new(1, -105, 1, -25)
_0xBy.Text = "by REMOTE HUB"
_0xBy.TextColor3 = Color3.fromRGB(100, 100, 100)
_0xBy.TextSize = 10
_0xBy.BackgroundTransparency = 1
_0xBy.TextXAlignment = Enum.TextXAlignment.Right

-- ระบบ Logic เปิด/ปิด
_0x2D.MouseButton1Click:Connect(function() 
    _0xCFG.E = not _0xCFG.E 
    _0x2D.Text = _0xCFG.E and "Kill Aura: ON" or "Kill Aura: OFF"
    _0x2D.BackgroundColor3 = _0xCFG.E and Color3.fromRGB(150, 60, 230) or Color3.fromRGB(35, 35, 35) 
end)


task.spawn(function()
    while true do
        task.wait(_0xCFG.D)
        if _0xCFG.E and _0x1B.Character and _0x1B.Character:FindFirstChildOfClass("Tool") then
            local myRoot = _0x1B.Character:FindFirstChild("HumanoidRootPart")
            if not myRoot then continue end
            
            for _, v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v ~= _0x1B.Character then
                    local targetPart = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Head")
                    if targetPart and (_0x1B.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude <= _0xCFG.R then
                        _0x1E:CaptureController()
                        _0x1E:ClickButton1(Vector2.new(0,0))
                        _0xHIT:FireServer(targetPart, {}, _0xCFG.K)
                    end
                end
            end
        end
    end
end)


local dragging, dragInput, dragStart, startPos
_0x2B.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging, dragStart, startPos = true, input.Position, _0x2B.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        _0x2B.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
_0x2B.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
