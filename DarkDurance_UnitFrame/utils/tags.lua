-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local tags = {}
addon.tags = tags
local utils = addon.utils

tags.name = '[difficulty][smartlevel]|r [raidcolor][name4]|r'
tags.majorname = '[raidcolor][name]|r'
tags.hp = '[colorhealth][hp]|r'
tags.mp = '[colorpower][mp]|r'
tags.lvl = '[difficulty][level]|r'

for i = 1, 10 do
    local token = 'name' .. i
    tags[token] = '[raidcolor][' .. token .. ']|r'
    oUF.Tags[token] = function(u)
        local n = UnitName(u)
        if(not n) then return end

        if(strbyte(n,1) > 224) then
            return utils.utf8sub(n, i)
        else
            return utils.utf8sub(n, i*2)
        end
    end
end

oUF.Tags.difficulty = [=[function(u)
    local l = UnitLevel(u)
    return Hex(GetQuestDifficultyColor((l>0) and l or 99))
end]=]

oUF.Tags.colorhealth = [=[function(u)
    return Hex(_COLORS.health)
end]=]

oUF.Tags.colorpower = [=[function(u)
    local _, t = UnitPowerType(u)
    local c = t and _COLORS.power[t]
    if(c) then
        return Hex(c)
    end
end]=]

oUF.Tags.hp = function(u)
    local hp = UnitHealth(u)
    return hp and utils.truncate(hp)
end
oUF.TagEvents.hp = oUF.TagEvents.curhp

oUF.Tags.mp = function(u)
    local mp = UnitPower(u)
    return mp and utils.truncate(mp)
end
oUF.TagEvents.mp = oUF.TagEvents.curpp

oUF.Tags.lostperhp = [[function(u)
    local min, max = UnitHealth(u), UnitHealthMax(u)
    if(min ~= max) then
        if(max == 0) then
            return 0
        else
            return math.floor(min/max * 100 + .5)
        end
    end
end]]
oUF.TagEvents.lostperhp = oUF.TagEvents.curhp




