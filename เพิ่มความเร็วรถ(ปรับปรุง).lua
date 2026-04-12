-- [[ REMOTE HUB: Ultra-Stable High Speed Boost ]] --

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local boostForce = 8    -- แรงส่ง
local maxSpeed = 600      -- ปลดล็อคความเร็วสูงสุด
local downforce = 50    -- แรงกดพื้น (หัวใจสำคัญที่ทำให้รถไม่บิน)

RunService.Heartbeat:Connect(function()
    local char = player.Character
    local seat = char and char.Humanoid.SeatPart
    
    if seat and seat:IsA("VehicleSeat") then
        -- 1. ระบบส่งกำลัง (W/S)
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            if seat.AssemblyLinearVelocity.Magnitude < maxSpeed then
                seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + (seat.CFrame.LookVector * boostForce)
            end
        elseif UIS:IsKeyDown(Enum.KeyCode.S) then
            seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity - (seat.CFrame.LookVector * boostForce)
        end

        -- 2. ระบบ Downforce (กดรถให้ติดพื้นตลอดเวลา)
        -- ยิ่งวิ่งเร็ว แรงกดยิ่งเยอะ รถจะนิ่งมาก
        local currentSpeed = seat.AssemblyLinearVelocity.Magnitude
        if currentSpeed > 100 then
            seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + (Vector3.new(0, -1, 0) * (currentSpeed / downforce))
        end

        -- 3. ระบบ Anti-Spin (ลดการส่าย)
        -- ช่วยล็อคไม่ให้รถหมุนติ้วเวลาเลี้ยวที่ความเร็วสูง
        if currentSpeed > 200 then
            seat.AssemblyAngularVelocity = seat.AssemblyAngularVelocity * 0.85
        end
    end
end)

print("✅ REMOTE HUB: Ultra Stability Loaded (400+ km/h support)")
