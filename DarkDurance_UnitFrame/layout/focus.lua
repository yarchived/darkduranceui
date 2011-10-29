
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'focus'

DDUF:RegisterStyle(_UNIT, function(self, unit)
    self:SetSize(85, 85)
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local fore = self.FG:CreateTexture(nil, 'ARTWORK')
    fore:SetAllPoints(self.FG)

    self.FG:ClearAllPoints()
    self.FG:SetPoint('CENTER', self)
    self.FG:SetSize(256, 128)

    self.FG.Texture = fore
    self.FG:SetScale(.7)

    local file = media.focus.focus
    fore:SetTexture(media.getTexture(file))
    self.Textures[fore] = file
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BACKGROUND')
    bg:SetAllPoints(self.FG)

    local file = media.focus.bg
    bg:SetTexture(media.getTexture(file))

    self.BG.Texture = bg
    self.Textures[bg] = file
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetStatusBarTexture(media.roth)
    hp:SetSize(63, 9)
    hp:SetPoint('BOTTOM', self, 0, 14)

    hp.colorClass = true
    hp.colorClassPet = true
    hp.colorClassNPC = true

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local pp = CreateFrame('StatusBar', nil, self.BG)
    self.Power = pp

    pp:SetStatusBarTexture(media.roth)
    pp:SetSize(63, 3)
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

    portrait:SetPoint('CENTER', self, 0, 5)

    local _SIZE = 45
    portrait:SetSize(_SIZE, _SIZE)
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    self.Tags.name = self:CreateTag(self.Health, '[raidcolor][name]', function(fs)
        fs:SetFont(media.font, 14, 'OUTLINE')
        fs:SetPoint('TOP', self, 'BOTTOM', 0, 6)
    end)

    self.Tags.level = self:CreateTag(self.FG, '[dd:difficulty][level]', function(fs)
        fs:SetFont(media.font, 20, 'OUTLINE')
        fs:SetPoint('CENTER', self, 28, -13)
    end)
end)

DDUF:Spawn(_UNIT, function()
    local f = oUF:Spawn(_UNIT)
    f:SetPoint('CENTER', -300, 0)
    DDUF.units[_UNIT] = f
end)

