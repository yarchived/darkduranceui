
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'pet'

DDUF:RegisterStyle(_UNIT, function(self, unit)
    self:SetSize(100, 33)
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local fore = self.FG:CreateTexture(nil, 'ARTWORK')
    fore:SetAllPoints(self.FG)

    self.FG:SetScale(.7)
    self.FG:ClearAllPoints()
    self.FG:SetSize(256, 128)
    self.FG:SetPoint('CENTER')

    local file = media.tot.tot
    fore:SetTexture(media.getTexture(file))
    self.FG.Texture = fore
    self.Textures[fore] = file

    DDUF:FlipTexture(fore)
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BACKGROUND')
    bg:SetAllPoints(self.FG)

    local file = media.tot.tot
    bg:SetTexture(media.getTexture(file))

    self.BG.Texture = bg
    self.Textures[bg] = file

    DDUF:FlipTexture(bg)
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetStatusBarTexture(media.roth)
    hp:SetSize(55, 7)
    hp:SetPoint('TOPRIGHT', self, 'CENTER', 12, 5)

    --hp.colorHealth = true
    hp.colorClass = true
    hp.colorClassNPC = true
    hp.colorClassPet = true

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local pp = CreateFrame('StatusBar', nil, self.BG)
    self.Power = pp

    pp:SetStatusBarTexture(media.roth)
    pp:SetSize(55, 3)
    pp:SetPoint('TOP', self.Health, 'BOTTOM', 0, 0)

    pp.colorPower = true

    pp.bg = pp:CreateTexture(nil, 'BORDER')
    pp.bg:SetTexture(media.roth)
    pp.bg:SetAllPoints()
    pp.bg.multiplier = .3
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local portrait = CreateFrame('PlayerModel', nil, self.BG)
    self.Portrait = portrait

    portrait:SetPoint('TOPLEFT', self, 'CENTER', 20, 15)

    local _SIZE = 30
    portrait:SetSize(_SIZE, _SIZE)
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    self.Tags.name = self:CreateTag(self.Health, '[raidcolor][name]')
    :SetFont(media.font, 12, 'OUTLINE')
    :SetPoint('TOPRIGHT', self, 'CENTER', 5, -13)
    :done()

    self.Tags.level = self:CreateTag(self.FG, '[dd:difficulty][level]')
    :SetFont(media.font, 14, 'OUTLINE')
    :SetPoint('CENTER', self, 22, -16)
    :done()
end)

DDUF:Spawn(_UNIT, function(f)
    f:SetPoint('TOPRIGHT', DDUF.units.player, 'BOTTOMRIGHT', 10, 5)
end)

