
local _NAME, _NS = ...
local DDUF, oUF = _NS[_NAME], _NS.oUF

local colors = {}

colors.smooth = {
    255/255, 42/255, 12/255,
    231/255, 48/255, 78/255,
    0.15, 0.15, 0.15,
}

colors.power = setmetatable({
    ['MANA'] = {27/255,147/255,226/255},
    ['RAGE'] = {191/255,48/255,62/255},
    ['FOCUS'] = {246/255,185/255,106/255},
    ['ENERGY'] = {250/255,210/255,117/255},
    ["RUNES"] = {0.55, 0.57, 0.61},
    ["RUNIC_POWER"] = {0/255, 209/255, 255/255},
    ["AMMOSLOT"] = {200/255, 255/255, 200/255},
    ["FUEL"] = {250/255,  75/255,  60/255},
    ["POWER_TYPE_STEAM"] = {0.55, 0.57, 0.61},
    ["POWER_TYPE_PYRITE"] = {0.60, 0.09, 0.17},
}, {__index = oUF.colors.power})

colors.reaction = setmetatable({
    [2] = {217/255, 45/255, 71/255},
    [4] = {109/255, 168/255, 199/255},
    [5] = {146/255, 223/255, 103/255}
}, {__index = oUF.colors.reaction})

colors.rune = {
    [1] = {255/255,75/255,25/255},
    [2] = {175/255,255/255,75/255},
    [3] = {172/255,224/255,255/255},
    [4] = {212/255,167/255,242/255},
}

colors.tapped = {186/255,168/255,149/255}
colors.disconnected = {227/255,206/255,166/255}

DDUF.colors = setmetatable(colors, {__index = oUF.colors})

