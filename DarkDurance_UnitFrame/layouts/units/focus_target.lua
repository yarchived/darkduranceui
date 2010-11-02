-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local utils = addon.utils
local units = 'focustarget'

local function func(self, unit)
    ns.style_party(self, unit)

    local nametag = self:CreateFontString(nil, 'OVERLAY')
    nametag:SetPoint('TOP', self, 'BOTTOM', 0, -2)
    nametag:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
    self:Tag(nametag, '[difficulty][smartlevel]|r [raidcolor][name4]|r')
end

addon:addLayoutElement(units, func)
addon:setSize(units, 90, 90)

addon:spawn(function()
    local u = addon.units
    local ft = oUF:Spawn('focustarget')
    ft:SetPoint('BOTTOMRIGHT', u.focus, 'BOTTOMLEFT', -5, 0)
    u.focustarget = ft
end)


