
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNIT = {'player', 'target'}

DDUF:UnitStyle(_UNIT, function(self, unit)
    self:SetSize(270, 45)
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local tar = unit == 'target'

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
        DDUF:FlipTexture(forground)
    end

    self.Textures[forground] = file
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
     local bg = self.BG:CreateTexture(nil, 'BACKGROUND')
     bg:SetAllPoints(self.FG)
     self.BG.Texture = bg


     local tar = unit == 'target'

     local file = media[tar and 'target' or 'player'].bg
     bg:SetTexture(media.getTexture(file))
     if(tar) then
         DDUF:FlipTexture(bg)
     end

     self.Textures[bg] = file
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local tar = unit == 'target'
    local hp, mp

    hp = CreateFrame('StatusBar', nil, self.BG)
    mp = CreateFrame('StatusBar', nil, self.BG)
    self.Health = hp
    self.Power = mp

    hp:SetFrameLevel(mp:GetFrameLevel()+1)

    hp.colorSmooth = true
    mp.colorPower = true

    hp:SetStatusBarTexture(media.dd)
    mp:SetStatusBarTexture(media.roth)

    hp:SetSize(155, 15)
    mp:SetSize(140, 28)

    local xoffset = 30
    hp:SetPoint('CENTER', self, tar and (0-xoffset) or xoffset, 0)
    mp:SetPoint('CENTER', self, tar and (0-xoffset) or xoffset, 0)

    hp.bg = hp:CreateTexture(nil, 'BORDER')
    hp.bg:SetTexture(media.dd)
    hp.bg:SetAllPoints(hp)
    hp.bg.multiplier = .3

    mp.bg = mp:CreateTexture(nil, 'BORDER')
    mp.bg:SetTexture(media.roth)
    mp.bg:SetAllPoints(mp)
    mp.bg.multiplier = .3
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local portrait = CreateFrame('PlayerModel', nil, self.BG)
    self.Portrait = portrait

    local _size = 40
    portrait:SetSize(_size, _size)

    local tar = unit == 'target'
    local xoffset = 40
    portrait:SetPoint(tar and 'BOTTOMRIGHT' or 'BOTTOMLEFT', self, tar and (0 - xoffset) or xoffset, 6)
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local tar = unit == 'target'

    self.Tags.name = self:CreateTag(self.Health, '[raidcolor][name]', function(fs)
        fs:SetFont(media.font, 14, 'OUTLINE')
        local xoffset = 100
        fs:SetPoint(tar and 'RIGHT' or 'LEFT', self, tar and (0-xoffset) or xoffset, 25)
    end)

    self.Tags.level = self:CreateTag(self.FG, '[dd:difficulty][level]', function(fs)
        fs:SetFont(media.font, 20, 'OUTLINE')
        if(tar) then
            fs:SetPoint('CENTER', self, 'BOTTOMRIGHT', -38, 13)
        else
            fs:SetPoint('CENTER', self, 'TOPLEFT', 46, -1)
        end
    end)
end)

DDUF:UnitStyle(_UNIT, function(self, unit)
    local tar = unit == 'target'

    local castbar = CreateFrame('StatusBar', nil, self)
    self.Castbar = castbar

    local xoffset = -60
    if(tar) then
        castbar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0 - xoffset, 20)
    else
        castbar:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', xoffset, 20)
    end

    castbar:SetStatusBarTexture(media.roth)
    castbar:SetSize(100, 9)
    castbar:SetStatusBarColor(27/255,147/255,226/255)

    local fg = CreateFrame('Frame', nil, castbar)
    fg:SetSize(256, 128)
    fg.Texture = fg:CreateTexture(nil, 'ARTWORK')
    fg.Texture:SetAllPoints(fg)
    fg:SetScale(.7)
    local xoffset = 25
    fg:SetPoint('CENTER', tar and (0 - xoffset) or xoffset, 0)

    fg.Texture:SetTexture(media.getTexture(media.castbar.castbar))
    self.Textures[fg.Texture] = media.castbar.castbar

    local bg = CreateFrame('Frame', nil, castbar)
    bg:SetFrameStrata'BACKGROUND'
    bg:SetSize(256, 128)
    bg.Texture = bg:CreateTexture(nil, 'ARTWORK')
    bg.Texture:SetAllPoints(bg)
    bg:SetScale(.7)
    bg:SetPoint('CENTER', fg)

    bg.Texture:SetTexture(media.getTexture(media.castbar.bg))
    self.Textures[bg.Texture] = media.castbar.bg

    castbar.FG = fg
    castbar.BG = bg
    if(tar) then
        DDUF:FlipTexture(fg.Texture)
        DDUF:FlipTexture(bg.Texture)
    end

    local text = castbar:CreateFontString(nil, 'ARTWORK')
    castbar.Text = text
    text:SetFont(media.font, 12, 'OUTLINE')
    local xoffset = 5
    if(tar) then
        text:SetPoint('RIGHT', castbar, 0 - xoffset)
    else
        text:SetPoint('LEFT', castbar, xoffset, 0)
    end

    local icon = castbar:CreateTexture(nil, 'ARTWORK')
    castbar.Icon = icon
    local _SIZE = 35
    icon:SetSize(_SIZE, _SIZE)
    local xoffset = 3
    if(tar) then
        icon:SetPoint('RIGHT', castbar, 'LEFT', 0 - xoffset, 0)
    else
        icon:SetPoint('LEFT', castbar, 'RIGHT', xoffset, 0)
    end

    if(not tar) then
        local safe = castbar:CreateTexture(nil, 'BACKGROUND')
        castbar.SafeZone = safe
        safe:SetTexture(media.roth)
        safe:SetVertexColor(231/255, 48/255, 78/255)
        safe:SetPoint'TOPRIGHT'
        safe:SetPoint'BOTTOMRIGHT'
    end
end)

DDUF:UnitStyle('player', function(self, unit)
    self:RegisterEvent('PLAYER_TARGET_CHANGED', function()
        if(UnitExists'target') then
            if(UnitIsEnemy('player', 'target')) then
                PlaySound'igCreatureAggroSelect'
            elseif(UnitIsFriend('player', 'target')) then
                PlaySound'igCharacterNPCSelect'
            else
                PlaySound'igCreatureNeutralSelect'
            end
        else
            PlaySound'INTERFACESOUND_LOSTTARGETUNIT'
        end
    end)
end)

DDUF:Spawn(function()
    local player = oUF:Spawn'player'
    player:SetPoint('CENTER', -300, -200)
    DDUF.units.player = player

    local target = oUF:Spawn'target'
    target:SetPoint('CENTER', 300, -200)
    DDUF.units.target = target
end)

