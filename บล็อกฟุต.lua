-- COPYRIGHT_NOTICE: STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY
-- OWNER: UGO132RE | BRAND: REMOTE HUB
-- RULE_3: CRASH_SYSTEM_ON_BREACH

local _0x5248 = "COPYRIGHT_NOTICE: STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY"
if not string.find(_0x5248, "STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY") then
    while true do Instance.new("Part", workspace) end 
end

-- Advanced Variable Obfuscation
local _0x1A = game:GetService("\80\108\97\121\101\114\115") -- Players
local _0x1B = _0x1A.LocalPlayer
local _0x1C = _0x1B:WaitForChild("\80\108\97\121\101\114\71\117\105") -- PlayerGui
local _0x1D = game:GetService("\82\101\112\108\105\99\97\116\101\100\83\116\111\114\97\103\101") -- ReplicatedStorage
local _0x1E = game:GetService("\86\105\114\116\117\97\108\85\115\101\114") -- VirtualUser

if _0x1C:FindFirstChild("\82\69\77\79\84\69\95\72\85\66\95\86\54") then _0x1C["\82\69\77\79\84\69\95\72\85\66\95\86\54"]:Destroy() end

local _0x2A = Instance.new("\83\99\114\101\101\110\71\117\105", _0x1C)
_0x2A.Name = "\82\69\77\79\84\69\95\72\85\66\95\86\54"
_0x2A.ResetOnSpawn = false

local _0x2B = Instance.new("\70\114\97\109\101", _0x2A)
_0x2B.Size, _0x2B.Position = UDim2.new(0, 220, 0, 120), UDim2.new(0.5, -110, 0.4, -60)
_0x2B.BackgroundColor3, _0x2B.Active, _0x2B.Draggable = Color3.fromRGB(20, 20, 20), true, true
Instance.new("\85\73\67\111\114\110\101\114", _0x2B).CornerRadius = UDim.new(0, 10)

local _0x2C = Instance.new("\84\101\120\116\76\97\98\101\108", _0x2B)
_0x2C.Size, _0x2C.Text, _0x2C.TextColor3, _0x2C.BackgroundTransparency = UDim2.new(1, 0, 0, 35), "REMOTE HUB", Color3.new(1,1,1), 1

local _0x2D = Instance.new("\84\101\120\116\66\117\116\116\111\110", _0x2B)
_0x2D.Size, _0x2D.Position, _0x2D.Text = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.45, 0), "ตีไกล: OFF"
_0x2D.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("\85\73\67\111\114\110\101\114", _0x2D).CornerRadius = UDim.new(0, 8)

local _0xCFG = { E = false, R = 100, D = 0.035, K = "\52\49\56\53\54\50\55\99" }
local _0xHIT = _0x1D:WaitForChild("\77\111\100\117\108\101\115"):WaitForChild("\78\101\116"):WaitForChild("\82\69\47\82\101\103\105\115\116\101\114\72\105\116")

task.spawn(function()
    local h = 0
    while true do
        h = h + 1/360
        local c = Color3.fromHSV(h, 0.7, 1)
        if _0xCFG.E then _0x2D.BackgroundColor3, _0x2D.Text = c, "ตีไกล: ON" else _0x2D.BackgroundColor3, _0x2D.Text = Color3.fromRGB(35, 35, 35), "ตีไกล: OFF" end
        task.wait()
    end
end)

_0x2D.MouseButton1Click:Connect(function() _0xCFG.E = not _0xCFG.E end)

task.spawn(function()
    while true do
        if _0xCFG.E and _0x1B.Character and _0x1B.Character:FindFirstChildOfClass("\84\111\111\108") then
            local p = _0x1B.Character.HumanoidRootPart.Position
            local t = {}
            local function s(v)
                if v and v:FindFirstChild("\72\101\97\100") and v:FindFirstChild("\72\117\109\97\110\111\105\100") and v.Humanoid.Health > 0 then
                    if (p - v.Head.Position).Magnitude <= _0xCFG.R then table.insert(t, v.Head) end
                end
            end
            for _, v in pairs(workspace.Enemies:GetChildren()) do s(v) end
            for _, pl in pairs(_0x1A:GetPlayers()) do if pl ~= _0x1B then s(pl.Character) end end
            if #t > 0 then
                _0x1E:CaptureController()
                _0x1E:ClickButton1(Vector2.new(0,0))
                for _, target in pairs(t) do task.spawn(function() _0xHIT:FireServer(target, {}, _0xCFG.K) end) end
            end
        end
        task.wait(_0xCFG.D)
    end
end)
