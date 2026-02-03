local miscLoc = { tags = {}, boosters = {}, vouchers = {} }

local getSealName = function(type)
	if
		CirnoMod.replaceDef
		and CirnoMod.replaceDef.locChanges
		and CirnoMod.replaceDef.locChanges.sealLoc
	then
		return CirnoMod.replaceDef.locChanges.sealLoc[type..'_seal'].name
	end
	
	return G.localization.descriptions.Other[type..'_seal'].name
end

--#region Win/Lose Quips
CirnoMod.quipReplace = function()
	if CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_joker) then
		SMODS.process_loc_text(G.localization.misc.quips, "lq_1", {
				"Looks like you're being",
				"backseated by chat.",
				"Need an additional voice",
				"in the crowd?"
			})
		
		SMODS.process_loc_text(G.localization.misc.quips, "lq_2", {
				"Hi! I'm Clippy, your",
				"Balatro assistant.",
				"Would you like",
				"assistance in winning?"
			})
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "lq_3", {
				"Time for us",
				"to shuffle off",
				"and try again!",
			})]]
		
		SMODS.process_loc_text(G.localization.misc.quips, "lq_4", {
				"You look like",
				"you need a coffee"
			})
		
		SMODS.process_loc_text(G.localization.misc.quips, "lq_5", {
				"Looks like you're trying",
				"to make a {C:red}"..getSealName('red'),
				"{C:attention}Steel King{} build. Would",
				"you like help with that?"
			})
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "lq_6", {
				"Oh no, were you",
				"bluffing too?",
			)]]
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "lq_7", {
				"Looks like the",
				"joke's on us!",
			})]]
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "lq_8", {
				"If I had hands",
				"I would have",
				"covered my eyes!"
			})]]
		
		SMODS.process_loc_text(G.localization.misc.quips, "lq_9", {
				"I'm literally",
				"a paperclip, what's",
				"your excuse?"
			})
		
		SMODS.process_loc_text(G.localization.misc.quips, "lq_10", {
				"What the",
				"fluoride?"
			})
		--[[
		
		SMODS.process_loc_text(G.localization.misc.quips, "wq_1", {
				"You Aced it!",
			})]]
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "wq_2", {
				"You dealt with",
				"that pretty well!",
			})]]
		
		SMODS.process_loc_text(G.localization.misc.quips, "wq_3", {
				"Looks like your keyboard",
				"is working correctly!",
				"Have you tried the",
				"function keys?"
			})
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "wq_4", {
				"Too bad these",
				"chips are all",
				"virtual...",
			})]]
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "wq_5", {
				"Looks like I've",
				"taught you well!",
			})]]
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "wq_6", {
				"You made some",
				"heads up plays!",
			})]]
		
		--[[
		SMODS.process_loc_text(G.localization.misc.quips, "wq_7", {
				"Good thing",
				"I didn't bet",
				"against you!",
			})]]
	end
end

--#endregion

--#region Tags

miscLoc.tags.tag_uncommon = { name = "Uncommon Fairy Tag" }

miscLoc.tags.tag_rare = { name = "Rare Fairy Tag" }

miscLoc.tags.tag_foil = { name = "Foil Fairy Tag",
    text={
        "Next base edition shop",
        "Joker is free and",
        "becomes {C:dark_edition}Foil",
		"{s:0.8,C:inactive}So there's a type of fairy",
		"{s:0.8,C:inactive}for every element, right?",
		"{s:0.8,C:inactive}And aluminium's an element...",
		"{s:0.8,C:inactive}So what would a foil fairy",
		"{s:0.8,C:inactive}look like?",
		"{s:0.8,C:inactive}...Conspiracy theorist fairy?",
		"{s:0.8,C:inactive}No wait, that's just Cirno, nevermind."
    } }

miscLoc.tags.tag_holo = { name = "Holographic Fairy Tag" }

miscLoc.tags.tag_polychrome = { name = "Polychrome Fairy Tag" }

miscLoc.tags.tag_negative = { name = "Negative Fairy Tag" }

miscLoc.tags.tag_double = { name = "Pepsi Tag",
    text={
        "Gives a copy of the",
        "next selected {C:attention}Tag{}",
        "{s:0.8,C:attention}Double Tag{s:0.8} excluded",
		"{s:0.8,C:inactive}Wait, why do we have a",
		"{s:0.8,C:inactive}South Korea Ta- OH! OHHHHHH..."
    } }

miscLoc.tags.tag_coupon = { name = "Prime Gaming Tag",
    text = {
        "Initial cards and",
        "booster packs in next",
        "shop are free",
		"{s:0.8,C:inactive}Did you know that if you",
		"{s:0.8,C:inactive}have Amazon Prime, you can",
		"{s:0.8,C:inactive}sub to one streamer per",
		"{s:0.8,C:inactive}month for FREE?"
    } }

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Tag:take_ownership('coupon', {
		create_main_end = function()
			local nodes_ = {
				Ln1 = {},
				Ln2 = {},
				Ln3 = {},
				Ln4 = {},
				Ln5 = {},
				Ln6 = {}
			}
			local nodeKeys = {
				'Ln1',
				'Ln2',
				'Ln3',
				'Ln4',
				'Ln5',
				'Ln6'
			}
			
			CirnoMod.miscItems.addUISpriteNode(nodes_.Ln1, Sprite(
					0, 0, -- Sprite X & Y
					0.8, 0.8, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.emotes, -- Sprite Atlas
					{ x = 0, y = 2 } -- Position in the atlas
				)
			)
			
			CirnoMod.miscItems.addUITextNode(nodes_.Ln2,
				'Learn more at ',
				G.C.UI.TEXT_INACTIVE,
				0.8)
			
			CirnoMod.miscItems.addUITextNode(nodes_.Ln3,
				'https://twitch.tv/girl_dm_/subscribe',
				G.C.BLUE,
				0.8)
			
			CirnoMod.miscItems.addUITextNode(nodes_.Ln4,
				'What\'s that look for? Something on my face?',
				G.C.UI.TEXT_INACTIVE,
				0.5)
			
			return {{
					n = G.UIT.C,
					config = {
						align = 'bm',
						padding = 0.02
					},
					nodes = CirnoMod.miscItems.restructureNodesTableIntoRowsOrColumns(nodes_, nodeKeys, 'R', { align = 'cm' })
				}}
		end,
		
		loc_vars = function(self, info_queue, tag)
			return { vars = {}, main_end = self.create_main_end() }
		end
	}, true)
else
	miscLoc.tags.tag_coupon.text = SMODS.merge_lists({ miscLoc.tags.tag_coupon.text, {
		'{s:0.8,C:inactive}Learn more at',
		'{s:0.8,C:blue}https://twitch.tv/girl_dm_/subscribe',
		'{s:0.5,C:inactive}What\'s that look for? Something on my face?'
	} })
end

miscLoc.tags.tag_investment = { name="cirGreed Tag",
    text={
        "After defeating",
        "the Boss Blind,",
        "gain {C:money}$#1#",
		"{s:0.8,C:inactive}...Come on, you",
		"{s:0.8,C:inactive}know you want to.",
		"{s:0.8,C:inactive}It's so tempting."
    } }

miscLoc.tags.tag_buffoon = { name = "cirMega Tag" }

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Tag:take_ownership('buffoon', {			
		create_main_end = function()
			local nodes_ = {
				Ln1 = {}
			}
			local nodeKeys = {
				'Ln1'
			}
			
			CirnoMod.miscItems.addUISpriteNode(nodes_.Ln1, Sprite(
					0, 0, -- Sprite X & Y
					0.8, 0.8, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.emotes, -- Sprite Atlas
					{ x = 1, y = 2 } -- Position in the atlas
				)
			)
			
			return {{
					n = G.UIT.C,
					config = {
						align = 'bm',
						padding = 0.02
					},
					nodes = CirnoMod.miscItems.restructureNodesTableIntoRowsOrColumns(nodes_, nodeKeys, 'R', { align = 'cm' })
				}}
		end,
		
		loc_vars = function(self, info_queue, tag)
			return { vars = {}, main_end = self.create_main_end() }
		end
	}, true)
end

miscLoc.tags.tag_garbage = { -- name = "Garbage Tag",
	text = {
       "Gives {C:money}$#1#{} per unused",
       "{C:red}discard{} this run",
       "{C:inactive}(Will give {C:money}$#2#{C:inactive})",
		"{s:0.8,C:inactive}I know it looks exactly",
		"{s:0.8,C:inactive}like the vanilla Garbage",
		"{s:0.8,C:inactive}tag, but if you look at",
		"{s:0.8,C:inactive}them side by side, you'll",
		"{s:0.8,C:inactive}see that we changed the",
		"{s:0.8,C:inactive}colour to blue for Cirno.",
		"{s:0.8,C:inactive}But yes, that's the only",
		"{s:0.8,C:inactive}difference"
   } }

miscLoc.tags.tag_ethereal = { name = "Mima Tag",
	text = {
		"Gives a free",
		"{C:spectral}Spectral Pack",
		"{s:0.8,C:inactive}ZUN, pls."
	} }

miscLoc.tags.tag_economy = { name = "Stonks Tag",
		text = {
			"Doubles your money",
			"{C:inactive}(Max of {C:money}$#1#{C:inactive})",
			"{s:0.8,C:inactive}...What's the status on",
			"{s:0.8,C:inactive}this one? Old? Dead?",
			"{s:0.8,C:inactive}Classic? What"
		} }

miscLoc.tags.tag_juggle = { name = "Jiggle Tag",
		text = {
			"{C:attention}+#1#{} hand size",
			"next round",
			"{s:0.8,C:inactive}I miss old POGGIES"
		} }

miscLoc.tags.tag_d_six = { name = "2nd Opinion Tag", --[[
		text = {
			"Rerolls in next shop",
			"start at {C:money}$0",
		} ]] }

miscLoc.tags.tag_standard = { -- name = "Standard Tag",
	text = {
		"Gives a free",
		"{C:attention}Mega Standard Pack",
		"{s:0.8,C:inactive}I don't have a joke",
		"{s:0.8,C:inactive}for this one. I spent",
		"{s:0.8,C:inactive}like half an hour",
		"{s:0.8,C:inactive}trying to think of one,",
		"{s:0.8,C:inactive}so I guess... uh, Chat,",
		"{s:0.8,C:inactive}just ping random people.",
		"{s:0.8,C:inactive}The funnier, the better.",
		"{s:0.8,C:inactive}...What do you mean it's",
		"{s:0.8,C:inactive}not a good substitute?"
	} }

miscLoc.tags.tag_handy = { -- name = "Handy Tag",
		text = {
			"Gives {C:money}$#1#{} per played",
			"{C:blue}hand{} this run",
			"{C:inactive}(Will give {C:money}$#2#{C:inactive})",
			"{s:0.8,C:inactive}Cirno's favourite thing",
			"{s:0.8,C:inactive}in games, being chased"
		},
	}

miscLoc.tags.tag_skip = { name = "Adge Tag",
		text = {
			"Gives {C:money}$#1#{} per skipped",
			"Blind this run",
			"{C:inactive}(Will give {C:money}$#2#{C:inactive})",
			"{s:0.8,C:inactive}Want a break from the ads?",
			"{s:0.8,C:inactive}If you tap now to watch a",
			"{s:0.8,C:inactive}short video, you'll receive",
			"{s:0.8,C:inactive}30 minutes of ad-free music"
		}
	}

miscLoc.tags.tag_boss = { name = "Boss Tag",
		text = {
			"Rerolls the",
			"{C:attention}Boss Blind",
			"{s:0.8,C:inactive}Have you ever fought",
			"{s:0.8,C:inactive}a lava spidergirl and",
			"{s:0.8,C:inactive}a lightning dragoon on",
			"{s:0.8,C:inactive}a cramped rooftop?"
		}
	}

miscLoc.tags.tag_charm = { name = "9 Tag",
		--[[
        text = {
            "Gives a free",
            "{C:tarot}Mega Arcana Pack",
        } ]]
    }

miscLoc.tags.tag_top_up = { name = "cirMany Tag" }

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Tag:take_ownership('top_up', {			
		create_main_end = function()
			local nodes_ = {
				Ln1 = {}
			}
			local nodeKeys = {
				'Ln1'
			}
			
			CirnoMod.miscItems.addUISpriteNode(nodes_.Ln1, Sprite(
					0, 0, -- Sprite X & Y
					2.4, 0.6, -- Sprite W & H
					CirnoMod.miscItems.funnyAtlases.didYouMeanGermany, -- Sprite Atlas
					{ x = 0, y = 0 } -- Position in the atlas
				)
			)
			
			return {{
					n = G.UIT.C,
					config = {
						align = 'bm',
						padding = 0.02
					},
					nodes = CirnoMod.miscItems.restructureNodesTableIntoRowsOrColumns(nodes_, nodeKeys, 'R', { align = 'cm' })
				}}
		end,
		
		loc_vars = function(self, info_queue, tag)
			return { vars = { tag.config.spawn_jokers }, main_end = self.create_main_end() }
		end
	}, true)
else
	miscLoc.tags.tag_top_up.text = {
			"Create up to {C:attention}#1#",
			"{C:blue}Common{} Jokers",
			"{C:inactive}(Must have room)",
			"{s:0.8,C:inactive}Did you mean: Germany?"
		}
end

if CirnoMod.config.planetsAreHus then
	miscLoc.tags.tag_meteor = { name = "Hu Tag",
		text={
			"Gives a free",
			"{C:planet}Mega #1#",
			"{s:0.8,C:cirInactiveAtt}Warning{s:0.8,C:inactive}: This Tag may contain",
			"{s:0.8,C:inactive}Double Spoilers and is Highly",
			"{s:0.8,C:inactive}Responsive to Prayers. Practice",
			"{s:0.8,C:inactive}safe Tag usage and consult a",
			"{s:0.8,C:inactive}certified Double Dealing Character",
			"{s:0.8,C:inactive}whenever using {s:0.8,C:planet}Hu Tags"
		} }
	
	miscLoc.tags.tag_orbital = { name = "Bomb Tag",
		text={
			"Upgrade {C:attention}#1#",
			"by {C:attention}#2# levels",
			"{s:0.8,C:inactive}It's yours, my friend.",
			"{s:0.8,C:inactive}As long as you have",
			"{s:0.8,C:inactive}enough rupees"
		} }
else
	SMODS.process_loc_text(G.localization.descriptions.Tag.tag_meteor, "text", {
			"Gives a free",
			"{C:planet}Mega #1#"
		})
end

SMODS.Tag:take_ownership('meteor', {
	loc_vars = function(self, info_queue, tag)
		return { vars = { G.localization.descriptions.Other.p_celestial_normal.name } }
	end
} , true)

miscLoc.tags.tag_voucher = { name = "Clover Tag",
		text = {
			"Adds one {C:voucher}Voucher",
			"to the next shop",
			"{s:0.8,C:inactive}It's payday."
		},
	},

--#endregion

--#region Boosters
--[[
Hu'ing the Celestial packs no longer seems to be working this way around.
miscLoc.boosters.p_celestial_normal = {}

if not CirnoMod.config['planetsAreHus'] then
	-- miscLoc.boosters.p_celestial_normal.name = "Celestial Pack"
end

miscLoc.boosters.p_celestial_normal.text = {
		"Choose {C:attention}#1#{} of up to",
		"{C:attention}#2#{C:planet} "..planetIntent.."{} cards to",
		"be used immediately",
	}

miscLoc.boosters.p_celestial_jumbo = {}

if not CirnoMod.config['planetsAreHus'] then
	-- miscLoc.boosters.p_celestial_jumbo.name = "Jumbo Celestial Pack"
end

miscLoc.boosters.p_celestial_jumbo.text = {
		"Choose {C:attention}#1#{} of up to",
		"{C:attention}#2#{C:planet} "..planetIntent.."{} cards to",
		"be used immediately",
	}

miscLoc.boosters.p_celestial_mega = {}

if not CirnoMod.config['planetsAreHus'] then
	-- miscLoc.boosters.p_celestial_mega.name = "Mega Celestial Pack"
end

miscLoc.boosters.p_celestial_mega.text = {
		"Choose {C:attention}#1#{} of up to",
		"{C:attention}#2#{C:planet} "..planetIntent.."{} cards to",
		"be used immediately",
	}
]]
--#endregion

--#region Vouchers

miscLoc.vouchers.v_wasteful = { name = "Noire",
		text = {
			"Permanently",
			"gain {C:red}+#1#{} discard",
			"each round",
			"{s:0.8,C:inactive}Nowa nowa no,",
			"{s:0.8,C:inactive}Nowa nowa nowa nowa,",
			"{s:0.8,C:inactive}Nowa, nowa"
		}
	}

miscLoc.vouchers.v_recyclomancy = { name = "Black Heart",
		text = {
			"Permanently",
			"gain {C:red}+#1#{} discard",
			"each round",
			"{s:0.8,C:inactive}So Purple Heart has purple hair",
			"{s:0.8,C:inactive}Green Heart is blonde",
			"{s:0.8,C:inactive}Black Heart has white hair",
			"{s:0.8,C:inactive}And White Heart has blue hair",
			"{s:0.8,C:inactive}...What exactly are the rules here?"
		}
	}

miscLoc.vouchers.v_grabber = { name = "White Knuckle",
		text={
			"Permanently",
			"gain {C:blue}+#1#{} hand",
			"per round",
			"{s:0.8,C:inactive}Nice to see Master Hand",
			"{s:0.8,C:inactive}still getting work"
		}
	}

miscLoc.vouchers.v_nacho_tong = { name = "Red Knuckle",
		text={
			"Permanently",
			"gain {C:blue}+#1#{} hand",
			"per round",
			"{s:0.8,C:inactive}Here I come, rougher",
			"{s:0.8,C:inactive}than the rest of them"
		}
	}

miscLoc.vouchers.v_blank = { name = "Disconnect Protection",
		text = {
			"{C:inactive}Does nothing?",
			"{s:0.8,C:inactive}Strimmer gone forever."
		}
	}

miscLoc.vouchers.v_antimatter = { name = "Zirno_BV",
		text = {
			"{C:dark_edition}+1{} Joker Slot",
			"{s:0.8,C:inactive}\"Does powdered water exist?\""
		},
		unlock = {
			"Redeem {C:voucher}Disconnect Protection{}",
			"{C:attention}#1#{} total times",
			"{C:inactive}(#2#)",
		}
	}

miscLoc.vouchers.v_hieroglyph = { -- name = "Hieroglyph",
		text = {
			"{C:attention}-#1#{} Ante,",
			"{C:blue}-#1#{} hand",
			"each round",
			"{s:0.8,C:inactive}Back in my day, school",
			"{s:0.8,C:inactive}was uphill. Both ways"
		}
	}

miscLoc.vouchers.v_petroglyph = { -- name = "Petroglyph",
		text = {
			"{C:attention}-#1#{} Ante,",
			"{C:red}-#1#{} discard",
			"each round",
			"{s:0.8,C:inactive}Did you know Twitch used",
			"{s:0.8,C:inactive}to be called Justin.tv?"
		}
	}

miscLoc.vouchers.v_hone = { -- name = "Hone",
		text = {
			"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, and",
			"{C:dark_edition}Polychrome{} cards",
			"appear {C:attention}#1#X{} more often",
			"{s:0.8,C:inactive}You found a car!",
			"{s:0.8,C:inactive}Doesn't look like much now,",
			"{s:0.8,C:inactive}but with a little love, it'll",
			"{s:0.8,C:inactive}look amazing!"
		}
	}

miscLoc.vouchers.v_glow_up = { -- name = "Glow Up",
		text = {
			"{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, and",
			"{C:dark_edition}Polychrome{} cards",
			"appear {C:attention}#1#X{} more often",
			"{s:0.8,C:inactive}See? What did I tell you?"
		}
	}

miscLoc.vouchers.v_tarot_merchant = { -- name = "Tarot Merchant",
		text = {
			"{C:tarot}Tarot{} cards appear",
			"{C:attention}#1#X{} more frequently",
			"in the shop",
			"{s:0.8,C:inactive}Todd Howard is my",
			"{s:0.8,C:inactive}favourite Touhou character"
		}
	}

miscLoc.vouchers.v_tarot_tycoon = { name = "CirSona",
		text = {
			"{C:tarot}Tarot{} cards appear",
			"{C:attention}#1#X{} more frequently",
			"in the shop",
			"{s:0.8,C:inactive}Now I face out, I hold out",
			"{s:0.8,C:inactive}I reach out to the truth of",
			"{s:0.8,C:inactive}my life, seeking to seize",
			"{s:0.8,C:inactive}On the whole moment, yeah"
		}
	}

miscLoc.vouchers.v_clearance_sale = { name = "Balatro Discount",
		text={
			"All cards and packs in",
			"shop are {C:attention}#1#%{} off",
			"{s:0.8,C:inactive}Hey, you should buy Balatro",
			"{s:0.8,C:inactive}if you haven't already.",
			"{s:0.8,C:inactive}...What?"
		}
	}

miscLoc.vouchers.v_liquidation = { name = "Steam Summer Sale",
		text={
			"All cards and packs in",
			"shop are {C:attention}#1#%{} off",
			"{s:0.8,C:inactive}There'll be 0% of your",
			"{s:0.8,C:inactive}wallet left afterwards"
		}
	}

miscLoc.vouchers.v_crystal_ball = { name = "Yin-Yang Orb",
		text = {
			"{C:attention}+1{} consumable slot",
			"{s:0.8,C:inactive}I would like to put forth",
			"{s:0.8,C:inactive}that Reimu was, while not",
			"{s:0.8,C:inactive}the first, at least one",
			"{s:0.8,C:inactive}of the OG orb ponderers"
		}
	}

miscLoc.vouchers.v_omen_globe = { name = "Eternal Shrine Maiden",
		text = {
			"{C:spectral}Spectral{} cards may",
			"appear in any of",
			"the {C:attention}Arcana Packs",
			"{s:0.8,C:inactive}Something usually happens",
			"{s:0.8,C:inactive}during the summer"
		}
	}

miscLoc.vouchers.v_overstock_norm = { name = "Card Table",
    text = {
        "{C:attention}+1{} card slot",
        "available in shop",
		"{s:0.8,C:inactive}I always thought it",
		"{s:0.8,C:inactive}a bold move to just",
		"{s:0.8,C:inactive}have your valuable",
		"{s:0.8,C:inactive}cardboard sit out in",
		"{s:0.8,C:inactive}the open like that"
    }
}

miscLoc.vouchers.v_overstock_plus = { name = "Display Cabinets",
    text = {
        "{C:attention}+1{} card slot",
        "available in shop",
		"{s:0.8,C:inactive}This makes more sense"
    }
}

miscLoc.vouchers.v_reroll_surplus = { name = "Reroll Gamblecore",
	text = {
		"Rerolls cost",
		"{C:money}$#1#{} less",
		"{s:0.8,C:inactive}I can't stop winning!"
	}
}

miscLoc.vouchers.v_paint_brush = { name = "Work-In-Progress",
    text = {
        "{C:attention}+#1#{} hand size",
		"{s:0.8,C:inactive}You can't rush art"
    }
}

miscLoc.vouchers.v_palette = { name = "Masterpiece",
    text = {
        "{C:attention}+#1#{} hand size",
		"{s:0.8,C:inactive}There! Now it's art"
    }
}

miscLoc.vouchers.v_seed_money = { name = "Golden Glove",
	text = {
		"Raise the cap on",
		"interest earned in",
		"each round to {C:money}$#1#",
		"{s:0.8,C:inactive}\"Ich liebe Kapitalismus!\"",
		"{s:0.8,C:inactive}-- Doktor, Metal Gear Rising"
    }
}

miscLoc.vouchers.v_money_tree = { name = "Golden Tome",
	text = {
		"Raise the cap on",
		"interest earned in",
		"each round to {C:money}$#1#{}",
		"{s:0.8,C:inactive}Among the worst items",
		"{s:0.8,C:inactive}in Megabonk, decent in",
		"{s:0.8,C:inactive}Balatro. Funny, that one"
    }
}

miscLoc.vouchers.v_directors_cut = { name = "Cirno_TV Highlights",
    text = {
        "Reroll Boss Blind",
        "{C:attention}1{} time per Ante,",
        "{C:money}$#1#{} per roll",
		"{s:0.8,C:inactive}Every year, be",
		"{s:0.8,C:inactive}reminded of your",
		"{s:0.8,C:inactive}failings"
    }
}

miscLoc.vouchers.v_retcon = { name = "I Don't Know What This Is Referencing",
    text = {
        "Reroll Boss Blind",
        "{C:attention}unlimited{} times,",
        "{C:money}$#1#{} per roll",
		"{s:0.8,C:inactive}I'm a fake Cirno fan, smh"
    }
}

if CirnoMod.config.planetsAreHus then
	miscLoc.vouchers.v_telescope = { name = 'Tewi Inaba',
		text = {
			"{C:attention}#1#s{} always",
			"contain the {C:planet}#2#",
			"card for your most",
			"played {C:attention}poker hand",
			"{s:0.8,C:inactive}\"It is said that although",
			"{s:0.8,C:inactive}the rabbit is supposed to",
			"{s:0.8,C:inactive}cross the river, it tricked",
			"{s:0.8,C:inactive}and crossed the shark\""
		}
	}
else
	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_telescope, "text", {
			"{C:attention}#1#s{} always",
			"contain the {C:planet}#2#",
			"card for your most",
			"played {C:attention}poker hand",
		})
end

SMODS.Voucher:take_ownership('telescope',{
	loc_vars = function(self, info_queue, card)
		return { vars = {
			G.localization.descriptions.Other.p_celestial_normal.name,
			G.localization.misc.labels.planet
		} }
	end
}, true)

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "text", {
		"{C:planet}#1#{} cards in your",
		"{C:attention}consumable{} area give",
		"{X:red,C:white} X#2# {} Mult for their",
		"specified {C:attention}poker hand",
	})
				
SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "unlock", {
		"Use a total of {C:attention}#1#",
		"{C:planet}#2#{} cards from any",
		"{C:planet}#3#",
		"{C:inactive}(#2#)",
	})

SMODS.Voucher:take_ownership('observatory',{
	loc_vars = function(self, info_queue, card)
		return { vars = {
			G.localization.misc.labels.planet,
			card.ability.extra
		} }
	end,
	
	locked_loc_vars = function(self, info_queue, card)
		return { vars = {
			25,
			G.localization.misc.labels.planet,
			G.localization.descriptions.Other.p_celestial_normal.name
		} }
	end
}, true)

miscLoc.vouchers.v_observatory = { name = 'Observe-atory',
		text = {
			"{C:planet}#1#{} cards in your",
			"{C:attention}consumable{} area give",
			"{X:red,C:white} X#2# {} Mult for their",
			"specified {C:attention}poker hand",
			"{s:0.8,C:inactive}...I see.",
			"{s:0.8,C:inactive}Wait, wrong emote"
		},
		unlock = {
			"Use a total of {C:attention}#1#",
			"{C:planet}#2#{} cards from any",
			"{C:planet}#3#",
			"{C:inactive}(#2#)"
		}
	}

if CirnoMod.config.planetsAreHus then
	miscLoc.vouchers.v_planet_merchant = { name = "Hu Merchant",
			text = {
				"{C:planet}#2#{} cards appear",
				"{C:attention}#1#X{} more frequently",
				"in the shop",
				"{s:0.8,C:inactive}Fun Cirno_TV Facts No. 9:",
				"{s:0.8,C:inactive}He LOVES the old classic",
				"{s:0.8,C:inactive}JP Ronald McDonald YTPMVs,",
				"{s:0.8,C:inactive}they're his favourite."
			}
		}
	
	miscLoc.vouchers.v_planet_tycoon = { name = "Hu Tycoon",
			text = {
				"{C:planet}#2#{} cards appear",
				"{C:attention}#1#X{} more frequently",
				"in the shop",
				"{s:0.8,C:inactive}Fun Cirno_TV Facts No. 99:",
				"{s:0.8,C:inactive}His favourite Touhou",
				"{s:0.8,C:inactive}character is Sakuya Izayoi."
			},
			unlock = {
				"Buy a total of",
				"{C:attention}#1#{C:planet} #3#{} cards",
				"from the shop",
				"{C:inactive}(#2#)"
			}
		}
else
	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_merchant, "text", {
			"{C:planet}#2#{} cards appear",
			"{C:attention}#1#X{} more frequently",
			"in the shop",
		})

	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "text", {
			"{C:planet}#2#{} cards appear",
			"{C:attention}#1#X{} more frequently",
			"in the shop",
		})

	SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "unlock", {
			"Buy a total of",
			"{C:attention}#1#{C:planet} #3#{} cards",
			"from the shop",
			"{C:inactive}(#2#)",
		})
end

SMODS.Voucher:take_ownership('planet_merchant',{
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra_disp,
			G.localization.misc.labels.planet
		} }
	end
}, true)

SMODS.Voucher:take_ownership('planet_tycoon',{
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra_disp,
			G.localization.misc.labels.planet
		} }
	end,
	
	locked_loc_vars = function(self, info_queue, card)
		return { vars = {
			50,
			G.PROFILES[G.SETTINGS.profile].career_stats.c_planets_bought,
			G.localization.misc.labels.planet
		} }
	end
}, true)

--#endregion

--#region Shop flavour text

SMODS.process_loc_text(G.localization.misc.dictionary, "ph_improve_run", "Lose all your money!")

--[[
Pool of strings to randomise the Shop phase flavour text with.
If you add stuff, probably try not to make it too long, as it
may rescale it in the UI to the point of illegibility. Or clip.
unsure which. But "Pretend to be bad at the game for content!"
is probably the extent of how long it could reasonably be?
It may be too long.]]
CirnoMod.miscItems.miscRenameTables.shopFlavourPool = {
	"Lose all your money!",
	"Drop matcha ice cream!",
	"Throw the run!",
	"Brag about being stupid!",
	"Finger guns!",
	"What the fluoride?",
	"Find out how popcorn's made!",
	"Be lost, run around in circles!",
	"Make your run worse!",
	"Stall for content!",
	"Pretend to be bad at the game for content!",
	"Chat, check this out!",
	"Watch this, Chat.",
	"Immortalise your stupidity!",
	"Try the other escalator!",
	"Use your gun!"
}

--#endregion

return miscLoc