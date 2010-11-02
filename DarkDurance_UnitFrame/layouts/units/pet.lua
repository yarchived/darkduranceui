-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local utils = addon.utils
local units = 'pet'

local function func(self, unit)
    --utils.testBackdrop(self)

    local tex = self:CreateTexture(nil, 'ARTWORK')
    tex:SetTexture(utils.mediaPath .. 'ToTFrame')
    utils.setSize(tex, 256, 128)
    tex:SetPoint('CENTER', self)
    utils.reverseTexture(tex)
    self.texture = tex

    local bg = self.bg:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture(utils.mediaPath .. 'ToTBackground')
    utils.setSize(bg, 256, 128)
    bg:SetPoint('CENTER', self)
    utils.reverseTexture(bg)
    self.bg_tex = bg

    local hp = CreateFrame('StatusBar', nil, self)
    self.Health = hp
    hp:SetPoint('BOTTOMLEFT', self, 8, -2)
    utils.setSize(hp, 93, 25)
    hp:SetFrameStrata'LOW'
    hp:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
    hp.colorHappiness = true
    hp.colorClassPet = true
    hp.colorHealth = true

    local port = CreateFrame('PlayerModel', nil, self)
    self.Portrait = port
    port:SetFrameStrata'BACKGROUND'
    utils.setSize(port, 35, 35)
    port:SetPoint('TOPRIGHT', self, -5, -5)

    local dog = self:CreateFontString(nil, 'OVERLAY')
    dog:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    dog:SetPoint('CENTER', self, -15, -13)
    self:Tag(dog, '[raidcolor][name4]|r [colorhealth][lostperhp<%]|r')
end

addon:addLayoutElement(units, func)
addon:setSize(units, 150, 50)


addon:spawn(function()
    local u = addon.units
    local pet = oUF:Spawn('pet')
    pet:SetPoint('TOPRIGHT', u.player, 'BOTTOMRIGHT', 55, 25)
    u.pet = pet
end)


