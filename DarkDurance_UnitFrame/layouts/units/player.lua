
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF
local utils = addon.utils
local tags = addon.tags

local function targetChangedSound(self, unit)
    self:RegisterEvent('PLAYER_TARGET_CHANGED', function(self)
        if UnitExists('target') then
            if( UnitIsEnemy('target', 'player') ) then
                PlaySound('igCreatureAggroSelect')
            elseif( UnitIsFriend('player', 'target') ) then
                PlaySound('igCharacterNPCSelect')
            else
                PlaySound('igCreatureNeutralSelect')
            end
        else
            PlaySound('INTERFACESOUND_LOSTTARGETUNIT')
        end
    end)
end

addon:addLayoutElement('player', targetChangedSound)

local textures = {
    [1] = utils.mediaPath .. 'PlayerFrame',
    [2] = utils.mediaPath .. 'PlayerLowThreat',
    [3] = utils.mediaPath .. 'PlayerHighThreat',
}
local function onevent(self, event, unit)
    if(self.unit ~= unit) then return end
    local status = UnitThreatSituation(unit) or 0
    local texture = textures[status] or textures[1]
    self.texture:SetTexture(texture)
end
local function threatUpdate(self, unit)
    self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', onevent)
    table.insert(self.__elements, onevent)
end

addon:addLayoutElement('player', threatUpdate)


local tag = function(self, unit)
    local hp = self:CreateFontString(nil, 'OVERLAY')
    hp:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE')
    hp:SetPoint('RIGHT', self, -10, -11)
    self:Tag(hp, tags.hp)

    local mp = self:CreateFontString(nil, 'OVERLAY')
    mp:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE')
    mp:SetPoint('LEFT', self, 'LEFT', 85, -11)
    self:Tag(mp, tags.mp)

    local lvl = self:CreateFontString(nil, 'OVERLAY')
    lvl:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    lvl:SetPoint('BOTTOMLEFT', self, 49, 9)
    self:Tag(lvl, tags.lvl)

    local name = self:CreateFontString(nil, 'OVERLAY')
    name:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE')
    name:SetPoint('LEFT', self, 90, 27)
    self:Tag(name, tags.majorname)
end
addon:addLayoutElement('player', tag)

addon:addLayoutElement('player', function(self, unit)
    local combat = self:CreateTexture(nil, 'OVERLAY')
    self.Combat = combat
    utils.setSize(combat, 30)
    combat:SetTexture(utils.mediaPath .. 'Combat')
    combat:SetPoint('CENTER', self, 'TOPLEFT', 45, 10)


    local looter = self:CreateTexture(nil, 'OVERLAY')
    self.MasterLooter = looter
    utils.setSize(looter, 24)
    --looter:SetTexture(utils.mediaPath .. '')
    looter:SetTexture([[Interface\GroupFrame\UI-Group-MasterLooter]])
    looter:SetPoint('CENTER', self, 'TOPLEFT', 10, 0)

    local leader = self:CreateTexture(nil, 'OVERLAY')
    self.Leader = leader
    utils.setSize(leader , 30)
    leader:SetTexture(utils.mediaPath .. 'Leader')
    leader:SetPoint('CENTER', self, 'TOPLEFT', 75, 0)

    local ass = self:CreateTexture(nil, 'OVERLAY')
    self.Assistant = ass
    utils.setSize(ass, 30)
    ass:SetTexture(utils.mediaPath .. 'Leader2')
    ass:SetPoint('CENTER', leader)
end)

local _, class = UnitClass'player'
addon:addLayoutElement('player', class == 'DEATHKNIGHT' and function(self, unit)
    local runes = CreateFrame('Frame', nil, self.Power)
    self.Runes = runes

    --utils.testBackdrop(runes)

    local w,h, spacing = 180, 7, 1
    utils.setSize(runes, w, 7)
    runes:SetPoint('TOP', self, 37, -30)

    for i = 1, 6 do
        local bar = CreateFrame('StatusBar', nil, runes)
        runes[i] = bar

        bar:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
        utils.setSize(bar, (w-5*spacing)/6, h)

        if(i==1) then
            bar:SetPoint('TOPLEFT', runes)
        else
            bar:SetPoint('TOPLEFT', runes[i-1], 'TOPRIGHT', spacing, 0)
        end

        bar.bg = bar:CreateTexture(nil, 'BORDER')
        bar.bg:SetAllPoints(bar)
        bar.bg:SetTexture(utils.mediaPath .. 'StatusBar1')
        bar.bg.multiplier = .5
    end
end)

