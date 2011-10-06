
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

oUF.Tags['dd:difficulty'] = [[
function(u)
    local l = UnitLevel(u)
    return Hex(GetQuestDifficultyColor((l > 0) and l or 99))
end
]]

