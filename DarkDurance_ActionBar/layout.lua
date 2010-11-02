--{{{ Config
local BARS = {
    ['main'] = true,
    ['bar2'] = true,
    ['bar3'] = true,
    ['right1'] = true,
    ['right2'] = true,
}
local SCALE = .7
--}}}


if not yBar then return end

yBar:DisableBlizzard()
yBar.Skin:Enable()
yBar.Speedy:Enable()




local _, class = UnitClass'player'
local TEXPATH = [[Interface\AddOns\DarkDurance_ActionBar\texture\]]
local bar1_states = setmetatable({
    ['DRUID'] = '[bonusbar:1]7;[bonusbar:3]9;[bonusbar:5]11;0', -- cat:7, bear:9, vehicle:11, normal
}, {__index = function(t, i)
    -- default value
    return '[bonusbar:5]11,0'
end})

local function hide(frame)
    frame:SetVisibilityState('hide')
end



local bar1 = yBar:Spawn('ActionBar', 1)
bar1:SetPoint('BOTTOM', UIParent, 0, 50)
bar1:SetScale(SCALE * 1)
do
    local state = bar1_states[class]
    if(state) then
        bar1:SetPageState(state)
    end
end

bar1.texture = bar1:CreateTexture(nil, 'BACKGROUND')
do
    local tex = bar1.texture

    tex:SetTexture(TEXPATH .. 'MainBar')
    tex:SetPoint('CENTER', bar1)
    tex:SetWidth(1200)
    tex:SetHeight(145)
end



local bar2 = yBar:Spawn('ActionBar', 6)
bar2:SetScale(SCALE * 1.3)
bar2:SetPoint('BOTTOM', bar1, 'TOP', 0, 20)
bar2.texture = bar2:CreateTexture(nil, 'BACKGROUND')
do
    local tex = bar2.texture
    tex:SetPoint('CENTER', bar2, 0, -2)

    tex:SetTexture(TEXPATH .. 'BottomLeftBar')
    tex:SetWidth(935)
    tex:SetHeight(120)
end



local bar3 = yBar:Spawn('ActionBar', 5)
bar3:SetScale(SCALE * 1.3)
bar3:SetPoint('BOTTOM', bar2, 'TOP', 0, 8)
bar3.texture = bar3:CreateTexture(nil, 'BACKGROUND')
do
    local tex = bar3.texture
    tex:SetPoint('CENTER', bar3)

    tex:SetTexture(TEXPATH .. 'BottomRightBar')
    tex:SetWidth(930)
    tex:SetHeight(60)
end

local pet = yBar:Spawn('PetBar')
pet:SetScale(SCALE * 1.2)
pet:SetPoint('BOTTOM', bar3, 'TOP', 0, 10)
pet.texture = pet:CreateTexture(nil, 'BACKGROUND')
do
    local tex = pet.texture
    tex:SetPoint('CENTER', pet, -3, -1)

    tex:SetTexture(TEXPATH .. 'BottomRightBar')
    tex:SetTexCoord(.23, .6755, 0, 1)
    tex:SetWidth(354)
    tex:SetHeight(50)
end


local vehicle = yBar:Spawn('VehicleBar')
vehicle:SetScale(SCALE)
vehicle:SetPoint('BOTTOMLEFT', bar3, 'TOPLEFT', 0, 5)

local stance = yBar:Spawn('StanceBar')
stance:SetScale(SCALE * 1)
stance:SetPoint('BOTTOM', bar3, 'TOP', 0, 55)

local bonusButtons = {}
for i = 1, 4 do
    local btn = yBar:Spawn('BonusButton')
    tinsert(bonusButtons, btn)

    if(i == 1) then
        btn:SetParent(bar2)
        btn:SetScale(SCALE *2.3)
        btn:SetPoint('RIGHT', bar2, 'LEFT', -13, -1)
    elseif(i == 2) then
        btn:SetParent(bar2)
        btn:SetScale(SCALE *2.3)
        btn:SetPoint('LEFT', bar2, 'RIGHT', 13, -1)
    elseif(i == 3) then
        btn:SetParent(bar1)
        btn:SetScale(SCALE *3)
        btn:SetPoint('RIGHT', bar1, 'LEFT', -5, 0)
    elseif(i == 4) then
        btn:SetParent(bar1)
        btn:SetScale(SCALE *3)
        btn:SetPoint('LEFT', bar1, 'RIGHT', 5, 0)
    end
end


do
    local right1 = yBar:Spawn('ActionBar', 3)
    local right2 = yBar:Spawn('ActionBar', 4)

    for _, bar in pairs{right1, right2} do
        bar:SetScale(SCALE *1)
        bar:SetVertical(true)
    end

    right1:SetPoint('BOTTOMRIGHT', UIParent, -3, 200)
    right2:SetPoint('RIGHT', right1, 'LEFT', -3, 0)

    if(not BARS['right1']) then
        hide(righ1)
    end
    if(not BARS['right2']) then
        hide(right2)
    end
end

if(not BARS['main']) then
    hide(bar1)
end
if(not BARS['bar2']) then
    hide(bar2)
end
if(not BARS['bar3']) then
    hide(bar3)
end



--[[

stance.ButtonStyle = yBarStanceButtonStyler
--]]

-- black background for testing


--[[
条件

bonusbar:5 心灵控制

bonusbar:1 猫
bonusbar:2 树
bonusbar:3 熊
bonusbar:4 鹌鹑

bonusbar:1 战斗
bonusbar:2 防御
bonusbar:3 狂暴

bonusbar:1 潜行
bonusbar:2 影舞

bonusbar:1 暗影

form:2 术士变身 
]]
