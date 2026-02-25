-- COPYRIGHT_NOTICE: STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY
-- OWNER: UGO132RE | BRAND: REMOTE HUB
-- RULE_3: CRASH_SYSTEM_ON_BREACH

local _0x_AUTH = "COPYRIGHT_NOTICE: STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY"
if not string.find(_0x_AUTH, "STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY") then
    while true do Instance.new("Part", workspace) end 
end

local _P = game:GetService("Players")
local _L = _P.LocalPlayer
local _PG = _L:WaitForChild("PlayerGui")
local _RE = game:GetService("ReplicatedStorage")
local _VU = game:GetService("VirtualUser")

if _PG:FindFirstChild("REMOTE_HUB_V6_RGB") then _PG.REMOTE_HUB_V6_RGB:Destroy() end

local _0x_G = Instance.new("ScreenGui", _PG)
_0x_G.Name = "REMOTE_HUB_V6_RGB"
_0x_G.ResetOnSpawn = false

local _0x_M = Instance.new("Frame", _0x_G)
_0x_M.Size = UDim2.new(0, 220, 0, 120)
_0x_M.Position = UDim2.new(0.5, -110, 0.4, -60)
_0x_M.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_0x_M.Active = true
_0x_M.Draggable = true

local _0x_C1 = Instance.new("UICorner", _0x_M)
_0x_C1.CornerRadius = UDim.new(0, 10)

local _0x_T = Instance.new("TextLabel", _0x_M)
_0x_T.Size = UDim2.new(1, 0, 0, 35)
_0x_T.Text = "REMOTE HUB"
_0x_T.TextColor3 = Color3.fromRGB(255, 255, 255)
_0x_T.BackgroundTransparency = 1
_0x_T.TextSize = 18
_0x_T.Font = Enum.Font.GothamBold

local _0x_B = Instance.new("TextButton", _0x_M)
_0x_B.Size = UDim2.new(0.9, 0, 0, 50)
_0x_B.Position = UDim2.new(0.05, 0, 0.45, 0)
_0x_B.Text = "ตีไกล: OFF"
_0x_B.TextSize = 16
_0x_B.Font = Enum.Font.GothamSemibold
_0x_B.TextColor3 = Color3.fromRGB(255, 255, 255)
_0x_B.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local _0x_C2 = Instance.new("UICorner", _0x_B)
_0x_C2.CornerRadius = UDim.new(0, 8)

-- RULE_4: Stability & Long-Range Calibration
local _0x_ST = { E = false, R = 100, D = 0.035, K = "4185627c" } 
local _0x_H = _RE:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")

task.spawn(function()
    local h = 0
    while true do
        h = h + 1/360
        if h > 1 then h = 0 end
        local c = Color3.fromHSV(h, 0.7, 1)
        if _0x_ST.E then
            _0x_B.BackgroundColor3 = c
            _0x_B.Text = "ตีไกล: ON"
        else
            _0x_B.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            _0x_B.Text = "ตีไกล: OFF"
        end
        task.wait()
    end
end)

_0x_B.MouseButton1Click:Connect(function()
    _0x_ST.E = not _0x_ST.E
end)

-- OVERDRIVE CORE: LONG RANGE EDITION
task.spawn(function()
    while true do
        if _0x_ST.E and _L.Character and _L.Character:FindFirstChildOfClass("Tool") then
            local p = _L.Character.HumanoidRootPart.Position
            local targets = {}
            local function scan(v)
                if v and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local dist = (p - v.Head.Position).Magnitude
                    if dist <= _0x_ST.R then table.insert(targets, v.Head) end
                end
            end
            for _, v in pairs(workspace.Enemies:GetChildren()) do scan(v) end
            for _, pl in pairs(_P:GetPlayers()) do if pl ~= _L then scan(pl.Character) end end
            if #targets > 0 then
                _VU:CaptureController()
                _VU:ClickButton1(Vector2.new(0,0))
                for _, target in pairs(targets) do 
                    task.spawn(function() _0x_H:FireServer(target, {}, _0x_ST.K) end)
                end
            end
        end
        task.wait(_0x_ST.D)
    end
end)
