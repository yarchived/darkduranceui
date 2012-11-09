
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF


oUF.Tags.Methods['dd:difficulty'] = [[
    function(u)
        local l = UnitLevel(u)
        return Hex(GetQuestDifficultyColor((l > 0) and l or 99))
    end
]]

oUF.Tags.Methods['dd:smarthp'] = [[
    function(u, r)
        local cur, max = UnitHealth(u), UnitHealthMax(u)
        if(not max) then return end
        if(max == 0) then max = 1 end

        if(not UnitIsConnected(r or u)) then
            return 'Offline'
        elseif(UnitIsGhost(u)) then
            return 'Ghost'
        elseif(UnitIsFeignDeath(u)) then
            return '|cffff3333FD|r'
        elseif(UnitIsDead(u)) then
            return 'Dead'
        else
            if(cur == max) then
                return '|cff98c290' .. Truncate(max)
            else
                local r, g, b = ColorGradient(cur, max, 245/255, 68/255, 68/255, 245/255, 186/255, 69/255, 105/255, 201/255, 105/255)
                local color = Hex(r, g, b)
                return ('|cfffd5c69%s |cffdbf6db- %s%d%%|r'):format(Truncate(cur), color, floor(cur/max*100))
            end
        end
    end
]]
oUF.Tags.Events['dd:smarthp'] = oUF.Tags.Events['missinghp']

oUF.Tags.Methods['dd:pp'] = [[
    function(u, r)
        local color = _COLORS.power[select(2, UnitPowerType(u))]
        return Hex(color) .. Truncate(UnitPower(u))
    end
]]
oUF.Tags.Events['dd:pp'] = oUF.Tags.Events.curpp

oUF.Tags.Methods['dd:realname'] = [[
    function(u, r)
        local name, realm = UnitName(r or u)
        if(realm) then
            name = name .. '-*'
        end
        return name
    end
]]

do
    local _ENV = getfenv(oUF.Tags.Methods.level)
    rawset(_ENV, 'Truncate', DDUF.TruncateNumber)
end


local instance, func, proxyfunc, proxy

proxyfunc = function(self, ...)
    func(instance, ...)
    return proxy
end

proxy = setmetatable({
    done = function()
        return instance
    end,
}, {
    __index = function(self, key)
        func = instance[key]
        return proxyfunc
    end,
})

-- better tag api
function CreateTag(self, region, tagstr)
    if(type(region) == 'string') then
        region, tagstr = self, region
    end

    local fs = region:CreateFontString(nil, 'OVERLAY')
    self:Tag(fs, tagstr)

    instance = fs

    return proxy
end

oUF:RegisterMetaFunction('CreateTag', CreateTag)

