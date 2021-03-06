
local _NAME, _NS = ...
local oUF= _NS.oUF
local DDUF = _NS[_NAME]

DDUF:RegsiterCommonStyle(function(self, unit)
    self:SetScript('OnEnter', UnitFrame_OnEnter)
    self:SetScript('OnLeave', UnitFrame_OnLeave)
end)

DDUF:RegsiterCommonStyle(function(self, unit)
    self.BG = CreateFrame('Frame', nil, self)
    self.BG:SetAllPoints(self)
    self.BG:SetFrameStrata'BACKGROUND'

    self.FG = CreateFrame('Frame', nil, self)
    self.FG:SetAllPoints(self)

    self.Textures = {}

    self.Tags = {}
end)

local menu = function(self)
    local unit = self.unit:gsub('(.)', string.upper, 1)
    local frame

    frame = _G[unit..'FrameDropDown']

    if(not frame) and (self.unit:match'party') then
        frame = _G['PartyMemberFrame'..self.id..'DropDown']
    end

    if(not frame) then
        frame = FriendsDropDown
        frame.unit = self.unit
        frame.id = self.id
        frame.initialize = RaidFrameDropDown_Initialize
    end

    if(frame) then
        ToggleDropDownMenu(1, nil, frame, 'cursor')
    end
end

DDUF:RegsiterCommonStyle(function(self, unit)
    self.menu = menu
    self:RegisterForClicks'AnyUp'
    self:SetAttribute('type2', 'menu')

    self.colors = DDUF.colors
end)

