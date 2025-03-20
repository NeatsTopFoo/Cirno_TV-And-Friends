local miscRenameTables = {}

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_1", {
	"Maybe Go Fish",
	"is more our",
	"speed..."
})]]

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
                "to make a {C:red}"..G.localization.misc.labels.red_seal,
                "{C:attention}Steel King{} build. Would",
				"you like help with that?"
            })

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_6", {
	"Oh no, were you",
	"bluffing too?",
})]]

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_7", {
    "It looks like you're",
    "trying to make a Red Seal",
    "Steel King build. Would",
	"you like help with that?"
})]]

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_8", {
	"Looks like the",
	"joke's on us!"
})]]

--[[
SMODS.process_loc_text(G.localization.misc.quips, "lq_9", {
	"If I had hands",
	"I would have",
	"covered my eyes!"
})]]

SMODS.process_loc_text(G.localization.misc.quips, "lq_10", {
				"What the fluoride?"
			})

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_normal, "name", "Celestial Pack")
end

SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_normal, "text", {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:planet} "..G.localization.misc.labels.planet.."{} cards to",
                    "be used immediately",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_jumbo, "name", "Jumbo Celestial Pack")
end

SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_jumbo, "text", {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:planet} "..G.localization.misc.labels.planet.."{} cards to",
                    "be used immediately",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_mega, "name", "Mega Celestial Pack")
end

SMODS.process_loc_text(G.localization.descriptions.Other.p_celestial_mega, "text", {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:planet} "..G.localization.misc.labels.planet.."{} cards to",
                    "be used immediately",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_telescope, "name", "Telescope")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_telescope, "text", {
                    "{C:attention}"..G.localization.descriptions.Other.p_celestial_normal.name.."s{} always",
                    "contain the {C:planet}"..G.localization.misc.labels.planet,
                    "card for your most",
                    "played {C:attention}poker hand",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "name", "Observatory")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "text", {
                    "{C:planet}"..G.localization.misc.labels.planet.."{} cards in your",
                    "{C:attention}consumable{} area give",
                    "{X:red,C:white} X#1# {} Mult for their",
                    "specified {C:attention}poker hand",
                })
				
SMODS.process_loc_text(G.localization.descriptions.Voucher.v_observatory, "unlock", {
                    "Use a total of {C:attention}#1#",
                    "{C:planet}"..G.localization.misc.labels.planet.."{} cards from any",
                    "{C:planet}"..G.localization.descriptions.Other.p_celestial_normal.name,
                    "{C:inactive}(#2#)",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_merchant, "name", "Planet Merchant")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_merchant, "text", {
                    "{C:planet}"..G.localization.misc.labels.planet.."{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop",
                })

if not CirnoMod.config['planetsAreHus'] then
	-- SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "name", "Planet Tycoon")
end

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "text", {
                    "{C:planet}"..G.localization.misc.labels.planet.."{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop",
                })

SMODS.process_loc_text(G.localization.descriptions.Voucher.v_planet_tycoon, "unlock", {
                    "Buy a total of",
                    "{C:attention}#1#{C:planet} "..G.localization.misc.labels.planet.."{} cards",
                    "from the shop",
                    "{C:inactive}(#2#)",
                })

SMODS.process_loc_text(G.localization.misc.dictionary, "ph_improve_run", "Lose all your money!")

--[[
Pool of strings to randomise the Shop phase flavour text with.
If you add stuff, probably try not to make it too long, as it
may rescale it in the UI to the point of illegibility. Or clip.
unsure which. But "Pretend to be bad at the game for content!"
is probably the extent of how long it could reasonably be?
It may be too long.]]
miscRenameTables.shopFlavourPool = {
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

return miscRenameTables