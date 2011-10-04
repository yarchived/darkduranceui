
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

DDUF:UnitStyle('pet', function(self, unit)
    self:SetSize(120, 33)
end)

DDUF:UnitStyle('pet', function(self, unit)
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

DDUF:UnitStyle('pet', function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BORDER')
    bg:SetAllPoints(self.FG)

    local file = media.tot.bg
    bg:SetTexture(file)
    self.BG.Texture = bg
    self.Textures[bg] = file
end)

DDUF:Spawn(function()
    local pet = oUF:Spawn'pet'
    pet:SetPoint('CENTER', DDUF.units.player, 0, -30)
    DDUF.units.pet = pet
end)

