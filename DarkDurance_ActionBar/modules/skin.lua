local tex_path = [[Interface\AddOns\DarkDurance_ActionBar\media\]]

local texture = {
	['normal'] = tex_path .. 'gloss',
	['flash'] = tex_path .. 'flash',
    ['hover'] = tex_path .. 'hover',
	['pushed'] = tex_path .. 'pushed',
	['checked'] = tex_path .. 'checked',
	['equipped'] = tex_path .. 'gloss_grey',
}

local color = {
	['normal'] = {.37, .3, .3},
	['equipped'] = {0, .5, 1},
}




local saved = setmetatable({}, {__index = function(t,i)
	local name = i:GetName()
	local temp = {}
	temp.name = name
	temp.bu  = _G[name]
	temp.ic  = _G[name..'Icon']
	temp.co  = _G[name..'Count']
	temp.bo  = _G[name..'Border']
	temp.ho  = _G[name..'HotKey']
	temp.cd  = _G[name..'Cooldown']
	temp.na  = _G[name..'Name']
	temp.fl  = _G[name..'Flash']
	temp.nt  = _G[name..'NormalTexture'] or _G[name..'NormalTexture2']
	
	t[i] = temp
	
	return temp
end})


local function buttonStyler(self)
	local s = saved[self]

	s.nt:SetHeight(s.bu:GetHeight())
	s.nt:SetWidth(s.bu:GetWidth())
	s.nt:SetPoint('Center', 0, 0)
	if s.bo then
		s.bo:Hide()
	end

	--[[s.ho:SetFont('Fonts\\FRIZQT__.TTF', 18, 'OUTLINE')
	s.co:SetFont('Fonts\\FRIZQT__.TTF', 18, 'OUTLINE')
	s.na:SetFont('Fonts\\FRIZQT__.TTF', 12, 'OUTLINE')
	s.ho:Hide()
	s.na:Hide()]]
	
	s.ho:SetTextColor(1,1,1)
	
	if s.fl then
		s.fl:SetTexture(texture.flash)
	end
	s.bu:SetHighlightTexture(texture.hover)
	s.bu:SetPushedTexture(texture.pushed)
	s.bu:SetCheckedTexture(texture.checked)
	s.bu:SetNormalTexture(texture.normal)
    do
        local t = s.bu:GetNormalTexture()
        if(t and t.SetPoint) then
            t:ClearAllPoints()
            t:SetPoint('TOPLEFT', s.bu, 2, -2)
            t:SetPoint('BOTTOMRIGHT', s.bu, -2, 2)
        end
    end

	s.ic:SetTexCoord(0.1,0.9,0.1,0.9)
	s.ic:SetPoint('TOPLEFT', s.bu, 'TOPLEFT', 2, -2)
	s.ic:SetPoint('BOTTOMRIGHT', s.bu, 'BOTTOMRIGHT', -2, 2)

	if self.action and IsEquippedAction(self.action) then
		s.bu:SetNormalTexture(texture.equipped)
		s.nt:SetVertexColor(color.equipped[1], color.equipped[2], color.equipped[3], 1)
	else
		s.bu:SetNormalTexture(texture.normal)
		s.nt:SetVertexColor(color.normal[1], color.normal[2], color.normal[3],1)
	end  
end


local function petBarStyler()
	for i=1, NUM_PET_ACTION_SLOTS do
		local name = 'PetActionButton'..i
		buttonStyler(_G[name])
	end  
end

local function shapeShiftStyler()
	for i=1, NUM_SHAPESHIFT_SLOTS do
		local b = _G['ShapeshiftButton'..i]
		if b then
			shapeshift(b)
		end
	end
end

--[[
	Skin
]]
local Skin = {}
yBar.Skin = Skin

function Skin:Enable()
	hooksecurefunc('ActionButton_Update', buttonStyler)
	
	hooksecurefunc(yBar.StanceButton, 'Update', buttonStyler)
	
	hooksecurefunc('PetActionBar_Update', petBarStyler)
	
end


--[[

hooksecurefunc('ActionButton_Update',   buttonStyler)

hooksecurefunc('ActionButton_ShowGrid', FixGrid)

hooksecurefunc('ShapeshiftBar_OnLoad',   shapeShiftStyler)
hooksecurefunc('ShapeshiftBar_Update',   shapeShiftStyler)
hooksecurefunc('ShapeshiftBar_UpdateState',   shapeShiftStyler)

hooksecurefunc('PetActionBar_Update',   petBarStyler)

]]
