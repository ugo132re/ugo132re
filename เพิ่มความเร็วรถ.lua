-- [[ REMOTE HUB: Vehicle Manual Boost (W/S Keys) ]] --

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

-- ตั้งค่าความแรง
local boostSpeed = 2 -- เพิ่มความเร็ว (ยิ่งเยอะยิ่งแรง)

RunService.Heartbeat:Connect(function()
    local char = player.Character
    local humanoid = char and char:FindFirstChild("Humanoid")
    
    if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
        local seat = humanoid.SeatPart
        
        -- ตรวจสอบว่ากำลังกดปุ่มอะไรอยู่
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            -- กด W: ส่งแรงไปข้างหน้า (LookVector)
            seat.Velocity = seat.Velocity + (seat.CFrame.LookVector * boostSpeed)
            
        elseif UIS:IsKeyDown(Enum.KeyCode.S) then
            -- กด S: ส่งแรงไปข้างหลัง (-LookVector)
            seat.Velocity = seat.Velocity - (seat.CFrame.LookVector * boostSpeed)
        end
        
        -- แถม: ระบบเบรก (กด Space เพื่อหยุดแรงเฉื่อย)
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            seat.Velocity = seat.Velocity * 0.9 -- ค่อยๆ ลดความเร็วลงจนหยุด
        end
    end
end)

print("✅ REMOTE HUB: Vehicle Boost (W/S) Active")
