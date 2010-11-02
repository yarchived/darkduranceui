--[[
	Speedy
]]

local Speedy = CreateFrame('Frame')
yBar.Speedy = Speedy

local realButtons = {}

local function OnMouseDown(self)
	realButtons[self]:SetButtonState('PUSHED')
end

local function OnMouseUp(self)
	realButtons[self]:SetButtonState('NORMAL')
end

function Speedy:GenerateButton(id)
	local name = format('yBarSpeedyButton%d', id)
	local button = CreateFrame('Button', name, nil, 'SecureActionButtonTemplate,SecureHandlerBaseTemplate')
	button:RegisterForClicks('AnyDown')
	button:SetAttribute('type', 'macro')
	button:SetAttribute('macrotext', '/click ActionButton' .. id)
	
	-- make it looks like real
	realButtons[button] = _G['ActionButton' .. id]
	button:SetScript('OnMouseDown', OnMouseDown)
	button:SetScript('OnMouseUp', OnMouseUp)
	
	return button, name
end

local bindings = {'1','2','3','4','5','6','7','8','9','0','-','='}
function Speedy:Enable()
	for i = 1, #bindings do
		local button, name = self:GenerateButton(i)
		SetOverrideBindingClick(Speedy, true, bindings[i], name)
	end
end


