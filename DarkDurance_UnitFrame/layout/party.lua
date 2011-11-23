

local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = 'party'

local function create_wrapper_for(unit, func)
    return function(self, ...)
        return self:GetAttribute'unitsuffix' == unit and func(self, ...)
    end
end

local wrap_party = function(func)
    return create_wrapper_for(nil, func)
end

local wrap_target = function(func)
    return create_wrapper_for('target', func)
end

DDUF:RegisterStyle(_UNIT, wrap_party(function(self, unit)
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
end))

DDUF:RegisterStyle(_UNIT, wrap_party(function(self, unit)
    local bg = self.BG:CreateTexture(nil, 'BORDER')
    bg:SetAllPoints(self.FG)

    local file = media.party.bg
    bg:SetTexture(media.getTexture(file))
    self.BG.Texture = bg
    self.Textures[bg] = bg
end))

DDUF:RegisterStyle(_UNIT, wrap_party(function(self, unit)
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetStatusBarTexture(media.roth)
    hp:SetSize(60, 9)

    hp.colorClass = true
    hp.colorClassPet = true
    hp.colorClassNPC = true

    hp:SetPoint('TOPLEFT', self, 'CENTER', -11, -7)

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end))

DDUF:RegisterStyle(_UNIT, wrap_party(function(self, unit)
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
end))

DDUF:RegisterStyle(_UNIT, wrap_party(function(self, unit)
    local f = CreateFrame('Frame', nil, self)
    self.Auras = f

    f.size = 16
    f.spacing = 2
    --f.gap = true
    f.initialAnchor = 'TOPLEFT'
    f['growth-x'] = 'RIGHT'
    f['growth-y'] = 'DOWN'

    local h = (f.size + f.spacing) * 10
    local w = (f.size + f.spacing) * 1

    f.numBuffs = 4
    f.numDebuffs = 6

    f:SetSize(h, w)
    f:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -5)

    f.PostCreateIcon = DDUF.PostCreateIcon
end))

DDUF:RegisterStyle(_UNIT, wrap_party(function(self, unit)
    local portrait = CreateFrame('PlayerModel', nil, self.BG)
    self.Portrait = portrait

    portrait:SetPoint('BOTTOMRIGHT', self, 'CENTER', -15, -15)

    local _SIZE = 35
    portrait:SetSize(_SIZE, _SIZE)
end))

DDUF:RegisterStyle(_UNIT, wrap_party(function(self, unit)
    self.Tags.name = self:CreateTag(self.Health,
        '[raidcolor][dd:realname]', function(fs)
            fs:SetFont(media.font, 12, 'OUTLINE')
            fs:SetPoint('LEFT', self, 'CENTER', 0, 5)
        end)

    self.Tags.level = self:CreateTag(self.FG,
        '[dd:difficulty][level]', function(fs)
            fs:SetFont(media.font, 14, 'OUTLINE')
            fs:SetPoint('CENTER', self, -67, -21)
        end)
end))

DDUF:RegisterStyle(_UNIT, wrap_target(function(self, unit)
    self.FG:ClearAllPoints()
    self.FG:SetPoint('CENTER', self)
    self.FG:SetSize(256, 64)
    self.FG:SetScale(.7)

    local bg = self.BG:CreateTexture(nil, 'BACKGROUND')
    bg:SetAllPoints(self.FG)

    local file = media.tot.totot
    bg:SetTexture(media.getTexture(file))

    self.BG.Texture = bg
    self.Textures[bg] = file
end))

DDUF:RegisterStyle(_UNIT, wrap_target(function(self, unit)
    local hp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp

    hp:SetPoint'CENTER'
    hp:SetStatusBarTexture(media.roth)
    hp:SetSize(60, 12)

    hp.colorClass = true
    hp.colorClassPet = true
    hp.colorClassNPC = true

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.roth)
    hp.bg:SetAllPoints()
    hp.bg.multiplier = .3
end))

DDUF:RegisterStyle(_UNIT, wrap_target(function(self, unit)
    self.Tags.name = self:CreateTag(self.Health,
        '[raidcolor][dd:realname]', function(fs)
            fs:SetFont(media.font, 12, 'OUTLINE')
            fs:SetPoint('CENTER', self, 0, 18)
        end)
end))

DDUF:Spawn(_UNIT, function()
    local header = oUF:SpawnHeader(nil, nil, nil,
        'oUF-initialConfigFunction', [=[
            local header = self:GetParent()
            if(self:GetAttribute'unitsuffix' == 'target') then
                local header = header:GetParent()

                self:SetWidth( header:GetAttribute'DDUF-target-width')
                self:SetHeight(header:GetAttribute'DDUF-target-height')
                self:SetScale( header:GetAttribute'DDUF-target-scale')
            else
                self:SetWidth( header:GetAttribute'DDUF-width')
                self:SetHeight(header:GetAttribute'DDUF-height')
                self:SetScale( header:GetAttribute'DDUF-scale')
            end
        ]=],
        'template', 'DarkDuranceUF_PartyTargetTemplate',
        'showParty', true,
        --'showRaid', true,
        'showPlayer', true,
        'showSolo', true,
        --'unitsPerColumn', 1,
        --'maxColumn', 5,
        'point', 'BOTTOM',
        'yOffset', 25,
        'DDUF-width', 100,
        'DDUF-height', 40,
        'DDUF-scale', 1,
        'DDUF-target-width', 76,
        'DDUF-target-height', 18,
        'DDUF-target-scale', 1
    )

    header:SetPoint('LEFT', UIParent,  25, 0)
    header:Show()
    DDUF.units[_UNIT] = header
end)

