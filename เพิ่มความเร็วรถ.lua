-- [[ REMOTE HUB: Vehicle Speed Boost ]] --
local speedMultiplier = 2 -- อยากให้เร็วขึ้นกี่เท่าปรับตรงนี้

local function boostVehicle()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local seat = char.Humanoid.SeatPart
        if seat and seat:IsA("VehicleSeat") then
            -- เพิ่มความเร็วโดยการคูณค่าใน MaxSpeed และ Torque (ถ้าแก้ได้จากภายนอก)
            seat.MaxSpeed = 500 -- ลองบังคับเปลี่ยนค่าโดยตรง
            
            -- หรือใช้การเร่งความเร็วผ่าน Velocity
            if seat.Velocity.Magnitude > 0 then
                seat.Velocity = seat.Velocity + (seat.CFrame.LookVector * speedMultiplier)
            end
        end
    end
end

-- รันวนลูปเพื่อให้ทำงานตลอดเวลาที่ขับ
game:GetService("RunService").Heartbeat:Connect(boostVehicle)
