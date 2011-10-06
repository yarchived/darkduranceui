

local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'party'

DDUF:UnitStyle(_UNIT, function(self, unit)
    local fore = self.FG:CreateTexture(nil, 'ARTWORK')
    fore:SetAllPoints()

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
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetStatusBarTexture(media.roth)
    hp:SetSize(60, 12)
    hp.colorClass = true

    hp:SetPoint('TOPLEFT', self, 'CENTER', -11, -6)

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local portrait = CreateFrame('PlayerModel', nil, self.BG)
    self.Portrait = portrait

    portrait:SetPoint('BOTTOMRIGHT', self, 'CENTER', -15, -15)

    local _SIZE = 35
    portrait:SetSize(_SIZE, _SIZE)
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
        'point', 'BOTTOM',
        'yOffset', 10,
        'DDUF-width', 100,
        'DDUF-height', 40,
        'DDUF-scale', 1
    )

    header:SetPoint('LEFT', UIParent,  15, 0)
    header:Show()
    DDUF.units[_UNIT] = header
end)

