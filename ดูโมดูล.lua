-- [[ REMOTE HUB: Module Scanner ]] --

local targetName = "Settings" -- เปลี่ยนชื่อตามโมดูลที่นายต้องการสแกน
local found = false

for _, module in pairs(game:GetDescendants()) do
    if module:IsA("ModuleScript") and module.Name == targetName then
        found = true
        print("------------------------------------------")
        print("🔍 Found Module: " .. module:GetFullName())
        
        -- โหลดข้อมูลออกมาดู
        local success, data = pcall(function() return require(module) end)
        
        if success and type(data) == "table" then
            print("📜 Data inside [" .. module.Name .. "]:")
            print("{")
            for key, value in pairs(data) do
                print("   [" .. tostring(key) .. "] = " .. tostring(value) .. " (" .. type(value) .. ")")
            end
            print("}")
        else
            warn("❌ Could not require module or it's not a table.")
        end
        print("------------------------------------------")
    end
end

if not found then
    warn("⚠️ Module named '" .. targetName .. "' not found in game.")
end
