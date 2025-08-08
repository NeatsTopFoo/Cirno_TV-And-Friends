local PTSloc = { planets = {}, tarots = {}, spectrals = {}, c_soul = {} }

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

local getSealName = function(type)
	return G.localization.descriptions.Other[type..'_seal'].name
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

PTSloc.tarots.c_fool = { -- name = "The Fool",
	text = {
			"Creates the last",
			"{C:tarot}Tarot{} or {C:planet}#2#{} card",
			"used during this run",
			"{s:0.8,C:tarot}The Fool{s:0.8} excluded",
			"{s:0.8,C:inactive}\"You sorry fool... You could",
			"{s:0.8,C:inactive}not be the chosen one...\""
		}
	}

SMODS.Consumable:take_ownership('fool', {
		loc_vars = function(self, info_queue, card)
			
			local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
			local last_tarot_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or
				localize('k_none')
			local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN
	
			if not (not fool_c or fool_c.name == 'The Fool') then
				info_queue[#info_queue + 1] = fool_c
			end
	
			local main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", padding = 0.02 },
					nodes = {
						{
							n = G.UIT.C,
							config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. last_tarot_planet .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
							}
						}
					}
				}
			}
			
			return { vars = {
				last_tarot_planet,
				G.localization.misc.labels.planet
				},
				main_end = main_end
			}
		end
	}, true)

PTSloc.tarots.c_high_priestess = { -- name = "High Priestess",
	text = {
			"Creates up to {C:attention}#1#",
			"random {C:planet}#2#{} cards",
			"{C:inactive}(Must have room)",
			"{s:0.8,C:inactive}Huh? No, retro consoles are",
			"{s:0.8,C:inactive}like the NES & SNES, right?",
			"{s:0.8,C:inactive}The Playstation 2 and DS",
			"{s:0.8,C:inactive}are still pretty new..."
		}
	}

SMODS.Consumable:take_ownership('high_priestess', {
		loc_vars = function(self, info_queue, card)
			return { vars = {
				card.ability.planets,
				G.localization.misc.labels.planet
			} }
		end
	}, true)

PTSloc.tarots.c_wheel_of_fortune = { name = "Wheel of Nope",
	text = {
			"{C:green}#1# in #2#{} chance to add",
			"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
			"{C:dark_edition}Polychrome{} edition",
			"to a random {C:attention}Joker",
			"{s:0.8,C:inactive}Just keep trying, you'll",
			"{s:0.8,C:inactive}get it eventually. Just",
			"{s:0.8,C:inactive}one more spin"
		}
	}

PTSloc.tarots.c_strength = { -- name = "Strength",
	text = {
			"Increases rank of",
			"up to {C:attention}#1#{} selected",
			"cards by {C:attention}1",
			"{s:0.8,C:inactive}Then you're gonna",
			"{s:0.8,C:inactive}add some protein..."
		}
	}

PTSloc.tarots.c_devil = { -- name = "The Devil",
	text = {
			"Enhances {C:attention}#1#{} selected",
			"card into a",
			"{C:attention}#2#",
			"{s:0.8,C:inactive}\"Who's laughing now?\""
		}
	}

PTSloc.tarots.c_sun= { name = "The Sus",
	text = {
			"Converts up to",
			"{C:attention}#1#{} selected cards",
			"to {V:1}#2#",
			"{s:0.8,C:inactive}Hey, I'm just",
			"{s:0.8,C:inactive}calling this meeting",
			"{s:0.8,C:inactive}to let you know that",
			"{s:0.8,C:inactive}I got the card swipe",
			"{s:0.8,C:inactive}first try"
		}
	}

PTSloc.tarots.c_lovers = { -- name = "The Lovers",
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

PTSloc.tarots.c_death = { -- name = "Death",
	text = {
			"Select {C:attention}#1#{} cards,",
			"convert the {C:attention}left{} card",
			"into the {C:attention}right{} card",
			"{C:inactive}(Drag to rearrange)",
			"{s:0.8,C:inactive}VTubers & dying to",
			"{s:0.8,C:inactive}the most random, yet",
			"{s:0.8,C:inactive}classic stuff in games,",
			"{s:0.8,C:inactive}name a more iconic duo"
		}
	}

PTSloc.tarots.c_temperance = { -- name = "Temperance",
	text = {
			"Gives the total sell",
			"value of all current",
			"Jokers {C:inactive}(Max of {C:money}$#1#{C:inactive})",
			"{C:inactive}(Currently {C:money}$#2#{C:inactive})",
			"{s:0.8,C:inactive}No drinking allowed?!",
			"{s:0.8,C:inactive}How will Biggdeck ever recover?"
		}
	}

PTSloc.tarots.c_justice = { -- name = "Justice",
	text = {
			"Enhances {C:attention}#1#{} selected",
			"card into a",
			"{C:attention}#2#",
			"{s:0.8,C:inactive}What the...",
			"{s:0.8,C:inactive}I was missold!",
			"{s:0.8,C:inactive}This isn't \"just ice\"",
			"{s:0.8,C:inactive}at all!"
		}
	}

PTSloc.tarots.c_moon = { -- name = "The Moon",
	text = {
			"Converts up to",
			"{C:attention}#1#{} selected cards",
			"to {V:1}#2#",
			"{s:0.8,C:inactive}Dawn of The Final Day",
			"{s:0.8,C:inactive}24 Hours Remaining"
		}
	}

PTSloc.tarots.c_heirophant = { -- name = "The Hierophant",
	text = {
			"Enhances {C:attention}#1#",
			"selected cards to",
			"{C:attention}#2#s",
			"{s:0.8,C:inactive}On today's docket:",
			"{s:0.8,C:inactive}Giving Hell Ravens",
			"{s:0.8,C:inactive}nuclear powers.",
			"{s:0.6,C:inactive}Well, not directly, but"
		}
	}

PTSloc.tarots.c_hanged_man = { -- name = "The Hanged Man",
	text = {
			"Destroys up to",
			"{C:attention}#1#{} selected cards",
			"{s:0.8,C:inactive}This... is a bucket.",
			"{s:0.7,C:inactive}Dear god...",
			"{s:0.8,C:inactive}There's more.",
			"{s:0.7,C:inactive}No!"
		}
	}

PTSloc.tarots.c_tower = { -- name = "The Tower",
	text = {
			"Enhances {C:attention}#1#{} selected",
			"card into a",
			"{C:attention}#2#",
			"{s:0.8,C:inactive}Nice ~$100 order with",
			"{s:0.8,C:inactive}inexact change, here's",
			"{s:0.8,C:inactive}your reward, idiot.",
			"{s:0.8,C:inactive}Whump Whump"
		}
	}

PTSloc.tarots.c_judgement = { -- name = "Judgement",
	text = {
			"Creates a random",
			"{C:attention}Joker{} card",
			"{C:inactive}(Must have room)",
			"{s:0.8,C:inactive}...What do you mean, you",
			"{s:0.8,C:inactive}aren't using rats to",
			"{s:0.8,C:inactive}open doors? How do you",
			"{s:0.8,C:inactive}do anything?",
			"{s:0.6,C:inactive}Ohhh, Alberta. That makes sense."
		}
	}

PTSloc.tarots.c_chariot = { -- name = "The Chariot",
	text = {
			"Enhances {C:attention}#1#{} selected",
			"card into a",
			"{C:attention}#2#",
			"{s:0.8,C:inactive}Training options have",
			"{s:0.8,C:inactive}been restricted"
		}
	}

PTSloc.tarots.c_emperor = { -- name = "The Emperor",
	text = {
			"Creates up to {C:attention}#1#",
			"random {C:tarot}Tarot{} cards",
			"{C:inactive}(Must have room)",
			"{s:0.8,C:inactive}Have you ever noticed",
			"{s:0.8,C:inactive}just how much space",
			"{s:0.8,C:inactive}her skill name takes",
			"{s:0.8,C:inactive}up in the skills screen?",
			"{s:0.8,C:inactive}It gets so small!"
		}
	}

--[[
PTSloc.tarots.c_empress = { -- name = "The Empress",
		text = {
			"Enhances {C:attention}#1#",
			"selected cards to",
			"{C:attention}#2#s"
		}
	}
]]

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Consumable:take_ownership('empress', {
		create_main_end = function()
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
					0.8, 0.8, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.emotes, -- Sprite Atlas
					{ x = 2, y = 2 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			local RT = { vars = {
				card.ability.max_highlighted,
				localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv }
			} }
			
			info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
			
			if CirnoMod.miscItems.atlasCheck(card) then
				RT.main_end = self.create_main_end()
			end
			
			return RT
		end
	}, true)
end

PTSloc.tarots.c_magician = { -- name = "The Magician",
	text = {
			"Enhances {C:attention}#1#{}",
			"selected cards to",
			"{C:attention}#2#s",
			"{s:0.8,C:inactive}You should eat",
			"{s:0.8,C:inactive}your vegetables"
		}
	}

PTSloc.tarots.c_star = { -- name = "The Star",
	text = {
			"Converts up to",
			"{C:attention}#1#{} selected cards",
			"to {V:1}#2#",
			"{s:0.8,C:inactive}Cirno v. Gold Ship,",
			"{s:0.8,C:inactive}who's dumber?"
		}
	}

PTSloc.tarots.c_hermit = { -- name = "The Hermit",
		text = {
			"Doubles money",
			"{C:inactive}(Max of {C:money}$#1#{C:inactive})",
			"{s:0.8,C:inactive}Remember, always have",
			"{s:0.8,C:inactive}the viewer list open",
			"{s:0.8,C:inactive}and greet everyone that",
			"{s:0.8,C:inactive}shows up to watch"
		}
	}

PTSloc.tarots.c_world = { -- name = "The World",
		text = {
			"Converts up to",
			"{C:attention}#1#{} selected cards",
			"to {V:1}#2#{}",
			"{s:0.8,C:inactive}\"You have bees here?\""
		}
	}

--#endregion

--#region Spectrals

PTSloc.spectrals.c_black_hole = { name = "MahoHuh",
	text = {
			"Upgrade every",
			"{C:legendary,E:1}poker hand",
			"by {C:attention}1{} level",
			"{s:0.8,C:inactive}You got the Maho Ending!"
		}
	}

PTSloc.c_soul = { -- name = "The Soul",
	text = {
			"Creates a",
			"{C:legendary,E:1}Legendary{} Joker",
			"{C:inactive}(Must have room)",
			"{s:0.8,C:inactive}The shape of a friend"
		}
	}

PTSloc.spectrals.c_ankh = { name = "Ankha",
	text = {
			"Create a copy of a random {C:attention}Joker{},",
			"{C:red}destroy all other Jokers",
			"{s:0.8,C:inactive}The year is 2021. A family member has",
			"{s:0.8,C:inactive}just sent you a 'funny picture of a",
			"{s:0.8,C:inactive}cute dancing cat.'"
		}
	}

PTSloc.spectrals.c_wraith = { name = "Frieren",
	text = {
			"Creates a random",
			"{C:red}Rare{C:attention} Joker{},",
			"sets money to {C:money}$0",
			"{s:0.8,C:inactive}...Would Himmel do this?"
		}
	}

PTSloc.spectrals.c_ouija = { name = "Chat Ouija" }

if CirnoMod.config['matureReferences_cyc'] == 3 then
	PTSloc.spectrals.c_ouija.text = {
		"Converts all cards in hand",
		"to a single random {C:attention}rank",
		"{C:red}-1{} hand size",
		"{s:0.8,C:inactive}Nintendo... Official... Sex.",
		"{s:0.8,C:inactive}Great work, chat"
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

PTSloc.spectrals.c_deja_vu = { -- name = "Deja Vu",
	text = {
			"Add a {C:red}#1#",
			"to {C:attention}1{} selected",
			"card in your hand",
			"{s:0.8,C:inactive}MULTi-track drifting."
		}
	}

SMODS.Consumable:take_ownership('deja_vu', {
	loc_vars = function(self, info_queue, card)
		return { vars = { getSealName('red') } }
	end
}, true)

PTSloc.spectrals.c_trance = { name = "Overlap",
	text = {
		"Add a {C:blue}#1#{} to {C:attention}1{} selected card in your hand",
		"{s:0.8,C:inactive}You know, if I had a nickel for every Canadian catgirl VTuber",
		"{s:0.8,C:inactive}I knew that has a weird sorta love-hate relationship with Souls",
		"{s:0.8,C:inactive}games & dropped CrossCode among various other things in common,",
		"{s:0.8,C:inactive}I'd have -$69.90 US, as one of them would have charged me",
		"{s:0.8,C:inactive}for two backseats over this bit."
		}
	}

SMODS.Consumable:take_ownership('trance', {
	create_main_end = function()
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
	
	loc_vars = function(self, info_queue, card)
		local RT = { vars = { getSealName('blue') } }
		
		if CirnoMod.miscItems.atlasCheck(card) then
			RT.main_end = self.create_main_end()
		end
		
		return RT
	end
}, true)

PTSloc.spectrals.c_grim = { name = "Anxiety",
	text = {
			"Destroy {C:attention}1{} random",
			"card in your hand,",
			"add {C:attention}#1#{} random {C:attention}Enhanced",
			"{C:attention}Aces{} to your hand",
			"{s:0.8,C:inactive}What, it's just an ordinary-",
			"{s:0.8,C:inactive}OH MY GOODNESS!"
		}
	}

PTSloc.spectrals.c_aura = { -- name = "Aura",
	text = {
			"Add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
			"or {C:dark_edition}Polychrome{} effect to",
			"{C:attention}1{} selected card in hand",
			"{s:0.8,C:inactive}She's fuming"
		}
	}

PTSloc.spectrals.c_immolate = { -- name = "Immolate",
		text = {
			"Destroys {C:attention}#1#{} random",
			"cards in hand,",
			"gain {C:money}$#2#",
			"{s:0.8,C:inactive}This is fine"
		}
	}

--[[ 
PTSloc.spectrals.c_cryptid = { -- name = "Cryptid", 
		text = {
			"Create {C:attention}#1#{} copies of",
			"{C:attention}1{} selected card",
			"in your hand",
			"{s:0.8,C:inactive}"
		}
	}
]]

PTSloc.spectrals.c_familiar = { -- name = "Familiar", 
		text = {
			"Destroy {C:attention}1{} random",
			"card in your hand, add",
			"{C:attention}#1#{} random {C:attention}Enhanced face",
			"{C:attention}cards{} to your hand",
			"{s:0.8,C:inactive}Oh no, he's hot!"
		}
	}

PTSloc.spectrals.c_talisman = { -- name = "Talisman", 
		text = {
			"Add a {C:attention}#1#",
			"to {C:attention}1{} selected",
			"card in your hand",
			"{s:0.8,C:inactive}Reimu exterminates yōkai",
			"{s:0.8,C:inactive}with her job bonus",
			"{s:0.8,C:inactive}...Okay, yes, exterminators",
			"{s:0.8,C:inactive}usually spend money on",
			"{s:0.8,C:inactive}equipment. I'm saying she",
			"{s:0.8,C:inactive}is literally smacking them",
			"{s:0.8,C:inactive}with it"
		}
	}

SMODS.Consumable:take_ownership('talisman', {
	loc_vars = function(self, info_queue, card)
		return { vars = { getSealName('gold') } }
	end
}, true)

--#endregion
return PTSloc