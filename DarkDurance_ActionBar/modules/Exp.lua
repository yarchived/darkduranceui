
assert(yBar)

local Exp = CreateFrame('StatusBar')
yBar.Exp = Exp
local mt = {__index = Exp}

function Exp:New(texture, parent, ...)
    local f = self:Create(parent, ...)


    return f
end

function Exp:Create(parent, ...)
    local bar =  setmetatable(CreateFrame('StatusBar', nil, parent), mt)

    local text = bar:CreateFontString(nil, 'OVERLAY')
    bar.Text = text

end

function Exp:SetTextFont(...)
    return self.text:SetFont(...)
end

function Exp:GetTextFont(...)
    return self.text:GetFont(...)
end

function Exp:SetTextPoint(...)
    return self.text:SetPoint(...)
end


