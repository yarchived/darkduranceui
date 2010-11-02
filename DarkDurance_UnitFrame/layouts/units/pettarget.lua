-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local utils = addon.utils
local units = 'pettarget'

local function func(self, unit)
    local tex = self:CreateTexture(nil, 'ARTWORK')
    tex:SetTexture(utils.mediaPath .. 'ToToTFrame')
    utils.setSize(tex, 128, 64)
    tex:SetPoint('CENTER', self)

    local bg = self.bg:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture(utils.mediaPath .. 'ToToTBackground')
    utils.setSize(bg, 128, 64)
    bg:SetPoint('CENTER', self)

    local hp = CreateFrame('StatusBar', nil, self)
    self.Health = hp
    hp:SetPoint('CENTER', self)
    utils.setSize(hp, 102, 25)
    hp:SetFrameStrata('LOW')
    hp:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
    hp.colorClass = true

    local dog = self:CreateFontString(nil, 'OVERLAY')
    dog:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    dog:SetPoint('CENTER', self, 0, 2)
    self:Tag(dog, '[raidcolor][name4] [colorhealth][lostperhp<%]|r')
end

addon:addLayoutElement(units, func)
addon:setSize(units, 120, 23)

addon:spawn(function()
    local u = addon.units
    local pt = oUF:Spawn('pettarget')
    pt:SetPoint('BOTTOMRIGHT', u.pet, 'BOTTOMLEFT', 0, -2)
    u.pettarget = pt
end)


