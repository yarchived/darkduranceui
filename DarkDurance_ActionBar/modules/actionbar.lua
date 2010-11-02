--[[
	ActionButton
]]

if not yBar then return end

local ActionButton = CreateFrame('CheckButton')
yBar.ActionButton = ActionButton
ActionButton.mt = {__index = ActionButton}

--[[local function OnAttributeChanged(self, ...)
	print(self:GetName(), ...)
end]]


function ActionButton:New(id)
	local b = self:Create(id)
	if b then
		b:SetAttribute('showgrid', 0)
		b:SetAttribute('action-base', id)
		--b:SetAttribute('action', id)

		b:SetAttribute('_childupdate-action', [[
			local id = message and self:GetAttribute('action-' .. message) or self:GetAttribute('action-base')
			self:SetAttribute('action', id)
		]])
		
		b.eventsRegistered = nil
		b:LoadEvents()
		ActionButton_UpdateAction(b)

		-- for debug
		-- b:HookScript('OnAttributeChanged', OnAttributeChanged)

		return b
	end
end

local function Create(id)
	if id <= 12 then
		local b = _G['ActionButton' .. id]
		b.buttonType = 'ACTIONBUTTON'
		return b
	elseif id <= 24 then
		local b = _G['BonusActionButton' .. (id - 12)]
		b:UnregisterEvent('UPDATE_BONUS_ACTIONBAR')
		b.isBonus = nil
		b.buttonType = nil --this is done because blizzard displays action bar 1 bindings on the bonus bar, which is incorrect in the case of Dominos
		return b
	elseif id <= 36 then
		return _G['MultiBarRightButton' .. (id-24)]
	elseif id <= 48 then
		return _G['MultiBarLeftButton' .. (id-36)]
	elseif id <= 60 then
		return _G['MultiBarBottomRightButton' .. (id-48)]
	elseif id <= 72 then
		return _G['MultiBarBottomLeftButton' .. (id-60)]
--	else
--		return CreateFrame('CheckButton', 'DominosActionButton' .. (id-72), nil, 'ActionBarButtonTemplate')
	end
end

function ActionButton:Create(id)
	local b = Create(id)
	if b then
		b = setmetatable(b, self.mt)

		--this is used to preserve the button's old id
		--we cannot simply keep a button's id at > 0 or blizzard code will take control of paging
		--but we need the button's id for the old bindings system
		b:SetAttribute('bindingid', b:GetID())
		b:SetID(0)

		b:ClearAllPoints()
		b:SetAttribute('useparent-actionpage', nil)
		b:SetAttribute('useparent-unit', true)
		b:EnableMouseWheel(true)
		b:SetScript('OnEnter', b.OnEnter)
	end
	return b
end

function ActionButton:OnEnter()
	if not self.Bar.notooltip then
		ActionButton_SetTooltip(self)
	end
end

function ActionButton:LoadEvents()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('ACTIONBAR_SHOWGRID')
	self:RegisterEvent('ACTIONBAR_HIDEGRID')
	self:RegisterEvent('ACTIONBAR_PAGE_CHANGED')
	self:RegisterEvent('ACTIONBAR_SLOT_CHANGED')
	self:RegisterEvent('UPDATE_BINDINGS')
end

local function getHotKey(self)
	local key = _G[self:GetName() .. 'HotKey']
	self.ybar_hotkey = key
	return key
end

function ActionButton:UpdateHotKey(buttonType)
	local key = self.ybar_hotkey or getHotKey(self)

	buttonType = buttonType or self.buttonType
	local id = self:GetAttribute('bindingid') or self:GetID()

	local text = buttonType and (GetBindingKey(buttonType .. id) or GetBindingKey('CLICK '..self:GetName()..':LeftButton'))

	if text then
		key:SetText(text)
		key:Show()
	else
		key:SetText('')
		key:Hide()
	end
end

hooksecurefunc('ActionButton_UpdateHotkeys', ActionButton.UpdateHotKey)

--[[
	ActionBar
]]

local BarFrame = yBar.BarFrame
local ActionBar = CreateFrame('Frame')
yBar.ActionBar = ActionBar
ActionBar = setmetatable(ActionBar, {__index = BarFrame})
ActionBar.mt = {__index = ActionBar}

function ActionBar:New(id, num)
	local bar = setmetatable(BarFrame:New(), self.mt)
	
	local num = num and math.min(12, num) or 12
	local baseid = (id - 1) * 12
	
	for i = 1, num do
		local b = ActionButton:New(baseid+i)
		bar.buttons[i] = b
		
		b:SetParent(bar)
		b.Bar = bar
		
		for j = 1, 11 do
			b:SetAttribute('action-'..j, (j - 1) * 12 + i)
		end
	end
	
	-- for debug
	-- bar:HookScript('OnAttributeChanged', OnAttributeChanged)
	
	bar:UpdateButtonPositions()
--	bar:LoadDefaultState()
	bar:UpdateActions()
	bar:UpdateStateController()
	bar:ClearPageState()
	
	return bar
end


--[[
	內置條件?
	
	[form:1]1;[form:2]2;0
]]


function ActionBar:SetPageState(state)
	UnregisterStateDriver(self, 'page')

	if state then
		RegisterStateDriver(self, 'page', state)
		self:UpdateActions()
	end
end

function ActionBar:ClearPageState()
	UnregisterStateDriver(self, 'page')
	RegisterStateDriver(self, 'page', '0')
	self:UpdateActions()
end

function ActionBar:UpdateStateController()
	self:SetAttribute('_onstate-page', [[ control:ChildUpdate('action', newstate)]])
end

function ActionBar:UpdateActions()
	local state = self:GetAttribute('state-page')
	if state then
		self:Execute(format([[ control:ChildUpdate('action', '%s') ]], state))
	else
		self:Execute([[ control:ChildUpdate('action', nil) ]])
	end
end

function ActionBar:SetGrid(show)
	local grid = show and 1 or 0
	local func = show and ActionButton_ShowGrid or ActionButton_HideGrid
	
	for i = 1, #self.buttons do
		local b = self.buttons[i]
		b:SetAttribute('showgrid', grid)
		func(b)
	end
end

function ActionBar:SetBinding(t)
	self.bindings = t
	local num = #self.buttons
	for i = 1, num do
		local b = self.buttons[i]
		local key = t[i]
		if key then
			SetBindingClick(key, b:GetName(), 'LeftButton')
		end
	end
end

