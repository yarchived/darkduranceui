-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF
local libstatusbar = LibStub('SuckLessStatusBar-1.0')

local utils = addon.utils
local units = {'player', 'target'}
local function func(self, unit)
    --self:SetBackdrop(utils.backdrop)
    --self:SetBackdropColor(0,0,0, .5)
    local target = unit == 'target'

    local texture = self:CreateTexture(nil, 'ARTWORK')
    texture:SetTexture(utils.mediaPath .. 'PlayerFrame')
    texture:SetWidth(512)
    texture:SetHeight(128)
    --mainTex:SetScale()
    texture:SetPoint('CENTER', self)
    utils.adjustCoord(target, texture)
    self.texture = texture

    local background = self.bg:CreateTexture(nil, 'BACKGROUND')
    background:SetTexture(utils.mediaPath .. 'PlayerBackground') 
    background:SetWidth(512)
    background:SetHeight(128)
    background:SetPoint('CENTER', self)
    utils.adjustCoord(target, background)

    local portrait = CreateFrame('PlayerModel', nil, self)
    portrait:SetFrameStrata('BACKGROUND')
    portrait:SetHeight(50)
    portrait:SetWidth( 50)
    if(target) then
        portrait:SetPoint('TOPRIGHT', self, -20, 0)
    else
        portrait:SetPoint('TOPLEFT', self, 20, 0)
    end
    self.Portrait = portrait

    --local hp = CreateFrame('StatusBar', nil, self)
    local hp = libstatusbar:NewStatusBar(nil, self)
    self.Health = hp
    do
        local xOffset, yOffset = 80, 38
        if(target) then
            hp:SetPoint('TOPRIGHT', self, -xOffset, -yOffset)
        else
            hp:SetPoint('TOPLEFT', self, xOffset, -yOffset)
        end
    end
    hp:SetFrameStrata('LOW')
    hp:SetFrameLevel(20)
    utils.setSize(hp, 200, 30)
    --hp:SetStatusBarTexture(utils.mediaPath .. 'Health' .. (target and '2' or ''))
    hp:SetStatusBarTexture(utils.mediaPath .. 'DDTex')
    --do
    --    local t = hp:GetStatusBarTexture()
    --    if(t.SetHorizTile) then
    --        --hp:GetStatusBarTexture():SetHorizTile(true)
    --        t:SetAllPoints(hp)
    --        t:SetHorizTile(true)
    --        t:SetVertTile(true)
    --    end
    --end
    --hp:SetStatusBarColor(.3,.3,.3)
    hp.colorSmooth = true
    --utils.testBackdrop(hp)
    hp.bg = hp:CreateTexture(nil, 'BACKGROUND')
    hp.bg:SetAllPoints(hp)
    hp.bg:SetTexture(utils.mediaPath .. 'DDTex')
    hp.bg:SetVertexColor(.15,.15,.15)
    hp.bg.multiplier = .3


    local mp = CreateFrame('StatusBar', nil, self)
    self.Power = mp
    mp:SetFrameStrata('LOW')
    mp:SetFrameLevel(10)
    mp:SetStatusBarTexture(utils.mediaPath .. 'PowerBar')
    do
        local x, y = -15, -5
        if(target) then
            mp:SetPoint('BOTTOMLEFT', self, -x, y)
        else
            mp:SetPoint('BOTTOMRIGHT', self, x, y)
        end
    end
    utils.setSize(mp, 184, 64)
    if(target) then
        mp.colorClass = true
        mp.colorClassNPC = true
        mp.colorClassPet = true
    else
        mp.colorPower = true
    end
    --utils.testBackdrop(mp)

    mp.bg = mp:CreateTexture(nil, 'BORDER')
    mp.bg:SetAllPoints(mp)
    mp.bg:SetTexture(utils.mediaPath .. 'PowerBar')
    mp.bg.multiplier = ns.colorMultiplier

    local caster = libstatusbar:NewStatusBar(nil, self)
    caster:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
    caster:SetStatusBarColor(0, 159/255, 233/255)
    self.Castbar = caster
    --caster:SetStatusBarTexture()
    caster.tex = caster:CreateTexture(nil, 'ARTWORK')
    utils.setSize(caster.tex, 256, 64)
    caster.tex:SetPoint('CENTER', caster)
    caster.tex:SetTexture(utils.mediaPath .. 'CastFrame')

    caster.bg = caster:CreateTexture(nil, 'BACKGROUND')
    utils.setSize(caster.bg, 256, 64)
    caster.bg:SetPoint('CENTER', caster)
    caster.bg:SetTexture(utils.mediaPath .. 'CastBackground')

    caster.Text = caster:CreateFontString(nil, 'OVERLAY')
    caster.Text:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE')
    caster.Text:SetPoint('CENTER', caster, 0, 2)

    caster.Time = caster:CreateFontString(nil, 'OVERLAY')
    caster.Time:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    caster.Time:SetPoint('RIGHT', caster, -3, 2)

    utils.setSize(caster, 200, 20)

    local sf = caster:CreateTexture(nil, 'BORDER')
    caster.SafeZone = sf
    sf:SetTexture(utils.mediaPath .. 'StatusBar1')
    sf:SetVertexColor(1,0,0)

    local icon = caster:CreateTexture(nil, 'ARTWORK')
    caster.Icon = icon
    icon:SetAllPoints(self.Portrait)
    icon:SetTexCoord(4/64, 60/64, 4/64, 60/64)

    do
        local x, y = 35, 5
        if(target) then
            caster:SetPoint('BOTTOM', self, 'TOP', -x, y)
        else
            caster:SetPoint('BOTTOM', self, 'TOP', x, y)
        end
    end
end

addon:addLayoutElement(units, func)
addon:setSize(units, 280, 80)


addon:spawn(function()
    local u = addon.units
    local player = oUF:Spawn('player')
    player:SetPoint('CENTER', -300, -200)
    player:SetFrameLevel(100)
    u.player = player

    local target = oUF:Spawn('target')
    target:SetPoint('CENTER', 300, -200)
    target:SetFrameLevel(100)
    u.target = target
end)


