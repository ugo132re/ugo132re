-- [[ REMOTE HUB: TOUCH BYPASS ]] --
for _, v in pairs(game:GetService("\80\108\97\121\101\114\115").LocalPlayer.Character:GetDescendants()) do
    if v:IsA("\84\111\117\99\104\84\114\97\110\115\109\105\116\116\101\114") then
        v:Destroy() -- ลบตัวส่งสัญญาณการสัมผัสทิ้ง
    end
end
