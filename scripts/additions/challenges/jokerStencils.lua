-- So it turns out that GitHub doesn't create directories in the repo if they are unpopulated, which makes sense, I guess.
-- So for now, this is a placeholder lua that does nothing until I get around to implementing my idea.

-- For future reference, I have some ideas for a few challenges we could add,
-- my intentions so far for challenges being:

-- - Start with eternal 5 Joker Stencils, all debuffed.
--   From Ante 2 onwards, beating a Boss Blind will remove
--   one of the Joker Stencil's debuffs.
--   No other alterations planned (i.e. standard deck w/o
--   alterations, other run settings, etc.).

-- - "Turn Towels to Steel By Holding Your Breath": Start
--   with an eternal Biggdeck (Perkeo) and eternal Steel
--   Joker, All Kings & Queens in deck are steel, deck is
--   otherwise normal.
--   Banned Jokers: Baron, Mime (Probably more that I can't
--   think of off the top of my head)
--   Other Bans: Chariot, Death, Cryptid (Maybe more that
--   I can't think of off the top of my head - I don't
--   intend on restricting ALL sources of new Steel cards,
--   but I would like to make it extremely difficult
--   and not without difficulty/paying a significant price
--   in order to do so.
--   Start with 1 less hand, 1 less discard and $2.

-- - "Only Cir": Just bans anything not edited or added by
--   this mod, including the deck - With the alterations at
--   the time of writing (22nd of Feb), deck should be half
--   the size and consist entirely of Queens of Clubs and
--   Spades. Revise if there were changes to the deck skin.

local chalInfo = {
	loc_txt = {
		name = "5 \"Joker Stencils.\"",
	},
	rules = {
		custom = {
			{ id = "cir_jokerStencils" }, 
			{ id = "cir_jokerStencilsA" }
		}
	},
	jokers = {
		{id = 'j_stencil', eternal = true, debuff = true},
		{id = 'j_stencil', eternal = true, debuff = true},
		{id = 'j_stencil', eternal = true, debuff = true},
		{id = 'j_stencil', eternal = true, debuff = true},
		{id = 'j_stencil', eternal = true, debuff = true}
	},
	consumeables = {
	},
	vouchers = {
	},
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
            banned_cards = {
            },
            banned_tags = {
            },
			
			-- "Other" can only be used to ban blind types.
            banned_other = {
				{ id = 'bl_final_leaf', type = 'blind' }
            }
	},
	unlocked = function(self)
		return true
	end
}

G.localization.misc.v_text.ch_c_cir_jokerStencils = {
	"Start with 5 {C:eternal}Eternal{}, {C:attention}debuffed{} "..G.localization.descriptions.Joker.j_stencil.name.."s."
}

G.localization.misc.v_text.ch_c_cir_jokerStencilsA = {
	"Every {C:attention}2{} defeated {C:attention}Boss Blinds{} removes a debuff."
}

CirnoMod.ChalFuncs.jokerStencilsDebuffCheck = function(calledFromWhichEvent)
	-- print(calledFromWhichEvent)
	local currentAnte = G.GAME.round_resets.ante
	local currentUndebuffedCounter = 0
	local undebuffCounter = 0
	local desiredUndebuffedCount = 0
	local desiredDebuffState = false
	local calcDebuff = false
	
	if
		calledFromWhichEvent == "blindDefeat"
		and G.GAME.blind:get_type() == 'Boss'
	then
		-- Makes undebuffing happen on the boss blind
		-- defeat as ante updating is slow
		currentAnte = G.GAME.round_resets.ante + 1
	elseif
		calledFromWhichEvent == "runStart"
	then
		-- Quashing a potential issue found in testing
		-- where undebuffed negative jokers don't properly
		-- update the joker limit
		local totalNegativeCount = 0
		local undebuffedStencilNegativeCount = 0
		for i, jkr in ipairs(G.jokers.cards) do
			if
				jkr.edition
				and not jkr.debuff
			then
				if jkr.edition.key == 'e_negative' then
					totalNegativeCount = totalNegativeCount + 1
					
					if jkr.config.center.key == 'j_stencil' then
						undebuffedStencilNegativeCount = undebuffedStencilNegativeCount + 1
					end
				end
			end
		end
		
		if
			G.jokers.config.card_limit < (5 + totalNegativeCount)
			and undebuffedStencilNegativeCount > 0
		then
			G.jokers.config.card_limit = (5 + totalNegativeCount)
		end
	end
	
		
	-- Lua doesn't have switch case statements.
	-- Now I understand why a bunch of this game's
	-- code is just massives if statements...
	-- Except a table lookup and call would be
	-- better for the size of some of the if
	-- statements in the game... Something this
	-- small should be fine, though
	if
		currentAnte >= 3
		and currentAnte < 11
	then
		-- Working out the requisite amount
		-- of undebuffed stencil jokers
		-- per ante. 1 undebuff every 2
		-- boss blinds.
		calcDebuff = true			
		if currentAnte >= 10 then
			desiredUndebuffedCount = 4
		elseif currentAnte >= 7 then
			desiredUndebuffedCount = 3
		elseif currentAnte >= 5 then
			desiredUndebuffedCount = 2
		elseif currentAnte >= 3 then
			desiredUndebuffedCount = 1
		end
	elseif currentAnte < 3 then
		desiredDebuffState = true
	end
	
	-- Determining the amount of existing
	-- undebuffed stencil jokers. This is
	-- to prevent an exploit where you
	-- could rearrange the stencil jokers
	-- before a blind (say, to make use of)
	-- any editions obtained to have it then
	-- change the undebuffed joker stencil
	-- to that joker stencil when you start
	-- the blind, since they undebuff from
	-- left to right. Unfortunately since
	-- there isn't really any way to sore
	-- unique identifiers for each stencil
	-- joker that persist through saving
	-- and loading the current run, we'll
	-- just have to permit this tactic
	-- but only after defeating a boss
	-- blind that would give a new undebuffed
	-- joker stencil.
	if calcDebuff then
		for i, jkr in ipairs(G.jokers.cards) do
			if 
				jkr.config.center.key == 'j_stencil'
				and not jkr.debuff
			then
				currentUndebuffedCounter = currentUndebuffedCounter + 1
			end
		end
	end
	
	if
		(calledFromWhichEvent == "runStart" and currentAnte < 3)
		or (currentUndebuffedCounter < desiredUndebuffedCount or (currentAnte >= 10 and currentUndebuffedCounter < 5))
	then
		-- Iterate through jokers
		for i, jkr in ipairs(G.jokers.cards) do
			-- Only stencil jokers
			if jkr.config.center.key == 'j_stencil' then
				-- Do we want to undebuff the joker we are looking at?
				if calcDebuff then
					desiredDebuffState = undebuffCounter >= desiredUndebuffedCount
					undebuffCounter = undebuffCounter + 1
				end
				
				if jkr.debuff ~= desiredDebuffState then
					-- Edition stuff here is further attempting to
					-- quash the negative issue mentioned earlier.
					local isNegative = false
					local undebuffing = false
					if
						jkr.debuff
						and not desiredDebuffState
					then
						-- Are we undebuffing this stencil joker?
						-- This used to be the message pop that's
						-- now at the end, but adding this thing
						-- with trying to deal with the negative
						-- issue I think might introduce some
						-- weird delays, so I instead wanted the
						-- message after, but the actual change
						-- changes jkr.debuff - So 
						undebuffing = true
					end
					
					if jkr.edition then
						isNegative = jkr.edition.key == 'e_negative'
					end
					
					if
						isNegative
						and undebuffing
					then
						jkr:set_edition(nil, true, true)
					end
					
					-- Sets debuff state
					SMODS.debuff_card(jkr, desiredDebuffState, "cir_jokerStencils")
					
					if
						isNegative
						and undebuffing
					then
						jkr:set_edition('e_negative', true, false)
					end
					
					if undebuffing then
						SMODS.calculate_effect({ message = "Undebuffed!" }, jkr)
					end
				end
			end
		end
	end
end

return chalInfo