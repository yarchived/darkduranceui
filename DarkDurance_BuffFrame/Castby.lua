-- yleaf (yaroot@gmail.com)

local cc = {}
do
    local function callback()
        for class, c in pairs(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
            cc[class] = format('|cff%02x%02x%02x', c.r*255, c.g*255, c.b*255)
        end
    end
    if(CUSTOM_CLASS_COLORS) then
        CUSTOM_CLASS_COLORS:RegisterCallback(callback)
    end
    callback()
end

local function SetCaster(self, unit, index, filter)
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, filter)
	if unitCaster then
		local uname, urealm = UnitName(unitCaster)
		local _, uclass = UnitClass(unitCaster)
		if urealm then uname = uname..'-'..urealm end
		self:AddLine('\nCast by ' .. (cc[uclass] or '|cffffffff') .. uname .. '|r (' .. unitCaster .. ')')
		self:Show()
	end
end

hooksecurefunc(GameTooltip, 'SetUnitAura', SetCaster)
--[[hooksecurefunc(GameTooltip, 'SetUnitBuff', function(self, unit, index, filter)
	filter = filter and ('HELPFUL '..filter) or 'HELPFUL'
	SetCaster(self, unit, index, filter)
end)
hooksecurefunc(GameTooltip, 'SetUnitDebuff', function(self, unit, index, filter)
	filter = filter and ('HARMFUL '..filter) or 'HARMFUL'
	SetCaster(self, unit, index, filter)
end)]]
