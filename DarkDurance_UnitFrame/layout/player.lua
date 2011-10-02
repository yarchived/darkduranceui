
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNITS = {'player', 'target'}

DDUF:UnitStyle(_UNITS, function(self, unit)
    self:SetSize(270, 45)
end)

DDUF:UnitStyle('player', function(self, unit)
    local forground = self:CreateTexture(nil, 'ARTWORK')

    local file = media.player.player
    forground:SetTexture(media.getTexture(file))

    self.Textures[forground] = file
end)

DDUF:UnitStyle('target', function(self, unit)
    local forground = self:CreateTexture(nil, 'ARTWORK')

    local file = media.target.target
    forground:SetTexture(media.getTexture(file))

    self.Textures[forground] = file
end)

DDUF:Spawn(function()
    local player = oUF:Spawn'player'
    player:SetPoint('CENTER', -300, -200)
    DDUF.units.player = player

    local target = oUF:Spawn'target'
    target:SetPoint('CENTER', 300, -200)
    DDUF.units.target = target
end)

