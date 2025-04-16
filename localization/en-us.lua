local creditSources = {}
local RV = { descriptions = { Joker = {} }, misc = { v_text = {} } }

--#region What will go in the top of an art credit tooltip.
creditSources.cr_JokerArt = "Joker Art By"
creditSources.cr_DeckArt = "Deck Art By"
creditSources.cr_EnhancerArt = "Enhancer Art By"
creditSources.cr_CardArt = "Card Art By"
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
creditSources.CommunityContrib = "{s:0.6,X:inactive,C:white}(Cirno_TV{s:0.6,X:inactive,C:inactive}_{s:0.6,X:inactive,C:white}Community-Contributed{s:0.6,X:inactive,C:inactive}_{s:0.6,X:inactive,C:white}Idea)"
creditSources.masthir = "Masthir"
creditSources.sanglune = "Sanglune"

-- The funny increases exponentially.
creditSources.CirnoTV = "{s:0.8,X:cirCyan,C:white}Cirno_TV{s:0.8}"

creditSources.solga = "Solgalestia"
creditSources.turpix = "Turpix"
creditSources.muddle = "Muddleee"
creditSources.hatotoou = "Hatotoou"
creditSources.notovia = "Notovia"
creditSources.thunk = "LocalThunk"
creditSources.unknown = "{s:0.8,X:black,C:white}Unknown{s:0.8}"
--#endregion


--[[
So because of the way this bullshit works, we have to do one of these... For every unique case. Yes.
I'm mad. We could have done a lot more progammatically, but instead every time we run into a unique
circumstance, we have to add it here. Have fun sifting through this shit because apparently this.
is the way we have to do it.]]
RV.descriptions.Other = {
	--[[
	We need this bullshit because of how this dumb fucking system works
	The contempt I feel for this setup is beyond human comprehension.
	Why are things this way? Why must LocalThunk torment us so? In this
	essay I will]]
	Joker_Art_By = { text = { creditSources.cr_JokerArt } },
	Deck_Art_By = { text = { creditSources.cr_DeckArt } },
	Enhancer_Art_By = { text = { creditSources.cr_EnhancerArt } },
	Card_Art_By = { text = { creditSources.cr_CardArt } },
	Generic_Art_By = { text = { creditSources.cr_GenericArt } },
	
	----- Me -----
	jA_NTF = {
		name = creditSources.cr_JokerArt,
		text = {creditSources.NTF}
	},
	gA_NTF = {
		name = creditSources.cr_GenericArt,
		text = { creditSources.NTF}
	},
	jA_LocalThunk_NTFEdit = {
		name = creditSources.cr_JokerArt,
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
	gA_DaemonTsun_NTF_Both = {
		name = creditSources.cr_GenericArt,
		text = {"{s:0.8}"..creditSources.DTsun.." &", creditSources.NTF}
	},
	gA_DaemonTsun_NTF_Both_ComCon = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." &",
			creditSources.NTF,
			creditSources.CommunityContrib
		}
	},
	jA_DaemonTsun_NTFEdit = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	gA_DaemonTsun_NTFEdit = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_DaemonTsun_BigNTFEdit = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", heavily",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	gA_DaemonTsun_BigNTFEdit = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", heavily",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	gA_DaemonTsun_BigNTFEdit_ComCon = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", heavily",
			"{s:0.8}edited by "..creditSources.NTF,
			creditSources.CommunityContrib
		}
	},
	jA_LocalThunk_DaemonTsunEdit = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.thunk.." art."
		}
	},
	gA_LocalThunk_DaemonTsunEdit = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.thunk.." art."
		}
	},
	
	----- Wait, what -----
	jA_Misprint = {
		name = creditSources.cr_JokerArt,
		text = {
			creditSources.CirnoTV.." & "..creditSources.thunk..",", -- Yes, Cirno drew cirBairy. Formally crediting him is funnier, trust me
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	jA_JustIRLCirno = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}...I don't know what to",
			"{s:0.8}say, it's literally just",
			"{s:0.8}a picture of "..creditSources.CirnoTV.."{s:0.8}."
		}
	},
	jA_Egg = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}...I don't know what to",
			"{s:0.8}say, it's literally just",
			"{s:0.8}a picture of "..creditSources.CirnoTV.."{s:0.8}.",
			"{s:0.8,E:1}DEFINITELY{s:0.8} real, not an",
			"{s:0.8}edit of any kind."
		}
	},
	jA_Hack = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.6}...I don't know what to",
			"{s:0.6}say, it's literally just",
			"{s:0.6}a screenshot of the",
			"{s:0.6}stream."
		}
	},
	jA_Baseball = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}Literally how do I ",
			"{s:0.8}credit this, it's a",
			"{s:0.8}still from Seinfeld."
		}
	},
	
	----- Other -----
	jA_Acrobat = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.masthir.." art.",
			creditSources.CommunityContrib
		}
	},
	jA_ciwnoEdit = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}Image of "..creditSources.CirnoTV..",",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	jA_Burglar = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}"..creditSources.sanglune.." art."
		}
	},
	jA_DuoDagger = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.thunk.." & "..creditSources.DTsun..",",
			"{s:0.8}edited by "..creditSources.NTF
		}
	},
	jA_Family = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}id software, edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_MikuTheClown = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.solga..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_BocchiTheRock = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.turpix..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_ObsvDuty = {
		name = creditSources.cr_JokerArt,
		text = { 
			"{s:0.8}"..creditSources.notovia..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_RedCard = {
		name = creditSources.cr_JokerArt,
		text = { 
			"{s:0.8}mystman12, edited",
			"{s:0.8}by "..creditSources.DTsun
		}
	},
	jA_CrysTap = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.6,X:mult,C:white}Uhh...{}, heavily edited",
			"by "..creditSources.NTF,
			"{s:0.7,C:inactive}'-'; ...Listen. It's fine.",
			"{s:0.7,C:inactive}Someone whose uncle works",
			"{s:0.7,C:inactive}there told me that this",
			"{s:0.7,C:inactive}is DEFINITELY okay.",
			"{s:0.45,C:inactive}Definitely."
		}
	},
	gA_Sun = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.muddle..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	gA_genPack_ZUN = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", ZUN",
			"{s:0.8}& "..creditSources.NTF
		}
	},
	gA_genPack_Daiyousei = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", ...Harada?",
			"{s:0.8}& "..creditSources.NTF
		}
	},
	gA_genPack_Renko = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.DTsun..", {s:0.8,X:mult,C:white}Alberta,",
			"{s:0.8,X:mult,C:white}Canada{s:0.8}, & "..creditSources.NTF
		}
	},
	gA_Wraith = {
		name = creditSources.cr_GenericArt,
		text = {
			"{s:0.8}"..creditSources.hatotoou..", edited",
			"{s:0.8}by "..creditSources.NTF
		}
	},
	jA_luchador = {
		name = creditSources.cr_JokerArt,
		text = {
			"{s:0.8}"..creditSources.DTsun.." edit of",
			"{s:0.8}Mojang art."
		}
	},
	jA_Unknown = {
		name = creditSources.cr_JokerArt,
		text = {creditSources.unknown}
	},
	eA_Unknown = {
		name = creditSources.cr_EnhancerArt,
		text = {creditSources.unknown}
	},
	jA_Unknown_LocalThunkEdit = {
		name = creditSources.cr_JokerArt,
		text = {
			creditSources.unknown.."{s:0.8} edit",
			"{s:0.8}of "..creditSources.thunk.." art."
		}
	},
	
	-- Non-Art Credit Things --
	jkrRedSeal = {
		name = "Red Seal",
		text = {
			"Retriggers this",
			"Joker {C:attention}1{} time"
		}
	},
	testHeader = { text = { "Test Header" } },
	testTooltip = {
		name = 'testHeader',
		text = {
			"This is a test tooltip.",
			"It should appear beside",
			"the item it is assigned to."
		}
	},
	testTooltipA = {
		name = 'Test Tooltip',
		text = {
			"This is a test tooltip.",
			"It should appear beside",
			"the item it is assigned to."
		}
	},
	errorHeader = { text = { 'ERROR' } },
	errorTooltip = { name = 'errorHeader', text = { '{C:red}Error fetching item.' } },
	questionMarkHeader = { text = { '?????' } },
	questionMarkTooltip = { name = 'questionmarkHeader', text = { '?????' } },
	blankHeader = { text = { '' } },
	blankTooltip = { name = 'blankHeader', text = { '' } },
	blankTooltipA = { name = '', text = { '' } }
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
	local replaceIntents = {
		stone = G.localization.descriptions.Enhanced.m_stone.name,
		bones = CirnoMod.miscItems.getJokerNameByKey('j_mr_bones')
	}
	
	if CirnoMod.replaceDef.locChanges.enhancerLoc.m_stone then
		replaceIntents.stone = CirnoMod.replaceDef.locChanges.enhancerLoc.m_stone.name
	end
	
	-- RV.descriptions.Enhanced = { m_stone = { name = "Whump Card" } }
	RV.misc.dictionary = {
		k_plus_stone = "+1 "..replaceIntents.stone,
		ph_deck_preview_stones = replaceIntents.stone.."s",
		ph_mr_bones = "Saved by "..replaceIntents.bones
	}
	
	if not CirnoMod.config['jokerRenames'] then
		RV.descriptions.Joker.j_stone = {
			text = {
				"Gives {C:chips}+#1#{} Chips for",
				"each {C:attention}"..replaceIntents.stone,
				"in your {C:attention}full deck",
				"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
			}
		}
	end
	
	-- Todo: Move into the above condition when we work out Marble Joker.
	RV.descriptions.Joker.j_marble = {
		text = {
			"Adds one {C:attention}"..replaceIntents.stone,
			"to deck when",
			"{C:attention}Blind{} is selected",
        }
	}
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