local jokerLoc = { nrmJkrs = {}, delGrat = {}, weeJkr = {}, lgndJkrs = {} }
local planetIntent = G.localization.misc.labels.planet
local planetPackIntent = G.localization.descriptions.Other.p_celestial_normal.name
--[[
Can't go based off the actual localisation variable name because it isn't changed  yet.
Thus, we need to establish what our intended changes will be and do it that way.]]
if CirnoMod.config.planetsAreHus then
	planetIntent = "Hu"
	planetPackIntent = "Gensokyo Pack"
end

-- ...There's probably a better way to do these.
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

local celestPackIntent = G.localization.descriptions.Other.p_celestial_normal.name

if CirnoMod.replaceDef.locChanges.boosterLoc then
	if CirnoMod.replaceDef.locChanges.boosterLoc.p_celestial_normal then
		celestPackIntent = CirnoMod.replaceDef.locChanges.boosterLoc.p_celestial_normal.name or celestPackIntent
	end
end

local stoneIntent = G.localization.descriptions.Enhanced.m_stone.name
local goldIntent = G.localization.descriptions.Enhanced.m_gold.name
local glassIntent = G.localization.descriptions.Enhanced.m_glass.name

if CirnoMod.replaceDef.locChanges.enhancerLoc.m_stone then
	stoneIntent = CirnoMod.replaceDef.locChanges.enhancerLoc.m_stone.name
end

if CirnoMod.replaceDef.locChanges.enhancerLoc.m_gold then
	goldIntent = CirnoMod.replaceDef.locChanges.enhancerLoc.m_gold.name
end
	
if CirnoMod.replaceDef.locChanges.enhancerLoc.m_glass then
	glassIntent = CirnoMod.replaceDef.locChanges.enhancerLoc.m_glass.name
end

--[[ Bootstraps goes first, as some future (cosmetic)
changes depend on a variable that's decided here]]
if CirnoMod.config['matureReferences_cyc'] >= 2 then
	jokerLoc.nrmJkrs.j_bootstraps = {
		name = "Allegations",
		text = {
			"{C:mult}+#1#{} Mult for every",
			"{C:money}$#2#{} you have",
			"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
			"{s:0.8,C:inactive}Can you believe Cirno's",
			"{s:0.8,C:inactive}body pillow was added",
			"{s:0.8,C:inactive}to Balatro?"
		}
	}
else
	jokerLoc.nrmJkrs.j_bootstraps = {
		name = "Cirno's Favourite",
		text = {
			"{C:mult}+#1#{} Mult for every",
			"{C:money}$#2#{} you have",
			"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
			"{s:0.8,C:inactive}...I wonder."
		}
	}
end

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('bootstraps', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_bootstraps', jokerLoc.nrmJkrs.j_bootstraps.name)
			end
		end
	}, true)
end




-- ======================================================================

jokerLoc.nrmJkrs.j_joker = {
	name = "Clippy",
	text = {
        "{C:red,s:1.1}+#1#{} Mult",
		"{s:0.8,C:inactive}>Yes     >No"
    }
}

jokerLoc.weeJkr.j_wee = { name = "cirMini", }

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('wee', {
		create_main_end = function()
			local mainEndRV = {
				n = G.UIT.C,
				config = {
					align = 'bm',
					padding = 0.02
				},
				nodes = {}
			}
			
			local firstLine = CirnoMod.miscItems.addUIColumnOrRowNode(mainEndRV.nodes, 'cm', 'R', G.C.CLEAR, 0, 0).nodes
			
			CirnoMod.miscItems.addUISpriteNode(firstLine, Sprite(
					0, 0, -- Sprite X & Y
					0.3, 0.3, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.emotes, -- Sprite Atlas
					{ x = 2, y = 0 } -- Position in the Atlas
				)
			)
			
			CirnoMod.miscItems.addUITextNode(firstLine, 's in the chat.', G.C.UI.TEXT_INACTIVE, 0.8)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = {
				card.ability.extra.chips,
				card.ability.extra.chip_mod },
			main_end = self.create_main_end() }
		end
	}, true)
else
	jokerLoc.weeJkr.j_wee.text = {
		"This Joker gains",
		"{C:chips}+#2#{} Chips when each",
		"played {C:attention}2{} is scored",
		"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
		"{s:0.35,C:inactive}Something about cirFairies in the chat."
	}
end

jokerLoc.nrmJkrs.j_chaos = {
	name = "Miku The Clown",
	text = {
        "{C:attention}#1#{} free {C:green}Reroll",
        "per shop",
		"{s:0.8,C:inactive}Society..."
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('chaos', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_chaos')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_jolly = {
	name = "Jolly Keine",
	text = {
		"{C:red}+#1#{} Mult if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}...What do you think",
		"{s:0.8,C:inactive}history tastes like?"
	}
}

jokerLoc.nrmJkrs.j_zany = {
	name = "Zany Shuten",
	text = {
		"{C:red}+#1#{} Mult if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}How To Capture A Hannah:",
		"{s:0.8,C:inactive}1. Stick with rope",
		"{s:0.8,C:inactive}2. Prop open box on stick",
		"{s:0.8,C:inactive}3. Place Shuten art under box",
		"{s:0.8,C:inactive}4. Wait"
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('zany', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_zany')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_mad = {
	name = "Mad Fumo",
	text = {
		"{C:red}+#1#{} Mult if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}...I can't quite tell",
		"{s:0.8,C:inactive}from the expression."
	}
}

jokerLoc.nrmJkrs.j_crazy = {
	name = "Crazy DM",
	text = {
		"{C:red}+#1#{} Mult if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}You must needs understand,",
		"{s:0.8,C:inactive}wouldst thou be in her shoes,",
		"{s:0.8,C:inactive}thine disposition mayhaps be",
		"{s:0.8,C:inactive}of similar vexation."
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('crazy', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_crazy')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_droll = {
	name = "Apple Magician Girl",
	text = {
		"{C:red}+#1#{} Mult if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}...How many Magician Girl",
		"{s:0.8,C:inactive}variants are there...?"
	}
}

jokerLoc.nrmJkrs.j_half = {
	name = "Half Clippy",
	text = {
		"{C:red}+#1#{} Mult if played",
        "hand contains",
        "{C:attention}#2#{} or fewer cards",
		"{s:0.8,C:inactive}...Somehow even",
		"{s:0.8,C:inactive}more annoying."
	}
}

jokerLoc.nrmJkrs.j_merry_andy = {
	name = "MikuSnale",
	text = {
		"{C:red}+#1#{} discards",
        "each round,",
        "{C:red}#2#{} hand size",
		"{s:0.8,C:inactive}\"woaaaaaaaaaaa",
		"{s:0.8,C:inactive}so cool..,.,\""
	}
}

jokerLoc.nrmJkrs.j_stone = {
	name = "Bocchi The Rock",
	text = {
		"Gives {C:chips}+#1#{} Chips for",
		"each {C:attention}Whump Card",
		"in your {C:attention}full deck",
		"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
		"{s:0.8,C:inactive}jgtkjhjngtjkhbjgfhjgfjjhfgfh"
	}
}


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_juggler = {
	name = "Chuckster",
	text = {
		"{C:attention}+#1#{} hand size",
		"{s:0.8,C:inactive}I'd say I get Nintendo, in that",
		"{s:0.8,C:inactive}developing good third person camera",
		"{s:0.8,C:inactive}controls for a 3D game is pretty",
		"{s:0.8,C:inactive}hard, I've tried it, but - They",
		"{s:0.8,C:inactive}had way more people & money to",
		"{s:0.8,C:inactive}throw at this than I do."
	}
}

jokerLoc.nrmJkrs.j_drunkard = { name = "JAPANESE GOBLIN" }

if CirnoMod.config.allowCosmeticTakeOwnership then	
	SMODS.Joker:take_ownership('drunkard', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_drunkard')
			end
		end,
			
		create_main_end = function(card)
			local mainEndRV = {
				n = G.UIT.C,
				config = {
					align = 'bm',
					padding = 0.02
				},
				nodes = {}
			}
			
			local spriteY = 0
			
			if
				card.edition
				and card.edition.key == 'e_negative'
			then
				spriteY = 1
			end
			
			CirnoMod.miscItems.addUISpriteNode(mainEndRV.nodes, AnimatedSprite(
					0, 0, -- Sprite X & Y
					0.8, 0.8, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.japaneseGoblin, -- Sprite Atlas
					{ x = 0, y = spriteY } -- Position in the atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.d_size }, main_end = self.create_main_end(card) }
		end
	}, true)
else
	jokerLoc.nrmJkrs.j_drunkard.text = {
		"{C:red}+#1#{} discard",
		"each round",
		"{s:0.8,C:inactive}WE ARE",
		"{s:0.8,C:inactive}JAPANESE GOBLIN!"
	}
end

jokerLoc.nrmJkrs.j_acrobat = {
	name = "Bar-Using Incel",
	text = {
        "{X:red,C:white} X#1# {} Mult on {C:attention}final",
        "{C:attention}hand{} of round",
		"{s:0.8,C:inactive}Makes me sick watching",
		"{s:0.8,C:inactive}people play DDR like this."
    }
}

jokerLoc.nrmJkrs.j_sock_and_buskin = {
	name = "Bad Apple",
	text = {
		"Retrigger all",
        "played {C:attention}face{} cards",
		"{s:0.8,C:inactive}Balatro, but it's Bad Apple."
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then	
	SMODS.Joker:take_ownership('sock_and_buskin', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_sock_and_buskin')
			end
		end,
		
		create_main_end = function(card)
			local mainEndRV = {
				n = G.UIT.C,
				config = {
					align = 'bm',
					padding = 0.02
				},
				nodes = {}
			}
			
			if
				card.edition
				and card.edition.key == 'e_negative'
			then
				CirnoMod.miscItems.addUISpriteNode(mainEndRV.nodes, Sprite(
						0, 0, -- Sprite X & Y
						1.2, 1, -- Sprite W & H
						CirnoMod.miscItems.funnyAtlases.badAppleInv, -- Sprite Atlas
						{ x = 0, y = 0 } -- Position in the atlas
					)
				)
			else
				CirnoMod.miscItems.addUISpriteNode(mainEndRV.nodes, Sprite(
						0, 0, -- Sprite X & Y
						1.2, 1, -- Sprite W & H
						CirnoMod.miscItems.funnyAtlases.badApple, -- Sprite Atlas
						{ x = 0, y = 0 } -- Position in the atlas
					)
				)
			end
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.d_size }, main_end = self.create_main_end(card) }
		end
	}, true)
end

jokerLoc.nrmJkrs.j_mime = {
	name = "Clownpiece",
	text = {
        "Retrigger all",
        "card {C:attention}held in",
        "{C:attention}hand{} abilities",
		"{s:0.8,C:inactive}Look chat, it's",
		"{s:0.8,C:inactive}Cirno's favourite."
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('mime', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_mime')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_credit_card = {
	-- name = "Credit Card"
	text = {
        "Go up to",
        "{C:red}-$#1#{} in debt",
		"{s:0.8,C:inactive}\"Sir, I don't",
		"{s:0.8,C:inactive}understand. How",
		"{s:0.8,C:inactive}did you leak it",
		"{s:0.8,C:inactive}to hundreds of",
		"{s:0.8,C:inactive}people at once?\""
    }
}

jokerLoc.nrmJkrs.j_greedy_joker = {
	name = "DiaMonds",
	text = {
        "Played cards with",
        "{C:diamonds}#2#{} suit give",
        "{C:mult}+#1#{} Mult when scored",
		"{s:0.8,C:inactive}Diamonds and DM just",
		"{s:0.8,C:inactive}aren't supposed to go",
		"{s:0.8,C:inactive}together. :("
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('greedy_joker', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_greedy_joker')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_lusty_joker = {	name = "hannahLove" }
if CirnoMod.config['matureReferences_cyc'] == 3 then
	jokerLoc.nrmJkrs.j_lusty_joker.text = {
		"Played cards with",
		"{C:hearts}#2#{} suit give",
		"{C:mult}+#1#{} Mult when scored",
		"{s:0.8,C:inactive}\"But people on Twitch be going",
		"{s:0.8,C:inactive}like 'BOING, BOING, BOING,",
		"{s:0.8,C:inactive}CHCHBOING, CHCHCHCHBOING'...\""
	}
else
	jokerLoc.nrmJkrs.j_lusty_joker.text = {
		"Played cards with",
		"{C:hearts}#2#{} suit give",
		"{C:mult}+#1#{} Mult when scored",
		"{s:0.8,C:inactive}Please be patient.",
		"{s:0.8,C:inactive}This stream is being worked on."
	}
end

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('lusty_joker', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_lusty_joker')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_wrathful_joker = {
	name = "Wrathful Biggdeck",
	text = {
        "Played cards with",
        "{C:spades}#2#{} suit give",
        "{C:mult}+#1#{} Mult when scored",
		"{s:0.8,C:inactive}Biggdeck? This is Anon, silly."
    }
}

jokerLoc.nrmJkrs.j_gluttenous_joker = {
	name = "Gluttonous Cirno",
	text = {
        "Played cards with",
        "{C:clubs}#2#{} suit give",
        "{C:mult}+#1#{} Mult when scored",
		"{s:0.8,C:inactive}\"Sometimes I'll just",
		"{s:0.8,C:inactive}spray a can of whipped",
		"{s:0.8,C:inactive}cream into my mouth.\""
    }
}


-- ===== NEXT LINE =====


--[[
jokerLoc.nrmJkrs.j_troubadour = {
	name = "Troubadour",
	text = {
		"{C:attention}+#1#{} hand size,",
        "{C:blue}-#2#{} hand each round"
	}
}]]

jokerLoc.nrmJkrs.j_banner = {
	name = "Gacha Banner",
	text = {
		"{C:chips}+#1#{} Chips for",
        "each remaining",
        "{C:attention}discard",
		"{s:0.8,C:inactive}\"This how you feel when",
		"{s:0.8,C:inactive}I pull your girls?\"",
		"{s:0.5,C:inactive}\"{s:0.5,C:cirFaintLavender}...What are my girls?{s:0.5,C:inactive}\""
	}
}

jokerLoc.nrmJkrs.j_mystic_summit = {
	name = "Jump King",
	text = {
		"{C:mult}+#1#{} Mult when",
        "{C:attention}#2#{} discards",
        "remaining",
		"{s:0.8,C:inactive}One would assume Cirno",
		"{s:0.8,C:inactive}enjoys the base of",
		"{s:0.8,C:inactive}the summit, given his ",
		"{s:0.8,C:inactive}tendency to return often"
	}
}

jokerLoc.nrmJkrs.j_marble = {
	name = "Cement Bread",
	text = {
		"Adds one {C:attention}Whump{} card",
		"to deck when",
		"{C:attention}Blind{} is selected"
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('marble', {
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
					{ x = 4, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue+1] = G.P_CENTERS.m_stone
			
			return { main_end = self.create_main_end() }
		end
	}, true)
end

jokerLoc.nrmJkrs.j_loyalty_card = {
	name = "New Sub",
	text = {
		"{X:red,C:white} X#1# {} Mult every",
        "{C:attention}#2#{} hands played",
        "{C:inactive}#3#",
		"{s:0.8,C:inactive}They keep posting that",
		"{s:0.8,C:inactive}blue-haired anime girl..."
	}
}

jokerLoc.nrmJkrs.j_hack = {
	-- name = "Hack",
	text = {
        "Retrigger each played",
        "{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{}",
		"{s:0.8,C:inactive}This just in, streamer",
		"{s:0.8,C:inactive}cheats at videogame by",
		"{s:0.8,C:inactive}watching his own stream."
    }
}

--[[
jokerLoc.nrmJkrs.j_misprint = {
	-- name = "Misprint",
	text = {
		--	Literally how do I add flavour text
		--	to Misprint, the text is generated in-game
        ""
    }
}]]

jokerLoc.nrmJkrs.j_steel_joker = {
	name = "Coldsteel The Jekjek",
	text = {
		"Gives {X:mult,C:white} X#1# {} Mult",
        "for each {C:attention}Steel Card",
        "in your {C:attention}full deck",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}\"psssh... nothin personnel... kid...\""
    }
}
--[[
Unsure what to do with Raised Fist.
jokerLoc.nrmJkrs.j_raised_fist = {
	name = "Raised Fist",
	text = {
		"Adds {C:attention}double{} the rank",
		"of {C:attention}lowest{} ranked card",
		"held in hand to Mult"
    }
}
]]

jokerLoc.nrmJkrs.j_golden = {
	name = "CirGlod",
	text = {
		"Earn {C:money}$#1#{} at",
        "end of round",
		"{s:0.8,C:inactive}...These aren't the golden",
		"{s:0.8,C:inactive}guns I remember."
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('golden', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_golden')
			end
		end,
		
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
					{ x = 3, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra }, main_end = self.create_main_end() }
		end
	}, true)
end


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_blueprint = {
	-- name = "Blueprint",
	text = {
		"Copies ability of",
		"{C:attention}Joker{} to the right",
		"{s:0.8,C:inactive}In the shape of",
		"{s:0.8,C:inactive}a friend-to-be."
	}
}

jokerLoc.nrmJkrs.j_glass = {
	name = "Ice Joker",
	text = {
		"This Joker gains {X:mult,C:white} X#1# {} Mult",
        "for every {C:attention}"..glassIntent.." Card",
        "that is destroyed",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}What's cooler than being cool?"
	}
}

jokerLoc.nrmJkrs.j_scary_face = {
	name = "Curly's Scary Face",
	text = {
		"Played {C:attention}face{} cards",
        "give {C:chips}+#1#{} Chips",
        "when scored",
		"{s:0.8,C:inactive}...What do you mean",
		"{s:0.8,C:inactive}you fed the tooth",
		"{s:0.8,C:inactive}rat child to the wall?"
	}
}

jokerLoc.nrmJkrs.j_abstract = {
	name = "Sayuri",
	text = {
		"{C:mult}+#1#{} Mult for",
        "each {C:attention}Joker{} card",
        "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
		"{s:0.8,C:inactive}Is that... Yes, I do believe it is!",
		"{s:0.8,C:inactive}It's the {s:0.8,C:cirInactiveAtt}real Sayuri!"
	}
}

if CirnoMod.config.matureReferences_cyc >= 2 then
	jokerLoc.delGrat.j_delayed_grat = {
		-- name = "Delayed Gratification"
	}
end

if CirnoMod.config.matureReferences_cyc == 3 then
	jokerLoc.delGrat.j_delayed_grat.text = {
        "Earn {C:money}$#1#{} per {C:attention}discard{} if",
        "no discards are used",
        "by end of the round",
		"{s:0.8,C:inactive}\"{s:0.8,C:cirLucy}You won't last a minute.{s:0.8,C:inactive}\""
    }
elseif CirnoMod.config.matureReferences_cyc == 2 then
	jokerLoc.delGrat.j_delayed_grat.text = {
        "Earn {C:money}$#1#{} per {C:attention}discard{} if",
        "no discards are used",
        "by end of the round",
		"{s:0.8,C:inactive}\"{s:0.8,C:cirLucy}Hey sweet one",
		"{s:0.8,C:cirLucy}To the grave I won't go",
		"{s:0.8,C:cirLucy}For when I am done",
		"{s:0.8,C:cirLucy}Kill me all you want{s:0.8,C:inactive}\""
    }
end

if
	CirnoMod.config.allowCosmeticTakeOwnership
	and CirnoMod.config.matureReferences_cyc >= 2
then
	SMODS.Joker:take_ownership('delayed_grat', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_delayed_grat')
			end
		end,
		
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
					{ x = 0, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra }, main_end = self.create_main_end() }
		end
	}, true)
end

--[[
jokerLoc.nrmJkrs.j_ticket = {
	name = "Golden Ticket",
	text = {
		"Played {C:attention}"..goldIntent.."{} cards",
        "earn {C:money}$#1#{} when scored"
	},
    unlock = {
        "Play a 5 card hand",
        "that contains only",
        "{C:attention,E:1}"..goldIntent.."{} cards",
    }
}
]]

jokerLoc.nrmJkrs.j_pareidolia = {
	-- name = "Pareidolia",
	text = {
		"All cards are",
        "considered",
        "{C:attention}face{} cards",
		"{s:0.8,C:inactive}A classic. :^)"
	}
}

--[[
jokerLoc.nrmJkrs.j_cartomancer = {
	name = "Cartomancer",
	text = {
		"Create a {C:tarot}Tarot{} card",
        "when {C:attention}Blind{} is selected",
        "{C:inactive}(Must have room)"
	}
}]]

jokerLoc.nrmJkrs.j_even_steven = {
	name = "Even Ariral",
	text = {
		"Played cards with",
        "{C:attention}even{} rank give",
        "{C:mult}+#1#{} Mult when scored",
        "{C:inactive}(10, 8, 6, 4, 2)",
		"{s:0.8,C:inactive}Unfortunately, Arirals are",
		"{s:0.8,C:inactive}banned from Alberta."
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('even_steven', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_even_steven')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_odd_todd = {
	name = "Odd Kerfur",
	text = {
		"Played cards with",
        "{C:attention}odd{} rank give",
        "{C:chips}+#1#{} Chips when scored",
        "{C:inactive}(A, 9, 7, 5, 3)",
		"{s:0.8,C:inactive}Meow!"
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('odd_todd', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_odd_todd')
			end
		end
	}, true)
end


-- ===== NEXT LINE =====

--[[
jokerLoc.nrmJkrs.j_scholar = {
	name = "Scholar",
	text = {
		"Played {C:attention}Aces{}",
        "give {C:chips}+#2#{} Chips",
        "and {C:mult}+#1#{} Mult",
        "when scored"
	}
}
]]
jokerLoc.nrmJkrs.j_business = {
	-- name = "Business Card"
	text = {
        "Played {C:attention}face{} cards have",
        "a {C:green}#1# in #2#{} chance to",
        "give {C:money}$2{} when scored",
		"{s:0.8,C:inactive}\"Let's see Paul Allen's card.\""
    }
}

--[[ Unsure what to do for Supernova.
jokerLoc.nrmJkrs.j_supernova, "name", "Supernova")
jokerLoc.nrmJkrs.j_supernova = {
	name = "Supernova",
	text = {
		"Adds the number of times",
        "{C:attention}poker hand{} has been",
        "played this run to Mult"
	}
}
]]

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('supernova', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_supernova')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_mr_bones = {
	name = "Excuses",
	text = {
        "Prevents Death",
        "if chips scored",
        "are at least {C:attention}25%",
        "of required chips",
        "{S:1.1,C:red,E:2}self destructs{}",
		"{s:0.8,C:inactive}Chat, it's the RNG, I",
		"{s:0.8,C:inactive}can't do anything if",
		"{s:0.8,C:inactive}the game doesn't give",
		"{s:0.8,C:inactive}me the cards I need."
    }
}

--[[
jokerLoc.nrmJkrs.j_seeing_double = {
	name = "Seeing Double",
	text = {
		"{X:mult,C:white} X#1# {} Mult if played",
        "hand has a scoring",
        "{C:clubs}Club{} card and a scoring",
        "card of any other {C:attention}suit"
	}
}]]

jokerLoc.nrmJkrs.j_duo = {
	-- name = "The Duo",
	text = {
		"{X:mult,C:white} X#1# {} Mult if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}2 max."
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('duo', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_duo')
			end
		end,
		
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
					{ x = 1, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = {
				card.ability.x_mult,
				localize(card.ability.type, 'poker_hands') },
			main_end = self.create_main_end() }
		end
	}, true)
end

--[[
jokerLoc.nrmJkrs.j_trio = {
	name = "The Trio",
	text = {
		"{X:mult,C:white} X#1# {} Mult if played",
        "hand contains",
        "a {C:attention}#2#"
	}
}
]]

jokerLoc.nrmJkrs.j_family = {
		-- name = "The Family"
	}
if CirnoMod.config['matureReferences_cyc'] >= 2 then
	if CirnoMod.config.allowCosmeticTakeOwnership then
		CirnoMod.miscItems.createABSwitchLatch('j_family', 0.15, 'A')
		
		jokerLoc.nrmJkrs.j_family.text = {
			"{X:mult,C:white} X#1# {} Mult if played",
			"hand contains",
			"a {C:attention}#2#",
			"{s:0.8,C:inactive}#3#",
			"{s:0.5,C:inactive}Search \"Cirno_TV Let me rephrase that\"",
			"{s:0.5,C:inactive}on YouTube to learn more!"
		}
		
		SMODS.Joker:take_ownership('family',
			{
				locAB = {
					A = "This is the nicest Joker.",
					B = "This is the incest Joker."
				},
				
				loc_vars = function(self, info_queue, card)				
					CirnoMod.miscItems.processSwitch('j_family')
					return {					
						vars = {
							card.ability.x_mult, localize(card.ability.type, 'poker_hands' ),
							self.locAB[CirnoMod.miscItems.switchTables['j_family'].AB]
						}
					}
				end
			},
		true)
	else
		jokerLoc.nrmJkrs.j_family.text = {
			"{X:mult,C:white} X#1# {} Mult if played",
			"hand contains",
			"a {C:attention}#2#",
			"{s:0.8,C:inactive}This is the nicest Joker.",
			"{s:0.5,C:inactive}Search \"Cirno_TV Let me rephrase that\"",
			"{s:0.5,C:inactive}on YouTube to learn more!"
		}
	end
else
	jokerLoc.nrmJkrs.j_family.text = {
        "{X:mult,C:white} X#1# {} Mult if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}...Should probably rephrase that.",
		"{s:0.5,C:inactive}Search \"Cirno_TV Let me rephrase that\"",
		"{s:0.5,C:inactive}on YouTube to learn more!"
    }
end

--[[
jokerLoc.nrmJkrs.j_order = {
	name = "The Order",
	text = {
		"{X:mult,C:white} X#1# {} Mult if played",
        "hand contains",
        "a {C:attention}#2#"
	}
}

jokerLoc.nrmJkrs.j_tribe = {
	name = "The Tribe",
	text = {
		"{X:mult,C:white} X#1# {} Mult if played",
        "hand contains",
        "a {C:attention}#2#"
	}
}]]


-- ===== NEXT LINE =====

--[[
jokerLoc.nrmJkrs.j_8_ball = {
	name = "9 Ball",
	text = {
		"{C:green}#1# in #2#{} chance for each",
        "played {C:attention}8{} to create a",
        "{C:tarot}Tarot{} card when scored",
        "{C:inactive}(Must have room)"
	}
}]]

jokerLoc.nrmJkrs.j_fibonacci = {
	name = "Why It's Called XBox 360",
	text = {
		"Each played {C:attention}Ace{},",
        "{C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{} gives",
        "{C:mult}+#1#{} Mult when scored",
		"{s:0.8,C:inactive}You turn 360 degrees and",
		"{s:0.8,C:inactive}walk away from the console."
	}
}

jokerLoc.nrmJkrs.j_stencil = {
	name = "The Enigma of Cirno's Many Faults",
	text = {
		"{X:red,C:white} X1 {} Mult for each empty {C:attention}Joker{} slot",
        "{s:0.8}(The Enigma of Cirno's Many Faults included)",
        "{C:inactive}(Currently {X:red,C:white} X#1# {C:inactive})",
		"{s:0.8,C:inactive}Do you see a slot that would fit the fairy?",
		"{s:0.8,C:inactive}That's right, it's the square hole!",
		"{s:0.8,C:inactive}...You know, do you think Junji Ito & the",
		"{s:0.8,C:inactive}Square Hole Guy are equivalent levels of",
		"{s:0.8,C:inactive}terrifying to the Square Hole Girl?",
		"{s:0.8,C:inactive}I realise that wording it like that is",
		"{s:0.8,C:inactive}weird, but like, how else do I put it?"
	}
}

--[[
jokerLoc.nrmJkrs.j_space = {
	name = "Space Joker",
	text = {
		"{C:green}#1# in #2#{} chance to",
        "upgrade level of",
        "played {C:attention}poker hand{}"
	}
}]]

jokerLoc.nrmJkrs.j_matador = {
	-- name = "Matador",
	text = {
		"Earn {C:money}$#1#{} if played",
        "hand triggers the",
        "{C:attention}Boss Blind{} ability",
		"{s:0.8,C:inactive}He's just standing there...",
		"{s:0.8,C:inactive}Menacingly."
	}
}

jokerLoc.nrmJkrs.j_ceremonial = {
	name = "Friendsword",
	text = {
		"When {C:attention}Blind{} is selected,",
        "destroy Joker to the right",
        "and permanently add {C:attention}double",
        "its sell value to this {C:red}Mult",
        "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
		"{s:0.8,C:inactive}In the old days, Cirno would",
		"{s:0.8,C:inactive}freely bestow these upon",
		"{s:0.8,C:inactive}people, with the hope that",
		"{s:0.8,C:inactive}they would stick around."
	}
}

jokerLoc.nrmJkrs.j_ring_master = {
	name = "CirGuns",
	text = {
        "{C:attention}Joker{}, {C:tarot}Tarot{}, {C:planet}"..planetIntent.."{},",
        "and {C:spectral}Spectral{} cards may",
        "appear multiple times",
		"{s:0.8,C:inactive}The last time I put cirGuns",
		"{s:0.8,C:inactive}in a game, Cirno gave me VIP",
		"{s:0.8,C:inactive}So clearly Twitch needs to",
		"{s:0.8,C:inactive}invent VIP 2 so Cirno can give",
		"{s:0.8,C:inactive}me that when he sees this.",
    }
}
if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('ring_master', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_ring_master')
			end
		end,
		
		create_main_end = function(card)
			local mainEndRV = {
				n = G.UIT.C,
				config = {
					align = 'bm',
					padding = 0.02
				},
				nodes = {}
			}			
			
			if
				card.edition
				and card.edition.key == 'e_negative'
			then
				CirnoMod.miscItems.cirGunsSpriteX = 1
			else
				CirnoMod.miscItems.cirGunsSpriteX = 0
			end
			
			CirnoMod.miscItems.addUISpriteNode(mainEndRV.nodes, Sprite(
					0, 0, -- Sprite X & Y
					1.0, 1.3, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.cirGuns, -- Sprite Atlas
					{ x = CirnoMod.miscItems.cirGunsSpriteX, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = CirnoMod.miscItems.descExtensionTooltips['eDT_cir_cirGuns']
			
			return { main_end = self.create_main_end(card) }
		end
	}, true)
else
	table.insert(jokerLoc.nrmJkrs.j_ring_master.text, "{s:0.8,C:inactive}Ka-chow!")
end

--[[
jokerLoc.nrmJkrs.j_fortune_teller = {
	name = "Fortune Teller",
	text = {
		"{C:red}+#1#{} Mult per {C:purple}Tarot{}",
        "card used this run",
        "{C:inactive}(Currently {C:red}+#2#{C:inactive})"
	}
}
]]

jokerLoc.nrmJkrs.j_hit_the_road = {
	-- name = "Hit The Road",
	text = {
        "This Joker gains {X:mult,C:white} X#1# {} Mult",
        "for every {C:attention}Jack{}",
        "discarded this round",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}Just constantly jumping down that",
		"{s:0.8,C:inactive}insanely long stretch of road...",
		"{s:0.8,C:inactive}Should've taken a bus, honestly."
    }
}

jokerLoc.nrmJkrs.j_swashbuckler = {
	name = "Pirate Majima",
	text = {
        "Adds the sell value",
        "of all other owned",
        "{C:attention}Jokers{} to Mult",
        "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
		"{s:0.8,C:inactive}\"KIRYU-CHAAAAAAN!\""
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('swashbuckler', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_swashbuckler')
			end
		end
	}, true)
end


-- ===== NEXT LINE =====


--[[
jokerLoc.nrmJkrs.j_flower_pot = {
	name = "Flower Pot",
	text = {
		"{X:mult,C:white} X#1# {} Mult if poker",
        "hand contains a",
        "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
        "{C:hearts}Heart{} card, and {C:spades}Spade{} card"
	}
}]]

jokerLoc.nrmJkrs.j_ride_the_bus = {
	name = "Toho Bus",
	text = {
		"This Joker gains {C:mult}+#1#{} Mult",
        "per {C:attention}consecutive{} hand played",
        "without a scoring {C:attention}face{} card",
        "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
		"{s:0.8,C:inactive}If a bus leaves the Scarlet Devil Mansion",
		"{s:0.8,C:inactive}with three people on board, one gets off",
		"{s:0.8,C:inactive}and half a person boards at Hakugyokurou,",
		"{s:0.8,C:inactive}then two people get off at Yakumo House,",
		"{s:0.8,C:inactive}how many passengers are there left on the bus?",
		"{s:0.45,C:inactive}A: 0. There are no buses in Gensokyo."
	}
}

jokerLoc.nrmJkrs.j_shoot_the_moon = {
	-- name = "Shoot The Moon",
	text = {
		"Each {C:attention}Queen{}",
        "held in hand",
        "gives {C:mult}+#1#{} Mult",
		"{s:0.8,C:inactive}...You can't just shoot a hole",
		"{s:0.8,C:inactive}into the surface of Mars."
	}
}

jokerLoc.nrmJkrs.j_smeared = {
	name = "Struggling Joker",
	text = {
		"{C:hearts}Hearts{} and {C:diamonds}Diamonds",
        "count as the same suit,",
        "{C:spades}Spades{} and {C:clubs}Clubs",
        "count as the same suit",
		"{s:0.8,C:inactive}HHHHHHH ANXIETYYYYYYYYYYY"
	}
}

jokerLoc.nrmJkrs.j_oops = {
	-- name = "Oops! All 6s",
	text = {
		"Doubles all {C:attention}listed",
        "{C:green,E:1,S:1.1}probabilities",
        "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}2 in 3{C:inactive})",
		"{s:0.8,C:inactive}Let's go gambling!!!1"
	}
}

jokerLoc.nrmJkrs.j_four_fingers = {
	name = "Four Panels",
	text = {
		"All {C:attention}Flushes{} and",
        "{C:attention}Straights{} can be",
        "made with {C:attention}4{} cards",
		"{s:0.8,C:inactive}Do I look like I know",
		"{s:0.8,C:inactive}what a .jpg is?",
		"{s:0.8,C:inactive}I just want a picture of",
		"{s:0.8,C:inactive}a god-dang hotdog."
	}
}

jokerLoc.nrmJkrs.j_gros_michel = {
	name = "CirLami",
	text = {
		"{C:mult}+#1#{} Mult",
        "{C:green}#2# in #3#{} chance this",
        "card is destroyed",
        "at end of round",
		"{s:0.8,C:inactive}A lesson for the ages:",
		"{s:0.8,C:inactive}Microwaving salami =",
		"{s:0.8,C:inactive}very, very greasy."
	}
}

--[[
if CirnoMod.config['matureReferences_cyc'] == 3 then
	table.insert(jokerLoc.nrmJkrs.j_gros_michel.text,
		"{s:0.8,C:inactive}But why is it so... Meaty?")
else
	table.insert(jokerLoc.nrmJkrs.j_gros_michel.text,
		"{s:0.8,C:inactive}Sometimes, chat will just")
		
	table.insert(jokerLoc.nrmJkrs.j_gros_michel.text,
		"{s:0.8,C:inactive}latch onto something they")
		
	table.insert(jokerLoc.nrmJkrs.j_gros_michel.text,
		"{s:0.8,C:inactive}find funny and it sticks.")
end

if CirnoMod.config.allowCosmeticTakeOwnership then	
	SMODS.Joker:take_ownership('gros_michel', {
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
					{ x = 2, y = 1 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = {
				card.ability.extra.mult,
				''..(G.GAME and G.GAME.probabilities.normal or 1),
				card.ability.extra.odds },
			main_end = self.create_main_end() }
		end
	}, true)
end]]

jokerLoc.nrmJkrs.j_stuntman = {
	name = "HelmetGuns",
	text = {
        "{C:chips}+#1#{} Chips,",
        "{C:attention}-#2#{} hand size",
		"{s:0.8,C:inactive}It may be his only",
		"{s:0.8,C:inactive}trick, but honestly",
		"{s:0.8,C:inactive}if it ain't broke..."
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('stuntman', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_stuntman')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_hanging_chad = {
	name = "Tied Poll",
	text = {
        "Retrigger {C:attention}first{} played",
        "card used in scoring",
        "{C:attention}#1#{} additional times",
		"{s:0.8,C:inactive}STRIMMER, WE VOTED FOR",
		"{s:0.8,C:inactive}ALL THE THINGS, NOW DO",
		"{s:0.8,C:inactive}ALL OF THEM AT THE SAME",
		"{s:0.8,C:inactive}TIME!!!111"
    }
}


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_drivers_license = {
	name = "Multipass",
	text = {
        "{X:mult,C:white} X#1# {} Mult if you have",
        "at least {C:attention}16{} Enhanced",
        "cards in your full deck",
        "{C:inactive}(Currently {C:attention}#2#{C:inactive})",
        "{s:0.8,C:inactive}Hi! Lea!"
    }
}

jokerLoc.nrmJkrs.j_invisible = {
	name = "Impossible Crossword",
	text = {
        "After {C:attention}#1#{} rounds, sell this",
        "card to {C:attention}Duplicate{} a random",
        "{C:joker}Joker{}. {C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
        "{s:0.8,C:inactive}Stop stalling, Cirno."
    }
}

jokerLoc.nrmJkrs.j_astronomer = {
	name = "Marisa Kirisame",
	text = {
        "All {C:planet}"..planetIntent.."{} cards and {C:planet}"..string.sub(planetPackIntent, 1, #planetPackIntent - 5),
        "{C:planet}Packs{} in the shop are {C:attention}free",
        "{s:0.8,C:inactive}\"It's bad of me to keep borrowing",
        "{s:0.8,C:inactive}books, so I'll put my book here at the",
        "{s:0.8,C:inactive}library this time!\" Narrator: She left",
        "{s:0.8,C:inactive}with 5 additional books under her arm."
    },
	unlock = {
        "Discover every",
        "{E:1,C:planet}"..planetIntent.."{} card",
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('astronomer', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_astronomer')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_burnt = {
	name = "Flandre Scarlet",
	text = {
        "Upgrade the level of",
        "the first {C:attention}discarded",
        "poker hand each round",
		"{s:0.8,C:inactive}Can someone explain to",
		"{s:0.8,C:inactive}me why United Nations Owen",
		"{s:0.8,C:inactive}is setting fire to the cards?"
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('burnt', {
		set_badges = function(self, card, badges)
			CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_burnt')
		end
	}, true)
end

jokerLoc.nrmJkrs.j_dusk = {
	name = "The Duskbloods",
	text = {
		"Retrigger all played cards in {C:attention}final hand{} of round",
		"{s:0.8,C:inactive}The vibe of this game sure {s:0.8,C:cirInactiveAtt}Elden Rings{s:0.8,C:inactive} a bell.",
		"{s:0.8,C:inactive}It takes a {s:0.8,C:cirInactiveAtt}Demon's Soul{s:0.8,C:inactive} to announce it as a Switch 2 exclusive.",
		"{s:0.8,C:inactive}In those who once claimed their {s:0.8,C:cirInactiveAtt}Cores Armoured{s:0.8,C:inactive},",
		"{s:0.8,C:inactive}I sense great lamentation and boiling {s:0.8,C:cirInactiveAtt}Blood{s:0.8,C:inactive}, {s:0.8,C:cirInactiveAtt}borne",
		"{s:0.8,C:inactive}from sheer frustration at how tone-deaf this affair seems to",
		"{s:0.8,C:inactive}them. Oh, these {s:0.8,C:cirInactiveAtt}Dark-ened Souls{s:0.8,C:inactive} and deeply {s:0.8,C:cirInactiveAtt}Seki-furrowed{s:0.8,C:inactive} brows!",
		"{s:0.8,C:inactive}We'll be having a {s:0.8,C:cirInactiveAtt}King's Field{s:0.8,C:inactive} day."
	}
}

jokerLoc.nrmJkrs.j_throwback = {
	-- name = "Throwback",
	text = {
        "{X:mult,C:white} X#1# {} Mult for each",
        "{C:attention}Blind{} skipped this run",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        "{s:0.8,C:inactive}\"...What are you talking",
        "{s:0.8,C:inactive}about, what Bing search?!",
        "{s:0.8,C:inactive}Do I have a virus?!?!?!\""
    }
}

jokerLoc.nrmJkrs.j_idol = {
	-- name = "The Idol",
	text = {
        "Each played {C:attention}#2#",
        "of {V:1}#3#{} gives",
        "{X:mult,C:white} X#1# {} Mult when scored",
        "{s:0.8}Card changes every round",
        "{s:0.8,C:inactive}I saw Hatsune Miku at a grocery",
        "{s:0.8,C:inactive}store in Akihabara yesterday."
    }
}

jokerLoc.nrmJkrs.j_brainstorm = {
	-- name = "Brainstorm",
	text = {
		"Copies the ability",
		"of leftmost {C:attention}Joker",
        "{s:0.8,C:inactive}...The shape...",
        "{s:0.8,C:inactive}...Taking shape.",
        "{s:0.8,C:inactive}Vaguely friend shaped.",
        "{s:0.5,C:inactive}...No, that's not quite right."
	}
}

--[[ Malverk does not do the thing if it is not set to replace that key.
jokerLoc.nrmJkrs.j_satellite = {
	-- name = "Satelilte",
	text = {
        "Earn {C:money}$#1#{} at end of",
        "round per unique {C:planet}"..planetIntent,
        "card used this run",
        "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
    }
}]]

SMODS.process_loc_text(G.localization.descriptions.Joker.j_satellite, "text", {
        "Earn {C:money}$#1#{} at end of",
        "round per unique {C:planet}"..planetIntent,
        "card used this run",
        "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
    })

jokerLoc.nrmJkrs.j_rough_gem = {
	name = "Diamond In The Rough",
	text = {
		"Played cards with",
        "{C:diamonds}Diamond{} suit earn",
        "{C:money}$#1#{} when scored",
        "{s:0.8,C:inactive}Have you heard of the critically",
        "{s:0.8,C:inactive}acclaimed MMORPG {s:0.8,C:cirInactiveAtt}Final Fantasy XIV{s:0.8,C:inactive}?",
        "{s:0.8,C:inactive}With an {s:0.8,C:cirInactiveAtt}expanded free trial{s:0.8,C:inactive} which",
        "{s:0.8,C:inactive}you can play through the {s:0.8,C:cirInactiveAtt}entirety",
        "{s:0.8,C:inactive}of {s:0.8,C:cirInactiveAtt}A Realm Reborn{s:0.8,C:inactive}, the {s:0.8,C:cirInactiveAtt}award-winning",
        "{s:0.8,C:inactive}expansion {s:0.8,C:cirInactiveAtt}Heavensward{s:0.8,C:inactive}, and also the",
        "{s:0.8,C:cirInactiveAtt}award-winning{s:0.8,C:inactive} expansion {s:0.8,C:cirInactiveAtt}Stormblood{s:0.8,C:inactive},",
        "{s:0.8,C:inactive}up to {s:0.8,C:cirInactiveAtt}level 70{s:0.8,C:inactive} for {s:0.8,C:cirInactiveAtt}free{s:0.8,C:inactive}, with {s:0.8,C:cirInactiveAtt}no",
        "{s:0.8,C:cirInactiveAtt}restrictions{s:0.8,C:inactive} on playtime."
	}
}


-- ===== NEXT LINE =====


--[[
jokerLoc.nrmJkrs.j_bloodstone = {
	name = "Bloodstone",
	text = {
		"Played cards with",
        "{C:diamonds}Diamond{} suit earn",
        "{C:money}$#1#{} when scored"
	}

jokerLoc.nrmJkrs.j_arrowhead = {
	name = "Arrowhead",
	text = {
		"Played cards with",
        "{C:spades}Spade{} suit give",
        "{C:chips}+#1#{} Chips when scored"
	}]]

jokerLoc.nrmJkrs.j_onyx_agate = {
	name = "Demon Core",
	text = {
		"Played cards with",
        "{C:clubs}Club{} suit give",
        "{C:mult}+#1#{} Mult when scored",
		"{s:0.8,C:inactive}Top 10 wacky things you",
		"{s:0.8,C:inactive}can do with a plutonium",
		"{s:0.8,C:inactive}core & two beryllium half-spheres"
	}
}

jokerLoc.lgndJkrs.j_caino = {
	name = "Girl_DM_",
	text = {
		"This Joker gains {X:mult,C:white} X#1# {} Mult",
        "when a {C:attention}face{} card",
        "is destroyed",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}All of your face (cards) are",
		"{s:0.8,C:inactive}hers. You will not get them back."
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('caino', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_caino')
			end
		end
	}, true)
end

jokerLoc.lgndJkrs.j_triboulet = { name = "HannahHyrule" }
if CirnoMod.config['matureReferences_cyc'] == 3 then
	jokerLoc.lgndJkrs.j_triboulet.text = {
		"Played {C:attention}Kings{} and",
		"{C:attention}Queens{} each give",
		"{X:mult,C:white} X#1# {} Mult when scored",
		"{s:0.8,C:inactive}Wow look Chat, Cirno finally",
		"{s:0.8,C:inactive}added the Big Naturals mod."
	}
else
	jokerLoc.lgndJkrs.j_triboulet.text = {
		"Played {C:attention}Kings{} and",
		"{C:attention}Queens{} each give",
		"{X:mult,C:white} X#1# {} Mult when scored",
		"{s:0.8,C:inactive}Hannah has a large, fearsome",
		"{s:0.8,C:inactive}& awesome pirate armada, with",
		"{s:0.8,C:inactive}a big galleon & a couple of",
		"{s:0.8,C:inactive}big pirate airships."
	}
end

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('triboulet', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_triboulet')
			end
		end
	}, true)
end

jokerLoc.lgndJkrs.j_yorick = { name = "ThorW" }
if CirnoMod.config['matureReferences_cyc'] >= 2 then
	jokerLoc.lgndJkrs.j_yorick.text = {
		"This Joker gains",
		"{X:mult,C:white} X#1# {} Mult every {C:attention}#2#{C:inactive} [#3#]{}",
		"cards discarded",
		"{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)",
		"{s:0.8,C:inactive}\"It's James from Pokemon!",
		"{s:0.8,C:inactive}In that one episode!\""
	}
else
	jokerLoc.lgndJkrs.j_yorick.text = {
		"This Joker gains",
		"{X:mult,C:white} X#1# {} Mult every {C:attention}#2#{C:inactive} [#3#]{}",
		"cards discarded",
		"{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)",
		"{s:0.8,C:inactive}...I think he found pickles."
	}
end

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('yorick', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_yorick')
			end
		end,
		
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
					{ x = 4, y = 1 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = {
				card.ability.extra.xmult,
				card.ability.extra.discards,
				card.ability.yorick_discards,
				card.ability.x_mult },
			main_end = self.create_main_end() }
		end
	}, true)
end

jokerLoc.lgndJkrs.j_chicot = { name = "ReimMomo" }

if CirnoMod.config.allowCosmeticTakeOwnership then
	jokerLoc.lgndJkrs.j_chicot.text = {
		"Disables effect of",
        "every {C:attention}Boss Blind",
		"{s:0.8,C:inactive}@Samses__"
	}
	
	SMODS.Joker:take_ownership('chicot', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_chicot')
			end
		end,
		
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
					{ x = 4, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { main_end = self.create_main_end() }
		end
	}, true)
else
	jokerLoc.lgndJkrs.j_chicot.text = {
		"Disables effect of",
        "every {C:attention}Boss Blind",
		"{s:0.8,C:inactive}@Samses__ cirPoint"
	}
end

jokerLoc.lgndJkrs.j_perkeo = {
	name = "Biggdeck",
	text = {
		"Creates a {C:dark_edition}Negative{} copy of",
		"{C:attention}1{} random {C:attention}consumable{}",
		"card in your possession",
		"at the end of the {C:attention}shop",
		"{s:0.8,C:inactive}Y'know, there's something",
		"{s:0.8,C:inactive}almost intoxicating about",
		"{s:0.8,C:inactive}drinking fifteen beers."
	}
}

jokerLoc.nrmJkrs.j_certificate = {
	name = "Empty Scroll",
	text = {
        "When round begins,",
        "add a random {C:attention}playing",
        "{C:attention}card{} with a random",
        "{C:attention}seal{} to your hand",
		"{s:0.8,C:inactive}O LORD",
		"{s:0.8,C:inactive}GIVE",
		"{s:0.8,C:inactive}GOOD RNGz"
    }
}


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_egg = {
	-- name = "Egg",
	text = {
        "Gains {C:money}$#1#{} of",
        "{C:attention}sell value{} at",
        "end of round",
		"{s:0.8,C:inactive}...What's wrong?"
    }
}

jokerLoc.nrmJkrs.j_burglar = {
	name = "CirThief",
	text = {
		"When {C:attention}Blind{} is selected,",
		"gain {C:blue}+#1#{} Hands and",
		"{C:attention}lose all discards",
		"{s:0.8,C:inactive}cirnoStealsUrJades"
	}
}

jokerLoc.nrmJkrs.j_blackboard = {
	name = "Perfect Maths",
	text = {
		"{X:red,C:white} X#1# {} Mult if all",
        "cards held in hand",
        "are {C:spades}#2#{} or {C:clubs}#3#{}",
		"{s:0.8,C:inactive}\"4?! 4... {s:0.5,C:inactive}THAT WAS WRONG!\""
	}
}

jokerLoc.nrmJkrs.j_runner = { name = "Speedrunner" }

if CirnoMod.config.allowCosmeticTakeOwnership then
	jokerLoc.nrmJkrs.j_runner.text = {
        "Gains {C:chips}+#2#{} Chips",
        "if played hand",
        "contains a {C:attention}Straight{}",
        "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
		"{s:0.8,C:inactive}#3#"
    }
	
	SMODS.Joker:take_ownership('runner', {
		loc_vars = function(self, info_queue, card)			
			if
				card.edition
				and card.edition.key == 'e_polychrome'
			then
				return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, "Rainbow splits, PB inbound!" } }
			elseif
				card.edition
				and card.edition.key == 'e_negative'
			then
				return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, "All gold splits!" } }
			else
				return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, "Keep going, you're at PB pace." } }
			end
		end
	}, true)
else
	jokerLoc.nrmJkrs.j_runner.text = {
        "Gains {C:chips}+#2#{} Chips",
        "if played hand",
        "contains a {C:attention}Straight{}",
        "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
		"{s:0.8,C:inactive}Keep going, you're at PB pace."
    }
end

jokerLoc.nrmJkrs.j_ice_cream = {
	name = "Matcha Ice Cream",
	text = {
		"{C:chips}+#1#{} Chips",
        "{C:chips}-#2#{} Chips for",
        "every hand played",
        "{s:0.8,C:inactive}\"Wait, you just T1'd\""
	}
}

jokerLoc.nrmJkrs.j_dna = { text = {
        "If {C:attention}first hand{} of round",
        "has only {C:attention}1{} card, add a",
        "permanent copy to deck",
        "and draw it to {C:attention}hand",
		"{s:0.8,C:inactive}At Twitch Inc, we strive to foster",
		"{s:0.8,C:inactive}a healthy & safe community. Click",
		"{s:0.8,C:blue}here {s:0.8,C:inactive}to learn more about our policy",
		"{s:0.8,C:inactive}on VTuber hips and why you need to",
		"{s:0.8,C:inactive}be protected from them.",
    }
}
if CirnoMod.config['matureReferences_cyc'] >= 2 then
	jokerLoc.nrmJkrs.j_dna.name = "\"DNA\""
end

--[[
jokerLoc.nrmJkrs.j_splash = {
	name = "Splash",
	text = {
		"Every {C:attention}played card",
        "counts in scoring"
	}
}

jokerLoc.nrmJkrs.j_blue_joker = {
	name = "Blue Joker",
	text = {
		"{C:chips}+#1#{} Chips for each",
        "remaining card in {C:attention}deck",
        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
	}
}
]]

jokerLoc.nrmJkrs.j_sixth_sense = {
	-- name = "Sixth Sense",
	text = {
		"If {C:attention}first hand{} of round is",
        "a single {C:attention}6{}, destroy it and",
        "create a {C:spectral}Spectral{} card",
        "{C:inactive}(Must have room)",
		"{s:0.8,C:inactive}We're watching."
	}
}

--[[ Malverk does not do the thing if it is not set to replace that key.
jokerLoc.nrmJkrs.j_constellation = {
	-- name = "Constellation",
	text = {
        "This Joker gains",
		"{X:mult,C:white} X#1# {} Mult every time",
		"a {C:planet}"..planetIntent.."{} card is used",
		"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
    }
}]]

SMODS.process_loc_text(G.localization.descriptions.Joker.j_constellation, "text", {
        "This Joker gains",
		"{X:mult,C:white} X#1# {} Mult every time",
		"a {C:planet}"..planetIntent.."{} card is used",
		"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
    })


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_hiker = {
	name = "Hoiker",
	text = {
		"Every played {C:attention}card{}",
		"permanently gains",
		"{C:chips}+#1#{} Chips when scored",
		"{s:0.8,C:inactive}HOIK!"
	}
}

jokerLoc.nrmJkrs.j_faceless = {
	name = "",
	text = {
		"Earn {C:money}$#1#{} if {C:attention}#2#{} or",
        "more {C:attention}face cards{}",
        "are discarded",
        "at the same time",
		"{s:0.8,C:inactive}For joking."
	}
}

jokerLoc.nrmJkrs.j_green_joker = {
	name = "4chan",
	text = {
		"{C:mult}+#1#{} Mult per hand played",
        "{C:mult}-#2#{} Mult per discard",
        "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
		"{s:0.8,C:inactive}apology for poor english",
		"{s:0.8,C:inactive}when were you when green clover site dies",
		"{s:0.8,C:inactive}i was sat at home drinking when fred ring",
		"{s:0.8,C:inactive}'4chan is kill'",
		"{s:0.8,C:inactive}'no'",
		"{s:0.8,C:inactive}and you?????????????????",
		"{s:0.5,C:inactive}I'm sorry '-'",
		"{s:0.5,C:inactive}In my defence, this reskin was not my idea."
	}
}
--[[
jokerLoc.nrmJkrs.j_superposition = {
	name = "Superposition",
	text = {
		"Create a {C:tarot}Tarot{} card if",
        "poker hand contains an",
        "{C:attention}Ace{} and a {C:attention}Straight{}",
        "{C:inactive}(Must have room)"
	}
}
]]

jokerLoc.nrmJkrs.j_todo_list = {
	name = "Sub Goals",
	text = {
		"Earn {C:money}$#1#{} if {C:attention}poker hand{}",
		"is a {C:attention}#2#{},",
		"poker hand changes",
		"at end of round"
	}
}

if CirnoMod.config['matureReferences_cyc'] == 3 then
	table.insert(jokerLoc.nrmJkrs.j_todo_list.text,
		"{s:0.8,C:inactive}So what's the over/under")
		
	table.insert(jokerLoc.nrmJkrs.j_todo_list.text,
		"{s:0.8,C:inactive}on most of Cirno's")
	
	table.insert(jokerLoc.nrmJkrs.j_todo_list.text,
		"{s:0.8,C:inactive}Koikatsu girls being tan")
	
	table.insert(jokerLoc.nrmJkrs.j_todo_list.text,
		"{s:0.8,C:inactive}with pink hair?")
	
	if CirnoMod.config.allowCosmeticTakeOwnership then
		SMODS.Joker:take_ownership('todo_list', {
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
						{ x = 1, y = 1 } -- Position in the Atlas
					)
				)
				
				return { mainEndRV }
			end,
			
			loc_vars = function(self, info_queue, card)
				return {
					vars = {
						card.ability.extra.dollars,
						localize(card.ability.to_do_poker_hand, 'poker_hands')
					},
					main_end = self.create_main_end()
				}
			end
		}, true)
	end
else
	table.insert(jokerLoc.nrmJkrs.j_todo_list.text,
		"{s:0.8,C:inactive}JOKE BOAT! JOKE BOAT!")
end

jokerLoc.nrmJkrs.j_cavendish = {
	-- name = "Cavendish",
	text = {
        "{X:mult,C:white} X#1# {} Mult",
        "{C:green}#2# in #3#{} chance this",
        "card is destroyed",
        "at end of round",
		"{s:0.8,C:inactive}OHHHH BANANA!"
    }
}

--[[
jokerLoc.nrmJkrs.j_card_sharp = {
	name = "Card Sharp",
	text = {
		"{X:mult,C:white} X#1# {} Mult if played",
        "{C:attention}poker hand{} has already",
        "been played this round"
	}
}
]]
jokerLoc.nrmJkrs.j_red_card = {
	name = "Principal of the Thing",
	text = {
		"This Joker gains",
        "{C:red}+#1#{} Mult when any",
        "{C:attention}Booster Pack{} is skipped",
        "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
		"{s:0.8,C:inactive}\"No running in the halls.\""
	}
}
--[[
jokerLoc.nrmJkrs.j_madness = {
	name = "Madness",
	text = {
		"When {C:attention}Small Blind{} or {C:attention}Big Blind{}",
        "is selected, gain {X:mult,C:white} X#1# {} Mult",
        "and {C:attention}destroy{} a random Joker",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
	}
}
]]

jokerLoc.nrmJkrs.j_square = {
	-- name = "Square Joker",
	text = {
        "This Joker gains {C:chips}+#2#{} Chips",
        "if played hand has",
        "exactly {C:attention}4{} cards",
        "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)",
		"{s:0.8,C:inactive}Squares, famously six-sided."
    }
}


-- ===== NEXT LINE =====


--[[
jokerLoc.nrmJkrs.j_seance = {
	name = "Séance",
	text = {
		"If {C:attention}poker hand{} is a",
        "{C:attention}#1#{}, create a",
        "random {C:spectral}Spectral{} card",
        "{C:inactive}(Must have room)"
	}
}
]]

jokerLoc.nrmJkrs.j_riff_raff = { name = "Twitch Chat" }
if CirnoMod.config['matureReferences_cyc'] == 3 then
	jokerLoc.nrmJkrs.j_riff_raff.text = {
		"When {C:attention}Blind{} is selected,",
		"create {C:attention}#1# {C:blue}Common{C:attention} Jokers",
		"{C:inactive}(Must have room)",
		"{s:0.8,C:inactive}\"Barking doesn't make me a",
		"{s:0.8,C:inactive}furry, all the furry porn I",
		"{s:0.8,C:inactive}have makes me a furry.\""
	}
else
	jokerLoc.nrmJkrs.j_riff_raff.text = {
        "When {C:attention}Blind{} is selected,",
        "create {C:attention}#1# {C:blue}Common{C:attention} Jokers",
        "{C:inactive}(Must have room)",
		"{s:0.8,C:inactive}Yeah, Chat just does that."
	}
end

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('riff_raff', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_riff_raff', jokerLoc.nrmJkrs.j_bootstraps.name)
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_vampire = {
	name = "Remilia Scarlet",
	text = {
        "This Joker gains {X:mult,C:white} X#1# {} Mult",
        "per scoring {C:attention}Enhanced card{} played,",
        "removes card {C:attention}Enhancement",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}\"Fairies really are completely useless.\""
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('vampire', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_vampire')
			end
		end
	}, true)
end

--[[
jokerLoc.nrmJkrs.j_shortcut = {
	name = "Shortcut",
	text = {
		"Allows {C:attention}Straights{} to be",
        "made with gaps of {C:attention}1 rank",
        "{C:inactive}(ex: {C:attention}10 8 6 5 3{C:inactive})"
	}
}]]

jokerLoc.lgndJkrs.j_hologram = {
	name = "\"Hologram\"",
	text = {
		"This Joker gains {X:mult,C:white} X#1# {} Mult",
        "every time a {C:attention}playing card{}",
        "is added to your deck",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}I flew all this way to see the famous Miku",
		"{s:0.8,C:inactive}hologram concert and not only was it just a",
		"{s:0.8,C:inactive}flatscreen TV, but I got removed from the",
		"{s:0.8,C:inactive}venue for bringing a raw leek.",
		"{s:0.8,C:inactive}Hundreds of dollars, wasted."
	}
}

jokerLoc.nrmJkrs.j_vagabond = {
	name = "Figurine Collector",
	text = {
		"Create a {C:tarot}Tarot{} card",
        "if hand is played",
        "with {C:money}$#1#{} or less",
		"{s:0.8,C:inactive}Your wallet may be empty,",
		"{s:0.8,C:inactive}but at least your heart's full."
	}
}

jokerLoc.nrmJkrs.j_baron = {
	name = "Gigachad",
	text = {
        "Each {C:attention}King{}",
        "held in hand",
        "gives {X:mult,C:white} X#1# {} Mult",
		"{s:0.8,C:inactive}You dropped your crown, king."
    }
}

jokerLoc.nrmJkrs.j_cloud_9 = {
	-- name = "Cloud 9",
	text = {
        "Earn {C:money}$#1#{} for each",
        "{C:attention}9{} in your {C:attention}full deck",
        "at end of round",
        "{C:inactive}(Currently {C:money}$#2#{}{C:inactive})",
		"{s:0.8,C:inactive}Crazy to think the whole 9",
		"{s:0.8,C:inactive}thing started with the PoFV",
		"{s:0.8,C:inactive}instruction manual."
    }
}

--[[
jokerLoc.nrmJkrs.j_rocket = {
	name = "Rocket",
	text = {
		"Earn {C:money}$#1#{} at end of round",
        "Payout increases by {C:money}$#2#{}",
        "when {C:attention}Boss Blind{} is defeated"
	}
}]]

jokerLoc.nrmJkrs.j_obelisk = {
	name = "The Greyhill Incident",
	text = {
		"This Joker gains {X:mult,C:white} X#1# {} Mult",
        "per {C:attention}consecutive{} hand played",
        "without playing your",
        "most played {C:attention}poker hand",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}Here's a bat and a gun.",
		"{s:0.8,C:inactive}They look like they help, but",
		"{s:0.8,C:inactive}they really don't. It just knocks",
		"{s:0.8,C:inactive}Ol' Gnorts Mr. Alien to the floor",
		"{s:0.8,C:inactive}for a few seconds, then he's back",
		"{s:0.8,C:inactive}choking you again. ...What were we doing?"
	}
}


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_midas_mask = {
	name = "Dagoth Ur",
	text = {
		"All played {C:attention}face{} cards",
        "become {C:attention}"..goldIntent.."{} cards",
        "when scored",
		"{s:0.8,C:inactive}\"Welcome, Moon-and-Star, to",
		"{s:0.8,C:inactive}this place where {s:0.8,C:inactive}YOUR{s:0.8,C:inactive} destiny",
		"{s:0.8,C:inactive}is made. Dagoth Ur weclomes you",
		"{s:0.8,C:inactive}Nerevar, my old friend. Come to",
		"{s:0.8,C:inactive}the Heart Chamber.\""
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('midas_mask', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_midas_mask')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_luchador = {
	name = "Chicken Jockey",
	text = {
		"Sell this card to",
        "disable the current",
        "{C:attention}Boss Blind{}",
		"{s:0.8,C:inactive}I want to be perfectly",
		"{s:0.8,C:inactive}clear that this was not",
		"{s:0.8,C:inactive}my idea."
	}
}

jokerLoc.nrmJkrs.j_photograph = {
	name = "CirMing",
	text = {
		"First played {C:attention}face",
        "card gives {X:mult,C:white} X#1# {} Mult",
        "when scored",
		"{s:0.8,C:inactive}Look at this photograph.",
		"{s:0.8,C:inactive}Every time I do,",
		"{s:0.8,C:inactive}it makes me laugh."
	}
}
--[[
jokerLoc.nrmJkrs.j_gift = {
	name = "Gift Card",
	text = {
		"Add {C:money}$#1#{} of {C:attention}sell value",
        "to every {C:attention}Joker{} and",
        "{C:attention}Consumable{} card at",
        "end of round"
	}
}]]

jokerLoc.nrmJkrs.j_turtle_bean = {
	name = "Talus Dome",
	--[[text = {
		"{C:attention}+#1#{} hand size,",
        "reduces by",
        "{C:red}#2#{} every round"
	}]]
}
if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('turtle_bean', {
		create_main_end = function()
			local mainEndRV = {
				n = G.UIT.C,
				config = {
					align = 'bm',
					padding = 0.02
				},
				nodes = {}
			}
			
			CirnoMod.miscItems.addUITextNode(mainEndRV.nodes, "Edmonton. ", G.C.UI.TEXT_INACTIVE, 0.8)
			
			CirnoMod.miscItems.addUISpriteNode(mainEndRV.nodes, Sprite(
					0, 0, -- Sprite X & Y
					0.35, 0.2, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.canadaFlag, -- Sprite Atlas
					{ x = 0, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.h_size,
					card.ability.extra.h_mod
				},
				main_end = self.create_main_end()
			}
		end
	}, true)
end

jokerLoc.nrmJkrs.j_erosion = {
	name = "Gingerbread House",
	text = {
		"{C:red}+#1#{} Mult for each",
        "card below {C:attention}#3#{}",
        "in your full deck",
        "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
		"{s:0.8,C:inactive}When you're in a falling apart",
		"{s:0.8,C:inactive}competition and your opponent is",
		"{s:0.8,C:inactive}a gingerbread house built by Cirno."
	}
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('erosion', {
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
					{ x = 0, y = 1 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra,
					math.max(0,card.ability.extra*(G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0)),
					G.GAME.starting_deck_size
				},
				main_end = self.create_main_end()
			}
		end
	}, true)
end

jokerLoc.nrmJkrs.j_reserved_parking = {
	-- name = "Reserved Parking",
	text = {
		"Each {C:attention}face{} card",
        "held in hand has",
        "a {C:green}#2# in #3#{} chance",
        "to give {C:money}$#1#{}",
		"{s:0.8,C:inactive}Who be out here taking shots",
		"{s:0.8,C:inactive}of the Mikumobile?"
	}
}

jokerLoc.nrmJkrs.j_mail = {
	name = "Idolmaster Gacha",
	text = {
        "Earn {C:money}$#1#{} for each",
        "discarded {C:attention}#2#{}, rank",
        "changes every round",
		"{s:0.8,C:inactive}Over 90% of gacha players",
		"{s:0.8,C:inactive}stop pulling right before",
		"{s:0.8,C:inactive}they pull who they're after."
    }
}

--[[
jokerLoc.nrmJkrs.j_to_the_moon = {
	name = "To The Moon",
	text = {
		"Earn an extra {C:money}$#1#{} of",
        "{C:attention}interest{} for every {C:money}$5{} you",
        "have at end of round"
	}
}
]]

jokerLoc.nrmJkrs.j_hallucination = {
	name = "Imaginary Anomaly",
	text = {
        "{C:green}#1# in #2#{} chance to create",
        "a {C:tarot}Tarot{} card when any",
        "{C:attention}Booster Pack{} is opened",
        "{C:inactive}(Must have room)",
		"{s:0.8,C:inactive}...Chat? Was that doorframe",
		"{s:0.8,C:inactive}always dark? There's no way,",
		"{s:0.8,C:inactive}right?"
    }
}


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_sly = {
	name = "Sly Purple Heart",
    text={
        "{C:chips}+#1#{} Chips if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}\"What do ya think I'm",
		"{s:0.8,C:inactive}made of, puddin'?\""
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('sly', {		
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_sly')
			end
		end,
		
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
					{ x = 1, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = {
				card.ability.t_chips,
				localize(card.ability.type, 'poker_hands') },
			main_end = self.create_main_end() }
		end
	}, true)
end

local wilyTakeOwnershipTable = {
	set_badges = function(self, card, badges)
		if CirnoMod.miscItems.isUnlockedAndDisc(card) then
			CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_wily')
		end
	end
}

jokerLoc.nrmJkrs.j_wily = { name = "Wily Hannah 2" }
if CirnoMod.config['matureReferences_cyc'] == 3 then
	jokerLoc.nrmJkrs.j_wily.text={
        "{C:chips}+#1#{} Chips if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}You know, the cards there",
		"{s:0.8,C:inactive}like that make it look",
		"{s:0.8,C:inactive}way more suspect."
    }
else
	jokerLoc.nrmJkrs.j_wily.text={
        "{C:chips}+#1#{} Chips if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}Not Hannah, common",
		"{s:0.8,C:inactive}misconception.",
		"{s:0.8,C:inactive}This is Hannah 2."
    }
			
	wilyTakeOwnershipTable.create_main_end = function()
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
				{ x = 4, y = 0 } -- Position in the Atlas
			)
		)
		
		return { mainEndRV }
	end
	
	wilyTakeOwnershipTable.loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.t_chips,
			localize(card.ability.type, 'poker_hands') },
		main_end = self.create_main_end() }
	end
end
	
if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('wily', wilyTakeOwnershipTable, true)
end

jokerLoc.nrmJkrs.j_clever = {
	name = "Clever Fumo", --[[
    text={
        "{C:chips}+#1#{} Chips if played",
        "hand contains",
        "a {C:attention}#2#",
    }]]
}

jokerLoc.nrmJkrs.j_devious = {
	name = "Devious Doppelganger",
    text={
        "{C:chips}+#1#{} Chips if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}...Wait a minute?",
		"{s:0.8,C:inactive}How did this one get in here?"
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('devious', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_devious')
			end
		end,
		
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
					{ x = 3, y = 0 } -- Position in the Atlas
				)
			)
			
			return { mainEndRV }
		end,
		
		loc_vars = function(self, info_queue, card)
			return { vars = {
				card.ability.t_chips,
				localize(card.ability.type, 'poker_hands') },
			main_end = self.create_main_end() }
		end
	}, true)
end

jokerLoc.nrmJkrs.j_crafty = {
	name = "Dark Magician Girl",
    text={
        "{C:chips}+#1#{} Chips if played",
        "hand contains",
        "a {C:attention}#2#",
		"{s:0.8,C:inactive}The classic."
    }
}

jokerLoc.nrmJkrs.j_lucky_cat = {
	name = "Neco-Arc",
    text={
        "This Joker gains {X:mult,C:white} X#1# {} Mult",
        "every time a {C:attention}Lucky{} card",
        "{C:green}successfully{} triggers",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}\"Burenyuu! Doridoridoridori.\""
    }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('lucky_cat', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_lucky_cat')
			end
		end
	}, true)
end

jokerLoc.nrmJkrs.j_baseball = {
	-- name = "Baseball Card",
	text = {
        "{C:green}Uncommon{} Jokers",
        "each give {X:mult,C:white} X#1# {} Mult",
		"{s:0.8,C:inactive}I seriously hope you",
		"{s:0.8,C:inactive}guys don't do this."
    }
}

--[[
jokerLoc.nrmJkrs.j_bull = {
	name = "Bull",
    text={
        "{C:chips}+#1#{} Chips for",
        "each {C:money}$1{} you have",
        "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
    }
}]]

jokerLoc.nrmJkrs.j_diet_cola = {
	name = "Pepsiman",
	text={
		"Sell this card to",
		"create a free",
		"{C:attention}#1#",
		"{s:0.8,C:inactive}90's ads sure were weird."
	}
}

jokerLoc.nrmJkrs.j_trading = {
	name = "Meowscarada Card",
     text={
         "If {C:attention}first discard{} of round",
         "has only {C:attention}1{} card, destroy",
         "it and earn {C:money}$#1#",
		"{s:0.8,C:inactive}Scene: You enter a trading card store.",
		"{s:0.8,C:inactive}There's a single glass display cabinet",
		"{s:0.8,C:inactive}and it's filled with Meowscarada cards",
		"{s:0.8,C:inactive}of varying rarity. You're not allowed",
		"{s:0.8,C:inactive}to buy any. They're just for show."
     }
}

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('trading', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_trading', jokerLoc.nrmJkrs.j_bootstraps.name)
			end
		end
	}, true)
end


-- ===== NEXT LINE =====


jokerLoc.nrmJkrs.j_flash = {
	name = "Takane Takamine",
	text={
        "Each played {C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8",
        "gives {C:mult}+#1#{} Mult when scored"
    }
}

if CirnoMod.config['matureReferences_cyc'] >= 2 then
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}\"...So she takes her panties off and it like,")
		
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}wipes everyone's mind, so she gets to do the test")
		
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}again, and she calls this guy her closet and makes")
		
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}him put panties on her every time she does it,")
	
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}because her panties disappear each time.\"")
	
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}-- Cirno_TV (approx. quote), circa 2020")
else
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}...How do I possibly explain this one?")
	
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}I've kinda dug myself a hole, here.")
		
	table.insert(jokerLoc.nrmJkrs.j_flash.text,
		"{s:0.8,C:inactive}...Maybe don't think about it too much.")
end

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Joker:take_ownership('flash', {
		set_badges = function(self, card, badges)
			if CirnoMod.miscItems.isUnlockedAndDisc(card) then
				CirnoMod.miscItems.addBadgesToJokerByKey(badges, 'j_flash')
			end
		end
	}, true)
end


jokerLoc.nrmJkrs.j_popcorn = {
	-- name = "Popcorn",
	text = {
        "{C:mult}+#1#{} Mult",
        "{C:mult}-#2#{} Mult per",
        "round played",
		"{s:0.8,C:inactive}Real talk, how was",
		"{s:0.8,C:inactive}this Joker made?",
		"{s:0.8,C:inactive}Is it a seed?",
		"{s:0.8,C:inactive}Was it grown?"
    }
}

--[[
jokerLoc.nrmJkrs.j_ramen = {
	name = "Ramen",
    text={
        "{X:mult,C:white} X#1# {} Mult,",
        "loses {X:mult,C:white} X#2# {} Mult",
        "per {C:attention}card{} discarded"
    }
}
]]

jokerLoc.nrmJkrs.j_selzer = {
	name = "Ketchup",
	text = {
        "Retrigger all",
        "cards played for",
        "the next {C:attention}#1#{} hands",
		"{s:0.8,C:inactive}\"...Where's the",
		"{s:0.8,C:inactive}Mac n Cheese?\""
    }
}

jokerLoc.nrmJkrs.j_trousers = {
	name = "SachikoJeans",
	text = {
        "This Joker gains {C:mult}+#1#{} Mult",
        "if played hand contains",
        "a {C:attention}#2#",
        "{C:inactive}(Currently {C:red}+#3#{C:inactive} Mult)",
		"{s:0.8,C:inactive}Ey, I'm walkin' here."
    }
}

jokerLoc.nrmJkrs.j_campfire = {
	name = "Bonfire",
    text = {
        "This Joker gains {X:mult,C:white}X#1#{} Mult",
        "for each card {C:attention}sold{}, resets",
        "when {C:attention}Boss Blind{} is defeated",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		"{s:0.8,C:inactive}Remember, 23 ATT, 32 END,",
		"{s:0.8,C:inactive}45 DEX, 97 INT"
    }
}

jokerLoc.nrmJkrs.j_smiley = {
	-- name = "Smiley Face",
	text = {
        "Played {C:attention}face{} cards",
        "give {C:mult}+#1#{} Mult",
        "when scored",
		"{s:0.8,C:inactive}A smile better suits a Joker."
    }
}

jokerLoc.nrmJkrs.j_ancient = {
	name = "CirOldge",
    text = {
        "Each played card with",
        "{V:1}#2#{} suit gives",
        "{X:mult,C:white} X#1# {} Mult when scored,",
        "{s:0.8}suit changes at end of round",
		"{s:0.8,C:inactive}It's well known that your",
		"{s:0.8,C:inactive}body just starts turning to",
		"{s:0.8,C:inactive}dust 3 decades into life."
    }
}

jokerLoc.nrmJkrs.j_walkie_talkie = {
	name = "Lifeline",
    text = {
        "Each played {C:attention}10{} or {C:attention}4",
        "gives {C:chips}+#1#{} Chips and",
        "{C:mult}+#2#{} Mult when scored",
		"{s:0.8,C:inactive}\"Pick up the telephone.\"",
		"{s:0.8,C:inactive}......{s:1.35,C:inactive}*BANG*",
		"{s:0.8,C:inactive}\"Oops, I missed.\""
    }
}

jokerLoc.nrmJkrs.j_castle = {
	-- name = "Castle",
	text = {
		"This Joker gains {C:chips}+#1#{} Chips",
        "per discarded {V:1}#2#{} card,",
        "suit changes every round",
        "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)",
		"{s:0.8,C:inactive}...Well yeah, of course.",
		"{s:0.8,C:inactive}You don't expect enemies",
		"{s:0.8,C:inactive}to appear and kill you after",
		"{s:0.8,C:inactive}you grab the flagpole?"
	}
}

return jokerLoc