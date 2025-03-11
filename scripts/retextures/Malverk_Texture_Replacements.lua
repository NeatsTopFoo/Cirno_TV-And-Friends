-----------------------------------------------------------------------
--------------------------- Malverk Code ------------------------------
-----------------------------------------------------------------------

-- Replaces Jokers, Tags, Blind Chips, Decks (As in Deck backs, NOT
-- playing cards, see PlayingCards_Retext for playing card replacements),
-- Seals, Vouchers, Boosters, Enhancers, Stakes, Stickers, Tarots,
-- Planets & Spectrals.

-- Every given AltTexture block MUST be represented later in the Texture
-- Pack definition. I would do each segment as its own individual lua,
-- but I'm not sure how to cross-do Malverk things across multiple files,
-- especially since I have a strong suspicion that each TexturePack block
-- is assigned its own card in the Malverk UI and I don't think we should
-- have five different mod cards all in one pack. I mean yes, it would be
-- helpful in terms of compatibility with other Malverk mods? Maybe? But
-- ultimately, I think it's just really, really unnecessary. And would
-- probably clutter it, too.

--------------------------
----- Regular Jokers -----
--------------------------
AltTexture({
	key = 'mlvrk_NormalJokers',
	set = 'Joker',
	path = CirnoMod.replaceDef.getPath("joker"),
	
	-- Sets the graphic of the mod card in Malverk UI to be Blueprint.
	-- It's basically the face of this mod at this point.
	display_pos = 'j_blueprint',
	
	-- This just informs the mod that the graphic we're providing is the
	-- exact dimensions of the default Balatro Joker sheet
	original_sheet = true,
	
	-- Defined in Cir_Vanilla_Replacement_Definition.lua.
	keys = CirnoMod.replaceDef.jokerReplacementKeys,
	loc_txt = {
		name = 'Jokers'
	}
})

---------------------
----- Wee Joker -----
---------------------
AltTexture({
	key = 'mlvrk_WeeJoker',
	set = 'Joker',
	path = "Vanilla_Replacements/cir_weeJoker.png",
	
	-- Just the Wee Joker.
	keys = { 'j_wee' },
	loc_txt = {
		name = 'Wee Joker'
	}
})

----------------------------
----- Legendary Jokers -----
----------------------------
AltTexture({
	key = 'mlvrk_LegendaryJokers',
	set = 'Joker',
	path = CirnoMod.replaceDef.getPath("l_joker"),
	keys = {
		'j_caino', -- I did say there were a bunch of these mispellings
		'j_triboulet',
		'j_yorick',
		'j_chicot',
		'j_perkeo'
	},
	soul_keys = {
		'j_caino',
		'j_triboulet',
		'j_yorick',
		'j_chicot',
		'j_perkeo'
	},
	loc_txt = {
		name = 'Legendary Jokers'
	}
})

----------------------------------------
----- Tarots, Planets & Spectrals ------
----------------------------------------

AltTexture({
	key = 'mlvrk_Tarots',
	set = 'Tarot',
	path = CirnoMod.replaceDef.getPath("tarot"),
	original_sheet = true,
	keys = {
		'c_fool',
		-- 'c_magician',
		-- 'c_high_priestess',
		-- 'c_empress',
		-- 'c_emperor',
		-- 'c_heirophant',
		-- 'c_lovers',
		-- 'c_chariot',
		-- 'c_justice',
		-- 'c_hermit',
		'c_wheel_of_fortune',
		-- 'c_strength',
		-- 'c_hanged_man',
		-- 'c_death',
		-- 'c_temperance',
		-- 'c_devil',
		-- 'c_tower',
		-- 'c_star',
		-- 'c_moon',
		-- 'c_sun',
		-- 'c_judgement',
		-- 'c_world'
	},
	loc_txt = {
		name = 'Tarots'
	}
})

-- TODO: Planets, Spectrals

-------------------------------
----- Vouchers & Boosters -----
-------------------------------

-- TODO

-- Boosters
AltTexture({
	key = 'mlvrk_Boosters',
	set = 'Booster',
	path = CirnoMod.replaceDef.getPath("booster"),
	original_sheet = true,
	keys = {
		'p_arcana_normal_1',
		--	'p_arcana_normal_2',
		--	'p_arcana_normal_3',
		--	'p_arcana_normal_4',
		--	'p_arcana_jumbo_1',
		--	'p_arcana_jumbo_2',
		--	'p_arcana_mega_1',
		--	'p_arcana_mega_2',
		--	'p_celestial_normal_1',
		--	'p_celestial_normal_2',
		--	'p_celestial_normal_3',
		--	'p_celestial_normal_4',
		--	'p_celestial_jumbo_1',
		--	'p_celestial_jumbo_2',
		--	'p_celestial_mega_1',
		--	'p_celestial_mega_2',
		--	'p_spectral_normal_1',
		--	'p_spectral_normal_2',
		--	'p_spectral_jumbo_1',
		--	'p_spectral_mega_1',
		--	'p_standard_normal_1',
		--	'p_standard_normal_2',
		--	'p_standard_normal_3',
		--	'p_standard_normal_4',
		--	'p_standard_jumbo_1',
		--	'p_standard_jumbo_2',
		--	'p_standard_mega_1',
		--	'p_standard_mega_2',
		'p_buffoon_normal_1',
		--	'p_buffoon_normal_2',
		--	'p_buffoon_jumbo_1',
		'p_buffoon_mega_1'
	},
	loc_txt = {
		name = 'Boosters'
	}
})

------------------------------
----- Decks & Enhancers ------
------------------------------

-- These have to be split this way
-- because funny Malverk structure

-- Decks
AltTexture({
	key = 'mlvrk_Decks',
	set = 'Back',
	path = CirnoMod.replaceDef.getPath("deck"),
	original_sheet = true,
	keys = {
		'b_red',
		'b_blue',
		-- 'b_yellow',
		-- 'b_green',
		'b_black',
		-- 'b_magic',
		-- 'b_nebula',
		-- 'b_ghost',
		-- 'b_abandoned',
		-- 'b_checkered',
		-- 'b_zodiac',
		-- 'b_painted',
		-- 'b_anaglyph',
		-- 'b_plasma',
		-- 'b_erratic',
		-- 'b_challenge'
	},
	loc_txt = {
		name = 'Decks'
	}
})

-- Enhancers
AltTexture({
	key = 'mlvrk_Enhancers',
	set = 'Enhanced',
	path = CirnoMod.replaceDef.getPath("enhancer"),
	original_sheet = true,
	keys = {
		-- 'm_bonus',
		-- 'm_mult',
		-- 'm_wild',
		-- 'm_glass',
		-- 'm_steel',
		'm_stone',
		-- 'm_gold',
		-- 'm_lucky'
	},
	loc_txt = {
		name = 'Enhancers'
	}
})

-- Seals
AltTexture({
	key = 'mlvrk_Seals',
	set = 'Seal',
	path = CirnoMod.replaceDef.getPath("enhancer"),
	original_sheet = true,
	loc_txt = {
		name = 'Seals'
	}
})

-----------------------
----- Blind Chips -----
-----------------------

-- Small & Big Blinds
AltTexture({
	key = 'mlvrk_SmallBigBlind',
	set = 'Blind',
	original_sheet = true,
	path = CirnoMod.replaceDef.getPath("blindchips"),
	frames = 21,
	keys = {
		'bl_small',
		'bl_big',
	},
	loc_txt = {
		name = 'Small & Big Blinds'
	}
})

-- Boss Blinds
AltTexture({
	key = 'mlvrk_Boss_Blinds',
	set = 'Blind',
	original_sheet = true,
	path = CirnoMod.replaceDef.getPath("blindchips"),
	frames = 21,
	keys = {
		'bl_ox',
		'bl_hook',
		'bl_mouth',
		'bl_fish',
		'bl_club',
		'bl_manacle',
		'bl_tooth',
		'bl_wall',
		'bl_house',
		'bl_mark',
		'bl_wheel',
		'bl_arm',
		'bl_psychic',
		'bl_goad',
		'bl_water',
		'bl_eye',
		'bl_plant',
		'bl_needle',
		'bl_head',
		'bl_window',
		'bl_serpent',
		'bl_pillar',
		'bl_flint'
	},
	loc_txt = {
		name = 'Boss Blinds'
	}
})

--  Finale Blinds
AltTexture({
	key = 'mlvrk_Finale_Blinds',
	set = 'Blind',
	original_sheet = true,
	path = CirnoMod.replaceDef.getPath("blindchips"),
	frames = 21,
	keys = {
		'bl_final_heart',
		'bl_final_bell',
		'bl_final_acorn',
		'bl_final_leaf',
		'bl_final_vessel'
	},
	loc_txt = {
		name = 'Finale Blinds'
	}
})

-------------------------------------------
-------------------------------------------
----- Malverk Texture Pack Definition -----
-------------------------------------------
-------------------------------------------
-- What do you mean 'my switch_func is out of date'???
-- What switch_func? Do I have a virus?????
TexturePack{
	key = 'mlvrk',
	
	-- Malverk is VERY strict about
	-- how you write your texture lines.
	-- The formula is [MOD KEY]_[ALT TEXTURE KEY]
	-- The mod key can be found in the config file.
	textures = {
		'cir_mlvrk_NormalJokers',
		'cir_mlvrk_WeeJoker',
		'cir_mlvrk_LegendaryJokers',
		
		'cir_mlvrk_Boosters',
		'cir_mlvrk_Tarots',
		'cir_mlvrk_Decks',
		'cir_mlvrk_Enhancers',
		'cir_mlvrk_Seals',
		
		'cir_mlvrk_SmallBigBlind',
		'cir_mlvrk_Boss_Blinds',		
		'cir_mlvrk_Finale_Blinds'
	},
	loc_txt = {
		name = 'Cirno_TV & Friends',
		text = {
			'Replaces textures with',
			'Cirno_TV themed variants',
			'& memes.'
		}
	}
}