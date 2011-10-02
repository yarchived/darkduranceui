
local _NAME, _NS = ...
local DDUF = _NS[_NAME]

DDUF.media = {}
local media = DDUF.media

media.basepath = 'Interface\\AddOns\\'.._NAME..'\\media\\%s\\%s'

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
    rare_elite = 'target_rare_elite',
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


