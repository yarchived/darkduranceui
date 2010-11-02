-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local utils = addon.utils
local units = 'targettarget'

local function func(self, unit)
    --self:SetBackdrop(utils.backdrop)
    --self:SetBackdropColor(0,0,0, .5)

    local texture = self:CreateTexture(nil, 'ARTWORK')
    texture:SetTexture(utils.mediaPath .. 'ToTFrame')
    utils.setSize(texture, 256, 128)
    texture:SetPoint('CENTER', self)

    local bg = self.bg:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture(utils.mediaPath .. 'ToTBackground')
    utils.setSize(bg, 256, 128)
    bg:SetPoint('CENTER', self)

    local port = CreateFrame('PlayerModel', nil, self)
    self.Portrait = port
    port:SetFrameStrata'BACKGROUND'
    utils.setSize(port, 35, 35)
    port:SetPoint('TOPLEFT', self, 5, -5)

    local hp = CreateFrame('StatusBar', nil, self)
    self.Health = hp
    hp:SetPoint('BOTTOMLEFT', self, 48, -2)
    utils.setSize(hp, 93, 25)
    hp:SetFrameStrata('LOW')
    hp:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
    hp.colorClass = true
    --utils.testBackdrop(hp)

    local dog = self:CreateFontString(nil, 'OVERLAY')
    dog:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    dog:SetPoint('CENTER', self, 15, -13)
    self:Tag(dog, '[raidcolor][name4]|r [colorhealth][lostperhp<%]|r')
end


addon:addLayoutElement(units, func)
addon:setSize(units, 150, 50)

addon:spawn(function()
    local u = addon.units
    local tot = oUF:Spawn('targettarget')
    tot:SetPoint('TOPLEFT', u.target, 'BOTTOMLEFT', -55, 25)
    u.tot = tot
end)



