
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF
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

    local hp = CreateFrame('StatusBar', nil, self)
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

    local mp = CreateFrame('StatusBar', nil, self)
    --mp:SetStatusBarTexture(utils.mediaPath .. 'PartyHealth')
    --mp:SetOrientation('VERTICAL')
    do
        --print(mp:GetStatusBarTexture():GetTexCoord())
        --mp:GetStatusBarTexture():SetTexCoord(1, 0, 0, 1)
        --mp:GetStatusBarTexture():SetRotation(1)
        --print(mp:GetStatusBarTexture():)
        local t = mp:CreateTexture(nil, 'OVERLAY')
        t:SetTexture(utils.mediaPath..'PartyHealth')
        t:SetTexCoord(1, 0, 1, 0)
        mp:SetStatusBarTexture(t)
        mp:SetOrientation('VERTICAL')
    end

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



