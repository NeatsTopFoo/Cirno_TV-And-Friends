-- SMODS.process_loc_text(G.localization.descriptions.Planet.c_neptune, "name", "Neptune")
local nepDesc = {
		"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
		"{C:attention}#2#",
		"{C:mult}+#3#{} Mult and",
		"{C:chips}+#4#{} chips",
		"{s:0.8,C:inactive}Nep nep!"
	}
if CirnoMod.config['planetsAreHus'] then
table.insert(nepDesc, "{s:0.6,C:inactive}...Wait a minute?")
end
SMODS.process_loc_text(G.localization.descriptions.Planet.c_neptune, nepDesc)

-- SMODS.process_loc_text(G.localization.descriptions.Tarot.c_fool, "name", "The Fool")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_fool, "text", {
		"Creates the last",
		"{C:tarot}Tarot{} or {C:planet}"..G.localization.misc.labels.planet.."{} card",
		"used during this run",
		"{s:0.8,C:tarot}The Fool{s:0.8} excluded",
		"{s:0.8,C:inactive}\"You sorry fool... You could",
		"{s:0.8,C:inactive}not be the chosen one...\""
	})
				
-- SMODS.process_loc_text(G.localization.descriptions.Tarot.c_high_priestess, "name", "High Priestess")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_high_priestess, "text", {
		"Creates up to {C:attention}#1#",
		"random {C:planet}"..G.localization.misc.labels.planet.."{} cards",
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
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_devil, "text", {
		"Enhances {C:attention}#1#{} selected",
		"card into a",
		"{C:attention}#2#",
		"{s:0.8,C:inactive}Going for the Matterhorn",
		"{s:0.8,C:inactive}again, are we? Bold choice."
	})
	
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_sun, "name", "The Sus")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_sun, "text", {
		"Converts up to",
		"{C:attention}#1#{} selected cards",
		"to {V:1}#2#{}",
		"{s:0.8,C:inactive}Hey, just letting you",
		"{s:0.8,C:inactive}know that I got the",
		"{s:0.8,C:inactive}card swipe first try."
	})
				
-- SMODS.process_loc_text(G.localization.descriptions.Tarot.c_lovers, "name", "The Lovers")
SMODS.process_loc_text(G.localization.descriptions.Tarot.c_lovers, "text", {
		"Enhances {C:attention}#1#{} selected",
		"card into a {C:attention}#2#",
		"{s:0.8,C:inactive}You know, during the MV when",
		"{s:0.8,C:inactive}Reimu tells Alice that her heart",
		"{s:0.8,C:inactive}was stolen, her eyes dilate.",
		"{s:0.8,C:inactive}That's an important little detail",
		"{s:0.8,C:inactive}that I think a lot of people miss.",
		"{s:0.5,C:inactive}To be fair, I didn't notice it myself until recently."
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

SMODS.process_loc_text(G.localization.descriptions.Spectral.c_ankh, "name", "Ankha")
SMODS.process_loc_text(G.localization.descriptions.Spectral.c_ankh, "text", {
		"Create a copy of a random {C:attention}Joker{},",
		"{C:red}destroy all other Jokers",
		"{s:0.8,C:inactive}The year is 2021. A family member has",
		"{s:0.8,C:inactive}just sent you a 'funny picture of a",
		"{s:0.8,C:inactive}dancing cat.'"
	})

SMODS.process_loc_text(G.localization.descriptions.Spectral.c_wraith, "name", "Frieren")
SMODS.process_loc_text(G.localization.descriptions.Spectral.c_wraith, "text", {
		"Creates a random",
		"{C:red}Rare{C:attention} Joker{},",
		"sets money to {C:money}$0",
		"{s:0.8,C:inactive}...Would Himmel do this?"
	})

SMODS.process_loc_text(G.localization.descriptions.Spectral.c_ouija, "name", "Chat Ouija")
if CirnoMod.config['matureReferences_cyc'] == 3 then
	SMODS.process_loc_text(G.localization.descriptions.Spectral.c_ouija, "text", {
		"Converts all cards in hand",
		"to a single random {C:attention}rank",
		"{C:red}-1{} hand size",
		"{s:0.8,C:inactive}Nintendo... Official... Sex.",
		"{s:0.8,C:inactive}Great work, chat."
	})
else
	SMODS.process_loc_text(G.localization.descriptions.Spectral.c_ouija, "text", {
		"Converts all cards in hand",
		"to a single random {C:attention}rank",
		"{C:red}-1{} hand size",
		"{s:0.8,C:inactive}The hivemind of Chat produces",
		"{s:0.8,C:inactive}many answers. Wrong ones",
		"{s:0.8,C:inactive}usually, but answers nonetheless."
	})
end

-- SMODS.process_loc_text(G.localization.descriptions.Spectral.c_deja_vu, "name", "Deja Vu")
SMODS.process_loc_text(G.localization.descriptions.Spectral.c_deja_vu, "text", {
		"Add a {C:red}"..G.localization.misc.labels.red_seal.."{} to {C:attention}1{} selected card in your hand",
		"{s:0.8,C:inactive}You know, if I had a nickel for every Canadian catgirl VTuber",
		"{s:0.8,C:inactive}I knew that has a weird sorta love-hate relationship with Souls",
		"{s:0.8,C:inactive}games & dropped CrossCode (although one picked it back up) among",
		"{s:0.8,C:inactive}various other similarities, I'd have -$69.90 US, as one of them",
		"{s:0.8,C:inactive}would have charged me for two backseats over this bit."
	})