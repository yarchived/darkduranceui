
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'pet'

DDUF:UnitStyle(_UNIT, function(self, unit)
    self:SetSize(100, 33)
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
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
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BACKGROUND')
    bg:SetAllPoints(self.FG)

    local file = media.tot.tot
    bg:SetTexture(media.getTexture(file))

    self.BG.Texture = bg
    self.Textures[bg] = file
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetStatusBarTexture(media.roth)
    hp:SetSize(55, 12)
    hp:SetPoint('TOPLEFT', self, 'CENTER', -12, 5)

    hp.colorClass = true
    hp.colorClassNPC = true
    hp.colorClassPet = true

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local portrait = CreateFrame('PlayerModel', nil, self.BG)
    self.Portrait = portrait

    portrait:SetPoint('TOPRIGHT', self, 'CENTER', -20, 15)

    local _SIZE = 30
    portrait:SetSize(_SIZE, _SIZE)
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    self.Tags.name = self:CreateTag(self.Health, '[raidcolor][name]', function(fs)
        fs:SetFont(media.font, 14, 'OUTLINE')
        fs:SetPoint('TOPLEFT', self, 'CENTER', -5, -13)
    end)

    self.Tags.level = self:CreateTag(self.FG, '[dd:difficulty][level]', function(fs)
        fs:SetFont(media.font, 20, 'OUTLINE')
        fs:SetPoint('CENTER', self, -22, -16)
    end)
end)

DDUF:Spawn(function()
    local f = oUF:Spawn(_UNIT)
    f:SetPoint('TOPLEFT', DDUF.units.player, 'BOTTOMLEFT', -10, -10)
    DDUF.units[_UNIT] = f
end)

