CirnoMod = {}
CirnoMod.path = SMODS.current_mod.path
CirnoMod.config = SMODS.current_mod.config
CirnoMod.allEnabledOptions = copy_table(CirnoMod.config)
CirnoMod.miscItems = {
	colours = { cirBlue = HEX('0766EBFF'), cirCyan = HEX('0AD0F7FF') }
}
CirnoMod.miscItems.deckSkinNames = {}

-- This will be used for any effects the focus on stuff edited or introduced by this mod
CirnoMod.miscItems.keysOfAllCirnoModItems = {}

local cirInitConfig = {
	-- Ensure that any Jokers with mature references
	-- and those without are implemented separately.
	-- Safe varianting should ideally be handled within
	-- the respective Joker's script.
	customJokers = {
		{ jkrFileName = 'customLegendaries', isSafeOrHasSafeVariant = true },
		{ jkrFileName = 'customUncommons', isSafeOrHasSafeVariant = true }
	},
	-- Ensure that any Challenges with mature references
	-- and those without are implemented separately.
	-- Safe varianting should ideally be handled within
	-- the respective Challenge's script.
	additionalChallenges = {
		{ chlFileName = 'jokerStencils', isSafeOrHasSafeVariant = true },
	}
}

-- Defines Steamodded mod menu config & extra tabs
-- See the files for more info.
SMODS.current_mod.config_tab = assert(SMODS.load_file("scripts/UI_bs/steamodded_mod_menu/config_ui.lua")())

SMODS.current_mod.extra_tabs = assert(SMODS.load_file("scripts/UI_bs/steamodded_mod_menu/additional_mod_tabs.lua")())

-- Change title screen logo to mod's logo & replace the ace that appears first with the blueprint joker (If the setting is enabled) - Has corresponding patcher code in the lovely.toml
if CirnoMod.allEnabledOptions['titleLogo'] then
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

CirnoMod.miscItems.artCreditKeys = {}
-- Hate. Hate. Hate. Hate that we have to do this this
-- way. Hatehatehatehatehate. I had a whole system set
-- up and I had to tear it right down because apparently
-- that's not how that fucking works and we need to do
-- this bullshit this way because we can't easily insert
-- thing into the other thing and do that thing and I'm
-- onna scream, I'M CRASHING OUT AAAAAAAAAAAAAAAAAAAAA
-- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
-- ...See the patcher toml and localization/en-us.lua
-- for more info. Though for your sanity, it's probably
-- best not to.
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
				G.SETTINGS.CUSTOM_DECK.Collabs[specific_vars.suit] == CirnoMod.miscItems.deckSkinNames[string.lower(specific_vars.suit)]
			then
				keyToCheck = specific_vars.value.."_"..specific_vars.suit
			end
		end
	end
	
	-- If the key is present in the table of art keys, return the necessary localisation data
	if CirnoMod.miscItems.artCreditKeys[keyToCheck] then
		if type(CirnoMod.miscItems.artCreditKeys[keyToCheck]) == 'table' then
			if
				CirnoMod.allEnabledOptions['planetsAreHus']
				and CirnoMod.miscItems.artCreditKeys[keyToCheck].planetsAreHus
			then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].planetsAreHus, set = "Other" }
			--	elseif
			--		TODO: Mature reference option changes
			--		
			--	then
			
			elseif CirnoMod.miscItems.artCreditKeys[keyToCheck].default then
				RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck].default, set = "Other" }
			end
		else
			RV = { key = CirnoMod.miscItems.artCreditKeys[keyToCheck], set = "Other" }
		end
	end
	
	return RV
end

-- Load vanilla replacements definitions
CirnoMod.replaceDef = assert(SMODS.load_file("Cir_Vanilla_Replacement_Definition.lua")())

-- Playing Card Textures
if CirnoMod.allEnabledOptions['playingCardTextures'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/retextures/PlayingCards_Retext.lua")()
end

-- Joker Textures
if CirnoMod.allEnabledOptions['malverkReplacements'] then	
	-- Processes kays as defined in the vanilla replacement doc and
	-- populates the replacement keys for the malverk pack accordingly.
	CirnoMod.replaceDef.deckReplacementKeys = {}
	for i, d in ipairs (CirnoMod.replaceDef.deckReplacements) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or d.isSafeOrHasSafeVariant
		then
			-- Ignore exceptional circumstances.
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
	
	CirnoMod.replaceDef.boosterReplacementKeys = {}
	for i, b in ipairs (CirnoMod.replaceDef.boosterReplacements) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or b.isSafeOrHasSafeVariant
		then
			-- Ignore exceptional circumstances.
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
	
	CirnoMod.replaceDef.jokerReplacementKeys = {}
	for i, k in ipairs (CirnoMod.replaceDef.jokerReplacements) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or k.isSafeOrHasSafeVariant
		then
			-- Ignore exceptional circumstances.
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
	
	CirnoMod.replaceDef.tarotReplacementKeys = {}
	for i, t in ipairs (CirnoMod.replaceDef.tarotReplacements) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or t.isSafeOrHasSafeVariant
		then
			-- Ignore exceptional circumstances.
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
	
	CirnoMod.replaceDef.planetReplacementKeys = {}
	for i, p in ipairs (CirnoMod.replaceDef.planetReplacements) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or p.isSafeOrHasSafeVariant
		then
			-- Ignore exceptional circumstances.
			if
				not CirnoMod.replaceDef.allKeysToIgnore[p.plnKey]
				and
				-- If we do not the planets as hus, then do not the planets as hus.
				-- This will likely be altered later, I'll just do this for now
				((CirnoMod.allEnabledOptions['planetsAreHus'] and p.planetsAreHus)
				or not p.planetsAreHus)
			then
				table.insert(CirnoMod.replaceDef.planetReplacementKeys, p.plnKey)
			end
			
			if p.artCreditKey then
				CirnoMod.miscItems.artCreditKeys[p.plnKey] = p.artCreditKey
			end
		end
	end
		
	CirnoMod.replaceDef.spectralReplacementKeys = {}
	for i, s in ipairs (CirnoMod.replaceDef.spectralReplacements) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or s.isSafeOrHasSafeVariant
		then
			-- Ignore exceptional circumstances.
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
	
	CirnoMod.replaceDef.enhancerReplacementKeys = {}
	for i, e in ipairs (CirnoMod.replaceDef.enhancerReplacements) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or e.isSafeOrHasSafeVariant
		then
			-- Ignore exceptional circumstances.
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
	
	-- TODO: Vouchers.
	
	-- Leaving these uncommented because I've only tested it in the Collection
	-- menu and never during an actual run, so it's possible
	CirnoMod.miscItems.artCreditKeys['blue_seal'] = 'eA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys['red_seal'] = 'eA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys['gold_seal'] = 'eA_DaemonTsun'
	CirnoMod.miscItems.artCreditKeys['purple_seal'] = 'eA_DaemonTsun'
	
	-- Also, we have no real need to touch seals manually or do anything with
	-- individual seal keys because we basically started having done them
	-- all at the point we started getting this in-depth.
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'blue_seal')
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'red_seal')
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'gold_seal')
	table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, 'purple_seal')
	
	SMODS.load_file("scripts/retextures/Malverk_Texture_Replacements.lua")()
end

-- Hhhhhhhhhhh some things need to be done before others.
-- And the other I need to be doing some things I want to
-- include in other things is weird, so I gotta do it
-- this way
if
	CirnoMod.allEnabledOptions['miscRenames']
	or CirnoMod.allEnabledOptions['jokerRenames']
then
	-- Adds our custom colours
	CirnoMod.miscItems.colours.cirLucy = HEX('7BB083FF')
	CirnoMod.miscItems.colours.cirNep = HEX('D066ADFF')
	
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
end

-- Planets are Hus
if CirnoMod.allEnabledOptions['planetsAreHus'] then
	CirnoMod.miscItems.colours.planet = HEX('980D50FF')
	
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/other/planetsAreHus.lua")()
end

-- Deck Renames
if CirnoMod.allEnabledOptions['deckRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Decks_Rename.lua")()
end

-- Enhancer Renames
if CirnoMod.allEnabledOptions['enhancerRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Enhancers_Rename.lua")()
end

-- Blind Renames
if CirnoMod.allEnabledOptions['blindRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Blinds_Rename.lua")()
end

-- Tarot & Spectral Renames
if CirnoMod.allEnabledOptions['planetTarotSpectralRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/PlanetsTarotsAndSpectrals_Rename.lua")()
end

-- Joker Renames
if CirnoMod.allEnabledOptions['jokerRenames'] then
	-- Runs the lua only if the setting is enabled in Steamodded mod config.
	SMODS.load_file("scripts/renames_etc/Jokers_Rename.lua")()
end

-- Misc Renames
if CirnoMod.allEnabledOptions['miscRenames'] then
	-- SMODS.load_files the misc renames
	-- My understanding is that using assert() makes the return value end up in the variable,
	-- This is important to capture the string pool defined at the end of the file.
	CirnoMod.miscItems.miscRenameTables = assert(SMODS.load_file("scripts/renames_etc/Misc_Rename.lua")())
	
	-- Function that randomises shop flavour text based on the pool defined in the rename file
	CirnoMod.miscItems.pickRandShopFlavour = function()
		SMODS.process_loc_text(G.localization.misc.dictionary, "ph_improve_run", pseudorandom_element(CirnoMod.miscItems.miscRenameTables.shopFlavourPool, pseudoseed('shopFlavourRand')))
		return nil
	end
end

-- Additional Custom Jokers
if CirnoMod.allEnabledOptions['addCustomJokers'] then
	-- Iterates through all lua files in scripts\additions\jokers\ and SMODS.load_file them.
	-- My understanding is that using assert() makes the return value end up in the variable.
	for i, Jkr in ipairs (cirInitConfig.customJokers) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or Jkr.isSafeOrHasSafeVariant
		then
			local jokerInfo = assert(SMODS.load_file('scripts/additions/jokers/'..Jkr.jkrFileName..".lua"))()
		
			if
				-- Atlas definition is required. No atlas, get out.
				jokerInfo.atlasInfo
				and
				-- Checking for valid structure before proceeding
				(
					jokerInfo.jokerConfig -- Either this for individual jokers
					or
					(jokerInfo.isMultipleJokers and jokerInfo.jokerConfigs) -- Or this for multiple jokers in one.
					-- Yes, could do just checking for either config singular or config plural, but
					-- that makes this confusable at a quick glance since they're similar. Could
					-- ultimately name them something else, but then you run into stuff like
					-- "well how do you read back through this," etc. etc. It looks stupid, but
					-- when you stop and think about it, it makes sense. It's clunky, yes, but
					-- it makes sense.
				)
			then
				SMODS.Atlas(jokerInfo.atlasInfo)
				
				if jokerInfo.isMultipleJokers then
					for i_, Jkr_ in ipairs (jokerInfo.jokerConfigs) do
						SMODS.Joker(Jkr_)
						
						table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, Jkr_.key)
					end
				else
					SMODS.Joker(jokerInfo.jokerConfig)
				
					table.insert(CirnoMod.miscItems.keysOfAllCirnoModItems, jokerInfo.jokerConfig.key)
				end
			end
		end		
	end
end
	
-- Additional Custom Challenges
if CirnoMod.allEnabledOptions['additionalChallenges'] then
	-- Initialises a challenge functions holder.
	-- This is then populated with any functions
	-- the challenge needs to use, in the challenge
	-- file itself.
	CirnoMod.ChalFuncs = {}

	-- Iterates through all lua files in scripts\additions\challenges\ and SMODS.load_file them.
	-- My understanding is that using assert() makes the return value end up in the variable.
	for i, Ch in ipairs (cirInitConfig.additionalChallenges) do
		if
			CirnoMod.allEnabledOptions['matureReferences']
			or Ch.isSafeOrHasSafeVariant
		then
			local chalInfo = assert(SMODS.load_file('scripts/additions/challenges/'..Ch.chlFileName..".lua"))()
			
			chalInfo.key = Ch.chlFileName
			
			-- Adds the challenge.
			local chal = SMODS.Challenge(chalInfo)
		end		
	end
end

local main_menuRef = Game.main_menu
function Game:main_menu(change_context)
	
	if not G.C.SPLASH then
		G.C.SPLASH = {}
	end
	
	if CirnoMod.allEnabledOptions['titleColours'] then
		G.C.SPLASH[1] = CirnoMod.miscItems.colours.cirBlue
		G.C.SPLASH[2] = CirnoMod.miscItems.colours.cirCyan
	else
		G.C.SPLASH[1] = G.C.RED
		G.C.SPLASH[2] = G.C.BLUE
	end
	
	main_menuRef(self, change_context)
	
	if
		CirnoMod.allEnabledOptions['malverkReplacements']
		and CirnoMod.miscItems.colours.tarot
	then
		G.C.SECONDARY_SET.Tarot = CirnoMod.miscItems.colours.tarot
	end
	
	if
		CirnoMod.allEnabledOptions['planetsAreHus']
		and CirnoMod.miscItems.colours.planet
	then
		G.C.SECONDARY_SET.Planet = CirnoMod.miscItems.colours.planet
	end
	
	if CirnoMod.allEnabledOptions['additionalChallenges'] then
		-- Should update the joker stencil challenge text
		-- with whatever name Joker Stencil is set to at this
		-- point in time, but for whatever reason doesn't work
		-- as intended.
		--	G.E_MANAGER:add_event(Event({
		--					trigger = 'after',
		--					delay = 2.0,
		--					blocking = false,
		--					func = function()
		--						SMODS.process_loc_text(G.localization.misc.v_text, "ch_c_cir_jokerStencils", {
		--									"Start with 5 {C:eternal}Eternal{}, {C:attention}debuffed{} "..G.localization.descriptions.Joker.j_stencil.name.."s."
		--								})
		--						return true
		--					end
		--				}))
		
		-- TODO: For every new challenge that bans something, we need to run their ban functions here.
	end
end

CirnoMod.CirnoHooks = {}
-- Hooks for things like challenge functionality.
-- Challenge functionality is a little weird and
-- primarily facilitated by checking G.GAME.modifiers
-- for the challenge id.
CirnoMod.CirnoHooks.onRunStart = function(args)
	-- Check if challenges are on and the
	-- challenge functions aren't empty
	if
		CirnoMod.allEnabledOptions['additionalChallenges']
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
		CirnoMod.allEnabledOptions['miscRenames']
		and type(CirnoMod.miscItems.pickRandShopFlavour) == 'function'
	then
		CirnoMod.miscItems.pickRandShopFlavour()
	end
	return nil
end

CirnoMod.CirnoHooks.evalCardHook = function(card, context)
	return nil -- Remove when there is a use for this hook.
	
	-- Check if challenges are on
	-- if CirnoMod.allEnabledOptions['additionalChallenges'] then
	-- 
	-- end
end

CirnoMod.CirnoHooks.onNewJoker = function(joker, edition, silent, eternal)
	return nil -- Remove when there is a use for this hook.

	-- Check if challenges are on
	-- if CirnoMod.allEnabledOptions['additionalChallenges'] then
	-- 
	-- end
end

CirnoMod.CirnoHooks.onBlindStart = function()
	--	if G.jokers.cards[1] and G.GAME.challenge == "c_cir_jokerStencils" then
	--		print(type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck))
	--		SMODS.debuff_card(G.jokers.cards[1], true, "debugging")
	--	end
	-- Check if challenges are on and the
	-- challenge functions aren't empty
	if
		CirnoMod.allEnabledOptions['additionalChallenges']
		and CirnoMod.ChalFuncs ~= nil
	then
		-- Is the stencil jokers challenge active?
		-- If so, do the thing.
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
	-- Check if challenges are on and the
	-- challenge functions aren't empty
	if
		CirnoMod.allEnabledOptions['additionalChallenges']
		and CirnoMod.ChalFuncs ~= nil
	then
		-- Is the stencil jokers challenge active?
		-- If so, do the thing.
		if
			G.GAME.challenge == "c_cir_jokerStencils"
			and type(CirnoMod.ChalFuncs.jokerStencilsDebuffCheck) == 'function'
		then
			CirnoMod.ChalFuncs.jokerStencilsDebuffCheck("blindDefeat")
		end
	
	end
	
	-- Randomises shop flavour text.
	if
		CirnoMod.allEnabledOptions['miscRenames']
		and type(CirnoMod.miscItems.pickRandShopFlavour) == 'function'
	then
		CirnoMod.miscItems.pickRandShopFlavour()
	end
	
	return nil
end

-- There appears to be no game function that can be
-- hooked into relating to when a shop phase starts
-- CirnoMod.onShopStart = function()
-- 	
-- end