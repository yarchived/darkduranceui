

local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'party'

DDUF:UnitStyle(_UNIT, function(self, unit)
    local fore = self.FG:CreateTexture(nil, 'ARTWORK')

    self.FG:ClearAllPoints()
    self.FG:SetScale(.7)
    self.FG:SetPoint'CENTER'
    self.FG:SetSize(256, 128)

    local file = media.party.party
    fore:SetTexture(media.getTexture(file))

    self.FG.Texture = fore
    self.Textures[fore] = file
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BORDER')
    bg:SetAllPoints(self.FG)

    local file = media.party.bg
    bg:SetTexture(media.getTexture(file))
    self.BG.Texture = bg
    self.Textures[bg] = bg
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    DDUF:TestBackdrop(self)
end)

DDUF:Spawn(function()
    local header = oUF:SpawnHeader(nil, nil, 'custom [group][@player,exists]show;hide',
        'oUF-initialConfigFunction', [[
            local unit = ...
            local header = self:GetParent()
            self:SetWidth(header:GetAttribute'DDUF-width')
            self:SetHeight(header:GetAttribute'DDUF-height')
            self:SetScale(header:GetAttribute'DDUF-scale')

            local body = self:GetParent():GetAttribute'DDUF-partyCustomFunction'
            if(body) then
                self:Run(body, ...)
            end
        ]],
        'showParty', true,
        --'showRaid', true,
        'showSolo', true,
        --'unitsPerColumn', 1,
        --'maxColumn', 5,
        --'point', 'TOP',
        --'yOffset', -5,
        'DDUF-width', 125,
        'DDUF-height', 65,
        'DDUF-scale', 1
    )

    header:SetPoint('LEFT', UIParent,  5, 0)
    header:Show()
    DDUF.units[_UNIT] = header
end)

