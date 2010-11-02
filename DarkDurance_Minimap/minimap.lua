-- http://www.wowwiki.com/GetMinimapShape
function _G.GetMinimapShape() return 'SQUARE' end

local addon = CreateFrame'Frame'
_G.DarkDurance_Minimap = addon

addon:SetScript('OnEvent', function(self, event, ...)
    self[event](self, event, ...)
end)

addon:RegisterEvent('PLAYER_LOGIN')
function addon:PLAYER_LOGIN()
    self:VARIABLES_LOADED()
end

addon:RegisterEvent('ZONE_CHANGED_NEW_AREA')
function addon:ZONE_CHANGED_NEW_AREA()
	SetMapToCurrentZone()
end

addon:RegisterEvent'VARIABLES_LOADED'
function addon:VARIABLES_LOADED()
    --SetCVar('showClock', '0')
	SetCVar('profanityFilter', '0')
end

addon:RegisterEvent'ADDON_LOADED'
function addon:ADDON_LOADED(event, name)
    if(TimeManagerClockButton) then
        TimeManagerClockButton:SetScript('OnUpdate', nil)
        TimeManagerClockButton:Hide()
        TimeManagerClockButton.Show = function() end
        self:UnregisterEvent(event)
    end
end

MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel()
Minimap:SetScript('OnMouseWheel', function(self, dir)
	if(dir > 0) then
		Minimap_ZoomIn()
	else
		Minimap_ZoomOut()
	end
end)

MinimapBorder:SetTexture(nil)
MinimapBorder:Hide()
local mapborder = Minimap:CreateTexture(nil, 'OVERLAY')
mapborder:SetTexture[[Interface\AddOns\DarkDurance_Minimap\Textures\MinimapBorder]]
mapborder:SetPoint('TOPLEFT', Minimap, -25, 15)
mapborder:SetPoint('BOTTOMRIGHT', Minimap, 40, -40)

addon.border = mapborder

MiniMapWorldMapButton:Hide()

GameTimeFrame:ClearAllPoints()
GameTimeFrame:SetPoint('BOTTOM', Minimap, 0, -16)
GameTimeFrame:SetNormalTexture(nil)

local text = GameTimeFrame:CreateFontString(nil, 'OVERLAY')
addon.time = text
text:SetPoint('CENTER', GameTimeFrame)
text:SetFont(STANDARD_TEXT_FONT, 26, 'OUTLINE')
text:SetJustifyH'CENTER'
text:SetJustifyV'CENTER'
text:SetTextColor(1, 1, 1)

addon.nextUpdate = 1
addon:SetScript('OnUpdate', function(self, elapsed)
    self.nextUpdate = self.nextUpdate - elapsed
    if(self.nextUpdate <= 0) then
        self.nextUpdate = 20

        local text = date('%d')
        self.time:SetText(text)
    end
end)


MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint('TOPRIGHT', Minimap, 15, 3)
MiniMapTracking:SetScale(1.5)

MinimapBorderTop:Hide()
MinimapZoneTextButton:Hide()





