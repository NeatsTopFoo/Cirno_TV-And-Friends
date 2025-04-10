local cMod_SMODSLoc = SMODS.find_mod("CTVaF")[1]

cMod_SMODSLoc.optional_features = function()
	return {
		retrigger_joker = true,
		post_trigger = true
	}
end

SMODS.Sound:register_global()

CirnoMod = {}
CirnoMod.path = cMod_SMODSLoc.path
CirnoMod.config = cMod_SMODSLoc.config

CirnoMod.miscItems = assert(SMODS.load_file("scripts/other/miscItems.lua")())

if
	#SMODS.find_mod("soj") > 0
then
	CirnoMod.miscItems.otherModPresences.isSealsOnJokersPresent = true
end

if
	#SMODS.find_mod("talisman") > 0
then
	CirnoMod.miscItems.otherModPresences.isTalimanPresent = true
end

CirnoMod.miscItems.getLocColour = function(colourNameStr, defaultColourStr)
	if CirnoMod.miscItems.colours[colourNameStr] then
		return colourNameStr
	end
	return defaultColourStr
end

-- Hook into localise colour and interpose with
-- detection for our own custom colours.
local old_loc_colour = loc_colour
function loc_colour(_c, _default)
	if CirnoMod.miscItems.colours[_c] then
		return CirnoMod.miscItems.colours[_c]
	else
		return old_loc_colour(_c, _default)
	end
end

--[[ Thank you aikoooo T_T
Honestly dumb that I need to do this
in the first place for what I initially
want it for, but I guess it's a useful
tool we can keep around]]
for i = 97, 122 do
	table.insert(CirnoMod.miscItems.alphabetNumberConv.numToAlphabet, string.char(i))
	CirnoMod.miscItems.alphabetNumberConv.alphabetToNum[string.char(i)] = i - 96
end

--[[
TODO: Describe what these are and how they work.
I probably won't and this will stay like this
forever, which would be even funnier. Good luck.]]
CirnoMod.miscItems.createABSwitchLatch = function(itemKey, chance, startOnAOrB)
	if 
		not CirnoMod.miscItems.switchKeys[itemKey]
		and (startOnAOrB == 'A' or startOnAOrB == 'B')
	then
		table.insert(CirnoMod.miscItems.switchKeys, itemKey)
		
		CirnoMod.miscItems.switchTables[itemKey] = {
			AB = startOnAOrB,
			sType = "ABSwitchLatch",
			first = noFirstHoverProc,
			procChance = chance
		}
	end	
	return CirnoMod.miscItems.switchTables[itemKey]
end

CirnoMod.miscItems.processSwitch = function(itemKey)
	if CirnoMod.miscItems.switchTables[itemKey] then
		if CirnoMod.miscItems.switchTables[itemKey].first then
			CirnoMod.miscItems.switchTables[itemKey].first = false
		else
			if CirnoMod.miscItems.switchTables[itemKey].sType == "ABSwitchLatch" then
				-- AB Switch processing					
				if CirnoMod.miscItems.switchTables[itemKey].AB == 'A' then
					if pseudorandom(itemKey) < CirnoMod.miscItems.switchTables[itemKey].procChance then
						CirnoMod.miscItems.switchTables[itemKey].AB = 'B'
					end
				elseif CirnoMod.miscItems.switchTables[itemKey].AB == 'B' then
					CirnoMod.miscItems.switchTables[itemKey].AB = 'A'
				end
			end
		end
	end
	
	return CirnoMod.miscItems.switchTables[itemKey]
end

-- These are surprise tools that will help us later.
CirnoMod.miscItems.funnyAtlases.cirGuns = SMODS.Atlas({
	key = 'cir_Guns',
	path = 'Misc/cirGuns.png',
	px = 71,
	py = 95
})

CirnoMod.miscItems.funnyAtlases.japaneseGoblin = SMODS.Atlas({
	key = 'cir_jGoblin',
	path = 'Misc/japaneseGoblin.png',
	px = 64,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 52
})
CirnoMod.miscItems.funnyAtlases.japaneseGoblin.manualFrameParsing = { delay = 0.2 }

CirnoMod.miscItems.funnyAtlases.emotes = SMODS.Atlas({
	key = 'cir_Emotes',
	path = 'Misc/cir_Emotes.png',
	px = 64,
	py = 64
})

CirnoMod.miscItems.funnyAtlases.rumiSleep = SMODS.Atlas({
	key = 'cir_rumiSleep',
	path = 'Misc/rumiSleep.png',
	px = 64,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 38
})
CirnoMod.miscItems.funnyAtlases.rumiSleep.manualFrameParsing = { delay = 0.4 }

--[[ This one I have to do funky stuff with because
Balatro gets weird with big atlases. Can't do the
whole of Bad Apple in one line.]]
CirnoMod.miscItems.funnyAtlases.badApple = SMODS.Atlas({
	key = 'cir_badApple',
	path = 'Misc/badApple.png',
	px = 80,
	py = 64
})
CirnoMod.miscItems.funnyAtlases.badApple.typewriterFrameParsing = { delay = 0.3, rowLength = 99, finalRowY = 4, finalRowFrames = 77 }

CirnoMod.miscItems.funnyAtlases.badAppleInv = SMODS.Atlas({
	key = 'cir_badApple_inv',
	path = 'Misc/badApple_inv.png',
	px = 80,
	py = 64
})
CirnoMod.miscItems.funnyAtlases.badAppleInv.typewriterFrameParsing = { delay = 0.3, rowLength = 99, finalRowY = 4, finalRowFrames = 77 }

--[[
This is what the new cycle option calls when it's cycled
Yes, it HAS to be in G.FUNCS.]]
G.FUNCS.cir_CycMatureReferencesVal = function(e)
	-- CirnoMod.allEnabledOptions.matureReferences_cyc = e.to_key
	CirnoMod.config.matureReferences_cyc = e.to_key
end

local cirInitConfig = {
	-- Mature reference level is now determined within each Joker.
	customJokers = {
		'customUncommons',
		'customRares',
		'customLegendaries'
	},
	customConsumables = {
		'customSpectrals'
	},
	-- Mature reference level is now determined within each Challenge.
	additionalChallenges = {
		'jokerStencils'
	}
}

--[[
Defines Steamodded mod menu config & extra tabs
See the files for more info.]]
cMod_SMODSLoc.config_tab = assert(SMODS.load_file("scripts/UI_bs/steamodded_mod_menu/config_ui.lua")())

cMod_SMODSLoc.extra_tabs = assert(SMODS.load_file("scripts/UI_bs/steamodded_mod_menu/additional_mod_tabs.lua")())

--[[
Change title screen logo to mod's logo & replace the ace that appears first with the blueprint joker (If the setting is enabled)
Has corresponding patcher code in the lovely.toml]]
if CirnoMod.config['titleLogo'] then
	-- Replaces the Ace that appears at start with the Blueprint Joker.
	G.TITLE_SCREEN_CARD = 'j_blueprint'
	
	-- Title Screen Logo Texture
	SMODS.Atlas {
		key = "balatro",
		path = "Vanilla_Replacements/cir_BalatroLogo.png",
		px = 333,
		py = 216,
		prefix_config = { key = false }
	}
else
	-- Necessary for the below
	G.TITLE_SCREEN_CARD = G.P_CARDS.S_A
end

-- These three are necessary function definition for above
-- title screen replacement stuff to both actually facilitate
-- the replacement and also make it not error because I'm giving it a string instead
function G.FUNCS.title_screen_card(self, SC_scale)
	if type(G.TITLE_SCREEN_CARD) == "table" then
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.TITLE_SCREEN_CARD, G.P_CENTERS.c_base)
		elseif type(G.TITLE_SCREEN_CARD) == "string" then
			return  Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.empty, G.P_CENTERS[G.TITLE_SCREEN_CARD])
		else
			return Card(self.title_top.T.x, self.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.S_A, G.P_CENTERS.c_base)
	end
end

function G.FUNCS.center_splash_screen_card(SC_scale)
	return Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_joker'])
end

function G.FUNCS.splash_screen_card(card_pos, card_size)
	return Card(card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
				card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
				card_size*G.CARD_W, card_size*G.CARD_H, pseudorandom_element(G.P_CARDS), G.P_CENTERS.c_base)
end

--[[
Hate. Hate. Hate. Hate that we have to do this this
way. Hatehatehatehatehate. I had a whole system set
up and I had to tear it right down because apparently
that's not how that fucking works and we need to do
this bullshit this way because we can't easily insert
thing into the other thing and do that thing and I'm
onna scream, I'M CRASHING OUT AAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
...See the patcher toml and localization/en-us.lua
for more info. Though for your sanity, it's probably
best not to.]]
CirnoMod.ParseVanillaCredit = function(card, specific_vars) -- Comes in from generate_card_ui() in common_events.lua, which passes in _c and specific_vars (After checking if the specified card isn't locked or undiscovered)
	local RV = nil
	local keyToCheck = card.key
	
	if
		specific_vars -- This is nil when it's a Joker, but needed when its a playing card
		and G.SETTINGS.CUSTOM_DECK -- Sanity check to make sure this is initialised
	then
		if
			G.SETTINGS.CUSTOM_DECK.Collabs -- Another sanity check
			and specific_vars.playing_card -- These are edge cases where specific_vars is passed and not nil, but these values aren't present.
			and specific_vars.suit
			and specific_vars.value
		then
			if
				G.SETTINGS.CUSTOM_DECK.Collabs[specific_vars.suit] == CirnoMod.miscItems.deckSkinNames[specific_vars.suit]
				and CirnoMod.miscItems.deckSkinWhich[G.SETTINGS.CUSTOM_DECK.Collabs[specific_vars.suit]]
			then
				keyToCheck = CirnoMod.miscItems.deckSkinWhich[G.SETTINGS.CUSTOM_DECK.Collabs[specific_vars.suit]].."_"..specific_vars.value.."_"..specific_vars.suit
			end
		end
	end
	
	--[[
	If the key is present in the table of art keys,
	return the necessary localisation data
	Not the best way to facilitate this, but eh.]]
	if CirnoMod.miscItems.artCreditKeys[keyToCheck] then
		if type(CirnoMod.miscItems.artCreditKeys[keyToCheck]) == 'table' then
			if
				CirnoMod.config['planetsAreHus']
				and CirnoMod.miscItems.artCreditKeys[keyToCheck].planetsAreHus
			then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].planetsAreHus, set = "Other" }
			elseif
				CirnoMod.config.matureReferences_cyc == 3
				and CirnoMod.miscItems.artCreditKeys[keyToCheck].nrmVer
			then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].nrmVer, set = "Other" }
			elseif
				CirnoMod.config.matureReferences_cyc >= 2
				and CirnoMod.miscItems.artCreditKeys[keyToCheck].saferVer
			then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].saferVer, set = "Other" }
			elseif CirnoMod.miscItems.artCreditKeys[keyToCheck].default then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].default, set = "Other" }
			end
		else
			RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck], set = "Other" }
		end
	end
	
	return RV
end

-- Load vanilla replacements definitions and puts its returned var into the var.
CirnoMod.replaceDef = assert(SMODS.load_file("Cir_Vanilla_Replacement_Definition.lua")())

-- Playing Card Textures
if CirnoMod.config['playingCardTextures'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/retextures/PlayingCards_Retext.lua")()
end

-- Joker Textures
if CirnoMod.config['malverkReplacements'] then	
	-- Set up localisation changes for Malverk to pull from.
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
		-- TODO: Vouchers
		jkrLoc = {}
	}
	-- Anything in the above that should be off by default, must be present in both lists to work.
	CirnoMod.replaceDef.mlvrkDefaultOffPackTextList = {}
	
	--[[ Processes kays as defined in the vanilla replacement doc and
	populates the replacement keys for the malverk pack accordingly.]]
	CirnoMod.replaceDef.deckReplacementKeys = {}
	for i, d in ipairs (CirnoMod.replaceDef.deckReplacements) do
		if	d.matureRefLevel <= CirnoMod.config.matureReferences_cyc	then
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
		CirnoMod.miscItems.filterTable(assert(SMODS.load_file("scripts/renames_etc/Decks_Rename.lua")()), CirnoMod.replaceDef.locChanges.deckLoc, CirnoMod.replaceDef.deckReplacementKeys)
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
		local enhLoc = assert(SMODS.load_file("scripts/renames_etc/Enhancers_Rename.lua")())
		
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
		CirnoMod.replaceDef.locChanges.blindsLoc = assert(SMODS.load_file("scripts/renames_etc/Blinds_Rename.lua")())
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
		local PTSloc = assert(SMODS.load_file("scripts/renames_etc/PlanetsTarotsAndSpectrals_Rename.lua")())
		
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
		local planetsAreHusLoc = assert(SMODS.load_file("scripts/other/planetsAreHus.lua")())
		
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
		local jkrLoc = assert(SMODS.load_file("scripts/renames_etc/Jokers_Rename.lua")())
		
		--[[
		Creates a new table filtered based on the values
		established above, determined by vanilla
		replacement definition]]
		CirnoMod.replaceDef.locChanges.jkrLoc.nrmJkrs = copy_table(CirnoMod.miscItems.newFilteredTable(jkrLoc.nrmJkrs, CirnoMod.replaceDef.jokerReplacementKeys))
		
		CirnoMod.replaceDef.locChanges.jkrLoc.delGrat = jkrLoc.delGrat
		CirnoMod.replaceDef.locChanges.jkrLoc.weeJkr = jkrLoc.weeJkr
		CirnoMod.replaceDef.locChanges.jkrLoc.lgndJkrs = jkrLoc.lgndJkrs
	end

	-- Parse Misc Renames
	if CirnoMod.config['miscRenames'] then
		CirnoMod.miscItems.miscRenameTables = {}
		-- Runs the lua and puts its returned var into the var.
		local miscLoc = assert(SMODS.load_file("scripts/renames_etc/Misc_Rename.lua")())
		
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
		
		-- TODO: Vouchers
		
		-- Function that randomises shop flavour text based on the pool defined in the rename file
		CirnoMod.miscItems.pickRandShopFlavour = function()
			SMODS.process_loc_text(G.localization.misc.dictionary, "ph_improve_run", pseudorandom_element(CirnoMod.miscItems.miscRenameTables.shopFlavourPool, pseudoseed('shopFlavourRand')))
			return nil
		end
	end
	
	--[[
	Malverk is VERY strict about
	how you write your texture lines.
	The formula is [MOD KEY]_[ALT TEXTURE KEY]
	The mod key can be found in the config file
	& the al texture keys are per alt texture
	block in the malverk file.]]
	CirnoMod.replaceDef.mlvrkTextPackTextList = {
		'cir_mlvrk_NormalJokers',
		'cir_mlvrk_WeeJoker',
		'cir_mlvrk_LegendaryJokers',
		
		'cir_mlvrk_Boosters',
		'cir_mlvrk_Tarots',
		'cir_mlvrk_Planets',
		'cir_mlvrk_Spectrals',
		'cir_mlvrk_Soul',
		'cir_mlvrk_Decks',
		'cir_mlvrk_Enhancers',
		'cir_mlvrk_Seals',
		
		'cir_mlvrk_SmallBigBlind',
		'cir_mlvrk_Boss_Blinds',		
		'cir_mlvrk_Finale_Blinds'
	}
	
	if CirnoMod.config.matureReferences_cyc >= 2 then
		table.insert(CirnoMod.replaceDef.mlvrkTextPackTextList, 'cir_mlvrk_DelGrat')
		table.insert(CirnoMod.replaceDef.mlvrkDefaultOffPackTextList, 'cir_mlvrk_DelGrat')
	end
	
	SMODS.load_file("scripts/retextures/Malverk_Texture_Replacements.lua")()
end

-- Additional Custom Jokers
if CirnoMod.config['addCustomJokers'] then
	-- Iterates through all lua files in scripts\additions\jokers\ and SMODS.load_file them.
	for i, Jkr in ipairs (cirInitConfig.customJokers) do
		-- Runs the lua and puts its returned var into the var.
		local jokerInfo = assert(SMODS.load_file('scripts/additions/jokers/'..Jkr..".lua"))()
		local loadAtlas = true
		
		if
			(jokerInfo.matureRefLevel or 3) <= CirnoMod.config.matureReferences_cyc
			or jokerInfo.isMultipleJokers
		then
			if
				-- Atlas definition is required. No atlas, get out.
				jokerInfo.atlasInfo
				and
				-- Checking for valid structure before proceeding
				(
					jokerInfo.jokerConfig -- Either this for individual jokers
					or
					(jokerInfo.isMultipleJokers and jokerInfo.jokerConfigs) -- Or this for multiple jokers in one.
					--[[
					Yes, could do just checking for either config singular or config plural, but
					that makes this confusable at a quick glance since they're similar. Could
					ultimately name them something else, but then you run into stuff like
					"well how do you read back through this," etc. etc. It looks stupid, but
					when you stop and think about it, it makes sense. It's clunky, yes, but
					it makes sense.]]
				)
			then
				if jokerInfo.isMultipleJokers then
					loadAtlas = false -- No point in loading the Atlas if all the jokers in the file's mature ref levels are higher than the current setting.
					
					for i_, JkrChk in ipairs (jokerInfo.jokerConfigs) do
						loadAtlas = JkrChk.matureRefLevel <= CirnoMod.config.matureReferences_cyc
						
						if loadAtlas then
							break
						end
					end
				end
				
				if loadAtlas then
					SMODS.Atlas(jokerInfo.atlasInfo)
				end
				
				if jokerInfo.isMultipleJokers then
					for iI_, Jkr_ in ipairs (jokerInfo.jokerConfigs) do
						if Jkr_.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
							SMODS.Joker(Jkr_)
							
							table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'cir_'..Jkr_.key)
						end
					end
				else
					SMODS.Joker(jokerInfo.jokerConfig)
				
					table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'cir_'..jokerInfo.jokerConfig.key)
				end
			end
		end		
	end
end

-- Additional Custom Consumables
if CirnoMod.config['addCustomConsumables'] then
	for i, Csnm in ipairs (cirInitConfig.customConsumables) do
		-- Runs the lua and puts its returned var into the var.
		local cnsmInfo = assert(SMODS.load_file('scripts/additions/consumables/'..Csnm..".lua"))()
		local loadAtlas = true
		
		if
			(cnsmInfo.matureRefLevel or 3) <= CirnoMod.config.matureReferences_cyc
			or cnsmInfo.isMultipleConsumables
		then
			if
				cnsmInfo.atlasInfo
				and
				(
					cnsmInfo.cnsmConfig
					or
					(cnsmInfo.isMultipleConsumables and cnsmInfo.cnsmConfigs)
					-- Same as joker setup
				)
			then
				if cnsmInfo.isMultipleConsumables then
					loadAtlas = false
					
					for i_, CnsmChk in ipairs (cnsmInfo.cnsmConfigs) do
						loadAtlas = CnsmChk.matureRefLevel <= CirnoMod.config.matureReferences_cyc
						
						if loadAtlas then
							break
						end
					end
				end
				
				if loadAtlas then
					SMODS.Atlas(cnsmInfo.atlasInfo)
				end
				
				if cnsmInfo.isMultipleConsumables then
					for iI_, Cnsm_ in ipairs (cnsmInfo.cnsmConfigs) do
						if Cnsm_.matureRefLevel <= CirnoMod.config.matureReferences_cyc then
							SMODS.Consumable(Cnsm_)
							
							table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'cir_'..Cnsm_.key)
						end
					end
				else
					SMODS.Consumable(cnsmInfo.cnsmConfig)
				
					table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'cir_'..cnsmInfo.cnsmConfig.key)
				end
			end
		end
	end
		
	--[[ The author of the mod "Seals on Jokers"
	helped me greatly with the functionality here,
	but obviously, we don't want to be running it
	if that mod is also running alongside this.]]
	if
		CirnoMod.miscItems.otherModPresences.isSealsOnJokersPresent == false
	then
		-- Hooks into the normal calculate_seal() 
		local oldSealCalc = Card.calculate_seal
		function Card:calculate_seal(context)
			if
				self.debuff
			then
				return nil
			end
			
			if
				self.ability
				and self.ability.set == 'Joker'
			then				
				if
					context.retrigger_joker_check
					and not context.retrigger_joker
					and self == context.other_card
					and self.seal == 'Red'
				then
					if
						CirnoMod.miscItems.redSealRetriggerIgnoreTable[self.config.center.key]
					then
						local allowRedSeal = true
						
						for i, cntxt in ipairs (CirnoMod.miscItems.redSealRetriggerIgnoreTable[self.config.center.key]) do
							if
								context[cntxt]
								or cntxt == 'any'
								or (context.other_context
								and context.other_context[cntxt])
							then
								allowRedSeal = false
								break
							end
						end
						
						if
							allowRedSeal
						then
							return {
								repetitions = 1,
								card = self
							}
						end
					else
						return {
							repetitions = 1,
							card = self
						}
					end
				end
				
				return nil
			end
			
			return oldSealCalc(self, context)
		end
		
		-- Fix for a weird-interaction with red seal on Mail-In Rebate
		SMODS.Joker:take_ownership('mail',
			{
				calculate = function(self, card, context)
					if
						context.discard
						and not context.other_card.debuff
						and (context.other_card:get_id() == G.GAME.current_round.mail_card.id)
					then
						return {
							dollars = card.ability.extra,
							colour = G.C.MONEY,
							card = card
						}
					end
				end
			},
			true
		)
	end
end

-- Additional Custom Challenges
if CirnoMod.config['additionalChallenges'] then	
	CirnoMod.ChallengeRefs = {}
	
	--[[ Initialises a challenge functions holder.
	This is then populated with any functions
	the challenge needs to use, in the challenge
	file itself.]]
	CirnoMod.ChalFuncs = {}
	
	local dependencyCheck = function(chInfo_)
		if
			chInfo_.dependenciesForAddition
			and type(chInfo_.dependenciesForAddition) == 'function'
		then
			return chInfo_.dependenciesForAddition()
		else
			return true
		end
	end
	
	for i, Ch in ipairs (cirInitConfig.additionalChallenges) do
		-- Runs the lua and puts its returned var into the var.
		local chalInfo = assert(SMODS.load_file('scripts/additions/challenges/'..Ch..".lua"))()
		
		if
			chalInfo.matureRefLevel <= CirnoMod.config.matureReferences_cyc
			and dependencyCheck(chalInfo)
		then
			chalInfo.key = Ch
			
			for i, ln in ipairs (chalInfo.loc_txt.text) do
				if i == 1 then
					table.insert(chalInfo.rules.custom, { id = 'cir_'..Ch })
				else
					table.insert(chalInfo.rules.custom, { id = 'cir_'..Ch..CirnoMod.miscItems.alphabetNumberConv.numToAlphabet[i - 1] })
				end
			end
			
			-- Adds the challenge.
			CirnoMod.ChallengeRefs['ch_c_cir_'..Ch] = SMODS.Challenge(chalInfo)
		end
	end
end

local main_menuRef = Game.main_menu -- Main_menu() hook
function Game:main_menu(change_context)	
	if not G.C.SPLASH then -- Ensure splash is initalised
		G.C.SPLASH = {}
	end
	
	--[[
	If our colours are enabled, set the vortex colours to
	our colours. If not, set them to the default ones.]]
	if CirnoMod.config['titleColours'] then
		G.C.SPLASH[1] = CirnoMod.miscItems.colours.cirBlue
		G.C.SPLASH[2] = CirnoMod.miscItems.colours.cirCyan
	else
		G.C.SPLASH[1] = G.C.RED
		G.C.SPLASH[2] = G.C.BLUE
	end
	
	G.C.SECONDARY_SET.UIDefault = G.C.SECONDARY_SET.Spectral
	
	main_menuRef(self, change_context) -- Calls the normal manu_menu() function in Game.
	
	-- Set Tarot colour.
	if
		CirnoMod.config['malverkReplacements']
		and CirnoMod.miscItems.colours.tarot
	then
		G.C.SECONDARY_SET.Tarot = CirnoMod.miscItems.colours.tarot
	end
	
	-- Set Planet colour (If Planets Are Hus is active)
	if
		CirnoMod.config['planetsAreHus']
		and CirnoMod.miscItems.colours.planet
	then
		G.C.SECONDARY_SET.Planet = CirnoMod.miscItems.colours.planet
	end
	
	if CirnoMod.config['additionalChallenges'] then
		--[[
		Should update the joker stencil challenge text
		with whatever name Joker Stencil is set to at this
		point in time, but for whatever reason doesn't work
		as intended.
		]]
		G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 2.0,
						blocking = false,
						blockable = true,
						func = function()
							CirnoMod.ChalFuncs.updateStencilName(G.localization.descriptions.Joker.j_stencil.name)
							return true
						end
					}))
		
		--[[
		TODO: For every new challenge that bans something,
		we need to run their ban functions here. Or any
		challenges that name specific things that can be
		renamed or w/e.]]
	end
end

CirnoMod.CirnoHooks = {}
--[[
"Hooks" for things like challenge functionality.
Challenge functionality is a little weird and
primarily facilitated by checking G.GAME.modifiers
for the challenge id.]]
CirnoMod.CirnoHooks.onRunStart = function(args)
	-- Check if challenges are on and the
	-- challenge functions aren't empty
	if
		CirnoMod.config['additionalChallenges']
		and CirnoMod.ChalFuncs ~= nil
	then
		-- Is the stencil jokers challenge active?
		-- If so, do the thing.
		if
			G.GAME.challenge == "c_cir_jokerStencils"
			and type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck) == 'function'
		then
			CirnoMod.ChalFuncs.jokerStencilsDebuffCheck("runStart")
		end
	
	end
	
	-- Randomises shop flavour text.
	if
		CirnoMod.config['miscRenames']
		and type(CirnoMod.miscItems.pickRandShopFlavour) == 'function'
	then
		CirnoMod.miscItems.pickRandShopFlavour()
	end
	
	--[[ YEP,
	THIS IS HOW WE'RE DOING THIS NOW.
	BLAME THUNK.]]
	if
		CirnoMod.miscItems.keysOfJokersToUpdateStateOnLoad
	then
		for i, jkr in ipairs(G.jokers.cards) do
			if
				CirnoMod.miscItems.keysOfJokersToUpdateStateOnLoad[jkr.config.center.key]
				and jkr.config.center.updateState
				and type(jkr.config.center.updateState) == 'function'
			then
				jkr.config.center.updateState(jkr)
			end
		end
	end
	
	return nil
end

CirnoMod.CirnoHooks.evalCardHook = function(card, context)
	return nil -- Remove when there is a use for this hook.
	
	-- Check if challenges are on
	-- if CirnoMod.config['additionalChallenges'] then
	-- 
	-- end
end

CirnoMod.CirnoHooks.onNewJoker = function(joker, edition, silent, eternal)
	return nil -- Remove when there is a use for this hook.

	-- Check if challenges are on
	-- if CirnoMod.config['additionalChallenges'] then
	-- 
	-- end
end

CirnoMod.CirnoHooks.onBlindStart = function()
	--[[
	Check if challenges are on and the
	challenge functions aren't empty]]
	if
		CirnoMod.config['additionalChallenges']
		and CirnoMod.ChalFuncs ~= nil
	then
		--[[ Is the stencil jokers challenge active?
		If so, do the thing.]]
		if
			G.GAME.challenge == "c_cir_jokerStencils"
			and type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck) == 'function'
		then
			CirnoMod.ChalFuncs.jokerStencilsDebuffCheck("blindStart")
		end
	
	end
	return nil
end

CirnoMod.CirnoHooks.onBlindDefeat = function()
	--[[
	Check if challenges are on and the
	challenge functions aren't empty]]
	if
		CirnoMod.config['additionalChallenges']
		and CirnoMod.ChalFuncs ~= nil
	then
		--[[ Is the stencil jokers challenge active?
		If so, do the thing.]]
		if
			G.GAME.challenge == "c_cir_jokerStencils"
			and type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck) == 'function'
		then
			CirnoMod.ChalFuncs.jokerStencilsDebuffCheck("blindDefeat")
		end
	
	end
	
	-- Randomises shop flavour text.
	if
		CirnoMod.config['miscRenames']
		and type(CirnoMod.miscItems.pickRandShopFlavour) == 'function'
	then
		CirnoMod.miscItems.pickRandShopFlavour()
	end
	
	return nil
end

--[[
There appears to be no game function that can be
hooked into relating to when a shop phase starts
CirnoMod.onShopStart = function()
	
end
]]