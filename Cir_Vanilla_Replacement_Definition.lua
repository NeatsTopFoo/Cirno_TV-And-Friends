--[[-----------------------------------------------------------
Moved definitions to this file so that it's hopefully easier to
operate for when you need to do whatever to the stuff for
replacing.
---------------------------------------------------------------]]

local replaceDef = {}
replaceDef.paths = {}
--[[
These will be the paths that are specified in the alt texture blocks for
Malverk.
If no path for safe replacements is provided, it will deffault to normal.]]
replaceDef.paths.cirJokerPath = {
	nrm = 'Vanilla_Replacements/cir_Jokers.png',
	safe = 'Vanilla_Replacements/cir_SafeJokers.png' }

--[[
Legendary Jokers are basically complete. <strikethrough>I don't see there being any
mature references in any changes we might make to the graphics.</strikethrough>
I got mad at Cirno repeatedly saying he'd never install the Big Naturals mod, so I
made Hannah's boobs bigger.]]
replaceDef.paths.cirLJokerPath = {
	nrm = 'Vanilla_Replacements/cir_Legendaries_AndHolo.png',
	safe = 'Vanilla_Replacements/cir_SafeLegendaries_AndHolo.png' }

-- Ehh, I don't see the planets or spectrals having mature references, honestly. Should be fine
replaceDef.paths.cirTPSPath = {
	nrm = 'Vanilla_Replacements/cir_TarotsPlanetsSpectrals_noHu.png',
	planetsAreHus = 'Vanilla_Replacements/cir_TarotsPlanetsSpectrals.png',
	-- safe = ''
	}

replaceDef.paths.cirDecksEnhancersPath = {
	nrm = 'Vanilla_Replacements/cir_DecksEnhancers.png'
	-- safe = ''
	}

--[[
Blind Chips are basically complete. I don't see there being any
mature references in any changes we might make to the graphics.]]
replaceDef.paths.cirBlindChipsPath = { nrm = 'Vanilla_Replacements/cir_BlindChips.png' }

replaceDef.paths.cirVouchersPath = {
	nrm = 'Vanilla_Replacements/cir_Vouchers_noHu.png',
	planetsAreHus = 'Vanilla_Replacements/cir_Vouchers.png',
	-- safe = 'Vanilla_Replacements/'
	}

-- Can't see the boosters having mature references, either.
replaceDef.paths.cirBoostersPath = {
	nrm = 'Vanilla_Replacements/cir_Boosters_noHu.png',
	planetsAreHus = 'Vanilla_Replacements/cir_Boosters.png'
	-- safe = ''
	}

-- Guess we doin tags now
replaceDef.paths.cirTagsPath = {
	nrm = 'Vanilla_Replacements/cir_Tags_NoHu.png',
	planetsAreHus = 'Vanilla_Replacements/cir_Tags.png'
}

replaceDef.getPath = function(replaceType)
	local RV = ""
	
	if type(replaceType) == "string" then
		if
			replaceType == "joker"
			or replaceType == "jokers"
		then
			if
				CirnoMod.config.matureReferences_cyc < 3
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
				CirnoMod.config.matureReferences_cyc < 3
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
				CirnoMod.config.matureReferences_cyc < 3
				and replaceDef.paths.cirDecksEnhancersPath.safe
			then
				RV = replaceDef.paths.cirDecksEnhancersPath.safe
			else
				RV = replaceDef.paths.cirDecksEnhancersPath.nrm
			end
		elseif
			replaceType == "planet"
			or replaceType == "planets"
			or replaceType == "spectral"
			or replaceType == "spectrals"
		then
			if CirnoMod.config.planetsAreHus then
				RV = replaceDef.paths.cirTPSPath.planetsAreHus
			else
				if
					CirnoMod.config.matureReferences_cyc < 3
					and replaceDef.paths.cirTPSPath.safe
				then
					RV = replaceDef.paths.cirTPSPath.safe
				else
					RV = replaceDef.paths.cirTPSPath.nrm
				end
			end
		elseif
			replaceType == "tarot"
			or replaceType == "tarots"
		then
			if
				CirnoMod.config.matureReferences_cyc < 3
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
				CirnoMod.config.matureReferences_cyc < 3
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
			if CirnoMod.config.planetsAreHus then
				RV = replaceDef.paths.cirBoostersPath.planetsAreHus
			else
				if
					CirnoMod.config.matureReferences_cyc < 3
					and replaceDef.paths.cirBoostersPath.safe
				then
					RV = replaceDef.paths.cirBoostersPath.safe
				else
					RV = replaceDef.paths.cirBoostersPath.nrm
				end
			end
		elseif
			replaceType == "tags"
			or replaceType == "tag"
		then
			if CirnoMod.config.planetsAreHus then
				RV = replaceDef.paths.cirTagsPath.planetsAreHus
			else
				RV = replaceDef.paths.cirTagsPath.nrm
			end
		elseif
			replaceType == "voucher"
			or replaceType == "vouchers"
		then
			if CirnoMod.config.planetsAreHus then
				RV = replaceDef.paths.cirVouchersPath.planetsAreHus
			else
				RV = replaceDef.paths.cirVouchersPath.nrm
			end
		end		
	else
		print("Not implemented ("..replaceType..")")
	end
	-- print(RV)
	return RV
end


--[[---------
Playing Cards
(Art Credits 
    Only)    
-------------]]
if CirnoMod.config['playingCardTextures'] then
-- The suits here should be in the other the appear in the graphic, for easier editing

	CirnoMod.miscItems.artCreditKeys.skin_1_Jack_Hearts = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_Queen_Hearts = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_King_Hearts = 'cA_DaemonTsun'
	-- CirnoMod.miscItems.artCreditKeys.skin_1_Ace_Hearts = 'cA_DaemonTsun'
	
	CirnoMod.miscItems.artCreditKeys.skin_1_Jack_Clubs = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_Queen_Clubs = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_King_Clubs = 'cA_DaemonTsun'
	-- CirnoMod.miscItems.artCreditKeys.skin_1_Ace_Clubs = 'cA_DaemonTsun'
	
	CirnoMod.miscItems.artCreditKeys.skin_1_Jack_Diamonds = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_Queen_Diamonds = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_King_Diamonds = 'cA_DaemonTsun'
	-- CirnoMod.miscItems.artCreditKeys.skin_1_Ace_Diamonds = 'cA_DaemonTsun'
	
	CirnoMod.miscItems.artCreditKeys.skin_1_Jack_Spades = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_Queen_Spades = 'cA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys.skin_1_King_Spades = 'cA_DaemonTsun'
	-- CirnoMod.miscItems.artCreditKeys.skin_1_Ace_Spades = 'cA_DaemonTsun'
end

--[[ IMPORTANT:
Since I'm adding an overt mature references
toggle for anyone that may want to stream this
that idk, has a PG-13 stream? (E.g. my kamioshi,
best mayo cat villainess. All praise.) This
should support that.

================================================
       MATURE REFERENCE LEVELS, HOW TO:
Levels 1 & 2 load the safer asset sheet, 3 loads
the normal sheet -

Safer sheet will have the less mature references
on. But if something feels a little mature for
it, then it gets set to 2.

Game elements (Jokers, Tarots, etc.) set to 1
will always be replaced, with the distinction
being that if they're something normally mature
with a safer version, it's loaded from the safer
sheet in the circumstance the setting is less
than 3. Game elements set to 3 do not get replaced
unless the setting is on 3.

3 is explicitly reserved for elements only present
on the normal sheet, without a safer replacement
on the safer sheet (i.e. To-Do List, Diet Cola)

Game elements set to 2 only get replaced if the
setting is on 2 or higher. They can be something
that is normally mature, with a safer replacement
in the safer sheet. but 2 particularly is reserved
for when the replacement in the safer sheet is
itself somewhat questionable (i.e. Delayed Grat).

If the element fits into neither of the above
two descriptions for 2 or 3, it's 1.

For art credits, the following:
If there is only one kind of artist credit
consideration for a given asset, just do one
key in artCreditKey.

If there were multiple (i.e. normal and safer or
normal and planetsAreHus have separate art
contributors, etc.), make artCreditKey with any
of the following values (does not need to contain
all):
planetsAreHus = For Planets Are Hus version of
	something with specific art contribution
	considerations

nrmVer = For normal version of something with
	specific art contribution considerations

saferVer = For safer version of something with
	specific art contribution considerations

default = For situations where either none of
	the above apply or one does, but the others
	are identical art contribution considerations.
	
Note that when artCreditKey is a table, It will
always default to default if it is present and
the conditions do not match for any of the
above.

This is especially important in the case where
the mature reference setting is on 1 and there
are considerations for 3 and 2 - But bear in
mind that at the current time of writing, 1
does not have any specific replacement loading.
It just allows to filter for cases between 1
and 2.

If only saferVer is defined and the mature ref
level is at 3, it will use saferVer.

================================================

Things like descriptions and such will be
handled in their individual rename scripts.

For each thing that we'll be replacing,
we will define the thing being replaced with
its key, then a var that states whether the
graphic is safe or has a safe replacement.

The Malverk script will need to be updated
if we add other things to this ]]

replaceDef.allKeysToIgnore = { -- There's probably a better way to do this
	j_wee = true,
	j_delayed_grat = true,
	j_green_joker = true,
	j_caino = true,
	j_triboulet = true,
	j_yorick = true,
	j_chicot = true,
	j_perkeo = true,
	j_hologram = true,
	c_soul = true
}

----------------
---- Decks -----
--[[------------
Deck art credits don't work unfortunately :(
The tooltip just doesn't appear.
These are also just in the order Malverk's
codebase had them in. These also kinda
control which decks the texture pack replaces
anyway, so]]
replaceDef.deckReplacements = { 
	{ dckKey = 'b_red', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_blue', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_yellow', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_green', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_black', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_magic', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_nebula', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_ghost', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_abandoned', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_checkered', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	-- { dckKey = 'b_zodiac', matureRefLevel = 1 },
	{ dckKey = 'b_painted', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_anaglyph', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_plasma', matureRefLevel = 1 },
	{ dckKey = 'b_erratic', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' },
	{ dckKey = 'b_challenge', matureRefLevel = 1, artCreditKey = 'dA_DaemonTsun' }
}

-------------------
---- Boosters -----
-------------------
replaceDef.boosterReplacements = { -- These are just in the order Malverk's codebase had them in. Could rearrange them to match the graphic for easier editing.
	{ bstKey = 'p_arcana_normal_1', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_BigNTFEdit' },
	{ bstKey = 'p_arcana_normal_2', matureRefLevel = 1, artCreditKey = 'bA_RH_DaemonTsunEdit' },
	{ bstKey = 'p_arcana_normal_3', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_BigNTFEdit' },
	--	{ bstKey = 'p_arcana_normal_4', matureRefLevel = 1, },
	{ bstKey = 'p_arcana_jumbo_1', matureRefLevel = 1, artCreditKey = 'bA_RH_DaemonTsunEdit' },
	{ bstKey = 'p_arcana_jumbo_2', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_BigNTFEdit' },
	{ bstKey = 'p_arcana_mega_1', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_BigNTFEdit' },
	{ bstKey = 'p_arcana_mega_2', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_BigNTFEdit' },
	{ bstKey = 'p_celestial_normal_1', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_genPack_ZUN' }, planetsAreHus = true },
	{ bstKey = 'p_celestial_normal_2', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_genPack_Daiyousei' }, planetsAreHus = true },
	{ bstKey = 'p_celestial_normal_3', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_genPack_Renko' }, planetsAreHus = true },
	{ bstKey = 'p_celestial_normal_4', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_DaemonTsun_NTF_Both' }, planetsAreHus = true },
	{ bstKey = 'p_celestial_jumbo_1', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_genPack_ZUN' }, planetsAreHus = true },
	{ bstKey = 'p_celestial_jumbo_2', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_genPack_ZUN' }, planetsAreHus = true },
	{ bstKey = 'p_celestial_mega_1', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_genPack_ZUN' }, planetsAreHus = true },
	{ bstKey = 'p_celestial_mega_2', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'bA_genPack_ZUN' }, planetsAreHus = true },
	--	{ bstKey = 'p_spectral_normal_1', matureRefLevel = 1, },
	--	{ bstKey = 'p_spectral_normal_2', matureRefLevel = 1, },
	--	{ bstKey = 'p_spectral_jumbo_1', matureRefLevel = 1, },
	--	{ bstKey = 'p_spectral_mega_1', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_normal_1', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_normal_2', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_normal_3', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_normal_4', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_jumbo_1', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_jumbo_2', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_mega_1', matureRefLevel = 1, },
	--	{ bstKey = 'p_standard_mega_2', matureRefLevel = 1, },
	{ bstKey = 'p_buffoon_normal_1', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_NTFEdit' },
	{ bstKey = 'p_buffoon_normal_2', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_NTFEdit' },
	{ bstKey = 'p_buffoon_jumbo_1', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_NTFEdit' },
	{ bstKey = 'p_buffoon_mega_1', matureRefLevel = 1, artCreditKey = 'bA_DaemonTsun_BigNTFEdit' }
}

-----------------
---- Jokers -----
-----------------
replaceDef.jokerReplacements = {
	--[[
	Joker keys in this list are in the order they appear on the joker
	sheet, from left to right, top to bottom, with whitespace gaps
	representing where one line in the Joker sheet ends and another
	begins. I set it up this way to increase compatibility with other
	Malverk mods all the time we're not replacing every single Joker.
	I will likely rewrite the Malverk implementation to be an individual
	AltTexture block for each rarity, if and when we approach
	replacing every single Joker. This is because my suspicion at the
	time of writing is that the discrete settings assignments in the
	Malverk UI (within the mod card) are assigned per AltTexture
	block and so giving people more things to toggle on and off
	corresponmding to different Jokers will just ultimately be
	better. I think. It's pain time, yaaaaaaaay!]]
	
	-- The art credit keys can be found (and added to) in localization/en-us.lua.
	
	{ jkrKey = 'j_joker', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	
	--[[
	Even though this is treated differently, credit still goes through
	this, so. I did also check with Cirno, the artist behind cirFairy
	is apparently some giga old chatter from back in the day and is
	to my knowledge, not any of the listed artists on his channel.]]
	{ jkrKey = 'j_wee', matureRefLevel = 1, artCreditKey = 'jA_solgryn' },
	
	{ jkrKey = 'j_chaos', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_jolly', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_zany', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_mad', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_crazy', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_droll', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_half', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_merry_andy', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_stone', matureRefLevel = 1, artCreditKey = 'jA_BocchiTheRock' },
	
	{ jkrKey = 'j_juggler', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_drunkard', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_acrobat', matureRefLevel = 1, artCreditKey = 'jA_Acrobat' },
	{ jkrKey = 'j_sock_and_buskin', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_mime', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_credit_card', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_greedy_joker', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_lusty_joker', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_wrathful_joker', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_gluttenous_joker', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' }, -- Yes, it's mispelled internally. LocalThunk issue. See game files
	
	{ jkrKey = 'j_troubadour', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_banner', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTFEdit' },
	{ jkrKey = 'j_mystic_summit', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_marble', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_loyalty_card', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_hack', matureRefLevel = 1, artCreditKey = 'jA_Hack' },
	{ jkrKey = 'j_misprint', matureRefLevel = 1, artCreditKey = 'jA_Misprint' },
	{ jkrKey = 'j_steel_joker', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_raised_fist', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_golden', matureRefLevel = 1, artCreditKey = 'jA_ciwnoEdit' },
	
	{ jkrKey = 'j_blueprint', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_glass', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_scary_face', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_abstract', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_delayed_grat', matureRefLevel = 2, artCreditKey = { saferVer = 'jA_DaemonTsun' } },
	{ jkrKey = 'j_ticket', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_pareidolia', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_cartomancer', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_even_steven', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_odd_todd', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	
	{ jkrKey = 'j_scholar', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_business', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_ComCon' },
	{ jkrKey = 'j_supernova', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_mr_bones', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_seeing_double', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_duo', matureRefLevel = 1, artCreditKey = 'jA_DuoDagger' },
	{ jkrKey = 'j_trio', matureRefLevel = 1, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	{ jkrKey = 'j_family', matureRefLevel = 1, artCreditKey = 'jA_Family' },
	-- { jkrKey = 'j_order', matureRefLevel = 1 },
	{ jkrKey = 'j_tribe', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	
	{ jkrKey = 'j_8_ball', matureRefLevel = 1, artCreditKey = 'jA_LocalThunk_NTFEdit' },
	{ jkrKey = 'j_fibonacci', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_stencil', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_space', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_matador', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_ceremonial', matureRefLevel = 1, artCreditKey = 'jA_DuoDagger' },
	{ jkrKey = 'j_ring_master', matureRefLevel = 1, artCreditKey = 'jA_JustIRLCirno' }, -- Yes, this is Showman. You have no idea how mad I am that it's called this internally.
	{ jkrKey = 'j_fortune_teller', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_hit_the_road', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_swashbuckler', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_ComCon' },
	
	{ jkrKey = 'j_flower_pot', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_ride_the_bus', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_shoot_the_moon', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_smeared', matureRefLevel = 1, artCreditKey = 'jA_smeared' },
	{ jkrKey = 'j_oops', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_four_fingers', matureRefLevel = 1, artCreditKey = 'jA_fourFingers'  },
	{ jkrKey = 'j_gros_michel', matureRefLevel = 1, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit_ComCon' },
	{ jkrKey = 'j_stuntman', matureRefLevel = 1, artCreditKey = 'jA_JustIRLCirno' },
	{ jkrKey = 'j_hanging_chad', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	
	{ jkrKey = 'j_drivers_license', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_invisible', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_astronomer', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_burnt', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_dusk', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_throwback', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_idol', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_ComCon' },
	{ jkrKey = 'j_brainstorm', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_satellite', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_rough_gem', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	
	
	{ jkrKey = 'j_bloodstone', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_arrowhead', matureRefLevel = 1, artCreditKey = 'jA_mcMeme' },
	{ jkrKey = 'j_onyx_agate', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	
	----- Legendary Jokers & Hologram don't get passed into the		 -----
	----- Malverk script from this, because they have to be handled  -----
	----- by a different alt texture block. However, they're present -----
	----- for simplificiation of doing the credits, anyrway.			 -----
	{ jkrKey = 'j_caino', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_triboulet', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_yorick', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_chicot', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_BigNTFEdit' },
	{ jkrKey = 'j_perkeo', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_hologram', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	
	{ jkrKey = 'j_certificate', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_bootstraps', matureRefLevel = 1, artCreditKey = 'jA_Unknown_NTFEdit' },
	
	
	{ jkrKey = 'j_egg', matureRefLevel = 1, artCreditKey = 'jA_Egg' },
	{ jkrKey = 'j_burglar', matureRefLevel = 1, artCreditKey = 'jA_Burglar' },
	{ jkrKey = 'j_blackboard', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_ice_cream', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_runner', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_dna', matureRefLevel = 1, artCreditKey = 'jA_Gote_NTFEdit' },
	{ jkrKey = 'j_splash', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_blue_joker', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_sixth_sense', matureRefLevel = 1, artCreditKey = 'jA_ciwnoEdit' },
	{ jkrKey = 'j_constellation', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	
	{ jkrKey = 'j_hiker', matureRefLevel = 1, artCreditKey = 'jA_JustIRLCirno' },
	{ jkrKey = 'j_faceless', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_green_joker', matureRefLevel = 2, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_superposition', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_todo_list', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_cavendish', matureRefLevel = 1, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	{ jkrKey = 'j_card_sharp', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_red_card', matureRefLevel = 1, artCreditKey = 'jA_RedCard' },
	{ jkrKey = 'j_madness', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_square', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	
	{ jkrKey = 'j_seance', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_riff_raff', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_vampire', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_shortcut', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_vagabond', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_baron', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_cloud_9', matureRefLevel = 1, artCreditKey = 'jA_LocalThunk_DaemonTsunEdit' },
	{ jkrKey = 'j_rocket', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_obelisk', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' }, -- Petition to rename this "Worst Joker in the Game."
	
	{ jkrKey = 'j_midas_mask', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_luchador', matureRefLevel = 1, artCreditKey = 'jA_mcMeme' },
	{ jkrKey = 'j_photograph', matureRefLevel = 1, artCreditKey = 'jA_ciwnoEdit' },
	{ jkrKey = 'j_gift', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_turtle_bean', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_erosion', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_reserved_parking', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_mail', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_ComCon' },
	-- { jkrKey = 'j_to_the_moon', matureRefLevel = 1 },
	{ jkrKey = 'j_hallucination', matureRefLevel = 1, artCreditKey = 'jA_ObsvDuty' },
	
	{ jkrKey = 'j_sly', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_wily', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_clever', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_devious', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_crafty', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_NTF_Both' },
	{ jkrKey = 'j_lucky_cat', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_baseball', matureRefLevel = 1, artCreditKey = 'jA_Baseball' },
	{ jkrKey = 'j_bull', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_diet_cola', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_trading', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	
	{ jkrKey = 'j_flash', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_popcorn', matureRefLevel = 1, artCreditKey = 'jA_NTF' },
	{ jkrKey = 'j_ramen', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_selzer', matureRefLevel = 1, artCreditKey = 'jA_LocalThunk_NTFEdit' },
	{ jkrKey = 'j_trousers', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun_ComCon' },
	{ jkrKey = 'j_campfire', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_smiley', matureRefLevel = 1, artCreditKey = 'jA_LocalThunk_NTFEdit' },
	{ jkrKey = 'j_ancient', matureRefLevel = 1, artCreditKey = 'jA_Ancient' },
	{ jkrKey = 'j_walkie_talkie', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' },
	{ jkrKey = 'j_castle', matureRefLevel = 1, artCreditKey = 'jA_DaemonTsun' }
}

-----------------
---- Tarots -----
-----------------
replaceDef.tarotReplacements = {
	{ trtKey = 'c_fool', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_magician', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_high_priestess', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_empress', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_emperor', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_heirophant', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' }, -- Yes, also mispelled internally; Make sure to have it right... Or wrong, in this case.
	{ trtKey = 'c_lovers', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_chariot', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_justice', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_hermit', matureRefLevel = 1, artCreditKey = 'cA_RHEdit' },
	{ trtKey = 'c_wheel_of_fortune', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_strength', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun_ComCon' },
	{ trtKey = 'c_hanged_man', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_death', matureRefLevel = 1, artCreditKey = 'cA_RHEdit_ComCon' },
	{ trtKey = 'c_temperance', matureRefLevel = 1, artCreditKey = 'cA_RHEdit' },
	{ trtKey = 'c_devil', matureRefLevel = 1, artCreditKey = 'cA_Devil' },
	{ trtKey = 'c_tower', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_star', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_moon', matureRefLevel = 1, artCreditKey = 'cA_RHEdit' },
	{ trtKey = 'c_sun', matureRefLevel = 1, artCreditKey = 'cA_Sun' },
	{ trtKey = 'c_judgement', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ trtKey = 'c_world', matureRefLevel = 1, artCreditKey = 'cA_LocalThunk_NTFEdit' }
}

-----------------
---- Planets ----
-----------------
replaceDef.planetReplacements = {
	{ plnKey = 'c_ceres', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_earth', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_eris', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_jupiter', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_mars', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_mercury', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_neptune', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun_NTF_Both' },
	{ plnKey = 'c_planet_x', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_pluto', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_saturn', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_uranus', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true },
	{ plnKey = 'c_venus', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun_NTF_Both_ComCon' }, planetsAreHus = true }
}

--------------------
---- Spectrals -----
--------------------
replaceDef.spectralReplacements = {
	{ spcKey = 'c_ankh', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun_NTFEdit' },
	{ spcKey = 'c_aura', matureRefLevel = 1, artCreditKey = 'cA_DaemonTsun' },
	{ spcKey = 'c_black_hole', matureRefLevel = 1, artCreditKey = 'gA_BlackHole' },
	{ spcKey = 'c_cryptid', matureRefLevel = 1 },
	{ spcKey = 'c_deja_vu', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
	--	{ spcKey = 'c_octoplasm', matureRefLevel = 1 },
	--	{ spcKey = 'c_familiar', matureRefLevel = 1 },
	{ spcKey = 'c_grim', matureRefLevel = 1, artCreditKey = 'gA_cirThing_Edit' },
	--	{ spcKey = 'c_hex', matureRefLevel = 1 },
	{ spcKey = 'c_immolate', matureRefLevel = 1, artCreditKey = 'gA_Immolate' },
	--	{ spcKey = 'c_incantation', matureRefLevel = 1 },
	--	{ spcKey = 'c_medium', matureRefLevel = 1 },
	{ spcKey = 'c_ouija', matureRefLevel = 1, artCreditKey = 'gA_NTF' },
	--	{ spcKey = 'c_sigil', matureRefLevel = 1 },
	{ spcKey = 'c_soul', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun_BigNTFEdit' },
	--	{ spcKey = 'c_talisman', matureRefLevel = 1 },
	{ spcKey = 'c_trance', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun_BigNTFEdit' },
	{ spcKey = 'c_wraith', matureRefLevel = 1, artCreditKey = 'gA_Wraith' }
}

--------------------
---- Enhancers -----
--------------------
replaceDef.enhancerReplacements = {
	{ enhKey = 'm_bonus', matureRefLevel = 1, artCreditKey = 'eA_DaemonTsun' },
	--	{ enhKey = 'm_mult', matureRefLevel = 1, },
	{ enhKey = 'm_wild', matureRefLevel = 1, artCreditKey = 'eA_DaemonTsun' },
	{ enhKey = 'm_glass', matureRefLevel = 1, artCreditKey = 'eA_DaemonTsun' },
	--	{ enhKey = 'm_steel', matureRefLevel = 1, },
	{ enhKey = 'm_stone', matureRefLevel = 1, artCreditKey = 'eA_Unknown' },
	{ enhKey = 'm_gold', matureRefLevel = 1, artCreditKey = 'eA_LocalThunk_NTFEdit' },
	--	{ enhKey = 'm_lucky' matureRefLevel = 1, }
}

----------------
----- Tags -----
----------------
replaceDef.tagReplacements = {
	{ tagKey = 'tag_uncommon', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_rare', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_negative', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_foil', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun_BigNTFEdit' },
    { tagKey = 'tag_holo', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun_BigNTFEdit' },
    { tagKey = 'tag_polychrome', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_investment', matureRefLevel = 1, artCreditKey = 'gA_solgryn' },
    -- { tagKey = 'tag_voucher', matureRefLevel = 1 },
    -- { tagKey = 'tag_boss', matureRefLevel = 1 },
    { tagKey = 'tag_standard', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    -- { tagKey = 'tag_charm', matureRefLevel = 1 },
    { tagKey = 'tag_meteor', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_NTF' }, planetsAreHus = true },
    { tagKey = 'tag_buffoon', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun_NTF_Both' },
    { tagKey = 'tag_handy', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_garbage', matureRefLevel = 1, artCreditKey = 'gA_neptunia' },
    { tagKey = 'tag_ethereal', matureRefLevel = 1, artCreditKey = 'gA_NTF' },
    { tagKey = 'tag_coupon', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_double', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_juggle', matureRefLevel = 2, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_d_six', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_top_up', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_skip', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { tagKey = 'tag_orbital', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_NTF' }, planetsAreHus = true },
    { tagKey = 'tag_economy', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' }
}

--------------------
----- Vouchers -----
--------------------
replaceDef.voucherReplacements = {
	{ vchKey = 'v_overstock_norm', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_clearance_sale', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_hone', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_reroll_surplus', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_crystal_ball', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_telescope', matureRefLevel = 1, artCreditKey = 'gA_NTF', planetsAreHus = true },
    { vchKey = 'v_grabber', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_wasteful', matureRefLevel = 1, artCreditKey = 'gA_IF_NTF' },
    { vchKey = 'v_tarot_merchant', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_planet_merchant', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun' }, planetsAreHus = true },
    -- { vchKey = 'v_seed_money', matureRefLevel = 1, artCreditKey = '' },
    { vchKey = 'v_blank', matureRefLevel = 1, artCreditKey = 'gA_NTF' },
    -- { vchKey = 'v_magic_trick', matureRefLevel = 1, artCreditKey = '' },
	{ vchKey = 'v_hieroglyph', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    -- { vchKey = 'v_directors_cut', matureRefLevel = 1, artCreditKey = '' },
    { vchKey = 'v_paint_brush', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_overstock_plus', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_liquidation', matureRefLevel = 1, artCreditKey = 'gaben' },
    { vchKey = 'v_glow_up', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    -- { vchKey = 'v_reroll_glut', matureRefLevel = 1, artCreditKey = '' },
    { vchKey = 'v_omen_globe', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    -- { vchKey = 'v_observatory', matureRefLevel = 1, artCreditKey = '', planetsAreHus = true },
    { vchKey = 'v_nacho_tong', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' },
    { vchKey = 'v_recyclomancy', matureRefLevel = 1, artCreditKey = 'gA_IF_NTF' },
    { vchKey = 'v_tarot_tycoon', matureRefLevel = 1, artCreditKey = 'gA_RHEdit' },
    { vchKey = 'v_planet_tycoon', matureRefLevel = 1, artCreditKey = { planetsAreHus = 'gA_DaemonTsun' }, planetsAreHus = true },
    -- { vchKey = 'v_money_tree', matureRefLevel = 1, artCreditKey = '' },
    { vchKey = 'v_antimatter', matureRefLevel = 1, artCreditKey = 'gA_NTF' },
    -- { vchKey = 'v_illusion', matureRefLevel = 1, artCreditKey = '' },
    { vchKey = 'v_petroglyph', matureRefLevel = 1, artCreditKey = 'petroglyph' },
    -- { vchKey = 'v_retcon', matureRefLevel = 1, artCreditKey = '' },
    { vchKey = 'v_palette', matureRefLevel = 1, artCreditKey = 'gA_DaemonTsun' }
}

return replaceDef