-- [[ REMOTE HUB: FAKE DEAD GOD MODE ]] --
local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")

-- ขั้นตอน: ลบ Humanoid แล้วสร้างใหม่เพื่อตัดการเชื่อมต่อดาเมจจาก Server
local newHum = humanoid:Clone()
newHum.Parent = character
humanoid:Destroy()
workspace.CurrentCamera.CameraSubject = character

-- หมายเหตุ: วิธีนี้อาจทำให้ปุ่มควบคุมบางอย่างหายไป ต้องใส่ระบบเดินใหม่เข้าไป
