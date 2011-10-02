
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF

function DDUF:CreateTag(obj, region, tagstr, call)
    local fs = region:CreateFontString()
    call(fs)
    obj:Tag(fs, tagstr)

    return fs
end

