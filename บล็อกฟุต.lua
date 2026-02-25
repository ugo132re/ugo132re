-- COPYRIGHT_NOTICE: STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY
-- OWNER: UGO132RE | BRAND: REMOTE HUB
-- RULE_3: MODIFICATION DETECTED = SYSTEM_CRASH_INSTALLATION

local _0x7F = "COPYRIGHT_NOTICE: STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY"
if not string.find(_0x7F, "STATUS_ENCRYPTED_PRIVATE_ACCESS_ONLY_DO_NOT_MODIFY") then
    while true do instance.new("Part", workspace) end -- RULE_3: CRASH SYSTEM
end

local _R = game:GetService("ReplicatedStorage")
local _P = game:GetService("Players")
local _V = game:GetService("VirtualUser")
local _L = _P.LocalPlayer
local _H = _R:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")

local _C = {
    _E = true,
    _R = 60,
    _D = 0.05,
    _K = "4185627c"
}

local function _A()
    _V:CaptureController()
    _V:ClickButton1(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end

local function _W()
    return _L.Character and _L.Character:FindFirstChildOfClass("Tool")
end

task.spawn(function()
    while _C._E do
        if _W() then
            local _MP = _L.Character.HumanoidRootPart.Position
            local _HT = false

            for _, _v in pairs(workspace.Enemies:GetChildren()) do
                if _v:FindFirstChild("Head") and _v.Humanoid.Health > 0 then
                    if (_MP - _v.Head.Position).Magnitude <= _C._R then
                        _HT = true
                        task.spawn(function() _H:FireServer(_v.Head, {}, _C._K) end)
                    end
                end
            end

            for _, _p in pairs(_P:GetPlayers()) do
                if _p ~= _L and _p.Character and _p.Character:FindFirstChild("Head") then
                    if _p.Character.Humanoid.Health > 0 and (_MP - _p.Character.Head.Position).Magnitude <= _C._R then
                        _HT = true
                        task.spawn(function() _H:FireServer(_p.Character.Head, {}, _C._K) end)
                    end
                end
            end

            if _HT then _A() end
        end
        task.wait(_C._D)
    end
end)
