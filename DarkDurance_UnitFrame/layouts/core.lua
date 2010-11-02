-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF
local config = addon.cfg

-- locals
local tinsert = table.insert
local type = type
local format = string.format

-- func pool
local styleFuncs = {
--  ['unit'] = {
--      function() end,
--      function() end,
--  },
}
addon.styleFuncs = styleFuncs

local function addElement(unit, func)
    if not (unit and func) then return end
    local funcs = styleFuncs[unit]
    if(not funcs) then
        funcs = {}
        styleFuncs[unit] = funcs
    end
    tinsert(funcs, func)
end

function addon:addLayoutElement(units, func)
    if(type(units) == 'table') then
        for k, v in pairs(units) do
            addElement(v, func)
        end
    else
        addElement(units, func)
    end
end

function addon:addCommonElement(func)
    addElement('common', func)
end

function addon:setSize(unit, w, h, scale)
    if(unit and w and h) then
        local func = function(self, unit)
            self:SetAttribute('initial-width', w)
            self:SetAttribute('initial-height', h or w)

            self:SetAttribute('initial-scale', (scale or 1) * config.Global_Scale)
        end
        self:addLayoutElement(unit, func)
    end
end

oUF:RegisterInitCallback(function(self)
    if not (self.hasChildren or self.isChild) then
        local w, h, s = self:GetAttribute'initial-width', self:GetAttribute'initial-height', self:GetAttribute'initial-scale'
        if(w) then self:SetWidth(w) end
        if(h) then self:SetHeight(h) end
        if(s) then self:SetScale(s) end
    end
end)

addon:addCommonElement(function(self, unit)
    --self:SetAttribute('toggleForVehicle', nil)
end)

function addon:spawn(func)
    if(IsLoggedIn()) then
        func()
    else
        oUF:EnableFactory()
        oUF:Factory(func)
    end
end

oUF:RegisterStyle(addonName, function(self, unit)
    --print('style call', self, unit)
    for _, func in pairs(styleFuncs.common) do
        func(self, unit)
    end

    local funcs = styleFuncs[unit]
    if(funcs) then
        for i = 1, #funcs do
            local func = funcs[i]
            func(self, unit)
        end
    else
        oUF.error("There's no style registered for [%s].", unit)
    end
end)
oUF:SetActiveStyle(addonName)

addon.units = {}


