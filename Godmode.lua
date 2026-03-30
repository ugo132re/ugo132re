-- [[ REMOTE HUB: UNDEAD MODULE ]] --
local lp = game:GetService("\80\108\97\121\101\114\115").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("\72\117\109\97\110\111\105\100")

-- สั่งปิดสถานะการตาย
hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)

-- ลบปลั๊กที่ทำให้ตัวละครหลุดออกจากกันเมื่อตาย
if char:FindFirstChild("\100\101\115\116\114\111\121") then
    char.BreakJointsOnDeath = false
end
