local creditSources = {}
local RV = { descriptions = { Joker = {} }, misc = { dictionary = {}, v_text = {} } }
local replaceIntents = {
	stone = G.localization.descriptions.Enhanced.m_stone.name,
	bones = CirnoMod.miscItems.getJokerNameByKey('j_mr_bones'),
	splash = CirnoMod.miscItems.getJokerNameByKey('j_splash')
}

if CirnoMod.replaceDef.locChanges.enhancerLoc.m_stone then
	replaceIntents.stone = CirnoMod.replaceDef.locChanges.enhancerLoc.m_stone.name
end
	
--#region What will go in the top of an art credit tooltip.
creditSources.cr_JokerArt = "Joker Art By"
creditSources.cr_DeckArt = "Deck Art By"
creditSources.cr_EnhancerArt = "Enhancer Art By"
creditSources.cr_CardArt = "Card Art By"
creditSources.cr_BoosterArt = "Booster Art By"
creditSources.cr_GenericArt = "Art By"
--#endregion

--#region Individuals to be credited
-- Boo this individual please.
creditSources.NTF = "{s:0.8,X:cirNope,C:white,E:2}NopeTooFast{s:0.8}"

-- Edit however you want, idk how you want it
creditSources.DTsun = "DaemonTsun"

--[[
Have to do underscores here because X doesn't work with spaces.
As a result, we end up with this nonsense.]]
creditSources.CommunityContrib = "{s:0.6,X:inactive,C:white}(Cirno_TV{s:0.6,X:inactive,C:cirBgInactive}_{s:0.6,X:inactive,C:white}Community-Contributed{s:0.6,X:inactive,C:cirBgInactive}_{s:0.6,X:inactive,C:white}Idea)"
creditSources.masthir = "Masthir"
creditSources.sanglune = "Sanglune"

-- The funny increases exponentially.
creditSources.CirnoTV = "{s:0.8,X:cirCyan,C:white}Cirno_TV{s:0.8}"
creditSources.CirnoTV_smol = "{s:0.6,X:cirCyan,C:white}Cirno_TV"

creditSources.solga = "Solgalestia"
creditSources.solgryn = "Solgryn"
creditSources.radicalHighway = "RadicalHighway"
creditSources.zoeyism = "Zoeyism"
creditSources.turpix = "Turpix"
creditSources.muddle = "Muddleee"
creditSources.hatotoou = "Hatotoou"
creditSources.notovia = "Notovia"
creditSources.thunk = "LocalThunk"
creditSources.unknown = "{s:0.8,X:black,C:white}Unknown{s:0.8}"
--#endregion


--[[
So because of the way this bullshit works, we have to do one of these... For every unique credit case. Yes.
I'm mad. We could have done a lot more progammatically, but instead every time we run into a unique
circumstance, we have to add it here. Have fun sifting through this shit because apparently this
is the way we have to do it.]]
RV.descriptions.Other = {
	--[[
	We need this bullshit because of how this dumb fucking system works -
	Or at least, how I thought it did because now it's no longer consistent
	The contempt I feel for this setup is beyond human comprehension.
	Why are things this way? Why must LocalThunk torment us so? In this
	essay I will]]
	Joker_Art_By = { text = { creditSources.cr_JokerArt } },
	Deck_Art_By = { text = { creditSources.cr_DeckArt } },
	Enhancer_Art_By = { text = { creditSources.cr_EnhancerArt } },
	Card_Art_By = { text = { creditSources.cr_CardArt } },
	Booster_Art_By = { text = { creditSources.cr_BoosterArt } },
	Generic_Art_By = { text = { creditSources.cr_GenericArt } },
	
	----- Me -----
	jA_NTF = {
		name = creditSources.cr_JokerArt,
		text = { creditSources.NTF }
	},
	gA_NTF = {
		name = creditSources.cr_GenericArt,
		text = { creditSources.NTF }
	},
	eA_NTF = {
		name = creditSources.cr_EnhancerArt,
		text = { creditSources.NTF }
	},
	jA_LocalThunk_NTFEdit = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.thunk..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	cA_LocalThunk_NTFEdit = {
		name = creditSources.cr_CardArt,
		text = {
			"{s:0.8}"..creditSources.thunk..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	eA_LocalThunk_NTFEdit = {
		name = creditSources.cr_EnhancerArt,
		text = {
			"{s:0.8}"..creditSources.thunk..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_Unknown_NTFEdit = {
		name = creditSources.cr_JokerArt,
		text = {
			creditSources.unknown..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	gA_BlackHole = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.thunk.." & "..creditSources.unknown..",",
			"{s:0.8}edited by "..creditSources.NTF,
			creditSources.CommunityContrib
		}
	},
	
	----- You -----
	jA_DaemonTsun = {
		name = creditSources.cr_JokerArt,
		text = {"{s:0.8}"..creditSources.DTsun}
	},
	jA_DaemonTsun_ComCon = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun,
			creditSources.CommunityContrib
		}
	},
	dA_DaemonTsun = {
		name = creditSources.cr_DeckArt,
		text = {"{s:0.8}"..creditSources.DTsun}
	},
	eA_DaemonTsun = {
		name = creditSources.cr_EnhancerArt,
		text = {"{s:0.8}"..creditSources.DTsun}
	},
	gA_DaemonTsun = {
		name = creditSources.cr_GenericArt,
		text = {"{s:0.8}"..creditSources.DTsun}
	},
	cA_DaemonTsun = {
		name = creditSources.cr_CardArt,
		text = {"{s:0.8}"..creditSources.DTsun}
	},
	cA_DaemonTsun_ComCon = {
		name = creditSources.cr_CardArt,
		text = {
			"{s:0.8}"..creditSources.DTsun,
			creditSources.CommunityContrib
		}
	},
	gA_DaemonTsun_ComCon = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun,
			creditSources.CommunityContrib
		}
	},
	jA_DaemonTsun_NTF_Both = {
		name = creditSources.cr_JokerArt,
		text = {"{s:0.8}"..creditSources.DTsun.." &", creditSources.NTF}
	},
	bA_DaemonTsun_NTF_Both = {
		name = creditSources.cr_BoosterArt,
		text = {"{s:0.8}"..creditSources.DTsun.." &", creditSources.NTF}
	},
	gA_DaemonTsun_NTF_Both = {
		name = creditSources.cr_GenericArt,
		text = {"{s:0.8}"..creditSources.DTsun.." &", creditSources.NTF}
	},
	gA_DaemonTsun_NTF_Both_ComCon = { name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." &",
			creditSources.NTF,
			creditSources.CommunityContrib
		}
	},
	jA_DaemonTsun_NTFEdit = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	bA_DaemonTsun_NTFEdit = { name = creditSources.cr_BoosterArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	gA_DaemonTsun_NTFEdit = { name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_DaemonTsun_BigNTFEdit = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", heavily",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	bA_DaemonTsun_BigNTFEdit = { name = creditSources.cr_BoosterArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", heavily",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	gA_DaemonTsun_BigNTFEdit = { name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", heavily",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	gA_DaemonTsun_BigNTFEdit_ComCon = { name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", heavily",
			"{s:0.8}edited by "..creditSources.NTF,
			creditSources.CommunityContrib
		}
	},
	jA_LocalThunk_DaemonTsunEdit = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.thunk.." art."
		}
	},
	jA_LocalThunk_DaemonTsunEdit_ComCon = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.thunk.." art.",
			creditSources.CommunityContrib
		}
	},
	gA_LocalThunk_DaemonTsunEdit = { name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.thunk.." art."
		}
	},
	
	----- Wait, what -----
	jA_Misprint = { name = creditSources.cr_JokerArt,
		text = {
			creditSources.CirnoTV.." & "..creditSources.thunk..",", -- Yes, Cirno drew cirBairy. Formally crediting him is funnier, trust me
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	jA_JustIRLCirno = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}...I don't know what to",
			"{s:0.8}say, it's literally just",
			"{s:0.8}a picture of "..creditSources.CirnoTV.."."
		}
	},
	jA_Egg = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}...I don't know what to",
			"{s:0.8}say, it's literally just",
			"{s:0.8}a picture of "..creditSources.CirnoTV..".",
			"{s:0.8,E:1}DEFINITELY{s:0.8} real, not an",
			"{s:0.8}edit of any kind."
		}
	},
	jA_Hack = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.6}...I don't know what to",
			"{s:0.6}say, it's literally just",
			"{s:0.6}a screenshot of the",
			creditSources.CirnoTV_smol.."{s:0.6} stream."
		}
	},
	jA_Baseball = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}Literally how do I ",
			"{s:0.8}credit this, it's a",
			"{s:0.8}still from Seinfeld."
		}
	},
	
	----- Other -----
	jA_Acrobat = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.masthir.." art.",
			creditSources.CommunityContrib
		}
	},
	jA_Ancient = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.zoeyism.." art."
		}
	},
	jA_ciwnoEdit = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}Image of "..creditSources.CirnoTV..",",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	jA_Burglar = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.sanglune.." art."
		}
	},
	jA_DuoDagger = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.thunk.." & "..creditSources.DTsun..",",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	jA_Family = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}id software, edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_MikuTheClown = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.solga..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_BocchiTheRock = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.turpix..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_ObsvDuty = { name = creditSources.cr_JokerArt,
		text = { 
			"{s:0.8}"..creditSources.notovia..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_RedCard = { name = creditSources.cr_JokerArt,
		text = { 
			"{s:0.8}mystman12, edited",
			"{s:0.8}by "..creditSources.DTsun
		}
	},
	jA_CrysTap = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.6,X:mult,C:white}Uhh...{}, heavily edited",
			"by "..creditSources.NTF,
			"{s:0.7,C:inactive}'-'; ...Listen. It's fine.",
			"{s:0.7,C:inactive}Someone whose uncle works",
			"{s:0.7,C:inactive}there told me that this",
			"{s:0.7,C:inactive}is {s:0.7,E:1,C:inactive}DEFINITELY{s:0.7,C:inactive} okay.",
			"{s:0.45,C:inactive}Definitely."
		}
	},
	jA_b3313 = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8,X:mult,C:white}'-';;"
		}
	},
	jA_b3313_uncanny = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8,X:mult,C:white}'-';;",
			'{s:0.8,C:inactive}+ edit of '..creditSources.DTsun..' art'
		}
	},
	jA_solgryn = { name = creditSources.cr_JokerArt,
		text = { "{s:0.8}"..creditSources.solgryn }
	},
	gA_solgryn = { name = creditSources.cr_GenericArt,
		text = { "{s:0.8}"..creditSources.solgryn }
	},
	gA_neptunia = { name = creditSources.cr_GenericArt,
		text = { "{s:0.8}Idea Factory" }
	},
	cA_Sun = { name = creditSources.cr_CardArt,
		text = {
			"{s:0.8}"..creditSources.muddle..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	cA_Devil = { name = creditSources.cr_CardArt,
		text = {
			"{s:0.8}This is just an",
			"{s:0.8}edit of Todd Howard.",
			"{s:0.8}And you should buy all",
			"{s:0.8}the Elder Scrolls games.",
		}
	},
	cA_RHEdit = { name = creditSources.cr_CardArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.radicalHighway.." art."
		}
	},
	cA_RHEdit_ComCon = { name = creditSources.cr_CardArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.radicalHighway.." art.",
			creditSources.CommunityContrib
		}
	},
	bA_genPack_ZUN = { name = creditSources.cr_BoosterArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", ZUN",
			"{s:0.8}& "..creditSources.NTF
		}
	},
	bA_genPack_Daiyousei = { name = creditSources.cr_BoosterArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", ...Harada?",
			"{s:0.8}& "..creditSources.NTF
		}
	},
	bA_genPack_Renko = { name = creditSources.cr_BoosterArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", {s:0.8,X:mult,C:white}Alberta,",
			"{s:0.8,X:mult,C:white}Canada{s:0.8}, & "..creditSources.NTF
		}
	},
	bA_RH_DaemonTsunEdit = { name = creditSources.cr_BoosterArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.radicalHighway.." art,",
			"{s:0.8}heavily edited by ",
			"{s:0.8}"..creditSources.NTF
		}
	},
	gA_Wraith = { name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.hatotoou..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_luchador = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}Mojang art."
		}
	},
	jA_smeared = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}...Now I'm no expert, but",
			"{s:0.8}I'm fairly certain this is a",
			"{s:0.8}still from {s:0.8,E:2}Bocchi The Rock{s:0.8}.",
			"{s:0.8}I'll have to consult on it."
		}
	},
	jA_fourFingers = { name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit",
			"{s:0.8}of Loss.jpg."
		}
	},
	jA_Unknown = { name = creditSources.cr_JokerArt,
		text = {creditSources.unknown}
	},
	eA_Unknown = { name = creditSources.cr_EnhancerArt,
		text = {creditSources.unknown}
	},
	jA_Unknown_LocalThunkEdit = { name = creditSources.cr_JokerArt,
		text = {
			creditSources.unknown.."{s:0.8} edit",
			"{s:0.8}of "..creditSources.thunk.." art."
		}
	},
	
	-- Non-Art Credit Things --
	jkrRedSeal = { name = 'Red Seal',
		text = {
			"Retrigger this",
			"Joker {C:attention}1{} time"
		}
	},
	foilScale = { name = 'Foil Scaling',
		text = {
			'{C:chips}+#1#{} Chips',
			'->',
			'{C:chips}+#2#{} Chips'
		}
	},
	holoScale = { name = 'Holographic Scaling',
		text = {
			'{C:mult}+#1#{} Mult',
			'->',
			'{C:mult}+#2#{} Mult'
		}
	},
	polyScale = { name = 'Polychrome Scaling',
		text = {
			'{X:mult,C:white}X#1#{} Mult',
			'->',
			'{X:mult,C:white}X#2#{} Mult'
		}
	},
	testHeader = { text = { "Test Header" } },
	testTooltip = { name = 'testHeader',
		text = {
			"This is a test tooltip.",
			"It should appear beside",
			"the item it is assigned to."
		}
	},
	testTooltipA = { name = 'Test Tooltip',
		text = {
			"This is a test tooltip.",
			"It should appear beside",
			"the item it is assigned to."
		}
	},
	boxesTestTTip = { name = 'Boxes Test Tooltip',
		text = {
			'{X:black}testing{} {X:black}black{}',
			'{X:mult,C:mult}testing{} {X:mult,C:mult}mult{}',
			'{X:chips,C:chips}testing{} {X:chips,C:chips}chips{}',
			'{X:attention,C:attention}testing{} {X:attention,C:attention}filter{}',
			'{X:green,C:green}testing{} {X:green,C:green}green{}',
			'{X:tarot,C:tarot}testing{} {X:tarot,C:tarot}tarot{}'
		}
	},
	errorTooltip = { name = 'ERROR', text = { '{C:red}Error fetching item.' } },
	questionMarkTooltip = { name = '?????', text = { '?????' } },
	blankHeader = { text = { '' } },
	blankTooltip = { name = 'blankHeader', text = { '' } },
	blankTooltipA = { name = '', text = { '' } }
}

RV.descriptions.Edition = {}

if CirnoMod.config.negativePCardsBalancing then
	RV.descriptions.Edition.e_negative_playing_card = { name = "Negative",
		text = {
			'{C:dark_edition}+#1#{} hand size',
			'Scores {C:dark_edition}regardless',
			'{C:dark_edition}of hand',
			'{s:0.8,C:inactive}(ala '..replaceIntents.splash..'/'..string.sub(replaceIntents.stone, 1, #replaceIntents.stone - 5)..')'
		}
	}
end

RV.descriptions.Joker.j_dna_negativePCardRebalancing = { name = "DNA",
	text = {
        "If {C:attention}first hand{} of round",
        "has only {C:attention}1{} card, add a",
        "permanent copy to deck",
        "and draw it to {C:attention}hand",
		"{C:inactive,s:0.9}(Removes {C:dark_edition,s:0.9}Negative{C:inactive,s:0.9} from copy)"
	}
}

RV.descriptions.Joker.cir_j_dna_negativePCardRebalancing = {
	text = {
        "If {C:attention}first hand{} of round",
        "has only {C:attention}1{} card, add a",
        "permanent copy to deck",
        "and draw it to {C:attention}hand",
		"{C:inactive,s:0.9}(Removes {C:dark_edition,s:0.9}Negative{C:inactive,s:0.9} from copy)",
		"{s:0.8,C:inactive}At Twitch Inc, we strive to foster",
		"{s:0.8,C:inactive}a healthy & safe community. Click",
		"{s:0.8,C:blue}here {s:0.8,C:inactive}to learn more about our policy",
		"{s:0.8,C:inactive}on VTuber hips and why you need to",
		"{s:0.8,C:inactive}be protected from them."
    }
}

if CirnoMod.config['matureReferences_cyc'] >= 2 then
	RV.descriptions.Joker.j_dna_negativePCardRebalancing.name = "\"DNA\""
else
	RV.descriptions.Joker.j_dna_negativePCardRebalancing.name = "DNA"
end



--[[ For facilitating some
custom Joker text; The pipeline
here is that for Jokers where the
name needs to change, we return
a key variable in loc_vars that
corresponds with an entry here.]]
RV.descriptions.Joker.cir_b3313_base = { name = 'B3313', text = {
		"This {C:joker}Joker{} is exclusive to the {C:attention}show{}.",
		"It's connected to a variety of {C:attention}worlds{},",
		"so play some {C:blue}hands{} and get adventuring."
	}
}

-- B3313 High Card Form
RV.descriptions.Joker.cir_b3313_betaLob = { name = 'Beta Lobby', text = { {
			'If scored card is a {C:attention}3{} or {C:attention}Ace',
			'and has no {C:attention}enhancement{},',
			'it gains a random enhancement.'
		}, {
			'{X:mult,C:white}X3.313{} mult if full hand reads',
			'{C:attention}3{}, {C:attention}3{}, {C:attention}Ace{}, {C:attention}3',
			'{s:0.8}(Excluding {s:0.8,C:red}debuffed{s:0.8} cards)',
			'{s:0.8,C:inactive}To be fair, the thing with the doors',
			'{s:0.8,C:inactive}does seem pretty random at first.',
			'{s:0.8,C:inactive}I never noticed it was based on the',
			'{s:0.8,C:inactive}doors until Houdini mentioned it.'
		} }
}

-- B3313 Pair Form
RV.descriptions.Joker.cir_b3313_plexalLob = { name = 'Plexal Lobby', text = { {
		'If played hand is a {C:attention}Pair{} or {C:attention}High Card{},',
		'{C:chips}+#1#{} Chips',
		'Otherwise, if played hand contains a {C:attention}Two Pair{},',
		'{C:mult}+#2#{} Mult'
		}, {
		'If played hand contains a',
		'{C:attention}Three of a Kind{} or {C:attention}Straight{},',
		'{C:mult}+#3#{} Mult'
		}, {
		'If played hand contains a {C:attention}Flush{},',
		'{X:mult,C:white}X#4#{} Mult'
		}, {
		'If played hand contains a {C:attention}Full House{},',
		'{X:mult,C:white}X#5#{} Mult'
		}, {
		'If played hand contains a',
		'{C:attention}Four of a Kind{} or {C:attention}Straight Flush{},',
		'{X:mult,C:white}X#6#{} Mult'
		}, {
		'{s:0.8,C:inactive}...So from here, you go... You get to...',
		'{s:0.8,C:inactive}...',
		'{s:0.8,C:inactive}Uh... Chat, I\'m lost.'
	} }
}

-- B3313 Two Pair Form
RV.descriptions.Joker.cir_b3313_toadLob = { name = 'Toad\'s Lobby', text = {
		'Earn {C:money}#1#{} every time a {C:joker}Joker{} triggers',
		'{s:0.8}(Excluding this {s:0.8,C:joker}Joker{s:0.8})',
		'{s:0.8,C:inactive}Please enquire with Cirno about his',
		'{s:0.8,C:inactive}Toad impression. It\'s exemplary.'
	}
}

-- B3313 Three of a Kind Form
RV.descriptions.Joker.cir_b3313_vanLob = { name = 'Vanilla Lobby', text = { {
		'After the first played hand:',
		}, {
		'When a hand is played, scales the',
		'current {C:attention}edition{} on this {C:joker}Joker{}','{s:0.8}({s:0.8,C:dark_edition}Foil{s:0.8}/{s:0.8,C:dark_edition}Holographic{s:0.8}/{s:0.8,C:dark_edition}Polychrome{s:0.8} only)'
		}, {
		'Every {C:attention}played card{} that would',
		'normally score, {C:red}doesn\'t{},',
		'and vice versa',
		'{s:0.8,C:inactive}>Jump into pipe',
		'{s:0.8,C:inactive}>Die',
		'{s:0.8,C:inactive}Mood.'
	} }
}

-- B3313 Straight Form
RV.descriptions.Joker.cir_b3313_uncanny = { name = 'Uncanny Basement', text = { {
		'{X:mult,C:white}XMult{} equal to the {C:attention}lowest{} ranked',
		'card in scored hand',
		'{s:0.8}(King/Queen/Jack are considered 10)'
		}, {
		'All {C:attention}played numbered cards{}',
		'have their ranks randomised',
		'{s:0.8}(They cannot become face cards)',
		'{s:0.8,C:inactive}HOW DO I GET TO WHERE I WANT TO GO?!'
	} }
}

-- B3313 Flush Form
RV.descriptions.Joker.cir_b3313_4thFloor = { name = '4th Floor', text = {
		'If played hand contains an',
		'{C:attention}odd{} number of cards (5, 3, 1),',
		'All cards {C:attention}left{} of the {C:attention}middle card',
		'have their ranks {C:attention}increased{} by {C:attention}#1#',
		'All cards {C:attention}right{} of the {C:attention}middle card',
		'have their ranks {C:attention}decreased{} by {C:attention}#1#',
		'The {C:attention}middle{} card, if not {C:red}destroyed{},',
		'is {C:attention}returned to hand',
		'{s:0.8,C:inactive}This will be where we part ways.',
		'{s:0.8,C:inactive}But will you go via the pipe, the pipe,',
		'{s:0.8,C:inactive}the door, the door, the door, the door,',
		'{s:0.8,C:inactive}the door, or the door?'
	}
}

-- B3313 Full House Form
RV.descriptions.Joker.cir_b3313_crescent = { name = 'Crescent Castle', text = {
		'Earn {C:money}#1#{} at the end of round per',
		'{C:attention}face card{} played this round',
		'{C:inactive}(Currently {C:money}#2#{C:inactive})',
		'{s:0.8,C:inactive}Our house, in the',
		'{s:0.8,C:inactive}middle of our street.'
	}
}

-- B3313 Four of a Kind Form
RV.descriptions.Joker.cir_b3313_forestMaze = { name = 'Forest Maze', text = { {
			'The first {C:attention}scored{} card gives',
			'{X:chips,C:white}XChips{} equal to {C:attention}1/4',
			'the {C:attention}total {C:chips}chips{} it scored'
		}, {
			'{C:green}#2# in #3#{} chance for {X:mult,C:white}X#1#{} mult,',
			'{C:green}#2# in #4#{} chance for {X:mult,C:white}X#1#{} mult,',
			'{C:green}#2# in #5#{} chance for {X:mult,C:white}X#1#{} mult,',
			'{C:green}#2# in #6#{} chance for {X:mult,C:white}X#1#{} mult.',
			'That was not a typo.',
			'{s:0.8,C:inactive}Behold, the fruits of my alchemy:',
			'{s:0.8,C:inactive}Gamba maze.',
			'{s:0.5,C:inactive}...What\'s that? What?',
			'{s:0.4,C:inactive}...What?'
		} }
}

-- B3313 Straight Flush Form
RV.descriptions.Joker.cir_b3313_loogi = { name = 'IT HURTS', text = {
		'All {C:attention}played 2s{} without an ',
		'{C:attention}edition{} have a {C:green}#1# in #2#',
		'chance to become {C:dark_edition}Negative',
		'Each {C:attention}2{} {C:attention}held in hand{} gives',
		'{X:chips,C:white}X#3#{} Chips',
		'{C:red}-2{} hand size',
		'{C:red}-2{} discards',
		'{s:0.8,C:inactive}SHHHH! PLEASE WALK QUIETLY',
		'{s:0.8,C:inactive}IN THE HALLWAY!'
	}
}

-- B3313 Five of a Kind Form
RV.descriptions.Joker.cir_b3313_peachCell = { name = 'Peach\'s Cell', text = { {
			'All scored {C:attention}Kings{} become {C:attention}Queens',
			'All scored {C:attention}Jacks{} become {C:attention}Queens',
			'All scored {C:attention}Queens{} without an {C:attention}edition',
			'have a {C:green}#1# in #2#{} chance to become {C:dark_edition}Polychrome'
		}, {
			'If played hand contains no {C:attention}face cards{}, this {C:joker}Joker{}',
			'becomes {C:red}debuffed{} for the remainder of round',
			"{s:0.8,C:inactive}I'd also be that skittish if all the",
			'{s:0.8,C:inactive}shadows near me were quicksand.'
		} }
}

-- B3313 Flush House Form
RV.descriptions.Joker.cir_b3313_nebLob = { name = 'Nebula Lobby', text = {
		'{C:attention}Balances {C:chips}Chips{} and {C:mult}Mult{C:attention} before scoring',
		'Combined base value of played hand',
		'is added to {C:mult}Mult',
		'{s:0.8,C:inactive}Want to sound less negative?',
		'{s:0.8,C:inactive}try "menx\'k rxxp qiurezok"'
	}
}

-- B3313 Flush Five Form
RV.descriptions.Joker.cir_b3313_floor3B = { name = 'Floor 3B', text = {
		'All played {C:attention}Queens of Clubs{} without an',
		'{C:attention}enhancement{} become {C:attention}#1#s',
		'{s:0.8,C:inactive}Found the orange sky yet?'
	}
}

RV.descriptions.Joker.cir_j_confusedRumi_nPCardRebalanced = { name = "Confused Rumi",
	text = {
		"During the first hand of a round,",
		"Convert all played {C:attention}left{} cards",
		"into {C:attention}right{} cards",
		"{C:inactive,s:0.9}(Removes {C:dark_edition,s:0.9}Negative{C:inactive,s:0.9} from copy)",
		"{s:0.8,C:inactive}What is \"left card?\"",
		"{s:0.8,C:inactive}How do you define \"left card?\"",
		"{s:0.8,C:inactive}If you're talking about what",
		"{s:0.8,C:inactive}you can feel, what you can taste,",
		"{s:0.8,C:inactive}and see, then \"left card\" is",
		"{s:0.8,C:inactive}simply electrical signals",
		"{s:0.8,C:inactive}interpreted by your brain"
	}
}

--[[
This just populates the localization vars for extended desc tooltips,
otherwise mousing over something that uses them causes a crash.]]
RV.descriptions.extendedDescTooltip={}

for k, eDT in pairs(CirnoMod.miscItems.descExtensionTooltips) do
	RV.descriptions.extendedDescTooltip[k] = {
		name = eDT.loc_txt.name,
		text = eDT.loc_txt.text
	}
end

--[[
Have to do this this way because
SMODS.process_loc_text() spontaneously
stopped working for stone card related
things.]]
if
	CirnoMod.config['enhancerRenames']
then	
	-- RV.descriptions.Enhanced = { m_stone = { name = "Whump Card" } }
	RV.misc.dictionary.k_plus_stone = "+1 "..replaceIntents.stone
	RV.misc.dictionary.ph_deck_preview_stones = replaceIntents.stone.."s"
	RV.misc.dictionary.ph_mr_bones = "Saved by "..replaceIntents.bones
	
	if not CirnoMod.config['jokerRenames'] then
		RV.descriptions.Joker.j_stone = {
			text = {
				"Gives {C:chips}+#1#{} Chips for",
				"each {C:attention}"..replaceIntents.stone,
				"in your {C:attention}full deck",
				"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
			}
		}
		
		RV.descriptions.Joker.j_marble = {
			text = {
				"Adds one {C:attention}"..replaceIntents.stone,
				"to deck when",
				"{C:attention}Blind{} is selected",
			}
		}
	end
end

--[[
A set up such that challenge descriptions can be
easily written via loc_txt.text instead of just
manually doing the whole rules nonsense, as it
will now set it up itself because of this code.]]
if
	CirnoMod.config['additionalChallenges']
	and CirnoMod.ChallengeRefs
then
	local curSuffix = ''
	for k, ch in pairs(CirnoMod.ChallengeRefs) do
		for i, r in ipairs(ch.rules.custom) do
			if
				r.id == 'cir_'..ch.original_key..curSuffix
			then
				RV.misc.v_text[k..curSuffix] = { ch.loc_txt.text[i] }
				
				curSuffix = CirnoMod.miscItems.alphabetNumberConv.numToAlphabet[i]
			end
		end
		curSuffix = ''
	end
end

return RV