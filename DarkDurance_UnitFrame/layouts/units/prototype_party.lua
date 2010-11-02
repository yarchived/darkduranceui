-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF
local libstatusbar = LibStub('SuckLessStatusBar-1.0')
local utils = addon.utils

ns.style_party = function(self, unit)
    local tex = self:CreateTexture(nil, 'ARTWORK')
    tex:SetTexture(utils.mediaPath .. 'PartyFrame')
    tex:SetPoint('CENTER', self)
    utils.setSize(tex, 128, 128)
    self.texture = tex

    local bg = self.bg:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture(utils.mediaPath .. 'PartyBackground')
    bg:SetPoint('CENTER', self)
    utils.setSize(bg, 128, 128)
    self.bg_tex = bg

    local WIDTH, HEIGHT = 44, 86

    local hp = libstatusbar:NewStatusBar(nil, self)
    hp:SetStatusBarTexture(utils.mediaPath .. 'PartyHealth')
    hp:SetOrientation('VERTICAL')
    self.Health = hp
    utils.setSize(hp, WIDTH, HEIGHT)
    hp:SetPoint('BOTTOMLEFT', 0, 3)
    hp.colorHealth = true
    --hp.colorClass = true

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetAllPoints(hp)
    hp.bg:SetTexture(utils.mediaPath .. 'PartyHealth')
    hp.bg.multiplier = ns.colorMultiplier

    local mp = libstatusbar:NewStatusBar(nil, self)
    mp:SetStatusBarTexture(utils.mediaPath .. 'PartyHealth')
    mp:SetOrientation('VERTICAL')
    mp:SetReverse(true)
    self.Power = mp
    utils.setSize(mp, WIDTH, HEIGHT)
    mp:SetPoint('BOTTOMRIGHT', 0, 3)
    mp.colorPower = true

    local port = CreateFrame('PlayerModel', nil, self)
    port:SetFrameStrata'BACKGROUND'
    utils.setSize(port, 65, 65)
    port:SetPoint'CENTER'
    self.Portrait = port

    mp.bg = mp:CreateTexture(nil, 'BORDER')
    mp.bg:SetAllPoints(mp)
    mp.bg:SetTexture(utils.mediaPath .. 'PartyHealth')
    mp.bg.multiplier = ns.colorMultiplier
    utils.reverseTexture(mp.bg)

    do
        local cb = CreateFrame('StatusBar', nil, self)
        self.Castbar = cb
        cb:SetAllPoints(self.Portrait)
        cb:SetOrientation('VERTICAL')
        cb:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
        cb:SetStatusBarColor(0, 159/255, 233/255, .75)

        local icon = cb:CreateTexture(nil, 'ARTWORK')
        cb.Icon = icon
        icon:SetTexCoord(4/64, 60/64, 4/64, 60/64)
        icon:SetAllPoints(cb)
    end

    --utils.testBackdrop(self)

    return self
end



