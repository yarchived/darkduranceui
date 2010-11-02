
if not yBar then return end

local StanceButton = CreateFrame('CheckButton')
yBar.StanceButton = StanceButton
StanceButton.mt = {__index = StanceButton}

function StanceButton:New(id)
	local b = setmetatable(CreateFrame('CheckButton', format('yBarStanceButton%d', id), nil, 'ShapeshiftButtonTemplate'), self.mt)
	b:SetID(id)
	b:SetScript('OnEnter', b.OnEnter)
	
	local name = b:GetName()
	b.hotkey = _G[name .. 'HotKey']
	b.cooldown = _G[name .. 'Cooldown']
	b.icon = _G[name .. 'Icon']
	b.normalTexture = b:GetNormalTexture()
	
	b.normalTexture:SetTexture('')
	b.hotkey:Hide()
	
	return b
end

function StanceButton:OnEnter()
	if not self.Bar.notooltip then
		if GetCVar('UberTooltips') == '1' then
			GameTooltip_SetDefaultAnchor(GameTooltip, self)
		else
			GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		end
		GameTooltip:SetShapeshift(self:GetID())
	end
end

function StanceButton:Update()
	local id = self:GetID()
	local texture, name, isActive, isCastable = GetShapeshiftFormInfo(id)
	
	self.icon:SetTexture(texture)
	
	if texture then
		self.cooldown:Show()
	else
		self.cooldown:Hide()
	end
	local start, duration, enable = GetShapeshiftFormCooldown(id)
	CooldownFrame_SetTimer(self.cooldown, start, duration, enable)
	

	if isActive then
		self:SetChecked(1)
	else
		self:SetChecked(0)
	end

	if isCastable then
		self.icon:SetVertexColor(1.0, 1.0, 1.0)
	else
		self.icon:SetVertexColor(0.4, 0.4, 0.4)
	end
end

function StanceButton:Free()
	-- self:UnregisterAllEvents()
	self:Hide()
	self.free = true
end

--[[
	StanceBar
]]
local BarFrame = yBar.BarFrame
local StanceBar = CreateFrame('Frame')
yBar.StanceBar = StanceBar
StanceBar = setmetatable(StanceBar, {__index = BarFrame})
StanceBar.mt = {__index = StanceBar}

local function onEvent(self, event, ...)
	self[event](self, event, ...)
end

function StanceBar:New()
	local bar = setmetatable(BarFrame:New(), self.mt)
	
	bar:SetScript('OnEvent', onEvent)
	
	bar:UpdateStanceBar()
	bar:LoadEvents()
	
	return bar
end

function StanceBar:LoadEvents()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('UPDATE_SHAPESHIFT_FORMS')
	self:RegisterEvent('SPELL_UPDATE_COOLDOWN')
	self:RegisterEvent('SPELL_UPDATE_USABLE')
	self:RegisterEvent('PLAYER_AURAS_CHANGED')
	self:RegisterEvent('PLAYER_REGEN_ENABLED')
	self:RegisterEvent('ACTIONBAR_PAGE_CHANGED')
end

function StanceBar:CreateButton(id)
	local b = StanceButton:New(id)
	b:SetParent(self)
	self.buttons[id] = b
	b.Bar = self
	
	b:Update()
	
	return b
end

function StanceBar:UpdateStanceBar()
	local numButtons = #self.buttons
	local numShapeshiftForms = GetNumShapeshiftForms()
	if numButtons < numShapeshiftForms then
		for i = numButtons+1, numShapeshiftForms do
			self:CreateButton(i)
		end
		self:Update()
	end
	
	for i = 1, #self.buttons do
		local b = self.buttons[i]
		if i > numShapeshiftForms and (not b.free) then
			b:Free()
		else
			if b.free then
				b:Show()
				b.free = nil
			end
			b:Update()
		end
	end
end

function StanceBar:UpdateAllButtons()
	for i, b in next, self.buttons do
		if (not b.free) then
			b:Update()
		end
	end
end

StanceBar.PLAYER_ENTERING_WORLD = StanceBar.UpdateStanceBar
StanceBar.UPDATE_SHAPESHIFT_FORMS = StanceBar.UpdateStanceBar

StanceBar.SPELL_UPDATE_COOLDOWN = StanceBar.UpdateAllButtons
StanceBar.SPELL_UPDATE_USABLE = StanceBar.UpdateAllButtons
StanceBar.PLAYER_AURAS_CHANGED = StanceBar.UpdateAllButtons
StanceBar.PLAYER_REGEN_ENABLED = StanceBar.UpdateAllButtons
StanceBar.ACTIONBAR_PAGE_CHANGED = StanceBar.UpdateAllButtons

