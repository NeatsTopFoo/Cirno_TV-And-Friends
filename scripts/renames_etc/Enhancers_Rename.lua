local enhLoc = { seals = {}, enhancers = {} }
local planetIntent = G.localization.misc.labels.planet
--[[
Can't go based off the actual localisation variable name because it isn't changed  yet.
Thus, we need to establish what our intended changes will be and do it that way.]]
if CirnoMod.config.planetsAreHus then
	planetIntent = "Hu"
end

--#region Seals

SMODS.process_loc_text(G.localization.misc.labels, "blue_seal", "Point Seal")
SMODS.process_loc_text(G.localization.misc.labels, "gold_seal", "Full Power Seal")
SMODS.process_loc_text(G.localization.misc.labels, "purple_seal", "Life Seal")
SMODS.process_loc_text(G.localization.misc.labels, "red_seal", "Power Seal")

--[[
if not CirnoMod.config.planetTarotSpectralRenames then
SMODS.process_loc_text(G.localization.descriptions.Spectral.c_deja_vu, "text", {
                    "Add a {C:red}"..G.localization.misc.labels.red_seal,
                    "to {C:attention}1{} selected",
                    "card in your hand"
                })
end

SMODS.process_loc_text(G.localization.descriptions.Spectral.c_medium, "text", {
                    "Add a {C:purple}"..G.localization.misc.labels.purple_seal,
                    "to {C:attention}1{} selected",
                    "card in your hand"
                })

SMODS.process_loc_text(G.localization.descriptions.Spectral.c_talisman, "text", {
                    "Add a {C:attention}"..G.localization.misc.labels.gold_seal,
                    "to {C:attention}1{} selected",
                    "card in your hand"
                })

SMODS.process_loc_text(G.localization.descriptions.Spectral.c_trance, "text", {
                    "Add a {C:blue}"..G.localization.misc.labels.blue_seal,
                    "to {C:attention}1{} selected",
                    "card in your hand"
                })]]

SMODS.process_loc_text(G.localization.descriptions.Other.blue_seal, "name", "Point Seal")
SMODS.process_loc_text(G.localization.descriptions.Other.blue_seal, "text", {
		"Creates the {C:planet}"..planetIntent.."{} card",
		"for final played {C:attention}poker hand{}",
		"of round if {C:attention}held{} in hand",
		"{C:inactive}(Must have room)"
	})

SMODS.process_loc_text(G.localization.descriptions.Other.gold_seal, "name", "Full Power Seal")
SMODS.process_loc_text(G.localization.descriptions.Other.purple_seal, "name", "Life Seal")
SMODS.process_loc_text(G.localization.descriptions.Other.red_seal, "name", "Power Seal")

enhLoc.seals.blue_seal = { name = "Point Seal",
	text = {
			"Creates the {C:planet}"..planetIntent.."{} card",
			"for final played {C:attention}poker hand{}",
			"of round if {C:attention}held{} in hand",
			"{C:inactive}(Must have room)"
		}
	}

enhLoc.seals.gold_seal = { name = "Full Power Seal" }
enhLoc.seals.purple_seal = { name = "Life Seal" }
enhLoc.seals.red_seal = { name = "Power Seal" }

--#endregion

--#region Enhancers

--[[
SMODS.process_loc_text() spontaneously stopped
working for stone card stuff, this is done in
the mod's localization/en-us.lua instead.
SMODS.process_loc_text(G.localization.descriptions.Enhanced.m_stone, "name", "Whump Card")

SMODS.process_loc_text(G.localization.misc.dictionary, "k_plus_stone", "+1 Whump")
SMODS.process_loc_text(G.localization.misc.dictionary, "ph_deck_preview_stones", "Whumps")]]

enhLoc.enhancers.m_stone = { name = "Whump Card" }

if not CirnoMod.config['jokerRenames'] then	
	SMODS.process_loc_text(G.localization.descriptions.Joker.j_stone, "text", {
						"Gives {C:chips}+#1#{} Chips for",
						"each {C:attention}Whump Card",
						"in your {C:attention}full deck",
						"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
					})
					
	SMODS.process_loc_text(G.localization.descriptions.Joker.j_marble, "text", {
						"Adds one {C:attention}Whump Card",
						"to deck when",
						"{C:attention}Blind{} is selected",
					})
	
end

--#endregion

return enhLoc