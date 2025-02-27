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

return chalInfo