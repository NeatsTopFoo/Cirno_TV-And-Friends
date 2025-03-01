local miscRenameTables = {}

-- SMODS.process_loc_text(G.localization.misc.quips, "lq_1", {
--					"Maybe Go Fish",
--					"is more our",
--					"speed..."
--				})

-- SMODS.process_loc_text(G.localization.misc.quips, "lq_2", {
--					"We folded like",
--					"a cheap suit!",
--				})

-- SMODS.process_loc_text(G.localization.misc.quips, "lq_3", {
--					"Time for us",
--					"to shuffle off",
--					"and try again!",
--				})

-- SMODS.process_loc_text(G.localization.misc.quips, "lq_4", {
--                 "You know what",
--                 "they say, the",
--                 "house always wins!"
--				})

SMODS.process_loc_text(G.localization.misc.quips, "lq_5", {
                "Looks like you're trying",
                "to make a {C:red}"..G.localization.misc.labels.red_seal,
                "{C:attention}Steel King{} build. Would",
				"you like help with that?"
            })

--	SMODS.process_loc_text(G.localization.misc.quips, "lq_6", {
--					"Oh no, were you",
--					"bluffing too?",
--				})

--	SMODS.process_loc_text(G.localization.misc.quips, "lq_7", {
--	                "It looks like you're",
--	                "trying to make a Red Seal",
--	                "Steel King build. Would",
--					"you like help with that?"
--	            })

--	SMODS.process_loc_text(G.localization.misc.quips, "lq_8", {
--					"Looks like the",
--					"joke's on us!"
--				})

--	SMODS.process_loc_text(G.localization.misc.quips, "lq_9", {
--					"If I had hands",
--					"I would have",
--					"covered my eyes!"
--				})

SMODS.process_loc_text(G.localization.misc.quips, "lq_10", {
				"What the fluoride?"
			})

SMODS.process_loc_text(G.localization.misc.dictionary, "ph_improve_run", "Lose all your money!")
-- Pool of strings to randomise the Shop phase flavour text with.
-- If you add stuff, probably try not to make it too long, as it
-- may rescale it in the UI to the point of illegibility. Or clip.
-- unsure which. But "Pretend to be bad at the game for content!"
-- is probably the extent of how long it could reasonably be?
-- It may be too long.
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
	"Watch this, Chat."
}

return miscRenameTables