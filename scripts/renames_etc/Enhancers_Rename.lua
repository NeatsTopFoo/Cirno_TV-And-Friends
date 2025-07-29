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
if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Seal:take_ownership('blue',
		{
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and CirnoMod.miscItems.atlasCheck(card) then
					info_queue[#info_queue + 1] = { key = 'sA_DaemonTsun', set = 'Other' }
				end
			end
		},
		true)
		
	SMODS.Seal:take_ownership('gold',
		{
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and CirnoMod.miscItems.atlasCheck(card) then
					info_queue[#info_queue + 1] = { key = 'sA_DaemonTsun', set = 'Other' }
				end
				
				return { vars = { (self.config.extra and self.config.extra.money) or SMODS.signed_dollars(3) } }
			end
		},
		true)
		
	SMODS.Seal:take_ownership('purple',
		{
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and CirnoMod.miscItems.atlasCheck(card) then
					info_queue[#info_queue + 1] = { key = 'sA_DaemonTsun', set = 'Other' }
				end
			end
		},
		true)
		
	SMODS.Seal:take_ownership('red',
		{
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config.artCredits and CirnoMod.miscItems.atlasCheck(card) then
					info_queue[#info_queue + 1] = { key = 'sA_DaemonTsun', set = 'Other' }
				end
				
				return { vars = { (self.config.extra and self.config.extra.retriggers) or 1 } }
			end
		},
		true)
end
]]

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

enhLoc.enhancers.m_bonus = { name = "Knife Card",
	text={
        "{s:0.8,C:inactive}Padding is the white space",
		"{s:0.8,C:inactive}immediately surrounding an",
		"{s:0.8,C:inactive}element or another object",
		"{s:0.8,C:inactive}on a web page, used to",
		"{s:0.8,C:inactive}create space around an",
		"{s:0.8,C:inactive}element's content."
    }
}

enhLoc.enhancers.m_stone = { name = "Whump Card" }

enhLoc.enhancers.m_gold = { name = "Skyrim Card",
    text={
        "{C:money}#1#{} if this",
        "card is held in hand",
        "at end of round",
		"{s:0.8,C:inactive}See this card?",
		"{s:0.8,C:inactive}You can hold it.",
		"{s:0.8,C:inactive}It just works."
    }
}

enhLoc.enhancers.m_wild = { name = "Pencil Card",
    text={
        "Can be used",
        "as any suit",
		"{s:0.8,C:inactive}The pencils from",
		"{s:0.8,C:inactive}Super Mario World!"
    }
}

enhLoc.enhancers.m_glass = { name = "Ice Card" }

--#endregion

return enhLoc