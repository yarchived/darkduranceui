
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF

-- better tag api
function CreateTag(self, region, tagstr, call)
    if(type(region) == 'string') then
        region, tagstr, call = self, region, tagstr
    end

    local fs = region:CreateFontString(nil, 'OVERLAY')
    call(fs)
    self:Tag(fs, tagstr)

    return fs
end

oUF:RegisterMetaFunction('CreateTag', CreateTag)

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

oUF.Tags.Methods['dd:realname'] = [[
    function(u, r)
        return UnitName(r or u)
    end
]]

-- hook into `_ENV' in tags.lua
-- but `_ENV' is a metatable, we need to call `rawget' and `rawset'
-- to manipulate it.
local _ENV
do
    local dummy_name = 'Zei1aeLuiedoo7EeNoop0veeOhneij3aOi0shuLeAipeiPh3ohZ5aa9fZequ5guz'
    oUF.Tags.Methods[dummy_name] = [[ function() return end ]]

    local func = oUF.Tags.Methods[dummy_name]
    _ENV = getfenv(func)

    -- remove the func
    rawset(oUF.Tags.Methods, dummy_name, nil)
end

rawset(_ENV, 'Truncate', DDUF.TruncateNumber)

