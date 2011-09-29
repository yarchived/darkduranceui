
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF
local utils = addon.utils

local textures = {
    worldboss = utils.mediaPath .. 'EliteFrame',
    elite = utils.mediaPath .. 'EliteFrame',
    rare = utils.mediaPath .. 'RareEliteFrame',
    normal = utils.mediaPath .. 'PlayerFrame',
}

local update_target_texture = function(self)
    local c = UnitClassification('target') or 'normal'
    local tex = textures[c] or textures['normal']
    if(tex) then
        self.texture:SetTexture(tex)
    end
end

local function targetChanged(self, unit)
    table.insert(self.__elements, update_target_texture)
end

addon:addLayoutElement('target', targetChanged)


local function targetThreat(self, unit)
    local button = CreateFrame('Button', nil, self)
    self.ThreatButton = button
    button:SetFrameStrata('MEDIUM')
    button:SetHeight(28)
    button:SetWidth(50)
    button:SetPoint('TOPLEFT', self, 20, -8)

    local bar = CreateFrame('StatusBar', nil, button)
    button.statusBar = bar
    bar:SetFrameStrata('LOW')
    bar:SetPoint('BOTTOMLEFT', button, 10, 0)
    bar:SetPoint('BOTTOMRIGHT', button, -10, 0)
    bar:SetHeight(20)
    bar:SetStatusBarTexture[[Interface\TargetingFrame\UI-StatusBar]]
    --bar:SetStatusBarColor(1,0,0)

    local tex = button:CreateTexture(nil, 'ARTWORK')
    button.texture = tex
    tex:SetAllPoints(button)
    tex:SetTexture(utils.mediaPath .. 'TargetThreat')

    local text = button:CreateFontString(nil, 'OVERLAY')
    button.text = text
    text:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
    text:SetPoint('BOTTOM', button, 'BOTTOM', 0, 8)
    text:SetJustifyH('CENTER')

    button.nextUpdate = 0
    button:SetScript('OnShow', function(self) self.nextUpdate = 0 end)
    button:SetScript('OnUpdate', function(self, el)
        self.nextUpdate = self.nextUpdate - el
        if(self.nextUpdate <= 0) then
            self.nextUpdate = .3

            local isTanking, status, pct, rawpct, value = UnitDetailedThreatSituation('player', 'target')
            pct = pct or 0
            --if(isTanking) then
            --    pct = 100
            --end
            local r, g, b = GetThreatStatusColor(status or 0)
            self.statusBar:SetStatusBarColor(r, g, b)
            self.text:SetFormattedText('%d%%', pct)
        end
    end)

    local function onevent(self, event, unit)
        --if(unit == 'player') then
            if(UnitCanAttack('player', 'target')) then
                self.ThreatButton:Show()
            else
                self.ThreatButton:Hide()
            end
        --end
    end
    --self:RegisterEvent('UNIT_TARGET', onevent)
    table.insert(self.__elements, onevent)
end
addon:addLayoutElement('target', targetThreat)

local function tag(self, unit)
    local tags = addon.tags

    local name = self:CreateFontString(nil, 'OVERLAY')
    name:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE')
    name:SetPoint('RIGHT', self, -90, 27)
    self:Tag(name, tags.majorname)

    local hp = self:CreateFontString(nil, 'OVERLAY')
    hp:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE')
    hp:SetPoint('RIGHT', self, -85, -11)
    self:Tag(hp, tags.hp)

    local mp = self:CreateFontString(nil, 'OVERLAY')
    mp:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE')
    mp:SetPoint('LEFT', self, 10, -11)
    self:Tag(mp, tags.mp)

    local lvl = self:CreateFontString(nil, 'OVERLAY')
    lvl:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    lvl:SetPoint('BOTTOMRIGHT', self, -49, 9)
    self:Tag(lvl, tags.lvl)
end
addon:addLayoutElement('target', tag)

local function postCreate(icons, button)
    local ol = button:CreateTexture(nil, 'ARTWORK')
    ol:SetPoint('TOPLEFT', button, -1, 1)
    ol:SetPoint('BOTTOMRIGHT', button, 1, -1)
    ol:SetTexture(utils.mediaPath .. 'SmartName')
    button.ol = ol

    button.icon:SetTexCoord(.1, .9, .1, .9)
end

local function setCommon(f)
    --utils.testBackdrop(f)

    f.size = 24
    --f.gap = true
    f.spacing = 2

    f.PostCreateIcon = postCreate

    f:SetWidth(200)
    f:SetHeight(10)

    return f
end


addon:addLayoutElement('target', function(self, unit)
    local buffs = CreateFrame('Frame', nil, self)
    self.Buffs = buffs

    setCommon(buffs)

    buffs['growth-x'] = 'RIGHT'
    buffs['growth-y'] = 'DOWN'
    buffs['initialAnchor'] = 'TOPLEFT'

    buffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -30)
end)

addon:addLayoutElement('target', function(self, unit)
    local debuffs = CreateFrame('Frame', nil, self)
    self.Debuffs = debuffs

    setCommon(debuffs)

    debuffs['growth-x'] = 'RIGHT'
    debuffs['growth-y'] = 'UP'
    debuffs['initialAnchor'] = 'BOTTOMLEFT'

    debuffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0, 35)
end)

