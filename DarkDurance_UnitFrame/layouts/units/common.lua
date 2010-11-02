-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local function menu(self)
	local unit = self.unit:gsub('(.)', string.upper, 1)
    local frame
	if _G[unit..'FrameDropDown'] then
        frame = _G[unit..'FrameDropDown']
    -- party
	elseif(self.unit:match('party')) then
        frame = _G['PartyMemberFrame'..self.id..'DropDown']
	else -- raid
        frame = FriendsDropDown
        frame.unit = self.unit
        frame.id = self.id
		frame.initialize = RaidFrameDropDown_Initialize
	end
    if(frame) then
        ToggleDropDownMenu(1, nil, frame, 'cursor')
    end
end

local function common(self, unit)
    self.menu = menu
    self:RegisterForClicks('AnyUp')
    self:SetAttribute('type2', 'menu')

	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

    self.colors = addon.colors

    local bg = CreateFrame('Frame', nil, self)
    bg:SetAllPoints(self)
    bg:SetFrameStrata('BACKGROUND')
    self.bg = bg

end

addon:addCommonElement(common)

do --- Click to set focus
    -- define the mod key
    -- default: shift click
    local ModKey = 'Shift'
    local MouseButton = 1
    addon:addCommonElement(function(self, unit)
        local key = ModKey .. '-type' .. (MouseButton or '')

        if(self.unit == 'focus') then
            self:SetAttribute(key, 'macro')
            self:SetAttribute('macrotext', '/clearfocus')
        else
            self:SetAttribute(key, 'focus')
        end
    end)
end


