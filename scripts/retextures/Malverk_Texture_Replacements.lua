--[[-------------------------------------------------------------------
--------------------------- Malverk Code ------------------------------
-----------------------------------------------------------------------

Replaces Jokers, Tags, Blind Chips, Decks (As in Deck backs, NOT
playing cards, see PlayingCards_Retext for playing card replacements),
Seals, Vouchers, Boosters, Enhancers, Stakes, Stickers, Tarots,
Planets & Spectrals.

Every given AltTexture block MUST be represented later in the Texture
Pack definition. I would do each segment as its own individual lua,
but I'm not sure how to cross-do Malverk things across multiple files,
especially since I have a strong suspicion that each TexturePack block
is assigned its own card in the Malverk UI and I don't think we should
have five different mod cards all in one pack. I mean yes, it would be
helpful in terms of compatibility with other Malverk mods? Maybe? But
ultimately, I think it's just really, really unnecessary. And would
probably clutter it, too.

---------------------
----- Wee Joker -----
---------------------]]
AltTexture({
	key = 'mlvrk_WeeJoker',
	set = 'Joker',
	path = "Vanilla_Replacements/cir_weeJoker.png",
	
	-- Just the Wee Joker.
	keys = { 'j_wee' },
	localization = CirnoMod.replaceDef.locChanges.jkrLoc.weeJkr,
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
	localization = CirnoMod.replaceDef.locChanges.jkrLoc.lgndJkrs,
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
	keys = CirnoMod.replaceDef.tarotReplacementKeys,
	localization = CirnoMod.replaceDef.locChanges.tarotLoc,
	loc_txt = {
		name = 'Tarots'
	}
})

AltTexture({
	key = 'mlvrk_Planets',
	set = 'Planet',
	path = CirnoMod.replaceDef.getPath("planet"),
	original_sheet = true,
	keys = CirnoMod.replaceDef.planetReplacementKeys,
	localization = CirnoMod.replaceDef.locChanges.planetLoc,
	loc_txt = {
		name = 'Planets'
	}
})

AltTexture({
	key = 'mlvrk_Spectrals',
	set = 'Spectral',
	path = CirnoMod.replaceDef.getPath("spectral"),
	original_sheet = true,
	keys = CirnoMod.replaceDef.spectralReplacementKeys,
	localization = CirnoMod.replaceDef.locChanges.spectralLoc,
	loc_txt = {
		name = 'Spectrals'
	}
})

--[[
Lmao, funny soul card bullshit, very cool
Can't include it in the normal spectrals
because the original graphic is cross-asset,
can't include it with legendaries as a kind
of "collective soul pack" because you can't
do cross-set. Fun!]]
AltTexture({
	key = 'mlvrk_Soul',
	set = 'Spectral',
	path = "Vanilla_Replacements/cir_Soul.png",
	keys = {
		'c_soul'
	},
	soul_keys = {
		'c_soul'
	},
	localization = CirnoMod.replaceDef.locChanges.soulLoc,
	loc_txt = {
		name = 'Soul Card'
	}
})

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
	keys = CirnoMod.replaceDef.boosterReplacementKeys,
	localization = CirnoMod.replaceDef.locChanges.boosterLoc,
	loc_txt = {
		name = 'Boosters'
	}
})

------------------------------
----- Decks & Enhancers ------
------------------------------

--[[
These have to be split this way
because funny Malverk structure]]

-- Decks
AltTexture({
	key = 'mlvrk_Decks',
	set = 'Back',
	path = CirnoMod.replaceDef.getPath("deck"),
	original_sheet = true,
	keys = CirnoMod.replaceDef.deckReplacementKeys,
	localization = CirnoMod.replaceDef.locChanges.deckLoc,
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
	keys = CirnoMod.replaceDef.enhancerReplacementKeys,
	localization = CirnoMod.replaceDef.locChanges.enhancerLoc,
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
	localization = CirnoMod.replaceDef.locChanges.blindsLoc.bosses,
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
	localization = CirnoMod.replaceDef.locChanges.blindsLoc.finals,
	loc_txt = {
		name = 'Finale Blinds'
	}
})

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
	localization = CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs,
	loc_txt = {
		name = 'Jokers'
	}
})

--------------------------
----- Regular Jokers -----
--------------------------
AltTexture({
	key = 'mlvrk_DelGrat',
	set = 'Joker',
	path = CirnoMod.replaceDef.getPath("joker"),
	
	-- This just informs the mod that the graphic we're providing is the
	-- exact dimensions of the default Balatro Joker sheet
	original_sheet = true,
	
	keys = { 'j_delayed_grat' },
	localization = CirnoMod.replaceDef.locChanges.jkrLoc.delGrat,
	loc_txt = {
		name = 'Delayed Gratification'
	}
})

-------------------------------------------
-------------------------------------------
----- Malverk Texture Pack Definition -----
-------------------------------------------
-------------------------------------------
--[[
What do you mean 'my switch_func is out of date'???
What switch_func? Do I have a virus?????]]
TexturePack{
	key = 'mlvrk',
	
	textures = CirnoMod.replaceDef.mlvrkTextPackTextList,
	toggle_textures = CirnoMod.replaceDef.mlvrkDefaultOffPackTextList,
	loc_txt = {
		name = 'Cirno_TV & Friends',
		text = {
			'Replaces textures with',
			'{C:cirCyan}Cirno_TV{} themed variants',
			'& memes.'
		}
	}
}