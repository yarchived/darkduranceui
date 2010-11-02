
if not yBar then return end

local PetButton = CreateFrame('CheckButton')
yBar.PetButton = PetButton
PetButton.mt = {__index = PetButton}

function PetButton:New(id)
	local b = _G['PetActionButton'..id]
	b = setmetatable(b, self.mt)
	b.buttonType = 'BONUSACTIONBUTTON'
	b:SetScript('OnEnter', b.OnEnter)
	
	return b
end

function PetButton:OnEnter()
	if not self.Bar.notooltip then
		PetActionButton_OnEnter(self)
	end
end

hooksecurefunc('PetActionButton_SetHotkeys', yBar.ActionButton.UpdateHotKey)

--[[
	PetBar
]]
local BarFrame = yBar.BarFrame
local PetBar = CreateFrame('Frame')
yBar.PetBar = PetBar
PetBar = setmetatable(PetBar, {__index = BarFrame})
PetBar.mt = {__index = PetBar}

function PetBar:New()
	local bar = setmetatable(BarFrame:New(), self.mt)
	for i = 1, 10 do
		local b = PetButton:New(i)
		bar.buttons[i] = b
		b:SetParent(bar)
		b.Bar = bar
	end
	
	bar.ButtonSize = 30
	bar:Update()
	
	local state
	if select(4, GetBuildInfo()) >= 30300 then
		state = '[@pet,exists,nobonusbar:5]show;hide'
	else
		state = '[target=pet,exists,nobonusbar:5]show;hide'
	end
    bar:Show()
    bar:SetVisibilityState(state)
	
	
	return bar
end



