---------------------------------------------------------------------------
----- Moved definitions to this file so that it's hopefully easier to -----
----- operate for when you need to do whatever to the stuff for       -----
----- replacing.													  -----
---------------------------------------------------------------------------

local replaceDef = {}
replaceDef.paths = {}
---- These will be the paths that are specified in the alt texture blocks for  -----
---- Malverk.																   -----
---- If no path for safe replacements is provided, it will deffault to normal. -----
replaceDef.paths.cirJokerPath = {
	nrm = 'Vanilla_Replacements/cir_Jokers.png',
	safe = 'Vanilla_Replacements/cir_SafeJokers.png' }

-- Legendary Jokers are basically complete. I don't see there being any
-- mature references in any changes we might make to the graphics.
replaceDef.paths.cirLJokerPath = { nrm = 'Vanilla_Replacements/cir_Legendaries.png' }

replaceDef.paths.cirTPSPath = {
	nrm = 'Vanilla_Replacements/cir_TarotsPlanetsSpectrals.png',
	-- safe = ''
	}

replaceDef.paths.cirDecksEnhancersPath = {
	nrm = 'Vanilla_Replacements/cir_DecksEnhancers.png'
	-- safe = ''
	}

-- Blind Chips are basically complete. I don't see there being any
-- mature references in any changes we might make to the graphics.
replaceDef.paths.cirBlindChipsPath = { nrm = 'Vanilla_Replacements/cir_BlindChips.png' }

--	replaceDef.paths.cirVouchersPath = {
--		nrm = '',
--		safe = ''
--		}

replaceDef.paths.cirBoostersPath = {
	nrm = 'Vanilla_Replacements/cir_Boosters.png',
	-- safe = ''
	}

replaceDef.getPath = function(replaceType)
	local RV = ""
	
	if type(replaceType) == "string" then
		if
			replaceType == "joker"
			or replaceType == "jokers"
		then
			if
				not CirnoMod.allEnabledOptions['matureReferences']
				and replaceDef.paths.cirJokerPath.safe
			then
				RV = replaceDef.paths.cirJokerPath.safe
			else
				RV = replaceDef.paths.cirJokerPath.nrm
			end
		elseif
			replaceType == "l_joker"
			or replaceType == "l_jokers"
		then
			if
				not CirnoMod.allEnabledOptions['matureReferences']
				and replaceDef.paths.cirLJokerPath.safe
			then
				RV = replaceDef.paths.cirLJokerPath.safe
			else
				RV = replaceDef.paths.cirLJokerPath.nrm
			end
		elseif
			replaceType == "deck"
			or replaceType == "decks"
			or replaceType == "enhancer"
			or replaceType == "enhancers"
		then
			if
				not CirnoMod.allEnabledOptions['matureReferences']
				and replaceDef.paths.cirDecksEnhancersPath.safe
			then
				RV = replaceDef.paths.cirDecksEnhancersPath.safe
			else
				RV = replaceDef.paths.cirDecksEnhancersPath.nrm
			end
		elseif
			replaceType == "tarot"
			or replaceType == "tarots"
			or replaceType == "planet"
			or replaceType == "planets"
			or replaceType == "spectral"
			or replaceType == "spectrals"
		then
			if
				not CirnoMod.allEnabledOptions['matureReferences']
				and replaceDef.paths.cirTPSPath.safe
			then
				RV = replaceDef.paths.cirTPSPath.safe
			else
				RV = replaceDef.paths.cirTPSPath.nrm
			end
		elseif
			replaceType == "blind"
			or replaceType == "blinds"
			or replaceType == "blindchip"
			or replaceType == "blindchips"
		then
			if
				not CirnoMod.allEnabledOptions['matureReferences']
				and replaceDef.paths.cirBlindChipsPath.safe
			then
				RV = replaceDef.paths.cirBlindChipsPath.safe
			else
				RV = replaceDef.paths.cirBlindChipsPath.nrm
			end
		elseif
			replaceType == "booster"
			or replaceType == "boosters"
		then
			if
				not CirnoMod.allEnabledOptions['matureReferences']
				and replaceDef.paths.cirBoostersPath.safe
			then
				RV = replaceDef.paths.cirBoostersPath.safe
			else
				RV = replaceDef.paths.cirBoostersPath.nrm
			end
		elseif
			replaceType == "voucher"
			or replaceType == "vouchers"
		then
			print("Not implemented (CirnoMod.replaceDef.getPath(voucher))")
		end		
	else
		print("CirnoMod.replaceDef.getPath() called with an invalid argument")
	end
	-- print(RV)
	return RV
end

-- IMPORTANT:
-- Since I'm adding an overt mature references
-- toggle for anyone that may want to stream this
-- that idk, has a PG-13 stream? (E.g. my Oshi,
-- best mayo cat villainess. All praise.) This
-- should support that. So then when the mature
-- references are DISABLED, the mod will either
-- need to not replace the graphic replacements
-- that are mature references, or be able to
-- replace them with something else.

-- Things like descriptions and such will be
-- handled in their individual rename scripts.

-- To that end, I've created a simple structure
-- here: For each thing that we'll be replacing,
-- we will define the thing being replaced with
-- its key, then a flag that states whether the
-- graphic is safe or has a safe replacement.

-- The Malverk script will need to be updated
-- if we add other things to this 

----------------
---- Decks -----
----------------
replaceDef.deckReplacements = { -- Deck art credits don't work unfortunately :( The tooltip just doesn't appear
	{ dckKey = 'b_red', isSafeOrHasSafeVariant = true, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_blue', isSafeOrHasSafeVariant = true, artCreditKey = 'dA_DaemonTsun' },
	-- { dckKey = 'b_yellow', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_green', isSafeOrHasSafeVariant = true },
	{ dckKey = 'b_black', isSafeOrHasSafeVariant = true, artCreditKey = 'dA_DaemonTsun' },
	-- { dckKey = 'b_magic', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_nebula', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_ghost', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_abandoned', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_checkered', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_zodiac', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_painted', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_anaglyph', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_plasma', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_erratic', isSafeOrHasSafeVariant = true },
	-- { dckKey = 'b_challenge, isSafeOrHasSafeVariant = true }
}

-------------------
---- Boosters -----
-------------------
replaceDef.boosterReplacements = {
	{ bstKey = 'p_arcana_normal_1', isSafeOrHasSafeVariant = true, artCreditKey = 'gA_DaemonTsun_BigNTFEdit' },
	--	{ bstKey = 'p_arcana_normal_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_arcana_normal_3', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_arcana_normal_4', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_arcana_jumbo_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_arcana_jumbo_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_arcana_mega_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_arcana_mega_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_normal_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_normal_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_normal_3', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_normal_4', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_jumbo_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_jumbo_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_mega_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_celestial_mega_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_spectral_normal_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_spectral_normal_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_spectral_jumbo_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_spectral_mega_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_normal_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_normal_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_normal_3', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_normal_4', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_jumbo_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_jumbo_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_mega_1', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_standard_mega_2', isSafeOrHasSafeVariant = true, },
	{ bstKey = 'p_buffoon_normal_1', isSafeOrHasSafeVariant = true, artCreditKey = 'gA_DaemonTsun_NTFEdit' },
	--	{ bstKey = 'p_buffoon_normal_2', isSafeOrHasSafeVariant = true, },
	--	{ bstKey = 'p_buffoon_jumbo_1', isSafeOrHasSafeVariant = true, },
	{ bstKey = 'p_buffoon_mega_1', isSafeOrHasSafeVariant = true, artCreditKey = 'gA_DaemonTsun_BigNTFEdit' }
}

-----------------
---- Jokers -----
-----------------
replaceDef.jokerReplacements = {
	-- Joker keys in this list are in the order they appear on the joker
	-- sheet, from left to right, top to bottom, with whitespace gaps
	-- representing where one line in the Joker sheet ends and another
	-- begins. I set it up this way to increase compatibility with other
	-- Malverk mods all the time we're not replacing every single Joker.
	-- I will likely rewrite the Malverk implementation to be an individual
	-- AltTexture block for each rarity, if and when we approach
	-- replacing every single Joker. This is because my suspicion at the
	-- time of writing is that the discrete settings assignments in the
	-- Malverk UI (within the mod card) are assigned per AltTexture
	-- block and so giving people more things to toggle on and off
	-- corresponmding to different Jokers will just ultimately be
	-- better. I think. It's pain time, yaaaaaaaay!
	
	-- The art credit keys can be found (and added to) in localization/en-us.lua.
	
	{ jkrKey = 'j_joker', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	
	-- Even though this is treated differently, credit still goes through
	-- this, so. I did also check with Cirno, the artist behind cirFairy
	-- is apparently some giga old chatter from back in the day and is
	-- to my knowledge, not any of the listed artists on his channel.
	{ jkrKey = 'j_wee', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Unknown' },
	{ jkrKey = 'j_chaos', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_MikuTheClown' },
	-- { jkrKey = 'j_jolly', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_zany', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_mad', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_crazy', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_droll', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_half', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	-- { jkrKey = 'j_merry_andy', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_stone', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_BocchiTheRock' },
	
	-- { jkrKey = 'j_jugglar', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_drunkard', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_acrobat', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_sock_and_buskin', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_mime', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Mime' },
	{ jkrKey = 'j_credit_card', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_greedy_joker', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_lusty_joker', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_wrathful_joker', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_gluttenous_joker', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' }, -- Yes, it's mispelled internally. LocalThunk issue. See game files
	
	-- { jkrKey = 'j_troubadour', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_banner', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_mystic_summit', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_marble', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_loyalty_card', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_hack', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Hack' },
	{ jkrKey = 'j_misprint', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Misprint' },
	-- { jkrKey = 'j_steel_joker', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_raised_fist', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_golden', isSafeOrHasSafeVariant = true },
	
	{ jkrKey = 'j_blueprint', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_glass', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_scary_face', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_abstract', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_delayed_grat', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_ticket', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_pareidolia' },
	-- { jkrKey = 'j_cartomancer', isSafeOrHasSafeVariant = true  },
	-- { jkrKey = 'j_even_steven', isSafeOrHasSafeVariant = true  },
	-- { jkrKey = 'j_odd_todd', isSafeOrHasSafeVariant = true },
	
	-- { jkrKey = 'j_scholar', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_business', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_supernova', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_mr_bones', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	-- { jkrKey = 'j_seeing_double', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_duo', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_trio', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_family', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_order', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_tribe', isSafeOrHasSafeVariant = true },
	
	-- { jkrKey = 'j_8_ball', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_fibonacci', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_stencil', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_space', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_matador', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_ceremonial', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_ring_master', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_JustIRLCirno' }, -- Yes, this is Showman. You have no idea how mad I am that it's called this internally.
	-- { jkrKey = 'j_fortune_teller', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_hit_the_road', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_swashbuckler', isSafeOrHasSafeVariant = true  },
	
	-- { jkrKey = 'j_flower_pot', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_ride_the_bus', isSafeOrHasSafeVariant = true  },
	{ jkrKey = 'j_shoot_the_moon', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_smeared', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_oops', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_four_fingers', isSafeOrHasSafeVariant = true  },
	-- { jkrKey = 'j_gros_michel', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_stuntman', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_JustIRLCirno' },
	{ jkrKey = 'j_hanging_chad', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	
	-- { jkrKey = 'j_drivers_license', isSafeOrHasSafeVariant = true  },
	-- { jkrKey = 'j_invisible', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_astronomer', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_burnt', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_dusk', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_throwback', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	-- { jkrKey = 'j_idol', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_brainstorm', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	-- { jkrKey = 'j_satellite', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_rough_gem', isSafeOrHasSafeVariant = true },
	
	-- { jkrKey = 'j_bloodstone', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_arrowhead', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_onyx_agate', isSafeOrHasSafeVariant = true },
	
	----- Legendary Jokers & Hologram don't get passed into the		 -----
	----- Malverk script from this, because they have to be handled  -----
	----- by a different alt texture block. However, they're present -----
	----- for simplificiation of doing the credits, anyrway.			 -----
	{ jkrKey = 'j_caino', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_triboulet', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_yorick', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_chicot', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_perkeo', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	-- { jkrKey = 'j_hologram', isSafeOrHasSafeVariant = true, artCreditKey = '' },
	
	{ jkrKey = 'j_certificate', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_bootstraps', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Unknown_NTFEdit' },
	
	{ jkrKey = 'j_egg', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Egg' },
	{ jkrKey = 'j_burglar', isSafeOrHasSafeVariant = false, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	-- { jkrKey = 'j_blackboard', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_ice_cream', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_runner', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_dna', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Unknown_NTFEdit' },
	-- { jkrKey = 'j_splash', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_blue_joker', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_sixth_sense', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_constellation', isSafeOrHasSafeVariant = true },
	
	{ jkrKey = 'j_hiker', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_JustIRLCirno' },
	-- { jkrKey = 'j_faceless', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_green_joker', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_superposition', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_todo_list', isSafeOrHasSafeVariant = false, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	{ jkrKey = 'j_cavendish', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	-- { jkrKey = 'j_card_sharp', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_red_card', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_madness', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_square', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_seance', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_riff_raff', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_vampire', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_shortcut', isSafeOrHasSafeVariant = true },
	
	----- Hologram is funky. Let me know if you work something out for its graphic. -----
	
	-- { jkrKey = 'j_vagabond', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_baron', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_cloud_9', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	-- { jkrKey = 'j_rocket' },
	-- { jkrKey = 'j_obelisk', isSafeOrHasSafeVariant = true }, -- Petition to rename this "Worst Joker in the Game."
	
	-- { jkrKey = 'j_midas_mask', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_luchador', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_photograph', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_gift', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_turtle_bean', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_erosion', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_reserved_parking', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_mail', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_to_the_moon', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_hallucination', isSafeOrHasSafeVariant = true },
	
	-- { jkrKey = 'j_sly', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_wily', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_clever', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_DaemonTsun' },
	-- { jkrKey = 'j_devious', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_crafty', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_lucky_cat', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_baseball', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_Baseball' },
	-- { jkrKey = 'j_bull', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_diet_cola', isSafeOrHasSafeVariant = false, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	-- { jkrKey = 'j_trading', isSafeOrHasSafeVariant = true },
	
	-- { jkrKey = 'j_flash', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_popcorn', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_NTF' },
	-- { jkrKey = 'j_ramen', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_selzer', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_LocalThunk_NTFEdit' },
	-- { jkrKey = 'j_spare_trousers', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_campfire', isSafeOrHasSafeVariant = true },
	{ jkrKey = 'j_smiley', isSafeOrHasSafeVariant = true, artCreditKey = 'jA_LocalThunk_NTFEdit' },
	-- { jkrKey = 'j_ancient', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_walkie_talkie', isSafeOrHasSafeVariant = true },
	-- { jkrKey = 'j_castle', isSafeOrHasSafeVariant = true }
}
replaceDef.jkrKeysToIgnore = { -- Probably a better way to do this
	j_wee = true,
	j_caino = true,
	j_triboulet = true,
	j_yorick = true,
	j_chicot = true,
	j_perkeo = true,
	j_hologram = true
}

-----------------
---- Tarots -----
-----------------
replaceDef.tarotReplacements = {
	{ trtKey = 'c_fool', isSafeOrHasSafeVariant = true, artCreditKey = 'gA_DaemonTsun' },
	--	{ trtKey = 'c_magician', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_high_priestess', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_empress', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_emperor', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_heirophant', isSafeOrHasSafeVariant = true }, -- Yes, also mispelled internally; Make sure to have it right... Or wrong, in this case.
	--	{ trtKey = 'c_lovers', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_chariot', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_justice', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_hermit', isSafeOrHasSafeVariant = true },
	{ trtKey = 'c_wheel_of_fortune', isSafeOrHasSafeVariant = true, artCreditKey = 'gA_NTF' },
	{ trtKey = 'c_strength', isSafeOrHasSafeVariant = true, artCreditKey = 'gA_DaemonTsun' },
	--	{ trtKey = 'c_hanged_man', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_death', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_temperance', isSafeOrHasSafeVariant = true },
	{ trtKey = 'c_devil', isSafeOrHasSafeVariant = true, artCreditKey = 'gA_DaemonTsun' },
	--	{ trtKey = 'c_tower', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_star', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_moon', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_sun', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_judgement', isSafeOrHasSafeVariant = true },
	--	{ trtKey = 'c_world', isSafeOrHasSafeVariant = true }
}

-----------------
---- Planets ----
-----------------
replaceDef.planetReplacements = { -- Planets are not fully implemented yet. Just add them here as you do them and I'll get around to it.
	--	{ plnKey = 'c_ceres', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_earth', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_eris', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_jupiter', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_mars', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_mercury', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_neptune', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_planet_x', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_pluto', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_saturn', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_uranus', isSafeOrHasSafeVariant = true, },
	--	{ plnKey = 'c_venus', isSafeOrHasSafeVariant = true, }
}

--------------------
---- Spectrals -----
--------------------
replaceDef.spectralReplacements = {
	-- TODO
}

--------------------
---- Enhancers -----
--------------------
replaceDef.enhancerReplacements = {
	--	{ enhKey = 'm_bonus', isSafeOrHasSafeVariant = true, },
	--	{ enhKey = 'm_mult', isSafeOrHasSafeVariant = true, },
	--	{ enhKey = 'm_wild', isSafeOrHasSafeVariant = true, },
	--	{ enhKey = 'm_glass', isSafeOrHasSafeVariant = true, },
	--	{ enhKey = 'm_steel', isSafeOrHasSafeVariant = true, },
	{ enhKey = 'm_stone', isSafeOrHasSafeVariant = true, artCreditKey = 'eA_Unknown' },
	--	{ enhKey = 'm_gold', isSafeOrHasSafeVariant = true, },
	--	{ enhKey = 'm_lucky' isSafeOrHasSafeVariant = true, }
}


-- TODO: Vouchers

return replaceDef