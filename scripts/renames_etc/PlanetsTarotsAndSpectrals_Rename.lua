-- SMODS.process_loc_text(G.localization.descriptions.Planet.c_neptune, "name", "Neptune")
if CirnoMod.allEnabledOptions['planetsAreHus'] then
SMODS.process_loc_text(G.localization.descriptions.Planet.c_neptune, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                    "{s:0.8,C:inactive}Nep nep!",
                    "{s:0.6,C:inactive}...Wait a minute?"
                })
else
SMODS.process_loc_text(G.localization.descriptions.Planet.c_neptune, "text", {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                    "{s:0.8,C:inactive}Nep nep!"
                })
end

-- SMODS.process_loc_text(G.localization.descriptions.Tarot.c_fool, "name", "The Fool")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_fool, "text", {
                    "Creates the last",
                    "{C:tarot}Tarot{} or {C:planet}Planet{} card",
                    "used during this run",
                    "{s:0.8,C:tarot}The Fool{s:0.8} excluded",
					"{s:0.8,C:inactive}\"You sorry fool... You could",
					"{s:0.8,C:inactive}not be the chosen one...\""
                })
				
-- SMODS.process_loc_text(G.localization.descriptions.Tarot.c_high_priestess, "name", "High Priestess")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_high_priestess, "text", {
                    "Creates up to {C:attention}#1#",
                    "random {C:planet}Planet{} cards",
                    "{C:inactive}(Must have room)",
                })

SMODS.process_loc_text(G.localization.descriptions.Tarot.c_wheel_of_fortune, "name", "Wheel of Nope")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_wheel_of_fortune, "text", {
                    "{C:green}#1# in #2#{} chance to add",
                    "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
                    "{C:dark_edition}Polychrome{} edition",
                    "to a random {C:attention}Joker",
					"{s:0.8,C:inactive}Just keep spinning, you'll",
					"{s:0.8,C:inactive}get it eventually."
                })

-- SMODS.process_loc_text(G.localization.descriptions.Tarot.c_strength, "name", "Strength")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_strength, "text", {
                    "Increases rank of",
                    "up to {C:attention}#1#{} selected",
                    "cards by {C:attention}1",
					"{s:0.8,C:inactive}Then you're gonna",
					"{s:0.8,C:inactive}add some protein..."
                })

-- SMODS.process_loc_text(G.localization.descriptions.Tarot.c_devil, "name", "The Devil")
--	SMODS.process_loc_text(G.localization.descriptions.Tarot.c_devil, "text", 
--	                    "Enhances {C:attention}#1#{} selected",
--	                    "card into a",
--	                    "{C:attention}#2#",
--						"{s:0.8,C:inactive}"
--	                })

SMODS.process_loc_text(G.localization.descriptions.Tarot.c_sun, "name", "The Sus")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_sun, "text", {
                    "Converts up to",
                    "{C:attention}#1#{} selected cards",
                    "to {V:1}#2#{}",
					"{s:0.8,C:inactive}Hey, just letting you",
					"{s:0.8,C:inactive}know that I got the",
					"{s:0.8,C:inactive}card swipe first try."
                })

SMODS.process_loc_text(G.localization.descriptions.Spectral.c_black_hole, "name", "MahoHuh")
SMODS.process_loc_text(G.localization.descriptions.Spectral.c_black_hole, "text", {
                    "Upgrade every",
                    "{C:legendary,E:1}poker hand",
                    "by {C:attention}1{} level",
					"{s:0.8,C:inactive}You got the Maho Ending!"
                })

-- SMODS.process_loc_text(G.localization.descriptions.Spectral.c_soul, "name", "The Soul")
SMODS.process_loc_text(G.localization.descriptions.Spectral.c_soul, "text", {
                    "Creates a",
                    "{C:legendary,E:1}Legendary{} Joker",
                    "{C:inactive}(Must have room)",
                    "{s:0.8,C:inactive}The shape of a friend."
                })