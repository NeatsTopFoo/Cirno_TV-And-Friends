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
	path = 'cir_Jokers.png',
	
	-- Sets the graphic of the mod card in Malverk UI to be Blueprint.
	-- It's basically the face of this mod at this point.
	display_pos = 'j_blueprint',
	
	-- This just informs the mod that the graphic we're providing is the
	-- exact dimensions of the default Balatro Joker sheet
	original_sheet = true,
	
	-- Joker keys in this list as in the order they appear on the joker
	-- sheet, from left to right, top to bottom, with whitespace gaps
	-- representing where one line in the Joker sheet ends and another
	-- begins. I set it up this way to increase compatibility with other
	-- Malverk mods all the time we're not replacing every single Joker.
	-- I will likely rewrite this to be an individual AltTexture block
	-- for each rarity, if and when we approach replacing every single
	-- Joker. This is because my suspicion at the time of writing is
	-- that the discrete settings assignments in the Malverk UI (within
	-- the mod card) are assigned per AltTexture block and so giving
	-- people more things to toggle on and off corresponmding to
	-- different Jokers will just ultimately be better. I think.
	keys = {
		'j_joker',
		'j_wee',
		'j_chaos',
		-- 'j_jolly',
		-- 'j_zany',
		'j_mad',
		-- 'j_crazy',
		-- 'j_droll',
		'j_half',
		-- 'j_merry_andy',
		-- 'j_stone',
		
		-- 'j_jugglar',
		'j_drunkard',
		-- 'j_acrobat',
		-- 'j_sock_and_buskin',
		'j_mime',
		'j_credit_card',
		-- 'j_greedy_joker',
		-- 'j_lusty_joker',
		'j_wrathful_joker',
		'j_gluttenous_joker', -- Yes, it's mispelled internally. LocalThunk issue. See game files
		
		-- 'j_troubadour',
		-- 'j_banner',
		-- 'j_mystic_summit',
		-- 'j_loyalty_card',
		'j_hack',
		'j_misprint',
		-- 'j_steel joker',
		'j_raised_fist',
		-- 'j_golden',
		
		'j_blueprint',
		-- 'j_glass',
		-- 'j_scary_face',
		-- 'j_abstract',
		-- 'j_delayed_grat',
		-- 'j_ticket',
		-- 'j_pareidolia'
		-- 'j_cartomancer', 
		-- 'j_even_steven', 
		-- 'j_odd_todd',
		
		-- 'j_scholar',
		-- 'j_business',
		'j_supernova',
		-- 'j_mr_bones',
		-- 'j_seeing_double',
		-- 'j_duo',
		-- 'j_trio',
		-- 'j_family',
		-- 'j_order',
		-- 'j_tribe',
		
		-- 'j_8_ball',
		-- 'j_fibonacci',
		-- 'j_stencil',
		-- 'j_space',
		-- 'j_matador',
		-- 'j_ceremonial',
		'j_ring_master', -- Yes, this is Showman. You have no idea how mad I am that it's called this internally.
		-- 'j_fortune_teller',
		-- 'j_hit_the_road', 
		-- 'j_swashbuckler', 
		
		-- 'j_flower_pot',
		-- 'j_ride_the_bus', 
		-- 'j_shoot_the_moon',
		-- 'j_smeared',
		-- 'j_oops',
		-- 'j_four_fingers', 
		-- 'j_gros_michel',
		'j_stuntman',
		-- 'j_hanging_chad',
		
		-- 'j_drivers_license', 
		-- 'j_invisible',
		-- 'j_astronomer',
		-- 'j_burnt',
		-- 'j_dusk',
		-- 'j_throwback',
		-- 'j_idol',
		'j_brainstorm',
		-- 'j_satellite',
		-- 'j_rough_gem',
		
		-- 'j_bloodstone',
		-- 'j_arrowhead',
		-- 'j_onyx_agate',
		----- Legendary Jokers are their own separate AltTexture block below. -----
		-- 'j_certificate',
		'j_bootstraps',
		
		'j_egg',
		'j_burglar',
		-- 'j_blackboard',
		-- 'j_ice_cream',
		-- 'j_runner',
		'j_dna',
		-- 'j_splash',
		-- 'j_blue_joker',
		-- 'j_sixth_sense',
		-- 'j_constellation',
		
		'j_hiker',
		-- 'j_faceless',
		-- 'j_green_joker',
		-- 'j_superposition',
		'j_todo_list',
		-- 'j_cavendish',
		-- 'j_card_sharp',
		-- 'j_red_card',
		-- 'j_madness',
		-- 'j_square',
		-- 'j_seance',
		-- 'j_riff_raff',
		-- 'j_vampire',
		-- 'j_shortcut',
		----- Hologram is funky. Let me know if you work something out for its graphic. -----
		-- 'j_vagabond'
		-- 'j_baron',
		'j_cloud_9',
		-- 'j_rocket'
		-- 'j_obelisk', -- Petition to rename this "Worst Joker in the Game."
		
		-- 'j_midas_mask',
		-- 'j_luchador',
		-- 'j_photograph',
		-- 'j_gift',
		-- 'j_turtle_bean',
		-- 'j_erosion',
		-- 'j_reserved_parking',
		-- 'j_mail',
		-- 'j_to_the_moon',
		-- 'j_hallucination',
		
		-- 'j_sly'
		-- 'j_wily',
		'j_clever',
		-- 'j_devious',
		-- 'j_crafty',
		-- 'j_lucky_cat',
		'j_baseball',
		-- 'j_bull',
		'j_diet_cola',
		-- 'j_trading',
		
		-- 'j_flash',
		'j_popcorn',
		-- 'j_ramen',
		-- 'j_selzer',
		-- 'j_spare_trousers',
		-- 'j_campfire',
		-- 'j_smiley',
		-- 'j_ancient',
		-- 'j_walkie_talkie',
		-- 'j_castle'
	},
	loc_txt = {
		name = 'Jokers'
	}	
})

----------------------------
----- Legendary Jokers -----
----------------------------
AltTexture({
	key = 'mlvrk_LegendaryJokers',
	set = 'Joker',
	path = 'cir_Legendaries.png',
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
	path = 'cir_TarotsPlanetsSpectrals.png',
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

------------------------------
----- Decks & Enhancers ------
------------------------------

-- These have to be split this way
-- because funny Malverk structure

-- Decls
AltTexture({
	key = 'mlvrk_Decks',
	set = 'Back',
	path = 'cir_DecksEnhancers.png',
	original_sheet = true,
	loc_txt = {
		name = 'Decks'
	}
})

-- Enhancers
AltTexture({
	key = 'mlvrk_Enhancers',
	set = 'Enhanced',
	path = 'cir_DecksEnhancers.png',
	original_sheet = true,
	loc_txt = {
		name = 'Enhancers'
	}
})

-- Seals
AltTexture({
	key = 'mlvrk_Seals',
	set = 'Seal',
	path = 'cir_DecksEnhancers.png',
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
	path = 'cir_BlindChips.png',
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
	path = 'cir_BlindChips.png',
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
	path = 'cir_BlindChips.png',
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
	textures = {
		'cir_mlvrk_NormalJokers',
		'cir_mlvrk_LegendaryJokers',
		
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