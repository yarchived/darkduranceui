
if(true) then return end

local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'party'

DDUF:UnitStyle(_UNIT, function(self, unit)
    local fore = self.FG:CreateTexture(nil, 'ARTWORK')

    self.FG:ClearAllPoints()
    self.FG:SetScale(.7)
    self.FG:SetPoint('CENTER')
    self.FG:SetSize(256, 128)

    local file = media.party.party
    fore:SetTexture(media.getTexture(file))
    self.FG.Texture = fore
    self.Textures[fore] = file
end)

DDUF:Spawn(function()
    local header = oUF:SpawnHeader(nil, nil, nil,
        '', [[
            local header = self:GetParent()
            self:SetSize(header:GetAttribute('__unitframe-width', '__unitframe-height'))
            self:SetScale(header:GetAttribute'__unitframe-scale'
        ]],
        'showParty', true,
        'showRaid', true,
        'showSolo', true,
        'unitsPerColumn', 1,
        'maxColumn', '5',
        'point', 'TOP',
        'yOffset', '-5',
        '__unitframe-width', 90,
        '__unitframe-height', 90,
        '__unitframe-scale', '1'
    )

    header:SetPoint('LEFT', 5, 0)
    DDUF.units[_UNIT] = header
end)

