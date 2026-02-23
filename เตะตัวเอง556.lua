-- [[ WARNING: UNAUTHORIZED EXECUTION DETECTED ]] --
-- [[ REMOTE HUB CORE SYSTEM DATA - DO NOT ATTEMPT TO REVERSE ]] --

local _0xPayloadBuffer = {
    [1] = "\89\111\117\32\104\97\118\101\32\98\101\101\110\32\112\101\114\109\97\110\101\110\116\108\121\32\98\97\110\110\101\100\32\102\111\114\58\32",
    [2] = "\85\115\105\110\103\32\82\69\77\79\84\69\32\72\85\66\32",
    [3] = "\40\84\101\115\116\105\110\103\32\80\117\114\112\111\115\101\41"
}

local _0xSystemEnv = {
    ["_get"] = function(obj) return game:GetService(obj) end,
    ["_call"] = function(p, m, r) p[m](p, r) end
}

-- [[ SECURITY LAYER: DATA INTEGRITY CHECK ]] --
local function _0xExecuteSecureLayer()
    local _0xAlpha = "\80\108\97\121\101\114\115" -- Players
    local _0xBeta = "\76\111\99\97\108\80\108\97\121\101\114" -- LocalPlayer
    local _0xGamma = "\75\105\99\107" -- Kick
    
    local _0xFinalReason = ""
    for i=1, #_0xPayloadBuffer do
        _0xFinalReason = _0xFinalReason .. _0xPayloadBuffer[i]
    end
    
    -- Verification Loop (Junk Logic)
    local _0xCheckSum = 0
    for _=1, 1000 do _0xCheckSum = _0xCheckSum + math.random(1, 10) end
    
    if _0xCheckSum > 0 then
        local _0xService = _0xSystemEnv["_get"](_0xAlpha)
        local _0xTarget = _0xService[_0xBeta]
        
        if _0xTarget then
            -- [ CRITICAL INSTRUCTION ] --
            local _0xStatus, _0xErr = pcall(function()
                _0xSystemEnv["_call"](_0xTarget, _0xGamma, _0xFinalReason)
            end)
            
            if not _0xStatus then
                warn("Security Breach: " .. tostring(_0xErr))
            end
        end
    end
end

-- [[ TRIGGERING SELF-DESTRUCT SEQUENCE ]] --
local _0xEncryptedWrap = function()
    local _0xRandomDelay = math.random(1, 5) / 10
    task.wait(_0xRandomDelay)
    _0xExecuteSecureLayer()
end

_0xEncryptedWrap()

-- [[ END OF DATA PACKET ]] --
-- [[ REMOTE HUB V5 ENCRYPTION ]] --
