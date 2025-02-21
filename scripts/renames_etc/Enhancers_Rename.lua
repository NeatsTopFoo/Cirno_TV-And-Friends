SMODS.process_loc_text(G.localization.misc.labels, "blue_seal", "Point Seal")
SMODS.process_loc_text(G.localization.misc.labels, "gold_seal", "Full Power Seal")
SMODS.process_loc_text(G.localization.misc.labels, "purple_seal", "Life Seal")
SMODS.process_loc_text(G.localization.misc.labels, "red_seal", "Power Seal")

SMODS.process_loc_text(G.localization.descriptions.Other.blue_seal, "name", "Point Seal")
SMODS.process_loc_text(G.localization.descriptions.Other.gold_seal, "name", "Full Power Seal")
SMODS.process_loc_text(G.localization.descriptions.Other.purple_seal, "name", "Life Seal")
SMODS.process_loc_text(G.localization.descriptions.Other.red_seal, "name", "Power Seal")

SMODS.process_loc_text(G.localization.descriptions.Enhanced.m_stone, "name", "Whump Card")
SMODS.process_loc_text(G.localization.misc.dictionary, "k_plus_stone", "+1 Whump")
SMODS.process_loc_text(G.localization.misc.dictionary, "ph_deck_preview_stones", "Whumps")

if CirnoMod.allEnabledOptions['jokerRenames'] then
	SMODS.process_loc_text(G.localization.descriptions.Joker.j_stone, "text", {
						"Gives {C:chips}+#1#{} Chips for",
						"each {C:attention}Whump Card",
						"in your {C:attention}full deck",
						"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
						"{C:inactive}jgtkjhjngtjkhbjgfhjgfjjhfgfh"
					})
else
	SMODS.process_loc_text(G.localization.descriptions.Joker.j_stone, "text", {
						"Gives {C:chips}+#1#{} Chips for",
						"each {C:attention}Whump Card",
						"in your {C:attention}full deck",
						"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
					})
end
				
SMODS.process_loc_text(G.localization.descriptions.Joker.j_marble, "text", {
                    "Adds one {C:attention}Whump{} card",
                    "to deck when",
                    "{C:attention}Blind{} is selected",
                })