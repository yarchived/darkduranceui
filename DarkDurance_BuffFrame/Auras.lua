-- yleaf (yaroot@gmail.com)

local BUFFS_PER_ROW = 12
local BUFF_MAX_DISPLAY = 32
local DEBUFF_MAX_DISPLAY = 16
local ROW_SPACING = 15
local SPACING = 5
local ICON_SIZE = 30
local COUNT_FONT = {STANDARD_TEXT_FONT, 12, 'OUTLINE'}
local DURATION_FONT = {STANDARD_TEXT_FONT, 13}
local POSITION = {'TOPRIGHT', Minimap, 'TOPLEFT', -20, 0}
local TEMP_POSITION = {'TOPRIGHT', '~', 'TOPLEFT', -10, 0}
local TEXTURE
do
    local path = debugstack():match[[\AddOns\(.-)\]]
    TEXTURE = [[Interface\AddOns\]] .. path .. [[\SmartName]]
end

local function fuk(self)
	self:UnregisterAllEvents()
	self:SetScript('OnUpdate', nil)
	self:SetScript('OnEvent', nil)
	self:Hide()
end

fuk(BuffFrame)
fuk(TemporaryEnchantFrame)


local buffs = CreateFrame('Frame', 'yBuffFrame', UIParent)
local debuffs = CreateFrame('Frame', 'yDebuffFrame', UIParent)
local temps = CreateFrame('Frame', 'yTempEnchantFrame', UIParent)
do
	local rows = ceil(BUFF_MAX_DISPLAY/BUFFS_PER_ROW)
	
	buffs:SetWidth(BUFFS_PER_ROW*(ICON_SIZE+SPACING) - SPACING)
	buffs:SetHeight(rows*(ICON_SIZE+ROW_SPACING))
	
	local d_rows = ceil(DEBUFF_MAX_DISPLAY/BUFFS_PER_ROW)
	
	debuffs:SetWidth(BUFFS_PER_ROW*(ICON_SIZE+SPACING) - SPACING)
	debuffs:SetHeight(d_rows*(ICON_SIZE+ROW_SPACING))
	
	buffs:SetPoint(unpack(POSITION))
	debuffs:SetPoint('TOPRIGHT', buffs, 'BOTTOMRIGHT')
	
	temps:SetWidth(ICON_SIZE*2 + SPACING)
	temps:SetHeight(ICON_SIZE)
	
	if TEMP_POSITION[2] == '~' then TEMP_POSITION[2] = buffs end
	temps:SetPoint(unpack(TEMP_POSITION))
end


local function onEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT')
	GameTooltip:SetUnitAura(PlayerFrame.unit, self.index, self.filter)
end

local function onLeave(self)
	GameTooltip:Hide()
end

local function onClick(self)
	CancelUnitBuff(PlayerFrame.unit, self.index, self.filter)
end

local function tempOnClick(self)
	if self.index == 16 then
		CancelItemTempEnchantment(1)
	elseif self.index == 17 then
		CancelItemTempEnchantment(2)
	end
end

local function tempOnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT')
	GameTooltip:SetInventoryItem('player', self.index)
end

local function createIcon(parent, template)
	local button = CreateFrame('Button', nil, parent, template)
	button:Hide()
	
	button:SetScript('OnEnter', onEnter)
	button:SetScript('OnLeave', onLeave)
	
	button:SetHeight(ICON_SIZE)
	button:SetWidth(ICON_SIZE)
	
	local icon = button:CreateTexture(nil, 'BACKGROUND')
	icon:SetAllPoints(button)
	icon:SetTexCoord(.1,.9,.1,.9)
	button.icon = icon
	
	local count = button:CreateFontString(nil, 'OVERLAY')
	count:SetFont(unpack(COUNT_FONT))
	count:SetPoint('BOTTOMRIGHT', button, 'BOTTOMRIGHT', -1, 0)
	button.count = count
	
	local duration = button:CreateFontString(nil, 'OVERLAY')
	duration:SetFont(unpack(DURATION_FONT))
	duration:SetTextColor(1, .82, 0)
	duration:SetShadowColor(0, 0, 0)
	duration:SetShadowOffset(1, -1)
	duration:SetPoint('TOP', button, 'BOTTOM', 0, 0)
	button.duration = duration
	
	local overlay = button:CreateTexture(nil, 'OVERLAY')
	overlay:SetTexture(TEXTURE)
	overlay:SetPoint('TOPLEFT', button, -1, 1)
	overlay:SetPoint('BOTTOMRIGHT', button, 1, -1)
	button.overlay = overlay
	
	return button
end

local function sortPositions(containor, max)
	for i = 1, max do
		local button = containor[i]
		if i == 1 then
			button:SetPoint('TOPRIGHT', containor)
		else
			local row = (i-1)/BUFFS_PER_ROW
			if row == floor(row) then
				button:SetPoint('TOPRIGHT', containor[i-BUFFS_PER_ROW], 'BOTTOMRIGHT', 0, -ROW_SPACING)
			else
				button:SetPoint('TOPRIGHT', containor[i-1], 'TOPLEFT', -SPACING, 0)
			end
		end
	end
end

for i = 1, BUFF_MAX_DISPLAY do
	local button = createIcon(buffs, 'SecureActionButtonTemplate')
	buffs[i] = button
	--button:EnableMouse(true)
	--button:RegisterForClicks'RightButtonUp'
	--button:SetScript('OnClick', onClick)
    button:SetAttribute('type', 'macro')
    button:SetAttribute('macrotext', string.format('/cancelaura %d', i))
    button:RegisterForClicks'RightButtonUp'
	button.index = i
	button.filter = 'HELPFUL'
end

for i = 1, DEBUFF_MAX_DISPLAY do
	local button = createIcon(buffs)
	debuffs[i] = button
	button.index = i
	button.filter = 'HARMFUL'
end

for i = 1, 2 do
	local button = createIcon(buffs)
	temps[i] = button
	button.count:Hide()
	button:EnableMouse(true)
	button:RegisterForClicks'RightButtonUp'
	button:SetScript('OnClick', tempOnClick)
	button:SetScript('OnEnter', tempOnEnter)
end

temps[1]:SetPoint('TOPRIGHT', temps)
temps[2]:SetPoint('TOPRIGHT', temps[1], 'TOPLEFT', -SPACING, 0)
sortPositions(buffs, BUFF_MAX_DISPLAY)
sortPositions(debuffs, DEBUFF_MAX_DISPLAY)

local function formatTime(s)
	if s < 0 then return end
	
	local min = floor(s/60)
	local sec = floor(s%60)
	
	if s > 600 then
		--return format('|cff00ff00%dm|r', min)
		return format('%dm', min), s%60
	elseif s > 60 then
		--return format('|cffffd100%d:%02d|r', min, sec)
		return format('%d:%02d', min, sec), s - floor(s)
	else
		return format('|cffff0000%ds|r', sec), s - floor(s)
	end
end

local function onUpdate(self, el)
	self.total = self.total - el
	if self.total > 0 then return end
	
	local timeleft, nextUpdate = formatTime(self.expirationTime - GetTime())
	if timeleft then
		self.duration:SetText(timeleft)
		self.total = nextUpdate
	else
		self:SetScript('OnUpdate', nil)
		self.duration:Hide()
	end
end

local function updateIcon(self, icon, count, expirationTime)
	self.icon:SetTexture(icon)
	if count and count>1 then
		self.count:SetText(count)
		self.count:Show()
	else
		self.count:Hide()
	end
	
	if expirationTime and expirationTime>0 then
		self.duration:Show()
		self.expirationTime = expirationTime
		self.total = 0
		self:SetScript('OnUpdate', onUpdate)
	else
		self.duration:Hide()
		self.expirationTime = 0
		self:SetScript('OnUpdate', nil)
	end
	self:Show()
end

local function updateTempIcon(self, icon, expirationTime)
	self.icon:SetTexture(icon)
	if expirationTime then
		self.duration:SetText(formatTime(expirationTime/1000))
		self.duration:Show()
	else
		self.duration:Hide()
	end
	self:Show()
end

local function hide(c, i, j)
	for k = i, j do
		c[k]:Hide()
	end
end

local function updateAuras()
	--local unit = UnitInVehicle('player') and 'vehicle' or 'player'
	local unit = PlayerFrame.unit
	
	for i = 1, BUFF_MAX_DISPLAY do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, i, 'HELPFUL')
		if name then
			updateIcon(buffs[i], icon, count, expirationTime)
		else
			hide(buffs, i, BUFF_MAX_DISPLAY)
			break
		end
	end
	
	for i = 1, DEBUFF_MAX_DISPLAY do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, i, 'HARMFUL')
		if name then
			updateIcon(debuffs[i], icon, count, expirationTime)
		else
			hide(debuffs, i, DEBUFF_MAX_DISPLAY)
			break
		end
	end
end

local function updateTemporaty()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
	local index = 1
	if hasOffHandEnchant then
		local button = temps[index]
		button.index = 17
		updateTempIcon(button, GetInventoryItemTexture('player', 17), offHandExpiration)
		index = index + 1
	end
	
	if hasMainHandEnchant then
		local button = temps[index]
		button.index = 16
		updateTempIcon(button, GetInventoryItemTexture('player', 16), mainHandExpiration)
		index = index + 1
	end
	
	if index <= 2 then
		for i = index, 2 do
			temps[i]:Hide()
		end
	end
end

function buffs:UNIT_AURA(event, unit)
	--if unit == (UnitInVehicle('player') and 'vehicle' or 'player') then
	if unit == PlayerFrame.unit then
		updateAuras()
	end
end
function buffs:PLAYER_ENTERING_WORLD()
	updateAuras()
	updateTemporaty()
end

function buffs:UNIT_INVENTORY_CHANGED(event, unit)
	if unit == 'player' then
		updateTemporaty()
	end
end

buffs.UNIT_EXITED_VEHICLE = buffs.UNIT_AURA
buffs.UNIT_ENTERED_VEHICLE = buffs.UNIT_AURA


hooksecurefunc('BuffFrame_Update', updateAuras)

buffs:SetScript('OnEvent', function(self, event, ...) self[event](self,event,...) end)
buffs:RegisterEvent('UNIT_AURA')
buffs:RegisterEvent('PLAYER_ENTERING_WORLD')
buffs:RegisterEvent('UNIT_INVENTORY_CHANGED')
buffs:RegisterEvent('UNIT_EXITED_VEHICLE')
buffs:RegisterEvent('UNIT_ENTERED_VEHICLE')

local total = 0
temps:SetScript('OnUpdate', function(self, el)
	total = total - el
	if total > 0 then return end
	total = 1
	updateTemporaty()
end)
