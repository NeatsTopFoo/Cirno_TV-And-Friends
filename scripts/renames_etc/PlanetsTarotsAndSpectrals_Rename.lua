local PTSloc = { planets = {}, tarots = {}, spectrals = {}, c_soul = {} }
local planetIntent = G.localization.misc.labels.planet
--[[
Can't go based off the actual localisation variable name because it isn't changed  yet.
Thus, we need to establish what our intended changes will be and do it that way.]]
if CirnoMod.config.planetsAreHus then
	planetIntent = "Hu"
end

-- ...There's probably a better way to do this.
local sealIntent = {
		blue_seal = G.localization.descriptions.Other.blue_seal.name,
		red_seal = G.localization.descriptions.Other.red_seal.name,
		gold_seal = G.localization.descriptions.Other.gold_seal.name,
		purple_seal = G.localization.descriptions.Other.purple_seal.name
	}

if
	CirnoMod.replaceDef.locChanges.sealLoc.blue_seal
	and CirnoMod.replaceDef.locChanges.sealLoc.red_seal
	and CirnoMod.replaceDef.locChanges.sealLoc.gold_seal
	and CirnoMod.replaceDef.locChanges.sealLoc.purple_seal
then
	sealIntent = {
		blue_seal = CirnoMod.replaceDef.locChanges.sealLoc.blue_seal.name,
		red_seal = CirnoMod.replaceDef.locChanges.sealLoc.red_seal.name,
		gold_seal = CirnoMod.replaceDef.locChanges.sealLoc.gold_seal.name,
		purple_seal = CirnoMod.replaceDef.locChanges.sealLoc.purple_seal.name
	}
end

--#region Planets

PTSloc.planets.c_neptune = { -- name = "Neptune",
	text = {
			"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
			"{C:attention}#2#",
			"{C:mult}+#3#{} Mult and",
			"{C:chips}+#4#{} chips",
			"{s:0.8,C:inactive}Nep nep!"
		}
	}
if CirnoMod.config.planetsAreHus then
	table.insert(PTSloc.planets.c_neptune.text, "{s:0.6,C:inactive}...Wait a minute?")
end

--#endregion

--#region Tarots

PTSloc.tarots.c_fool = {
	-- name = "The Fool",
	text = {
			"Creates the last",
			"{C:tarot}Tarot{} or {C:planet}"..planetIntent.."{} card",
			"used during this run",
			"{s:0.8,C:tarot}The Fool{s:0.8} excluded",
			"{s:0.8,C:inactive}\"You sorry fool... You could",
			"{s:0.8,C:inactive}not be the chosen one...\""
		}
	}
				
PTSloc.tarots.c_high_priestess = {
	-- name = "High Priestess",
	text = {
			"Creates up to {C:attention}#1#",
			"random {C:planet}"..planetIntent.."{} cards",
			"{C:inactive}(Must have room)",
		}
	}

PTSloc.tarots.c_wheel_of_fortune = {
	name = "Wheel of Nope",
	text = {
			"{C:green}#1# in #2#{} chance to add",
			"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
			"{C:dark_edition}Polychrome{} edition",
			"to a random {C:attention}Joker",
			"{s:0.8,C:inactive}Just keep trying, you'll",
			"{s:0.8,C:inactive}get it eventually. Just",
			"{s:0.8,C:inactive}one more spin."
		}
	}
				
PTSloc.tarots.c_strength = {
	-- name = "Strength",
	text = {
			"Increases rank of",
			"up to {C:attention}#1#{} selected",
			"cards by {C:attention}1",
			"{s:0.8,C:inactive}Then you're gonna",
			"{s:0.8,C:inactive}add some protein..."
		}
	}

PTSloc.tarots.c_devil = {
	-- name = "The Devil",
	text = {
			"Enhances {C:attention}#1#{} selected",
			"card into a",
			"{C:attention}#2#",
			"{s:0.8,C:inactive}Going for the Matterhorn",
			"{s:0.8,C:inactive}again, are we? Bold choice."
		}
	}

PTSloc.tarots.c_sun= {
	name = "The Sus",
	text = {
			"Converts up to",
			"{C:attention}#1#{} selected cards",
			"to {V:1}#2#{}",
			"{s:0.8,C:inactive}Hey, just letting you",
			"{s:0.8,C:inactive}know that I got the",
			"{s:0.8,C:inactive}card swipe first try."
		}
	}

PTSloc.tarots.c_lovers = {
	-- name = "The Lovers",
	text = {
			"Enhances {C:attention}#1#{} selected",
			"card into a {C:attention}#2#",
			"{s:0.8,C:inactive}You know, during the MV when",
			"{s:0.8,C:inactive}Reimu tells Alice that her heart",
			"{s:0.8,C:inactive}was stolen, her eyes dilate.",
			"{s:0.8,C:inactive}That's an important little detail",
			"{s:0.8,C:inactive}that I think a lot of people miss.",
			"{s:0.5,C:inactive}To be fair, I didn't notice it myself until recently."
		}
	}

--#endregion

--#region Spectrals

PTSloc.spectrals.c_black_hole = {
	name = "MahoHuh",
	text = {
			"Upgrade every",
			"{C:legendary,E:1}poker hand",
			"by {C:attention}1{} level",
			"{s:0.8,C:inactive}You got the Maho Ending!"
		}
	}

PTSloc.c_soul = {
	-- name = "The Soul",
	text = {
			"Creates a",
			"{C:legendary,E:1}Legendary{} Joker",
			"{C:inactive}(Must have room)",
			"{s:0.8,C:inactive}The shape of a friend."
		}
	}

PTSloc.spectrals.c_ankh = {
	name = "Ankha",
	text = {
			"Create a copy of a random {C:attention}Joker{},",
			"{C:red}destroy all other Jokers",
			"{s:0.8,C:inactive}The year is 2021. A family member has",
			"{s:0.8,C:inactive}just sent you a 'funny picture of a",
			"{s:0.8,C:inactive}cute dancing cat.'"
		}
	}

PTSloc.spectrals.c_wraith = {
	name = "Frieren",
	text = {
			"Creates a random",
			"{C:red}Rare{C:attention} Joker{},",
			"sets money to {C:money}$0",
			"{s:0.8,C:inactive}...Would Himmel do this?"
		}
	}

PTSloc.spectrals.c_ouija = {
	name = "Chat Ouija"
}

if CirnoMod.config['matureReferences_cyc'] == 3 then
	PTSloc.spectrals.c_ouija.text = {
		"Converts all cards in hand",
		"to a single random {C:attention}rank",
		"{C:red}-1{} hand size",
		"{s:0.8,C:inactive}Nintendo... Official... Sex.",
		"{s:0.8,C:inactive}Great work, chat."
	}
else
	PTSloc.spectrals.c_ouija.text = {
		"Converts all cards in hand",
		"to a single random {C:attention}rank",
		"{C:red}-1{} hand size",
		"{s:0.8,C:inactive}The hivemind of Chat produces",
		"{s:0.8,C:inactive}many answers. Wrong ones",
		"{s:0.8,C:inactive}usually, but answers nonetheless."
	}
end

PTSloc.spectrals.c_deja_vu = {
	-- name = "Deja Vu",
	text = {
			"Add a {C:red}"..sealIntent.red_seal,
			"to {C:attention}1{} selected",
			"card in your hand",
			"{s:0.8,C:inactive}MULTi-track drifting."
		}
	}

PTSloc.spectrals.c_trance = {
	name = "Overlap",
	text = {
		"Add a {C:blue}"..G.localization.misc.labels.blue_seal.."{} to {C:attention}1{} selected card in your hand",
		"{s:0.8,C:inactive}You know, if I had a nickel for every Canadian catgirl VTuber",
		"{s:0.8,C:inactive}I knew that has a weird sorta love-hate relationship with Souls",
		"{s:0.8,C:inactive}games & dropped CrossCode (although one picked it back up) among",
		"{s:0.8,C:inactive}various other commonalities, I'd have -$69.90 US, as one of them",
		"{s:0.8,C:inactive}would have charged me for two backseats over this bit."
		}
	}

if CirnoMod.config['allowCosmeticTakeOwnership'] then
	SMODS.Consumable:take_ownership('trance', {
		create_main_end = function(center)
			local mainEndRV = {
				n = G.UIT.C,
				config = {
					align = 'bm',
					padding = 0.02
				},
				nodes = {}
			}
			
			CirnoMod.miscItems.addUISpriteNode(mainEndRV.nodes, Sprite(
					0, 0, -- Sprite X & Y
					1, 1, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.emotes, -- Sprite Atlas
					{ x = 0, y = 1 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, center)
			return { main_end = self.create_main_end(center) }
		end
	}, true)
end

--#endregion
return PTSloc