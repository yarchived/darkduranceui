
if IsAddOnLoaded'Dominos' or Dominos then return end

yBar = {}


local function disable(frame)
	frame:UnregisterAllEvents()
	frame:SetScript('OnUpdate', nil)
	frame:Hide()
end

-- 关闭暴雪动作条
function yBar:DisableBlizzard()
	local dummy = Multibar_EmptyFunc
	
	MultiActionBar_UpdateGrid = dummy
	MultiActionBar_Update = dummy
	ShowBonusActionBar = dummy
	
	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarRight'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarLeft'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarBottomLeft'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarBottomRight'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['MainMenuBar'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['ShapeshiftBarFrame'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['PossessBarFrame'] = nil
	UIPARENT_MANAGED_FRAME_POSITIONS['PETACTIONBAR_YPOS'] = nil
	
	
	disable(MainMenuBar)
	disable(MainMenuBarArtFrame)
	disable(MainMenuExpBar)
	disable(ShapeshiftBarFrame)
	disable(BonusActionBarFrame)
	disable(PossessBarFrame)
	
	-- register back some events
	--MainMenuBarArtFrame:RegisterEvent('BAG_UPDATE') -- backpag button stuff, should be enabled in pagbar
	MainMenuBarArtFrame:RegisterEvent('KNOWN_CURRENCY_TYPES_UPDATE') -- why blizz register it here???
	MainMenuBarArtFrame:RegisterEvent('CURRENCY_DISPLAY_UPDATE') -- ditto

	-- should we do this?
	for i=1,12 do
		disable(_G['ActionButton' .. i])
		disable(_G['MultiBarBottomLeftButton' .. i])
		disable(_G['MultiBarBottomRightButton' .. i])
		disable(_G['MultiBarRightButton' .. i])
		disable(_G['MultiBarLeftButton' .. i])
		disable(_G['BonusActionButton' .. i])
	end
	
	MainMenuBar_ToPlayerArt = dummy
	--[[
	local function onload()
		PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
	end
	
	if PlayerTalentFrame then
		onload()
	else
		hooksecurefunc('TalentFrame_LoadUI', onload)
	end
	]]
end

function yBar:Spawn(type, ...)
	local class = self[type]
	assert(class, format('%s doesn\'t exists.', type))
	local bar = class:New(...)
	return bar
end
