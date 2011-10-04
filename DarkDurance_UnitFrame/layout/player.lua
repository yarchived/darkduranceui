
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF
local media = DDUF.media

local _UNITS = {'player', 'target'}

DDUF:UnitStyle(_UNITS, function(self, unit)
    self:SetSize(270, 45)
end)

DDUF:UnitStyle(_UNITS, function(self, unit)
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

DDUF:UnitStyle(_UNITS, function(self, unit)
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

DDUF:UnitStyle(_UNITS, function(self, unit)
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

DDUF:UnitStyle(_UNITS, function(self, unit)
    local portrait = CreateFrame('PlayerModel', nil, self.BG)
    self.Portrait = portrait

    local _size = 40
    portrait:SetSize(_size, _size)

    local tar = unit == 'target'
    local xoffset = 40
    portrait:SetPoint(tar and 'BOTTOMRIGHT' or 'BOTTOMLEFT', self, tar and (0 - xoffset) or xoffset, 6)
end)

DDUF:UnitStyle(_UNITS, function(self, unit)
    local tar = unit == 'target'

    self.Tags.name = self:CreateTag(self.Health, '[name]', function(fs)
        fs:SetFont(media.font, 14, 'OUTLINE')
        local xoffset = 100
        fs:SetPoint(tar and 'RIGHT' or 'LEFT', self, tar and (0-xoffset) or xoffset, 25)
    end)

    self.Tags.level = self:CreateTag(self, '[level]', function(fs)
        fs:SetFont(media.font, 14, 'OUTLINE')

    end)
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

