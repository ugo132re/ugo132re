-- [[ REMOTE HUB: Vehicle Speed Boost (On-Press Only) ]] --

local boostPower = 1.5 -- ปรับความแรงได้ตามชอบ
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

local connection
connection = RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChild("Humanoid")
    
    if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
        local seat = humanoid.SeatPart
        
        -- เช็คว่ามีการกดปุ่มเดินหน้า (W) หรือถอยหลัง (S)
        -- Throttle > 0 คือเดินหน้า, < 0 คือถอยหลัง
        if seat.Throttle ~= 0 then
            -- เพิ่มความเร็วตามทิศทางที่รถหันไป
            seat.Parent:PivotTo(seat.Parent:GetPivot() * CFrame.new(0, 0, -boostPower * math.abs(seat.Throttle)))
        end
    end
end)

-- วิธีปิดสคริปต์: connection:Disconnect()
