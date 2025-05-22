-- Set up localisation changes for Malverk implementation to pull from.
CirnoMod.replaceDef.locChanges = {
	deckLoc = {},
	planetLoc = {},
	enhancerLoc = {},
	sealLoc = {},
	blindsLoc = {},
	tarotLoc = {},
	spectralLoc = {},
	soulLoc = {},
	boosterLoc = {},
	tagLoc = {},
	-- TODO: Vouchers
	jkrLoc = {}
}

--[[
Malverk is VERY strict about
how you write your texture lines.
The formula is [MOD KEY]_[ALT TEXTURE KEY]
The mod key can be found in the config file
& the al texture keys are per alt texture
block in the malverk file.]]
local mlvrkTextPackTextList = {
	'cir_mlvrk_NormalJokers',
	'cir_mlvrk_GrnJoker',
	'cir_mlvrk_WeeJoker',
	'cir_mlvrk_LegendaryJokersAndHolo',
	
	'cir_mlvrk_Boosters',
	'cir_mlvrk_Tarots',
	'cir_mlvrk_Planets',
	'cir_mlvrk_Spectrals',
	'cir_mlvrk_Soul',
	'cir_mlvrk_Decks',
	'cir_mlvrk_Enhancers',
	'cir_mlvrk_Seals',
	'cir_mlvrk_Tags',
	
	'cir_mlvrk_SmallBigBlind',
	'cir_mlvrk_Boss_Blinds',		
	'cir_mlvrk_Finale_Blinds'
}

-- Anything in the above that should be off by default, must be present in both lists to work.
local mlvrkDefaultOffPackTextList = {}

--[[ Processes kays as defined in the vanilla replacement doc and
populates the replacement keys for the malverk pack accordingly.]]
CirnoMod.replaceDef.deckReplacementKeys = {}
for i, d in ipairs (CirnoMod.replaceDef.deckReplacements) do
	if d.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[d.dckKey]
		then
			table.insert(CirnoMod.replaceDef.deckReplacementKeys, d.dckKey)
		end
		
		if d.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[d.dckKey] = d.artCreditKey
		end
	end
end

-- Parse Deck Renames
if CirnoMod.config['deckRenames'] then
	-- Runs the lua and puts its returned var into the var.
	CirnoMod.miscItems.filterTable(assert(SMODS.load_file("scripts/renames_etc/Decks_Rename.lua"))(), CirnoMod.replaceDef.locChanges.deckLoc, CirnoMod.replaceDef.deckReplacementKeys)
end

CirnoMod.replaceDef.enhancerReplacementKeys = {}
for i, e in ipairs (CirnoMod.replaceDef.enhancerReplacements) do
	if e.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[e.enhKey]
		then
			table.insert(CirnoMod.replaceDef.enhancerReplacementKeys, e.enhKey)
		end
		
		if e.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[e.enhKey] = e.artCreditKey
		end
	end
end

-- Parse Enhancer Renames
if CirnoMod.config['enhancerRenames'] then
	-- Runs the lua and puts its returned var into the var.
	local enhLoc = assert(SMODS.load_file("scripts/renames_etc/Enhancers_Rename.lua"))()
	
	--[[
	==================================================
	TODO: Work out what to do about Seals in Malverk
		-- Discussed with Eremel, he's looking into
		   it, potential oversight with how Seals are
		   handled.
	==================================================]]
	
	CirnoMod.miscItems.filterTable(enhLoc.enhancers, CirnoMod.replaceDef.locChanges.enhancerLoc, CirnoMod.replaceDef.enhancerReplacementKeys)
	CirnoMod.replaceDef.locChanges.sealLoc = copy_table(enhLoc.seals)
	
	--[[ Leaving these uncommented because I've only tested it in the Collection
	menu and never during an actual run, so it's possible]]
	CirnoMod.miscItems.artCreditKeys['blue_seal'] = 'eA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys['red_seal'] = 'eA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys['gold_seal'] = 'eA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys['purple_seal'] = 'eA_DaemonTsun'
	
	--[[ Also, we have no real need to touch seals manually or do anything with
	individual seal keys because we basically started having done them
	all at the point we started getting this in-depth.]]
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'blue_seal')
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'red_seal')
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'gold_seal')
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'purple_seal')
end

-- Parse Blind Renames
if CirnoMod.config['blindRenames'] then
	-- Runs the lua and puts its returned var into the var.
	CirnoMod.replaceDef.locChanges.blindsLoc = assert(SMODS.load_file("scripts/renames_etc/Blinds_Rename.lua"))()
end

--[[ Processes kays as defined in the vanilla replacement doc and
populates the replacement keys for the malverk pack accordingly.]]
CirnoMod.replaceDef.planetReplacementKeys = {}
for i, p in ipairs (CirnoMod.replaceDef.planetReplacements) do
	if p.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[p.plnKey]
			and
			--[[ If we do not the planets as hus, then do not the planets as hus.
			This will likely be altered later, I'll just do this for now]]
			((CirnoMod.config['planetsAreHus'] and p.planetsAreHus)
			or not p.planetsAreHus)
		then
			table.insert(CirnoMod.replaceDef.planetReplacementKeys, p.plnKey)
		end
		
		if p.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[p.plnKey] = p.artCreditKey
		end
	end
end

CirnoMod.replaceDef.tarotReplacementKeys = {}
for i, t in ipairs (CirnoMod.replaceDef.tarotReplacements) do
	if t.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[t.trtKey]
		then
			table.insert(CirnoMod.replaceDef.tarotReplacementKeys, t.trtKey)
		end
		
		if t.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[t.trtKey] = t.artCreditKey
		end
	end
end

CirnoMod.miscItems.colours.tarot = HEX('185095FF')
	
CirnoMod.replaceDef.spectralReplacementKeys = {}
for i, s in ipairs (CirnoMod.replaceDef.spectralReplacements) do
	if s.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[s.spcKey]
		then
			table.insert(CirnoMod.replaceDef.spectralReplacementKeys, s.spcKey)
		end
		
		if s.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[s.spcKey] = s.artCreditKey
		end
	end
end

-- Parse Planet, Tarot & Spectral Renames (Planets moreso if planets aren't Hus)
if CirnoMod.config['planetTarotSpectralRenames'] then
	-- Runs the lua and puts its returned var into the var.
	local PTSloc = assert(SMODS.load_file("scripts/renames_etc/PlanetsTarotsAndSpectrals_Rename.lua"))()
	
	CirnoMod.miscItems.filterTable(PTSloc.planets, CirnoMod.replaceDef.locChanges.planetLoc, CirnoMod.replaceDef.planetReplacementKeys)
	CirnoMod.miscItems.filterTable(PTSloc.tarots, CirnoMod.replaceDef.locChanges.tarotLoc, CirnoMod.replaceDef.tarotReplacementKeys)
	CirnoMod.miscItems.filterTable(PTSloc.spectrals, CirnoMod.replaceDef.locChanges.spectralLoc, CirnoMod.replaceDef.spectralReplacementKeys)
	CirnoMod.replaceDef.locChanges.soulLoc.c_soul = copy_table(PTSloc.c_soul)
end

--[[ Processes kays as defined in the vanilla replacement doc and
populates the replacement keys for the malverk pack accordingly.]]
CirnoMod.replaceDef.boosterReplacementKeys = {}
for i, b in ipairs (CirnoMod.replaceDef.boosterReplacements) do
	if b.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[b.bstKey]
		then
			table.insert(CirnoMod.replaceDef.boosterReplacementKeys, b.bstKey)
		end			
		
		if b.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[b.bstKey] = b.artCreditKey
		end
	end
end

-- TODO: Vouchers.

-- Parse Planets are Hus
if CirnoMod.config['planetsAreHus'] then
	CirnoMod.miscItems.colours.planet = HEX('980D50FF')
	
	-- Runs the lua and puts its returned var into the var.
	local planetsAreHusLoc = assert(SMODS.load_file("scripts/other/planetsAreHus.lua"))()
	
	if CirnoMod.config.planetTarotSpectralRenames then
		CirnoMod.miscItems.filterTable(planetsAreHusLoc.planets, CirnoMod.replaceDef.locChanges.planetLoc, CirnoMod.replaceDef.planetReplacementKeys)
	end
	
	if CirnoMod.config.miscRenames then
		CirnoMod.replaceDef.locChanges.boosterLoc = copy_table(planetsAreHusLoc.boosters)
		
		-- TODO: Vouchers
	end
end

--[[ Processes kays as defined in the vanilla replacement doc and
populates the replacement keys for the malverk pack accordingly.]]
CirnoMod.replaceDef.jokerReplacementKeys = {}
for i, k in ipairs (CirnoMod.replaceDef.jokerReplacements) do
	if k.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[k.jkrKey]
		then
			table.insert(CirnoMod.replaceDef.jokerReplacementKeys, k.jkrKey)
		end
		
		table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, k.jkrKey)
		
		if k.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[k.jkrKey] = k.artCreditKey
		end
	end
end

-- Parse Joker Renames
if CirnoMod.config['jokerRenames'] then
	-- Runs the lua and puts its returned var into the var.
	local jkrLoc = assert(SMODS.load_file("scripts/renames_etc/Jokers_Rename.lua"))()
	
	--[[
	Creates a new table filtered based on the values
	established above, determined by vanilla
	replacement definition]]
	CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs = copy_table(CirnoMod.miscItems.newFilteredTable(jkrLoc.nrmJkrs, CirnoMod.replaceDef.jokerReplacementKeys))
	
	CirnoMod.replaceDef.locChanges.jkrLoc.grnJkr = jkrLoc.grnJkr
	CirnoMod.replaceDef.locChanges.jkrLoc.delGrat = jkrLoc.delGrat
	CirnoMod.replaceDef.locChanges.jkrLoc.weeJkr = jkrLoc.weeJkr
	CirnoMod.replaceDef.locChanges.jkrLoc.lgndJkrs = jkrLoc.lgndJkrs
end

CirnoMod.replaceDef.tagReplacementKeys = {}
for i, t in ipairs(CirnoMod.replaceDef.tagReplacements) do
	if t.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
		-- Ignore exceptional circumstances as defined in the file.
		if
			not CirnoMod.replaceDef.allKeysToIgnore[t.tagKey]
		then
			table.insert(CirnoMod.replaceDef.tagReplacementKeys, t.tagKey)
		end
		
		if t.artCreditKey then
			CirnoMod.miscItems.artCreditKeys[t.tagKey] = t.artCreditKey
		end
	end
end

-- Parse Misc Renames
if CirnoMod.config['miscRenames'] then
	CirnoMod.miscItems.miscRenameTables = {}
	-- Runs the lua and puts its returned var into the var.
	local miscLoc = assert(SMODS.load_file("scripts/renames_etc/Misc_Rename.lua"))()
	
	--[[
	Since planets are hus potentially goes first and
	thus sets up the booster loc table, we basically
	need to properly merge the entries]]
	for i, b in ipairs (CirnoMod.replaceDef.boosterReplacementKeys) do
		if miscLoc.boosters[b] then
			if CirnoMod.config.planetsAreHus then
				if 
					CirnoMod.replaceDef.locChanges.boosterLoc[b]
					and miscLoc.boosters[b].text
				then
					CirnoMod.replaceDef.locChanges.boosterLoc[b].text = miscLoc.boosters[b].text
				end
			else
				CirnoMod.replaceDef.locChanges.boosterLoc[b] = miscLoc.boosters[b]
			end
		end
	end
	
	CirnoMod.replaceDef.locChanges.tagLoc = miscLoc.tags
	
	-- TODO: Vouchers
	
	-- Function that randomises shop flavour text based on the pool defined in the rename file
	CirnoMod.miscItems.pickRandShopFlavour = function()
		SMODS.process_loc_text(G.localization.misc.dictionary, "ph_improve_run", pseudorandom_element(CirnoMod.miscItems.miscRenameTables.shopFlavourPool, pseudoseed('shopFlavourRand')))
		return nil
	end
end

if CirnoMod.config.matureReferences_cyc >= 2 then
	table.insert(mlvrkTextPackTextList, 'cir_mlvrk_DelGrat')
	table.insert(mlvrkDefaultOffPackTextList, 'cir_mlvrk_DelGrat')
end

for i, at in ipairs (mlvrkTextPackTextList) do
	CirnoMod.miscItems.mlvrk_tex_keys['alt_tex_'..at] = true
end

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
	key = 'mlvrk_LegendaryJokersAndHolo',
	set = 'Joker',
	path = CirnoMod.replaceDef.getPath("l_joker"),
	keys = {
		'j_caino', -- I did say there were a bunch of these mispellings
		'j_triboulet',
		'j_yorick',
		'j_chicot',
		'j_perkeo',
		'j_hologram'
	},
	soul_keys = {
		'j_caino',
		'j_triboulet',
		'j_yorick',
		'j_chicot',
		'j_perkeo',
		'j_hologram'
	},
	localization = CirnoMod.replaceDef.locChanges.jkrLoc.lgndJkrs,
	loc_txt = {
		name = 'Legendary Jokers & Hologram'
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

-- Tags
AltTexture({
	key = 'mlvrk_Tags',
	set = 'Tag',
	path = CirnoMod.replaceDef.getPath("tag"),
	keys = CirnoMod.replaceDef.tagReplacementKeys,
	localization = CirnoMod.replaceDef.locChanges.tagLoc,
	original_sheet = true,
	loc_txt = {
		name = 'Tags'
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

AltTexture({
	key = 'mlvrk_GrnJoker',
	set = 'Joker',
	path = CirnoMod.replaceDef.getPath("joker"),
	
	-- This just informs the mod that the graphic we're providing is the
	-- exact dimensions of the default Balatro Joker sheet
	original_sheet = true,
	
	keys = { 'j_green_joker' },
	localization = CirnoMod.replaceDef.locChanges.jkrLoc.grnJkr,
	loc_txt = {
		name = 'Green Joker'
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
	
	textures = mlvrkTextPackTextList,
	toggle_textures = mlvrkDefaultOffPackTextList,
	loc_txt = {
		name = 'Cirno_TV & Friends',
		text = {
			'Replaces textures with',
			'{C:cirCyan}Cirno_TV{} themed variants',
			'& memes.'
		}
	}
}