local ALTERNATE_POWER_INDEX = ALTERNATE_POWER_INDEX

local UpdatePower = function(self, event, unit, powerType)
	if(self.unit ~= unit or powerType ~= 'ALTERNATE') then return end

	local altpowerbar = self.AltPowerBar

	if(altpowerbar.PreUpdate) then
		altpowerbar:PreUpdate()
	end

	local barType, min = UnitAlternatePowerInfo(unit)
	local cur = UnitPower(unit, ALTERNATE_POWER_INDEX)
	local max = UnitPowerMax(self.unit, ALTERNATE_POWER_INDEX)

	altpowerbar.barType = barType
	altpowerbar:SetValue(cur)
	altpowerbar:SetMinMaxValues(min, max)

	if(altpowerbar.PostUpdate) then
		return altpowerbar:PostUpdate(min, cur, max)
	end
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'ALTERNATE')
end

local Toggler = function(self, event, unit)
	if(unit ~= self.unit) then return end
	local altpowerbar = self.AltPowerBar

	local barType, minPower, _, _, _, hideFromOthers = UnitAlternatePowerInfo(unit)
	if(barType and not hideFromOthers) then
		self:RegisterEvent('UNIT_POWER', UpdatePower)
		self:RegisterEvent('UNIT_MAXPOWER', UpdatePower)

		local max = UnitPowerMax(unit, ALTERNATE_POWER_INDEX)
		local cur = UnitPower(unit, ALTERNATE_POWER_INDEX)

		altpowerbar.barType = barType
		altpowerbar:SetMinMaxValues(minPower, max)
		altpowerbar:SetValue(cur)

		self:Show()
	else
		self:UnregisterEvent('UNIT_POWER', UpdatePower)
		self:UnregisterEvent('UNIT_MAXPOWER', UpdatePower)

		self:Hide()
	end
end

local Enable = function(self, unit)
	local altpowerbar = self.AltPowerBar
	if(altpowerbar) then
		altpowerbar.__owner = self
		altpowerbar.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER_BAR_SHOW', Toggler)
		self:RegisterEvent('UNIT_POWER_BAR_HIDE', Toggler)

		altpowerbar:Hide()

		PlayerPowerBarAlt:UnregisterEvent'UNIT_POWER_BAR_SHOW'
		PlayerPowerBarAlt:UnregisterEvent'UNIT_POWER_BAR_HIDE'
		PlayerPowerBarAlt:UnregisterEvent'PLAYER_ENTERING_WORLD'

		return true
	end
end

local Disable = function(self, unit)
	local altpowerbar = self.AltPowerBar
	if(altpowerbar) then
		self:UnregisterEvent('UNIT_POWER_BAR_SHOW', Toggler)
		self:UnregisterEvent('UNIT_POWER_BAR_HIDE', Toggler)

		PlayerPowerBarAlt:RegisterEvent'UNIT_POWER_BAR_SHOW'
		PlayerPowerBarAlt:RegisterEvent'UNIT_POWER_BAR_HIDE'
		PlayerPowerBarAlt:RegisterEvent'PLAYER_ENTERING_WORLD'
	end
end

oUF:AddElement('AltPowerBar', Update, Enable, Disable)
