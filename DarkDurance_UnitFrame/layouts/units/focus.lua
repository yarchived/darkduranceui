-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local utils = addon.utils
local units = 'focus'

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
    local focus = oUF:Spawn('focus')
    focus:SetPoint('BOTTOMRIGHT', u.player, 'TOPLEFT', -10, 10)
    u.focus = focus
end)


