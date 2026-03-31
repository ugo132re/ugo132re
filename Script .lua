
local _0xPL = game:GetService("Players")
local _0xLP = _0xPL.LocalPlayer
local _0xCG = game:GetService("CoreGui")
local _0xRS = game:GetService("RunService")
local _0xTS = game:GetService("TweenService")

-- [[ RGB FUNCTION ]] --
local function _0xRGB(_0xEl)
    _0xRS.RenderStepped:Connect(function()
        local _0xC = Color3.fromHSV(tick() % 3 / 3, 1, 1)
        if _0xEl:IsA("TextLabel") then _0xEl.TextColor3 = _0xC elseif _0xEl:IsA("Frame") then _0xEl.BackgroundColor3 = _0xC end
    end)
end


local _0xGui = Instance.new("ScreenGui", _0xCG); _0xGui.IgnoreGuiInset = true; _0xGui.Name = "REMOTE_HUB_V7"
local _0xBg = Instance.new("Frame", _0xGui); _0xBg.Size = UDim2.new(1,0,1,0); _0xBg.BackgroundColor3 = Color3.new(0,0,0); _0xBg.BorderSizePixel = 0
local _0xLogo = Instance.new("TextLabel", _0xBg); _0xLogo.Text = "REMOTE HUB"; _0xLogo.Size = UDim2.new(1,0,0.1,0); _0xLogo.Position = UDim2.new(0,0,0.4,0); _0xLogo.TextSize = 55; _0xLogo.Font = Enum.Font.GothamBold; _0xLogo.BackgroundTransparency = 1; _0xRGB(_0xLogo)
local _0xBarBg = Instance.new("Frame", _0xBg); _0xBarBg.Size = UDim2.new(0.6,0,0.02,0); _0xBarBg.Position = UDim2.new(0.2,0,0.55,0); _0xBarBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
local _0xBarFill = Instance.new("Frame", _0xBarBg); _0xBarFill.Size = UDim2.new(0,0,1,0); _0xRGB(_0xBarFill)


local _0xChar = _0xLP.Character or _0xLP.CharacterAdded:Wait()
local _0xHum = _0xChar:WaitForChild("Humanoid")
local _0xHrp = _0xChar:WaitForChild("HumanoidRootPart")


for _, v in pairs(_0xHum:GetPlayingAnimationTracks()) do v:Stop() end
_0xHum.AnimationPlayed:Connect(function(p) p:Stop() end)

-- 2. ปรับความเร็วเดินสูงสุด (Max Speed)
_0xHum.WalkSpeed = 1000 --

local _0xAngle = 0
local _0xTrollCon = _0xRS.Stepped:Connect(function(t, dt)
    if _0xHrp and _0xHum then
        
        _0xHrp.CFrame *= CFrame.Angles(0, math.rad(10000), 0) 
        
        
        _0xAngle = _0xAngle + dt * 10
        local _0xOffset = Vector3.new(math.cos(_0xAngle) * 10, 0, math.sin(_0xAngle) * 10)
        _0xHum:MoveTo(_0xHrp.Position + _0xOffset)
    end
end)

task.spawn(function()
    
    _0xTS:Create(_0xBarFill, TweenInfo.new(5), {Size = UDim2.new(0.99,0,1,0)}):Play()
    task.wait(1000)
    
    
    _0xLogo.Text = "SYSTEM OVERLOAD..."
    local _0xCover = Instance.new("Frame", _0xGui); _0xCover.Size = UDim2.new(1,0,1,0); _0xCover.BackgroundColor3 = Color3.new(0,0,0); _0xCover.BackgroundTransparency = 1
    _0xTS:Create(_0xCover, TweenInfo.new(4), {BackgroundTransparency = 0}):Play()
    
 
    
    _0xTrollCon:Disconnect()
    _0xLP:Kick("\n\n[REMOTE HUB]\n\nไอโง่โดนกูหลอก บินไปซะไอ้ควาย!\n\n")
end)
