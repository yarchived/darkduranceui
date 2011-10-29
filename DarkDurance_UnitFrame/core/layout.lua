
local _NAME, _NS = ...
local oUF = _NS.oUF
local DDUF = _NS[_NAME]

DDUF.styles = {}
DDUF.units = {}
DDUF.commonFuncs = {}

local function styleName(name)
    return ('%s - %s'):format(_NAME, name)
end

local style_mt = {
    __call = function(self, ...)
        for _, func in next, self do
            func(...)
        end
    end,
}
setmetatable(DDUF.commonFuncs, style_mt)

local function styleFunc(self, unit)
    local name = self.style
    local styleFunc = name and DDUF.styles[name]
    if(styleFunc) then
        DDUF.commonFuncs(self, unit)
        styleFunc(self, unit)
    end
end

local function addStyle(name, func)
    name = styleName(name)

    local funcs = DDUF.styles[name]

    if(not funcs) then
        oUF:RegisterStyle(name, styleFunc)
        funcs = setmetatable({}, style_mt)
        DDUF.styles[name] = funcs
    end

    table.insert(funcs, func)
end

function DDUF:RegisterStyle(name, func)
    if(not func) then return end

    if(type(name) == 'table') then
        for _, n in next, name do
            addStyle(n, func)
        end
    else
        addStyle(name, func)
    end
end

function DDUF:RegsiterCommonStyle(func)
    table.insert(self.commonFuncs, func)
end

function DDUF:Spawn(name, func)
    oUF:Factory(function()
        oUF:SetActiveStyle(styleName(name))
        func()
    end)
end

