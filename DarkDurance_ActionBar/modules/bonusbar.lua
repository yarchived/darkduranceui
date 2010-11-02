
if not yBar then return end

local BonusButton = CreateFrame'CheckButton'
yBar.BonusButton = BonusButton
BonusButton.mt = {__index = BonusButton}

BonusButton.index = 0
function BonusButton:New()

    local button = self:Create()
	button:SetAttribute('showgrid', 1)
	button:SetAttribute('type', 'action')
    button:SetAttribute('action', self.index + 107)

    button:SetButtonSize(32)

    return button
end

function BonusButton:Create()
    self.index = self.index + 1

	local button = setmetatable(CreateFrame('CheckButton', 'yBarBonusButton' .. self.index, nil, 'ActionBarButtonTemplate'), self.mt)
	return button

end

function BonusButton:SetButtonSize(size)
    self:SetWidth(size)
    self:SetHeight(size)
    self.__size = size
end

function BonusButton:GetButtonSize()
    return self.__size
end

function BonusButton:SetGrid(show)
    if(show) then
        self:SetAttribute('showgrid', 1)
    else
        self:SetAttribute('showgrid', 0)
    end
end

function BonusButton:GetGrid()
    return self:GetAttribute'showgrid'
end

