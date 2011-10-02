
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNITS = {'player', 'target'}

DDUF:UnitStyle(_UNITS, function(self, unit)
    self:SetSize(270, 45)
end)

DDUF:UnitStyle(_UNITS, function(self, unit)
    local tar = unit == 'target'

    --local forground = self:CreateTexture(nil, 'ARTWORK')
    local forground = self.FG:CreateTexture(nil, 'ARTWORK')
    forground:SetAllPoints(self.FG)

    self.FG:ClearAllPoints()
    self.FG:SetSize(512, 128)
    self.FG:SetPoint('CENTER', self, 0, 0)

    self.FG.Texture = forground

    self.FG:SetScale(.7)

    local file = tar and media.target.target or media.player.player
    forground:SetTexture(media.getTexture(file))
    if(tar) then
        DDUF.FlipTexture(forground)
    end

    self.Textures[forground] = file
end)

DDUF:UnitStyle(_UNITS, function(self, unit)
    local tar = unit == 'target'
    local hp, mp

    hp = CreateFrame('StatusBar', nil, self.BG)
    mp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp
    self.Power = mp

    hp:SetFrameLevel(mp:GetFrameLevel()+1)

    --hp.colorClass = true
    mp.colorClass = true

    hp:SetStatusBarTexture(media.dd)
    mp:SetStatusBarTexture(media.roth)

    hp:SetSize(155, 15)
    mp:SetSize(140, 28)

    local xoffset = 30
    hp:SetPoint('CENTER', self, tar and (0-xoffset) or xoffset, 0)
    mp:SetPoint('CENTER', self, tar and (0-xoffset) or xoffset, 0)
end)

DDUF:UnitStyle(_UNITS, function(self, unit)
end)

DDUF:UnitStyle(_UNITS, function(self, unit)
end)

DDUF:UnitStyle(_UNITS, function(self, unit)
end)

DDUF:Spawn(function()
    local player = oUF:Spawn'player'
    player:SetPoint('CENTER', -300, -200)
    DDUF.units.player = player

    local target = oUF:Spawn'target'
    target:SetPoint('CENTER', 300, -200)
    DDUF.units.target = target
end)

