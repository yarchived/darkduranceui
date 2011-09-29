
local MAJOR, MINOR = 'SuckLessStatusBar-1.0', 1
local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if(not lib) then return end


--lib.pool = lib.pool or {}
lib.prototype = lib.prototype or CreateFrame'Frame'
lib.mt = lib.mt or {__index = lib.prototype}
local statusbar = lib.prototype

lib.SetWidth = lib.SetWidth or statusbar.SetWidth
lib.SetHeight = lib.SetHeight or statusbar.SetHeight
lib.GetWidth = lib.GetWidth or statusbar.GetWidth
lib.GetHeight = lib.GetHeight or statusbar.GetHeight

function lib:NewStatusBar(...)
    return statusbar:New(...)
end

function statusbar:New(frameName, parent)
    local bar = setmetatable(CreateFrame('Frame', frameName, parent), lib.mt)

    -- initiate values
    bar.minvalue = 0
    bar.maxvalue = 0
    bar.value = 0
    bar.height = 0
    bar.width = 0

    bar.bartexture = bar:CreateTexture(nil, 'ARTWORK')
    bar.bartexture:SetTexture[[Interface\TargetingFrame\UI-StatusBar]]
    --bar.bartexture:SetBlendMode('BLEND')
    --bar.bartexture:SetTexture(texture_path)
    --bar.bartexture:Show()

    bar:SetOrientation('HORIZONTAL')

    return bar
end

--[[
    HORIZONTAL
    VERTICAL
]]
function statusbar:SetOrientation(orientation)
    if(orientation) then
        if(orientation == 'VERTICAL') then
            self.bartexture:ClearAllPoints()
            self.bartexture:SetPoint('BOTTOMLEFT', self)
            self.bartexture:SetPoint('BOTTOMRIGHT', self)
        elseif(orientation == 'HORIZONTAL') then
            self.bartexture:ClearAllPoints()
            self.bartexture:SetPoint('TOPLEFT', self)
            self.bartexture:SetPoint('BOTTOMLEFT', self)
        else
            return
        end
        self.orientation = orientation
        self:UpdateStatusBar()
    end
end

function statusbar:GetOrientation()
    return self.orientation
end

function statusbar:SetReverse(rev)
    self.reverse = not not rev
end

function statusbar:GetReverse()
    return self.reverse
end

function statusbar:SetMinMaxValues(min, max)
    self.minvalue = min
    self.maxvalue = max
    self:UpdateStatusBar()
end

function statusbar:GetValue()
    return self.value
end

function statusbar:GetMinMaxValues()
    return self.minvalue, self.maxvalue
end

function statusbar:SetValue(v)
    self.value = v
    self:UpdateStatusBar()
end

function statusbar:UpdateStatusBar()
    local pct = self.maxvalue == 0 and 0 or (self.value/self.maxvalue)
    pct = math.max(0, math.min(1, pct))

    --print(self.maxvalue, self.minvalue, self.value, pct)
    if(self:GetOrientation() == 'VERTICAL') then
        self.bartexture:SetTexCoord(self.reverse and 1 or 0, self.reverse and 0 or 1, 1-pct, 1)
        self.bartexture:SetHeight(pct == 0 and 1 or (self.height *pct))
    else
        self.bartexture:SetTexCoord(self.reverse and 1 or 0, self.reverse and (1-pct) or pct, 0, 1)
        self.bartexture:SetWidth(pct == 0 and 1 or (self.width *pct))
    end
end

function statusbar:SetHeight(height)
    if(height) then
        lib.SetHeight(self, height)
    end
    self.height = lib.GetHeight(self)
    self:UpdateStatusBar()
end

function statusbar:SetWidth(width)
    if(width) then
        lib.SetWidth(self, width)
    end
    self.width = lib.GetWidth(self)
end

function statusbar:SetStatusBarTexture(path)
    self.bartexture:SetTexture(path)
end

function statusbar:GetStatusBarTexture()
    return self.bartexture:GetTexture()
end

function statusbar:SetStatusBarColor(r,g,b,a)
    self.bartexture:SetVertexColor(r,g,b,a)
end

function statusbar:GetStatusBarColor()
    return self.bartexture:GetVertexColor()
end

if(oldminor) then
    -- TODO
end
