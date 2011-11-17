
local _NAME, _NS = ...

local DDUF = {}

_NS[_NAME] = DDUF
_G[_NAME] = DDUF
_G.DDUF = DDUF

-- locate oUF
_NS.oUF = _NS.oUF or _G.oUF
local oUF = _NS.oUF

DDUF.units = {}
DDUF.styles = {}

local common_style = 'common'

local style_names = setmetatable({}, {
    __index = function(t, i)
        -- preventing conflict names
        t[i] = ('%s -%s'):format(_NAME, i)
        return t[i]
    end,
})

local meta = {
    __call = function(self, ...)
        for _, v in next, self do
            v(...)
        end
    end,
}

local function styleFunc(self, ...)
    if(self.style and DDUF.styles[self.style]) then
        DDUF.styles[common_style](self, ...)
        DDUF.styles[self.style](self, ...)
    end
end

function DDUF:RegisterStyle(name, func)
    if(not func) then return end

    if(type(name) == 'table') then
        for _, n in next, name do
            self:RegisterStyle(n, func)
        end
    else
        name = name == common_style and common_style or style_names[name]
        if(not self.styles[name]) then
            self.styles[name] = setmetatable({}, meta)
            oUF:RegisterStyle(name, styleFunc)
        end

        table.insert(self.styles[name], func)
    end
end

function DDUF:RegsiterCommonStyle(func)
    self:RegisterStyle(common_style, func)
end

function DDUF:Spawn(name, func)
    oUF:Factory(function()
        oUF:SetActiveStyle(style_names[name])
        func()
    end)
end

