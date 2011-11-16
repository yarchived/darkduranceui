
local _NAME, _NS = ...

local DDUF = {}

_NS[_NAME] = DDUF
_G[_NAME] = DDUF
_G.DDUF = DDUF

-- locate oUF
_NS.oUF = _NS.oUF or _G.oUF
local oUF = _NS.oUF

local CallbackHandler = LibStub:GetLibrary'CallbackHandler-1.0'

DDUF.callbacks = CallbackHandler:New(DDUF)
DDUF.units = {}
local common_style = 'common'
local style_names = setmetatable({}, {__index = function(t, i)
    local name = ('%s -%s'):format(_NAME, name)
    t[i] = name
    return name
end})

local function styleFunc(self, ...)
    if(self.style) then
        DDUF.callbacks:Fire(common_style, self, ...)
        DDUF.callbacks:Fire(self.style, self, ...)
    end
end

local function addStyle(name, func)
    local style = rawget(style_names, name)
    if(not style) then
        oUF:RegisterStyle(name, styleFunc)
    end
    DDUF:RegisterMessage(style_names[name], func)
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
    DDUF:RegisterMessage(common_style, func)
end

function DDUF:Spawn(name, func)
    oUF:Factory(function()
        oUF:SetActiveStyle(styleName(name))
        func()
    end)
end

