-- [[ REMOTE HUB: Stable Vehicle Boost (A-Chassis Support) ]] --

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

-- ปรับแต่งค่าความแรง
local boostForce = 5 -- ความแรงในการส่ง (ปรับเพิ่ม/ลดได้ตามความลื่น)
local maxSpeed = 300 -- ความเร็วสูงสุดที่อยากให้ไปถึง

RunService.Heartbeat:Connect(function()
    local char = player.Character
    local humanoid = char and char:FindFirstChild("Humanoid")
    
    -- ตรวจสอบว่านั่งอยู่บนรถไหม
    if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
        local seat = humanoid.SeatPart
        
        -- ถ้าความเร็วยังไม่เกินกำหนด
        if seat.AssemblyLinearVelocity.Magnitude < maxSpeed then
            
            -- กด W (เดินหน้า)
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + (seat.CFrame.LookVector * boostForce)
            
            -- กด S (ถอยหลัง)
            elseif UIS:IsKeyDown(Enum.KeyCode.S) then
                seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity - (seat.CFrame.LookVector * boostForce)
            end
        end
        
        -- ระบบกันรถเหิน (Anti-Flip) - ช่วยให้รถเกาะถนนขึ้น
        if UIS:IsKeyDown(Enum.KeyCode.W) or UIS:IsKeyDown(Enum.KeyCode.S) then
             -- แรงกดพื้นเบาๆ เพื่อความเสถียร
            seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + Vector3.new(0, -1, 0)
        end
    end
end)

print("✅ REMOTE HUB: Stable Boost for A-Chassis Active")
