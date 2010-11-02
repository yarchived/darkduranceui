
if not yBar then return end

local BarFrame = yBar.BarFrame
local VehicleBar = CreateFrame('Frame')
yBar.VehicleBar = VehicleBar
VehicleBar = setmetatable(VehicleBar, {__index = BarFrame})
VehicleBar.mt = {__index = VehicleBar}

local buttons = {'VehicleMenuBarLeaveButton', 'VehicleMenuBarPitchUpButton', 'VehicleMenuBarPitchDownButton'}

local function onEvent(self, event, ...)
	self[event](self, event, ...)
end

function VehicleBar:New()
	local bar = setmetatable(BarFrame:New(), self.mt)

	for i = 1, #buttons do
		local b = _G[buttons[i]]
		b:SetParent(bar)
		bar.buttons[i] = b

		b:Show()
	end

	bar:SetScript('OnEvent', onEvent)
	bar:RegisterEvent('UNIT_ENTERED_VEHICLE')
	--bar:RegisterEvent('UNIT_ENTERING_VEHICLE')

	bar.ButtonSize = 30
	bar:Update()

	bar:Skin()

	local state
	if select(4, GetBuildInfo()) >= 30300 then
		state = '[@vehicle,exists]show;hide'
	else
		state = '[target=vehicle,exists]show;hide'
	end
	bar:SetVisibilityState(state)

	return bar
end

function VehicleBar:UNIT_ENTERED_VEHICLE(event, player)
	if player == 'player' then
		if IsVehicleAimAngleAdjustable() then
			VehicleMenuBarPitchUpButton:Show()
			VehicleMenuBarPitchDownButton:Show()
		else
			VehicleMenuBarPitchUpButton:Hide()
			VehicleMenuBarPitchDownButton:Hide()
		end

		if CanExitVehicle() then
			VehicleMenuBarLeaveButton:Show()
		else
			VehicleMenuBarLeaveButton:Hide()
		end
	end
end

function VehicleBar:Skin()
	-- setup button skins
	VehicleMenuBarPitchUpButton:GetNormalTexture():SetTexture([[Interface\Vehicles\UI-Vehicles-Button-Pitch-Up]])
	VehicleMenuBarPitchUpButton:GetNormalTexture():SetTexCoord(0.21875, 0.765625, 0.234375, 0.78125)
	VehicleMenuBarPitchUpButton:GetPushedTexture():SetTexture([[Interface\Vehicles\UI-Vehicles-Button-Pitch-Down]])
	VehicleMenuBarPitchUpButton:GetPushedTexture():SetTexCoord(0.21875, 0.765625, 0.234375, 0.78125)

	VehicleMenuBarPitchDownButton:GetNormalTexture():SetTexture([[Interface\Vehicles\UI-Vehicles-Button-PitchDown-Up]])
	VehicleMenuBarPitchDownButton:GetNormalTexture():SetTexCoord(0.21875, 0.765625, 0.234375, 0.78125)
	VehicleMenuBarPitchDownButton:GetPushedTexture():SetTexture([[Interface\Vehicles\UI-Vehicles-Button-PitchDown-Down]])
	VehicleMenuBarPitchDownButton:GetPushedTexture():SetTexCoord(0.21875, 0.765625, 0.234375, 0.78125)

	VehicleMenuBarLeaveButton:GetNormalTexture():SetTexture([[Interface\Vehicles\UI-Vehicles-Button-Exit-Up]])
	VehicleMenuBarLeaveButton:GetNormalTexture():SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375)
	VehicleMenuBarLeaveButton:GetPushedTexture():SetTexture([[Interface\Vehicles\UI-Vehicles-Button-Exit-Down]])
	VehicleMenuBarLeaveButton:GetPushedTexture():SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375)
end




