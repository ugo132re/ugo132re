-- [[ REMOTE HUB: Ultra-Stable + Sharp Turning ]] --

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local boostForce = 8
local maxSpeed = 600
local downforce = 45 -- ปรับให้กดหนึบขึ้นนิดนึง

RunService.Heartbeat:Connect(function()
    local char = player.Character
    local seat = char and char.Humanoid.SeatPart
    
    if seat and seat:IsA("VehicleSeat") then
        local currentSpeed = seat.AssemblyLinearVelocity.Magnitude
        
        -- 1. ระบบส่งกำลัง (W/S)
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            if currentSpeed < maxSpeed then
                seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + (seat.CFrame.LookVector * boostForce)
            end
        elseif UIS:IsKeyDown(Enum.KeyCode.S) then
            seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity - (seat.CFrame.LookVector * boostForce)
        end

        -- 2. ระบบ Downforce (ยิ่งเร็ว ยิ่งกด)
        if currentSpeed > 100 then
            seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + (Vector3.new(0, -1, 0) * (currentSpeed / downforce))
        end

        -- 3. Adaptive Steering (ระบบเลี้ยวอัจฉริยะ)
        if currentSpeed > 150 then
            -- ถ้าไม่ได้กดเลี้ยว (A หรือ D) ให้ล็อครถไว้นิ่งๆ
            if not (UIS:IsKeyDown(Enum.KeyCode.A) or UIS:IsKeyDown(Enum.KeyCode.D)) then
                seat.AssemblyAngularVelocity = seat.AssemblyAngularVelocity * 0.7 -- ล็อคทางตรงให้นิ่ง
            else
                -- ถ้ากดเลี้ยว ให้ช่วยส่งแรงหมุนให้เลี้ยวคมขึ้น (Buff Turning)
                local turnDirection = UIS:IsKeyDown(Enum.KeyCode.A) and 1 or -1
                local turnPower = currentSpeed / 200 -- ยิ่งเร็วยิ่งช่วยหมุน
                seat.AssemblyAngularVelocity = seat.AssemblyAngularVelocity + Vector3.new(0, turnDirection * turnPower, 0)
            end
        end
    end
end)
