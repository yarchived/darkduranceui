-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local config = addon.cfg
local utils = addon.utils
local tags = addon.tags
local units = 'party'

local function func(self, unit)
    ns.style_party(self, unit)

    local dogtag = self:CreateFontString(nil, 'OVERLAY')
    dogtag:SetPoint('TOP', self, 'BOTTOM', 0, -2)
    dogtag:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
    self:Tag(dogtag, '[difficulty][smartlevel]|r [raidcolor][name4]|r')
end

addon:addLayoutElement(units, func)
--addon:setSize(units, 40, 40)

addon:spawn(function()

    local party = oUF:SpawnHeader(
        addonName .. '_PartyFrame', nil, nil,--'solo,party,raid',
        'oUF-initialConfigFunction', [[
            local header = self:GetParent()
            local w, h = header:GetAttribute'initial-width', header:GetAttribute'initial-height'
            local s = header:GetAttribute'initial-scale'
            self:SetWidth(w)
            self:SetHeight(h)
            self:SetScale(s)
        ]],
        'showParty', true,
        --'showRaid', true,
        'unitsPerColumn', 2,
        'maxColumns', 2,
        'point', 'LEFT',
        --'yOffset', -5,
        'xOffset', 5,
        'columnSpacing', 20,
        'columnAnchorPoint', 'TOP',
        'initial-width', 90,
        'initial-height', 90,
        'initial-scale', config.Global_Scale
    )
    party:SetPoint('CENTER', UIParent, 400, 0)
    party:Show()

    addon.units.party = party


    local f = CreateFrame'Frame'
    f:SetScript('OnEvent', function(self, event)
        if(InCombatLockdown()) then return end

        local hide = GetNumRaidMembers() > 5
        if(GetNumRaidMembers() > 5) then
            if(party:IsShown()) then
                party:Hide()
            end
        else
            if(not party:IsShown()) then
                party:Show()
            end
        end
    end)
    f:RegisterEvent'PLAYER_REGEN_ENABLED'
    f:RegisterEvent'PARTY_MEMBERS_CHANGED'
    f:RegisterEvent'PARTY_MEMBER_ENABLE'
    f:RegisterEvent'RAID_ROSTER_UPDATE'
end)


