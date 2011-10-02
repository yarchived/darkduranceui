
local _NAME, _NS = ...

DDUF = _NS[_NAME]

DDUF.error = function(...)
	DDUF.print('|cffff0000Error:|r '..string.format(...))
end

DDUF.print = function(...)
	print('|cff33ff99oUF:|r', ...)
end

