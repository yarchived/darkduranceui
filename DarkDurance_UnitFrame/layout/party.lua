

local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'party'

DDUF:RegisterStyle(_UNIT, function(self, unit)
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

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BORDER')
    bg:SetAllPoints(self.FG)

    local file = media.party.bg
    bg:SetTexture(media.getTexture(file))
    self.BG.Texture = bg
    self.Textures[bg] = bg
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetStatusBarTexture(media.roth)
    hp:SetSize(60, 9)

    hp.colorClass = true
    hp.colorClassPet = true
    hp.colorClassNPC = true

    hp:SetPoint('TOPLEFT', self, 'CENTER', -11, -6)

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    local pp = CreateFrame('StatusBar', nil, self.BG)
    self.Power = pp

    pp:SetStatusBarTexture(media.roth)
    pp:SetSize(60, 3)
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

    portrait:SetPoint('BOTTOMRIGHT', self, 'CENTER', -15, -15)

    local _SIZE = 35
    portrait:SetSize(_SIZE, _SIZE)
end)

DDUF:RegisterStyle(_UNIT, function(self, unit)
    self.Tags.name = self:CreateTag(self.Health, '[raidcolor][dd:realname]', function(fs)
        fs:SetFont(media.font, 14, 'OUTLINE')
        fs:SetPoint('LEFT', self, 'CENTER', -10, 8)
    end)

    self.Tags.level = self:CreateTag(self.FG, '[dd:difficulty][level]', function(fs)
        fs:SetFont(media.font, 20, 'OUTLINE')
        fs:SetPoint('CENTER', self, -67, -21)
    end)
end)


DDUF:Spawn(_UNIT, function()
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
        'yOffset', 20,
        'DDUF-width', 100,
        'DDUF-height', 40,
        'DDUF-scale', 1
    )

    header:SetPoint('LEFT', UIParent,  25, 0)
    header:Show()
    DDUF.units[_UNIT] = header
end)

