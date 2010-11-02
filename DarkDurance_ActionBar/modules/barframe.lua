
if not yBar then return end

local BarFrame = CreateFrame('Frame')
yBar.BarFrame = BarFrame

function BarFrame:New(id)
	local f = CreateFrame('Frame', id and format('yBar%d', id), UIParent, 'SecureHandlerStateTemplate') -- no need to bind, cuz it'll be done soon
	f.buttons = {}
	
	return f
end

function BarFrame:Update()
	-- 更新各种设置
	
	self:UpdateButtonPositions()
end

--[[
	[combat]show;[form:1]show;hide
]]
function BarFrame:SetVisibilityState(state)
	UnregisterStateDriver(self, 'visibility')
	self:Show()
	
	if state then
		RegisterStateDriver(self, 'visibility', state)
	end
end

function BarFrame:ClearVisibilityState()
	UnregisterStateDriver(self, 'visibility')
	self:Show()
end

function BarFrame:SetButtonPoint(b, id)
    local gap = (self.Space + self.ButtonSize) * (id-1)
    b:ClearAllPoints()
    if(self.isVerticle) then
        b:SetPoint('TOPLEFT', self, 'TOPLEFT', 0, -gap)
    else
        b:SetPoint('TOPLEFT', self, 'TOPLEFT', gap, 0)
    end

	return b
end

BarFrame.ButtonSize = 36
BarFrame.Space = 5

function BarFrame:UpdateButtonPositions()
	local num = #self.buttons
	for i = 1, num do
		local b = self.buttons[i]
		self:SetButtonPoint(b, i)
	end
	
	--self:SetPoint('BOTTOMLEFT', self.buttons[1])
	--self:SetPoint('TOPRIGHT', self.buttons[num])
    local size = num*self.ButtonSize + (num-1)*BarFrame.Space
    if(self.isVerticle) then
        self:SetWidth(self.ButtonSize)
        self:SetHeight(size)
    else
        self:SetWidth(size)
        self:SetHeight(self.ButtonSize)
    end
end

function BarFrame:SetVertical(vert)
    self.isVerticle = vert
    self:UpdateButtonPositions()
end


