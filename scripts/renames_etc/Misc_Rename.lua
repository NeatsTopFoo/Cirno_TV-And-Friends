local miscLoc = { boosters = {}, vouchers = {} }
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
-- TODO: Vouchers, when we replace some.

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