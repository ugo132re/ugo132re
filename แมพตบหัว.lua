-- COPYRIGHT_NOTICE: STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY
-- OWNER: UGO132RE
-- NAME: REMOTE HUB (BACK-DETECTOR EDITION)

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- REMOTE HANDLER
local Events = RS:WaitForChild("Events")
local Remotes = {
    Hit = Events:WaitForChild("Hit"),
    Slap = Events:WaitForChild("Slap"),
    Choose = Events:WaitForChild("ChooseSlapper"),
    Dodge = Events:WaitForChild("Dodge")
}

-- CONFIGURATION
_G.AutoSlap = false
_G.AutoDodge = false
_G.SlapperNotifier = false

-- [INTERNAL NOTIFICATION SYSTEM]
local NotifyGui = Instance.new("ScreenGui")
NotifyGui.Name = "REMOTE_HUB_NOTIFY"
NotifyGui.Parent = CoreGui

local function ShowAlert(realName)
    local AlertText = Instance.new("TextLabel")
    AlertText.Parent = NotifyGui
    AlertText.Size = UDim2.new(1, 0, 0, 60)
    AlertText.Position = UDim2.new(0, 0, 0.25, 0)
    AlertText.BackgroundTransparency = 1
    AlertText.TextColor3 = Color3.fromRGB(255, 30, 30)
    AlertText.TextStrokeTransparency = 0
    AlertText.Font = Enum.Font.SourceSansBold
    AlertText.TextSize = 45 -- ใหญ่พิเศษอ่านง่าย
    AlertText.Text = "⚠️ BEHIND YOU: " .. realName .. " ⚠️"
    
    task.wait(2.5)
    for i = 0, 1, 0.1 do
        AlertText.TextTransparency = i
        AlertText.TextStrokeTransparency = i
        task.wait(0.05)
    end
    AlertText:Destroy()
end

-- UI CONSTRUCTION
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("ScrollingFrame")
local UIList = Instance.new("UIListLayout")

ScreenGui.Name = "REMOTE_HUB_V12"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "REMOTE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24

Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 0, 0, 50)
Container.Size = UDim2.new(1, 0, 1, -55)
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
Container.ScrollBarThickness = 0

UIList.Parent = Container
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 10)

local function CreateToggle(text, var_name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text .. ": OFF"
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = Container
    btn.MouseButton1Click:Connect(function()
        _G[var_name] = not _G[var_name]
        btn.Text = text .. ": " .. (_G[var_name] and "ON" or "OFF")
        btn.BackgroundColor3 = _G[var_name] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(35, 35, 35)
    end)
    return btn
end

-- [LOOP SYSTEMS] --

-- BACK-DETECTION LOGIC (เน้นคนประชิตหลัง)
task.spawn(function()
    local last_found = nil
    while true do
        task.wait(0.3)
        if not _G.SlapperNotifier then last_found = nil continue end
        
        pcall(function()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            local myHrp = char.HumanoidRootPart
            local found = nil
            
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = v.Character.HumanoidRootPart
                    local dist = (myHrp.Position - targetHrp.Position).Magnitude
                    
                    -- เช็คระยะประชิต (8 studs คือระยะตบที่แน่นอนที่สุด)
                    if dist < 8 then
                        -- คำนวณหาตำแหน่งว่าอยู่ข้างหลังเราหรือไม่ (Dot Product)
                        local relativePos = (targetHrp.Position - myHrp.Position).Unit
                        local backwardVec = -myHrp.CFrame.LookVector
                        local dot = relativePos:Dot(backwardVec)
                        
                        -- ถ้า dot > 0.5 แสดงว่าอยู่โซนด้านหลังเรา
                        if dot > 0.5 then
                            found = v.Name -- ใช้ชื่อจริง (Name)
                        end
                    end
                end
            end
            
            if found and found ~= last_found then
                last_found = found
                ShowAlert(found)
            elseif not found then
                last_found = nil
            end
        end)
    end
end)

-- AUTO SLAP / DODGE
task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.AutoSlap then pcall(function() Remotes.Slap:FireServer() end) end
        if _G.AutoDodge then 
            local keys = {"Z", "X", "C", "F", "G", "E", "R", "Q"}
            for _, k in ipairs(keys) do pcall(function() Remotes.Dodge:FireServer(k) end) end
        end
    end
end)

-- [INIT BUTTONS] --
local OneShotBtn = Instance.new("TextButton")
OneShotBtn.Size = UDim2.new(0.9, 0, 0, 55)
OneShotBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
OneShotBtn.Text = "CLICK TO PERFECT SLAP"
OneShotBtn.Font = Enum.Font.SourceSansBold
OneShotBtn.TextSize = 20
OneShotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OneShotBtn.Parent = Container
OneShotBtn.MouseButton1Click:Connect(function()
    pcall(function() Remotes.Hit:FireServer(1) end)
    OneShotBtn.Text = "EXECUTED!"
    task.wait(0.5)
    OneShotBtn.Text = "CLICK TO PERFECT SLAP"
end)

CreateToggle("Auto Slap", "AutoSlap")
CreateToggle("Auto Dodge", "AutoDodge")
CreateToggle("Slapper Notifier", "SlapperNotifier")
