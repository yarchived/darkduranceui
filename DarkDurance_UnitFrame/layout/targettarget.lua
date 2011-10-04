
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'targettarget'

DDUF:UnitStyle(_UNIT, function(self, unit)
    self:SetSize()
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local fore = self.FG:CreateTexture(nil, 'ARTWORK')
    fore:SetAllPoints(self.FG)

    self.FG:ClearAllPoints()
    self.FG:SetPoint('CENTER', self)
    self.FG:SetSize(256, 128)

    self.FG.Texture = fore
    self.FG:SetScale(.7)

    local file = 
    fore:SetTexture(media.getTexture(file))
    self.Textures[fore] = file
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BACKGROUND')
    bg:SetAllPoints(self.FG)

    local file = 
    bg:SetTexture(media.getTexture(file))

    self.BG.Texture = bg
    self.Textures[bg] = file
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetStatusBarTexture(media.roth)
    hp:SetSize()
    hp:SetPoint('BOTTOM', self, 0, 5)

    hp.colorClass = true

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local portrait = CreateFrame('PlayerModel', nil, self.BG)
    self.Portrait = portrait

    portrait:SetPoint('CENTER', self, 0, 5)

    local _SIZE = 
    portrait:SetSize(_SIZE, _SIZE)
end)

DDUF:Spawn(function()
    local f = oUF:Spawn(_UNIT)
    f:SetPoint('CENTER', -300, 0)
    DDUF.units[_UNIT] = f
end)




