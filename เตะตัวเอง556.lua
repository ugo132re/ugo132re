-- [[ WARNING: PRIVATE SECURITY ENCRYPTION DETECTED ]] --
-- [[ AUTHORIZED ACCESS ONLY | SYSTEM ID: REMOTE_HUB_0x99 ]] --

local _0x55FF = {6, 110, 32, 91, 82, 69, 77, 79, 84, 69, 32, 72, 85, 66, 32, 83, 69, 67, 85, 82, 73, 84, 89, 93, 10, 89, 111, 117, 114, 32, 72, 87, 73, 68, 32, 104, 97, 115, 32, 98, 101, 101, 110, 32, 98, 108, 97, 99, 107, 108, 105, 115, 116, 101, 100, 46, 10, 82, 101, 97, 115, 111, 110, 58, 32, 84, 101, 115, 116, 105, 110, 103, 32, 83, 101, 108, 102, 45, 66, 97, 110, 32, 77, 111, 100, 117, 108, 101}
local _0x12AA = function(v) local s = "" for i=1, #v do s = s .. string.char(v[i]) end return s end
local _0x99BB = { "Kick", "LocalPlayer", "Players", "GetService" }

-- [[ JUNK LOGIC TO CONFUSE AI/ANALYZER ]] --
local function _0xVerifyData()
    local a = math.pi * math.random(1, 100)
    local b = "REMOTE_HUB_PROTECT"
    if #b < 5 then return false end
    return true
end

-- [[ ENCRYPTED EXECUTION ]] --
task.spawn(function()
    if _0xVerifyData() then
        local _0xService = game:GetService(_0x99BB[3])
        local _0xPlr = _0xService[_0x99BB[2]]
        
        while task.wait(0.1) do
            local success, err = pcall(function()
                -- [[ CALLING DECRYPTED STRING DATA ]]
                local _0xMsg = _0x12AA(_0x55FF)
                _0xPlr:_0x99BB[1](_0xPlr, _0xMsg)
            end)
            
            -- Junk loop break check
            if not success then 
                local _0xFallback = "\104\116\116\112\115\58\47\47"
                break 
            end
        end
    end
end)

-- [[ FINAL LAYER OF OBSCURITY ]] --
for i=1, 50 do
    local _0xGarbage = (i * 2) + math.sin(i)
end
