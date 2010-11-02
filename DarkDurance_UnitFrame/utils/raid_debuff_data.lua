local _, ns = ...
local ORD = ns.oUF_RaidDebuffs

if not ORD then return end

--[[
local bc_data = {
	-- Black Temple
	39837, -- High Warlord Naj'entus
	40239, 40251, -- Teron Gorefiend
	40604, 40481, 40508, 42005, -- Gurtogg Bloodboil
	41303, 41303, 41410, 41376, -- EOS
	40860, 41001, -- Mother Shahraz
	41485, 41472, -- The Illidari Council
	41914, 40585, 41032, 40932, -- Illidan Stormrage
	
	-- Sunwell Plateau
	46561, 46562, 46266, 46557, 46560, 46543, 46427, -- trash
	45032, 45018, -- Kalecgos
	46394, 45150, -- Brutallus
	45855, 45662, 45402, 45717, -- Felmyst
	45256, 45333, 46771, 45270, 45347, 45348, -- The Eredar Twins
	45996, -- M'uru
	45442, 45641, 45885, 45737, -- Kil'jaeden
	
	-- Hyjal Summit
	31249, -- Rage Winterchill
	31306, 31298, -- Anetheron
	31347, 31341, 31344, -- Azgalor
	31944, 31972, -- Archimonde
}
]]

local debuff_data = {
	--Vault of Archavon
	67332,
	71993, 72098, 72104,
	
	--Trial of the Crusader
	66331, 67475, 66406, --Gormok the Impaler
	67618, 66869, --Jormungar Behemoth
	67654, 66689, 66683, --Icehowl
	66532, 66237, 66242, 66197, 66283, 66209, 66211, 67906, --Lord Jaraxxus
	65812, 65960, 65801, 65543, 66054, 65809, --Faction Champions
	--[[67176,]] --[[67222,]] 67283, 67298, 67309, --The Twin Val'kyr
	67574, 66013, 67847, 66012, 67863, 68509, --Anub'arak
	
	--The Eye of Eternity
	57407, 56272, --Malygos
	
	--The Obsidian Sanctum
	39647, 58936, --Trash
	60708, 57491, --Sartharion
	
	--Naxxramas
	55314, --Trash
	28786, --Anub'Rekhan
	28796, 28794, --Grand Widow Faerlina
	28622, 54121, --Maexxna
	29213, 29214, 29212, --Noth the Plaguebringer
	29998, 29310, --Heigan the Unclean
	28169, --Grobbulus
	54378, 29306, --Gluth
	28084, 28059, --Thaddius
	55550, --Instructor Razuvious
	28522, 28542, --Sapphiron
	28410, 27819, 27808, --Kel'Thuzad
	
	--Ulduar
	63612, 63615, 63169, --Trash
	64771, --Razorscale
	62548, 62680, 62717, --Ignis the Furnace Master
	63024, 63018, --XT-002 Deconstructor
	61888, 62269, 61903, 61912, --The Iron Council
	64290, 63355, 62055, --Kologarn
	62469, 61969, 62188, --Hodir
	62042, 62130, 62526, 62470, 62331, --Thorim
	62589, 62861, --Freya
	63666, 62997, 64668, --Mimiron
	63276, 63322, --General Vezax
	63134, 63138, 63830, 63802, 63042, 64156, 64153, 64157, 64152, 64125, 63050, --Yogg-Saron
	64412, --Algalon the Observer
	
	--Icecrown Citadel
	70980, 69483, 69969, --The Lower Spire 
	71089, 71127, 71163, 71103, 71157, --The Plagueworks 
	70645, 70671, 70432, 70435, --The Crimson Hall 
	71257, 71252, 71327, 36922, --Frostwing Hall
	70823, 69065, 70835, --Lord Marrowgar
	72109, 71289, 71204, 67934, 71237, 72491, --Lady Deathwhisper
	69651, --Gunship Battle
	72293, 72442, 72449, 72769, --Deathbringer Saurfang
	71224, 71215, 69774, --Rotface
	69279, 71218, 72219, --Festergut
	70341, 72549, 71278, 70215, 70447, 72454, 70405, 72856, 70953, --Proffessor
	72796, 71822, --Blood Princes
	70838, 72265, 71473, 71474, 73070, 71340, 71265, 70923, --Blood-Queen Lana'thel
	70873, 71746, 71741, 71738, 71733, 71283, 71941, --Valithria Dreamwalker
	69762, 70106, 69766, 70126, 70157, 70127, --Sindragosa
	70337, 72149, 70541, 69242, 69409, 72762, 68980, --The Lich King
}

ORD:RegisterDebuffs(debuff_data)
