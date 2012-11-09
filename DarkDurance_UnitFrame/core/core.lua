
local _NAME, _NS = ...

local DDUF = {}

_NS[_NAME] = DDUF
_G[_NAME] = DDUF
_G.DDUF = DDUF

-- locate oUF
_NS.oUF = _NS.oUF or _G.oUF
local oUF = _NS.oUF

DDUF.units = {}
local styleCallbacks = {}
DDUF.styleCallbacks = styleCallbacks

local common_style = 'common'

local style_names = setmetatable({}, {
    __index = function(t, i)
        -- preventing conflict names
        t[i] = ('%s -%s'):format(_NAME, i)
        return t[i]
    end,
})

rawset(style_names, common_style, common_style)

local meta = {
    __call = function(self, ...)
        for _, v in next, self do
            v(...)
        end
    end,
}

local function styleFunc(self, ...)
    local callbacks = self.style and styleCallbacks[self.style]
    if(callbacks) then
        styleCallbacks[common_style](self, ...)
        return callbacks(self, ...)
    end
end

function DDUF:RegisterStyle(name, func)
    if(type(func) ~= 'function') then return end

    if(type(name) == 'table') then
        for _, n in next, name do
            self:RegisterStyle(n, func)
        end
    else
        local styleName = style_names[name]
        local funcs = self.styleCallbacks[styleName]
        if(not funcs) then
            funcs = setmetatable({}, meta)
            styleCallbacks[styleName] = funcs
            oUF:RegisterStyle(styleName, styleFunc)
        end

        table.insert(funcs, func)
    end
end

function DDUF:RegsiterCommonStyle(func)
    self:RegisterStyle(common_style, func)
end

function DDUF:Spawn(args, func)
    local name
    if(type(args) == 'table') then
        name = args[1]
    else
        name = args
    end

    oUF:SetActiveStyle(style_names[name])
    local object
    if(type(args) == 'table') then
        object = oUF:Spawn(unpack(args))
    else
        -- no args in
        object = oUF:Spawn(name)
    end

    DDUF.units[name] = object
    return func(object)
end


function DDUF:SpawnHeader(name, func, ...)
    oUF:SetActiveStyle(style_names[name])
    local object = oUF:SpawnHeader(...)
    DDUF.units[name] = object
    return func(object)
end

