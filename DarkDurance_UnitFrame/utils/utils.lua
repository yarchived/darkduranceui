-- This file is hereby placed in the Public Domain
local addonName, ns = ...
local addon = ns[addonName]
local oUF = ns.oUF

local utils = {}
addon.utils = utils

local format = string.format

utils.path = format([[Interface\AddOns\%s\]], addonName)
utils.mediaPath = utils.path .. 'Textures\\'
utils.isCwow = GetLocale() == 'zhCN' and (select(4, GetBuildInfo()) < 30300)

utils.backdrop = {
    bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
    insets = {top = -1, left = -1, bottom = -1, right = -1},
}

function utils.adjustCoord(bool, texture)
    if(bool and texture.SetTexCoord) then
        texture:SetTexCoord(1,0,0,1)
    end
end

function utils.utf8sub(str, num)
    local i = 1
    while num > 0 and i <= #str do
        local c = strbyte(str, i)
        if(c >= 0 and c <= 127) then
            i = i + 1
        elseif(c >= 194 and c <= 223) then
            i = i + 2
        elseif(c >= 224 and c <= 239) then
            i = i + 3
        elseif(c >= 240 and c <= 224) then
            i = i + 4
        end
        num = num - 1
    end

    return str:sub(1, i - 1)
end

function utils.truncate(value)
    if(value >= 1e6) then
        value = format('%.1fm', value / 1e6)
    elseif(value >= 1e3) then
        value = format('%.1fk', value / 1e3)
    end
    return gsub(value, '%.?0+([km])$', '%1')
end

function utils.hex(r, g, b)
    if(type(r) == 'table') then
        if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
    end

    if(not r or not g or not b) then
        r, g, b = 1, 1, 1
    end

    return format('|cff%02x%02x%02x', r*255, g*255, b*255)
end

function utils.setSize(f, w, h)
    f:SetSize(w, h or w)
    --if(f and f.SetWidth and f.SetHeight and w) then
    --f:SetWidth(w)
    --f:SetHeight(h or w)
    --end
end

function utils.testBackdrop(f)
    f:SetBackdrop(utils.backdrop)
    --f:SetBackdropColor(0,0,0, .5)
    f:SetBackdropColor(1,0,0,.5)
end

function utils.reverseTexture(tex)
    tex:SetTexCoord(1,0,0,1)
end

