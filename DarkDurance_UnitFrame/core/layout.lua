
local _NAME, _NS = ...
local oUF = _NS.oUF
local DDUF = _NS[_NAME]

DDUF.styles = {}
DDUF.unit = {}

local style_mt = {
    __call = function(funcs, self, ...)
        for _, func in next, funcs do
            func(self, ...)
        end
    end,
}

function DDUF:UnitStyle(unit, func)
    if(not func) then return end
    if(type(units) == 'table') then
        for _, u in next, unit do
            self:UnitStyle(u, func)
        end
    else
        if(not self.styles[unit]) then
            self.styles = setmetatable({}, style_mt)
        end
        tinsert(self.styles[unit], func)
    end
end

function DDUF:UnitCommonStyle(func)
    self:UnitStyle('common', func)
end

function DDUF:Spawn(func)
    oUF:Factory(func)
end

oUF:RegisterStyle(_NAME, function(self, unit)
    local funcs = DDUF.styles[unit]
    if(funcs) then
        DDUF.styles.common(self, unit)
        funcs(self, unit)
    else

    end
end)

oUF:SetActiveStyle(_NAME)

