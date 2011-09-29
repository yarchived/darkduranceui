
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local utils = addon.utils
local units = 'raid'

local function func(self, unit)
    self:SetBackdrop(utils.backdrop)
    self:SetBackdropColor(0,0,0, .7)

    local hp = CreateFrame('StatusBar', nil, self)
    self.Health = hp
    hp:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
    hp:SetOrientation('VERTICAL')
    hp:GetStatusBarTexture():SetHorizTile(true)
    hp:GetStatusBarTexture():SetVertTile(true)
    hp:SetPoint('TOPLEFT')
    hp:SetPoint('TOPRIGHT')
    hp:SetPoint('BOTTOM', 0, 5)
    hp.colorClass = true

    hp.bg = hp:CreateTexture(nil, 'BACKGROUND')
    hp.bg:SetAllPoints(hp)
    hp.bg:SetTexture(utils.mediaPath .. 'StatusBar1')
    hp.bg:SetHorizTile(true)
    hp.bg:SetVertTile(true)
    hp.bg.multiplier = .3

    local mp = CreateFrame('StatusBar', nil, self)
    self.Power = mp
    mp:SetStatusBarTexture(utils.mediaPath .. 'StatusBar1')
    mp:SetPoint('TOPLEFT', hp, 'BOTTOMLEFT', 0, -1)
    mp:SetPoint('BOTTOMRIGHT')
    mp.colorPower = true

    mp.bg = mp:CreateTexture(nil, 'BACKGROUND')
    mp.bg:SetAllPoints(mp)
    mp.bg:SetTexture(utils.mediaPath .. 'StatusBar1')
    mp.bg.multiplier = .3
    --utils.testBackdrop(self)

    local name = hp:CreateFontString(nil, 'OVERLAY')
    name:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
    name:SetPoint('CENTER', hp, 0, -1)
    self:Tag(name, addon.tags.name3)
    self.nametag = name

    --local tex = mp:CreateTexture(nil, 'ARTWORK')
    --tex:SetTexture(utils.mediaPath .. 'gloss_grey')
    --tex:SetAllPoints(self)

	self.RaidDebuffs = CreateFrame('Frame', nil, self)
	self.RaidDebuffs:SetHeight(20)
	self.RaidDebuffs:SetWidth(20)
	self.RaidDebuffs:SetPoint('CENTER', self)
	self.RaidDebuffs:SetFrameStrata'HIGH'
	
	self.RaidDebuffs:SetBackdrop(utils.backdrop)
	
	self.RaidDebuffs.icon = self.RaidDebuffs:CreateTexture(nil, 'OVERLAY')
	self.RaidDebuffs.icon:SetTexCoord(.1,.9,.1,.9)
	self.RaidDebuffs.icon:SetAllPoints(self.RaidDebuffs)
	
	self.RaidDebuffs.cd = CreateFrame('Cooldown', nil, self.RaidDebuffs)
	self.RaidDebuffs.cd:SetAllPoints(self.RaidDebuffs)
	
	--[[
	self.RaidDebuffs.time = self.RaidDebuffs:CreateFontString(nil, 'OVERLAY')
	self.RaidDebuffs.time:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
	self.RaidDebuffs.time:SetPoint('CENTER', self.RaidDebuffs, 'CENTER', 0, 0)
	self.RaidDebuffs.time:SetTextColor(1, .9, 0)
	]]
	
	self.RaidDebuffs.count = self.RaidDebuffs:CreateFontString(nil, 'OVERLAY')
	self.RaidDebuffs.count:SetFont(STANDARD_TEXT_FONT, 8, 'OUTLINE')
	self.RaidDebuffs.count:SetPoint('BOTTOMRIGHT', self.RaidDebuffs, 'BOTTOMRIGHT', 2, 0)
	self.RaidDebuffs.count:SetTextColor(1, .9, 0)
end

addon:addLayoutElement(units, func)
--addon:setSize(units, 40)


addon:addLayoutElement(units, function(self, unit)
    local looter = self.Health:CreateTexture(nil, 'OVERLAY')
    self.MasterLooter = looter
    utils.setSize(looter, 14)
    --looter:SetTexture(utils.mediaPath .. '')
    looter:SetTexture([[Interface\GroupFrame\UI-Group-MasterLooter]])
    looter:SetPoint('CENTER', self, 'TOPRIGHT', -7, 0)

    local leader = self.Health:CreateTexture(nil, 'OVERLAY')
    self.Leader = leader
    utils.setSize(leader , 14)
    leader:SetTexture(utils.mediaPath .. 'Leader')
    leader:SetPoint('CENTER', self, 'TOPLEFT', 7, 0)

    local ass = self.Health:CreateTexture(nil, 'OVERLAY')
    self.Assistant = ass
    utils.setSize(ass, 14)
    ass:SetTexture(utils.mediaPath .. 'Leader2')
    ass:SetPoint('CENTER', leader)
end)



addon:spawn(function()
    local u = {}
    addon.units.raid = u

    for i = 1, 5 do
        local header = oUF:SpawnHeader(
            addonName .. '_RaidFrame' .. i, nil, nil,
            'oUF-initialConfigFunction', [[ self:SetWidth(40); self:SetHeight(40) ]],
            'showRaid', true,
            'groupFilter', tostring(i),
            'yOffset', -5)

        header:Show()
        u[i] = header
        if(i==1) then
            header:SetPoint('TOPLEFT', UIParent, 5, -15)
        else
            header:SetPoint('TOPLEFT', u[i-1], 'TOPRIGHT', 5, 0)
        end
    end
end)

--[[
List of the various configuration attributes
======================================================
showRaid = [BOOLEAN] -- true if the header should be shown while in a raid
showParty = [BOOLEAN] -- true if the header should be shown while in a party and not in a raid
showPlayer = [BOOLEAN] -- true if the header should show the player when not in a raid
showSolo = [BOOLEAN] -- true if the header should be shown while not in a group (implies showPlayer)
nameList = [STRING] -- a comma separated list of player names (not used if 'groupFilter' is set)
groupFilter = [1-8, STRING] -- a comma seperated list of raid group numbers and/or uppercase class names and/or uppercase roles
strictFiltering = [BOOLEAN] - if true, then characters must match both a group and a class from the groupFilter list
point = [STRING] -- a valid XML anchoring point (Default: 'TOP')
xOffset = [NUMBER] -- the x-Offset to use when anchoring the unit buttons (Default: 0)
yOffset = [NUMBER] -- the y-Offset to use when anchoring the unit buttons (Default: 0)
sortMethod = ['INDEX', 'NAME'] -- defines how the group is sorted (Default: 'INDEX')
sortDir = ['ASC', 'DESC'] -- defines the sort order (Default: 'ASC')
template = [STRING] -- the XML template to use for the unit buttons
templateType = [STRING] - specifies the frame type of the managed subframes (Default: 'Button')
groupBy = [nil, 'GROUP', 'CLASS', 'ROLE'] - specifies a 'grouping' type to apply before regular sorting (Default: nil)
groupingOrder = [STRING] - specifies the order of the groupings (ie. '1,2,3,4,5,6,7,8')
maxColumns = [NUMBER] - maximum number of columns the header will create (Default: 1)
unitsPerColumn = [NUMBER or nil] - maximum units that will be displayed in a singe column, nil is infinate (Default: nil)
startingIndex = [NUMBER] - the index in the final sorted unit list at which to start displaying units (Default: 1)
columnSpacing = [NUMBER] - the ammount of space between the rows/columns (Default: 0)
columnAnchorPoint = [STRING] - the anchor point of each new column (ie. use LEFT for the columns to grow to the right)
]]
