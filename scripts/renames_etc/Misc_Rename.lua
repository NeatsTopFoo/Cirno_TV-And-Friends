local miscLoc = { tags = {}, boosters = {}, vouchers = {} }
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

local celestPackIntent = G.localization.descriptions.Other.p_celestial_normal.name

if CirnoMod.replaceDef.locChanges.boosterLoc then
	if CirnoMod.replaceDef.locChanges.boosterLoc.p_celestial_normal then
		celestPackIntent = CirnoMod.replaceDef.locChanges.boosterLoc.p_celestial_normal.name or celestPackIntent
	end
end

--#region Win/Lose Quips


SMODS.process_loc_text(G.localization.misc.quips, "lq_1", {
		"Looks like you're being",
		"backseated by chat.",
		"Need an additional voice",
		"in the crowd?"
	})

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_2", {
		"We folded like",
		"a cheap suit!",
	})]]

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_3", {
		"Time for us",
		"to shuffle off",
		"and try again!",
	})]]

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_4", {
		"You know what",
		"they say, the",
		"house always wins!"
	})]]

SMODS.process_loc_text(G.localization.misc.quips, "lq_5", {
		"Looks like you're trying",
		"to make a {C:red}"..sealIntent.red_seal,
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

miscLoc.tags.tag_investment = { name="cirGreed Tag",
    text={
        "After defeating",
        "the Boss Blind,",
        "gain {C:money}$#1#",
		"{s:0.8,C:inactive}...Come on, you",
		"{s:0.8,C:inactive}know you want to.",
		"{s:0.8,C:inactive}It's so tempting."
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
		
		loc_vars = function(self, info_queue, card)
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

miscLoc.tags.tag_buffoon = { name = "cirMega Tag" }

if CirnoMod.config.allowCosmeticTakeOwnership then
	SMODS.Tag:take_ownership('buffoon', {			
		create_main_end = function()
			local nodes_ = {
				Ln1 = {},
				Ln2 = {},
				Ln3 = {},
				Ln4 = {}
			}
			local nodeKeys = {
				'Ln1',
				'Ln2',
				'Ln3',
				'Ln4'
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
		
		loc_vars = function(self, info_queue, card)
			return { vars = {}, main_end = self.create_main_end() }
		end
	}, true)
end

miscLoc.tags.tag_garbage = { text = {
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
		"{s:0.8,C:inactive}difference."
   } }

miscLoc.tags.tag_ethereal = { name = "Mima Tag",
	text={
		"Gives a free",
		"{C:spectral}Spectral Pack",
		"{s:0.8,C:inactive}ZUN, pls."
	} }

if CirnoMod.config.planetsAreHus then
	miscLoc.tags.tag_meteor = { name = "Hu Tag",
		text={
			"Gives a free",
			"{C:planet}Mega "..celestPackIntent,
			"{s:0.8,C:cirInactiveAtt}Warning{s:0.8,C:inactive}: This Tag may contain",
			"{s:0.8,C:inactive}Double Spoilers and is Highly",
			"{s:0.8,C:inactive}Responsive to Prayers. Practice",
			"{s:0.8,C:inactive}safe Tag usage and consult a",
			"{s:0.8,C:inactive}certified Double Dealing Character",
			"{s:0.8,C:inactive}whenever using {s:0.8,C:planet}Hu Tags{s:0.8,C:inactive}."
		} }
	
	miscLoc.tags.tag_orbital = { name = "Bomb Tag",
		text={
			"Upgrade {C:attention}#1#",
			"by {C:attention}#2# levels",
			"{s:0.8,C:inactive}It's yours, my friend.",
			"{s:0.8,C:inactive}As long as you have",
			"{s:0.8,C:inactive}enough rupees."
		} }
else
	SMODS.process_loc_text(G.localization.descriptions.Tag.tag_meteor, "text", {
			"Gives a free",
			"{C:planet}Mega "..celestPackIntent
		})
end

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

miscLoc.vouchers.v_grabber = { name = "White Knuckle",
		text={
			"Permanently",
			"gain {C:blue}+#1#{} hand",
			"per round",
			"{s:0.8,C:inactive}Nice to see Master Hand",
			"{s:0.8,C:inactive}still getting work."
		}
	}

miscLoc.vouchers.v_nacho_tong = { name="Red Knuckle",
		text={
			"Permanently",
			"gain {C:blue}+#1#{} hand",
			"per round",
			"{s:0.8,C:inactive}Here I come, rougher",
			"{s:0.8,C:inactive}than the rest of them."
		}
	}

miscLoc.vouchers.v_blank = { name = "Disconnect Protection",
		text = {
			"{C:inactive}Does nothing?",
			"{s:0.8,C:inactive}Strimmer gone forever."
		}
	}

miscLoc.vouchers.v_hieroglyph = { -- name = "Hieroglyph",
		text = {
			"{C:attention}-#1#{} Ante,",
			"{C:blue}-#1#{} hand",
			"each round",
			"{s:0.8,C:inactive}Back in my day, school",
			"{s:0.8,C:inactive}was uphill. Both ways."
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

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_telescope, "name", "Telescope")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_telescope, "text", {
                    "{C:attention}"..celestPackIntent.."s{} always",
                    "contain the {C:planet}"..planetIntent,
                    "card for your most",
                    "played {C:attention}poker hand",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "name", "Observatory")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "text", {
                    "{C:planet}"..planetIntent.."{} cards in your",
                    "{C:attention}consumable{} area give",
                    "{X:red,C:white} X#1# {} Mult for their",
                    "specified {C:attention}poker hand",
                })
				
SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "unlock", {
                    "Use a total of {C:attention}#1#",
                    "{C:planet}"..planetIntent.."{} cards from any",
                    "{C:planet}"..celestPackIntent,
                    "{C:inactive}(#2#)",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_merchant, "name", "Planet Merchant")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_merchant, "text", {
                    "{C:planet}"..planetIntent.."{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "name", "Planet Tycoon")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "text", {
                    "{C:planet}"..planetIntent.."{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop",
                })

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "unlock", {
                    "Buy a total of",
                    "{C:attention}#1#{C:planet} "..planetIntent.."{} cards",
                    "from the shop",
                    "{C:inactive}(#2#)",
                })
				
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
	"Immortalise your stupidity!"
}

--#endregion

return miscLoc