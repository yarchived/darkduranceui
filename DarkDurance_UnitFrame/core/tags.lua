
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF

-- better tag api
function CreateTag(self, region, tagstr, call)
    local fs = region:CreateFontString()
    call(fs)
    self:Tag(fs, tagstr)

    return fs
end

oUF:RegisterMetaFunction('CreateTag', CreateTag)

