-- [[ REMOTE HUB SECURITY PROTOCOL: GOD MODE MODULE ]] --
-- [[ ENCODING: ASCII | PROTECTION: METATABLE HOOK ]] --

local _0xGM = { enabled = true }
local _0xTargetRemotes = {"\84\97\107\101\68\97\109\97\103\101", "\72\105\116", "\68\97\109\97\103\101"} -- "TakeDamage", "Hit", "Damage"

local _0xMT = getrawmetatable(game)
local _0xOld = _0xMT.__namecall
setreadonly(_0xMT, false)

_0xMT.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- [[ CHECK IF GOD MODE IS ACTIVE ]] --
    if _0xGM.enabled and method == "\70\105\114\101\83\101\114\118\101\114" then
        for _, remoteName in pairs(_0xTargetRemotes) do
            if self.Name:find(remoteName) then
                -- [ SECURITY LOG: DAMAGE EVENT BLOCKED ] --
                return nil 
            end
        end
    end
    
    return _0xOld(self, ...)
end)

setreadonly(_0xMT, true)

-- [[ OPTIONAL: ADD TO YOUR PLAYER TAB ]] --
-- _0xT.p:AddToggle("T_God",{Title="God Mode (Stealth)",Default=false,Callback=function(v)_0xGM.enabled=v end})
