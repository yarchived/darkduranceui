
local _NAME, _NS = ...
local DDUF = _NS[_NAME]

DDUF.media = {}
local media = DDUF.media

media.font = STANDARD_TEXT_FONT

media.backdrop = {
    bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
    insets = { top=-1, left=-1, bottom=-1, right=-1 },
}

local MEDIAPATH = [[Interface\AddOns\]].. _NAME ..[[\media\]]

media.getTexture = function(file, style)
    style = style or 'origin'
    return MEDIAPATH .. ([[%s\%s]]):format(style, file)
end


media.dd = MEDIAPATH..'dd'
media.roth = MEDIAPATH..'roth'
media.aura_overlay = MEDIAPATH..'SmartName'
media.bubbleTex = MEDIAPATH..'bubbleTex'

media.castbar = {
    castbar = 'castbar',
    bg = 'castbar_bg',
}

media.party = {
    party = 'party_party',
    bg = 'party_bg',
    threat_high = 'party_threat_high',
}

media.player = {
    player = 'player_player',
    bg = 'player_bg',
    threat_high = 'player_threat_high',
    threat_low = 'player_threat_low',
}

media.target = {
    target = 'target_target',
    bg = 'player_bg',
    boss = 'target_boss',
    elite = 'target_elite',
    rare = 'target_rare_elite',
}

media.focus = {
    focus = 'focus_focus',
    threat_high = 'focus_threat_high',
    bg = 'focus_bg',
}

media.tot = {
    tot = 'tot_tot',
    bg = 'tot_bg',
    threat_high = 'tot_threat_high',
    totot = 'totot',
}

media.icon = {
    assistant = 'assistant',
    leader = 'leader',
    combat = 'sword',
}

