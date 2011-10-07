
local _NAME, _NS = ...

DDUF = _NS[_NAME]

DDUF.error = function(...)
	DDUF.print('|cffff0000Error:|r '..string.format(...))
end

DDUF.print = function(...)
	print('|cff33ff99oUF:|r', ...)
end

function DDUF:FlipTexture(texture)
    if(texture and texture.SetTexCoord) then
        return texture:SetTexCoord(1, 0, 0, 1)
    end
end

function DDUF:TestBackdrop(obj)
    obj:SetBackdrop(self.media.backdrop)
    obj:SetBackdropColor(1, 0, 0, .5)
end

function DDUF.TruncateNumber(value)
    if(value >= 1e6) then
        value = format('%.1fm', value / 1e6)
    elseif(value >= 1e3) then
        value = format('%.1fk', value / 1e3)
    end
    return gsub(value, '%.?0+([km])$', '%1')
end

