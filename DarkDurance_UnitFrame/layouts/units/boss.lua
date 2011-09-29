
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES
local units = {}
for i = 1, MAX_BOSS_FRAMES do
    table.insert(units, 'boss' .. i)
end

addon:addLayoutElement(units, function(self, unit)

end)



addon:spawn(function(self, unit)
    local u = addon.units
    for i = 1, MAX_BOSS_FRAMES do
        local unit = units[i]
        local frame = oUF:Spawn(unit)

        u[unit] = frame

        if(i == 1) then
            frame:SetPoint('TOP', UIParent, 'TOP', 0, -5)
        else
            local pre = addon.units[units[i-1]]

            frame:SetPoint('TOP', pre, 'BOTTOM', 0, -5)
        end
    end
end)





