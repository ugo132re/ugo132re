--BY REMOT HUB
--ทำขึ้นเพื่อให้รู้ถึงภัยใกล้ตัวและความเป็นห่วงจากสคริปพวกนี้อย่าไปหามาเล่นสคริปแบบนี้--

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")


if PlayerGui:FindFirstChild("REMOTE_HUB_FINAL_V1.7") then 
    PlayerGui["REMOTE_HUB_FINAL_V1.7"]:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "REMOTE_HUB_FINAL_V1.7"
ScreenGui.ResetOnSpawn = false


local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 160)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true -- เปิดเพื่อให้ Frame รับ Input

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)


local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(0, 255, 0)
UIStroke.Thickness = 2.5


local Watermark = Instance.new("TextLabel", MainFrame)
Watermark.Size = UDim2.new(0, 100, 0, 20)
Watermark.Position = UDim2.new(1, -105, 1, -25)
Watermark.BackgroundTransparency = 1
Watermark.Text = "by REMOTE HUB"
Watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
Watermark.TextSize = 12
Watermark.Font = Enum.Font.GothamMedium
Watermark.TextXAlignment = Enum.TextXAlignment.Right

-- 5. ปุ่ม Lucky Random (x999)
local LuckyBtn = Instance.new("TextButton", MainFrame)
LuckyBtn.Size = UDim2.new(0.85, 0, 0, 50)
LuckyBtn.Position = UDim2.new(0.075, 0, 0.45, -25)
LuckyBtn.BackgroundColor3 = Color3.fromRGB(150, 60, 230)
LuckyBtn.Text = "x9999 Lucky Random Fruit"
LuckyBtn.TextColor3 = Color3.new(1, 1, 1)
LuckyBtn.TextSize = 19
LuckyBtn.Font = Enum.Font.GothamBold
LuckyBtn.AutoButtonColor = false

local BtnCorner = Instance.new("UICorner", LuckyBtn)
BtnCorner.CornerRadius = UDim.new(0, 12)


local function TriggerRGB()
    local startTime = tick()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        if elapsed < 3 then
            local hue = (tick() * 7) % 1
            LuckyBtn.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 1)
            LuckyBtn.Text = "Lucky🤑🤑🤑..."
        else
            connection:Disconnect()
            LuckyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            LuckyBtn.Text = "SUBSCRIBE REMOTE HUB" 
            
            local FakeNotice = Instance.new("TextLabel", ScreenGui)
            FakeNotice.Size = UDim2.new(0, 250, 0, 30)
            FakeNotice.Position = UDim2.new(0.5, -125, 0.3, 0)
            FakeNotice.Text = "LUCK UNLOCKED FOR SUBSCRIBERS!"
            FakeNotice.TextColor3 = Color3.new(1, 1, 0)
            FakeNotice.BackgroundTransparency = 1
            FakeNotice.TextSize = 20
            FakeNotice.Font = Enum.Font.GothamBold
            TweenService:Create(FakeNotice, TweenInfo.new(2), {Position = UDim2.new(0.5, -125, 0.1, 0), TextTransparency = 1}):Play()
            
            task.wait(3)
            LuckyBtn.Text = "x9999 Lucky Random Fruit"
            LuckyBtn.BackgroundColor3 = Color3.fromRGB(150, 60, 230)
        end
    end)
end

LuckyBtn.MouseButton1Click:Connect(TriggerRGB)


local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
