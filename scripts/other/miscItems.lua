local miscItems = {
	artCreditKeys = {},
	creditLinks = {
		daemonTsun = { type = 'BSky', link = 'https://bsky.app/profile/daemontsun.bsky.social' },
		ntf_bsky = { type = 'BSky', link = 'https://bsky.app/profile/nopetoofast.bsky.social' },
		ntf_twch = { type = 'Twitch', link = 'https://www.twitch.tv/NopeTooFast' },
		cirnotv_bsky = { type = 'BSky', link = 'https://bsky.app/profile/cirnotv.bsky.social' },
		cirnotv_twch = { type = 'Twitch', link = 'https://www.twitch.tv/Cirno_TV/' },
		cardsauce = { type = 'GitHub', link = 'https://github.com/BarrierTrio/Cardsauce' },
		cryptid = { type = 'GitHub', link = 'https://github.com/SpectralPack/Cryptid' },
		trance = { type = 'GitHub', link = 'https://github.com/SpectralPack/Trance' },
		turpix_tw = { type = 'Twitter', link = 'https://x.com/turpix_00' },
		turpix_nm = { type = 'Nexus', link = 'https://www.nexusmods.com/balatro/mods/114' },
		solgryn = { type = 'Twitch', link = 'https://twitch.tv/solgryn' },
		radicalhighway = { type = 'Twitch', link = 'https://twitch.tv/radicalhighway' },
		muddleee = { type = 'GitHub', link = 'https://github.com/Muddieee/sun_is_sus' },
		aikoyori = { type = 'BSky', link = 'https://bsky.app/profile/aikoyori.xyz' },
		artbydefault = { type = 'BSky', link = 'https://bsky.app/profile/artbydefault.bsky.social' }
	},
	allFaceCards = { 'Jack', 'Queen', 'King', 'Ace' },
	cardSuits = { 'Hearts', 'Clubs', 'Diamonds', 'Spades' },
	ID_To_String = {
		'nil',
		'2',
		'3',
		'4',
		'5',
		'6',
		'7',
		'8',
		'9',
		'10',
		'Jack',
		'Queen',
		'King',
		'Ace'
	},
	cardRanksToValues_AceLow = {
		['King'] = 10,
		['Queen'] = 10,
		['Jack'] = 10,
		['10'] = 10,
		['9'] = 9,
		['8'] = 8,
		['7'] = 7,
		['6'] = 6,
		['5'] = 5,
		['4'] = 4,
		['3'] = 3,
		['2'] = 2,
		['Ace'] = 1
	},
	cardRanksToValues_AceHigh = {
		['Ace'] = 11,
		['King'] = 10,
		['Queen'] = 10,
		['Jack'] = 10,
		['10'] = 10,
		['9'] = 9,
		['8'] = 8,
		['7'] = 7,
		['6'] = 6,
		['5'] = 5,
		['4'] = 4,
		['3'] = 3,
		['2'] = 2
	},
	AKQJ_Shorthander = {
		['Ace'] = 'A',
		['King'] = 'K',
		['Queen'] = 'Q',
		['Jack'] = 'J'
	},
	SuitShorthander = {
		['Diamonds'] = 'D',
		['Hearts'] = 'H',
		['Clubs'] = 'C',
		['Spades'] = 'S'
	},
	cirFriends = {
		dm = 'Girl_DM_', -- Pay no attention as to how this list is ordered. There is no specific reasoning behind it.
		cir = 'Cirno_TV',
		vle = 'Vileelf',
		han = 'HannahHyrule',
		mom = 'ReimMomo',
		rmi = 'ArumiaTheSleepy',
		kzr = 'KaizurTV',
		tom = 'UnsanityLIVE',
		nrp = 'Naro',
		thr = 'ThorW',
		hou = 'Houdini111',
		wls = 'Wolsk',
		dme = 'Demeorin',
		dck = 'Biggdeck',
		oct = 'Octopimp',
		ntf = 'NopeTooFast'
	},
	cirFriend_Short = {
		dm = 'DM',
		cir = 'Cirno',
		vle = 'Vileelf',
		han = 'Hannah',
		mom = 'Momo',
		rmi = 'Rumi',
		kzr = 'Kaizur',
		tom = 'Tom',
		nrp = 'Naro',
		thr = 'ThorW',
		hou = 'Houdini',
		wls = 'Wolsk',
		dme = 'Demeorin',
		dck = 'Biggdeck',
		oct = 'Octo',
		ntf = 'Nope'
	},
	-- For the cardarea initialisation check
	friendDeckKeys = {
		b_cir_flesh = true,
		b_cir_frozen = true,
		b_cir_pirate = true,
		b_cir_narp = true,
		b_cir_fate = true,
		b_cir_zzz = true,
		b_cir_cryptic = true,
		b_cir_big = true,
		b_cir_theGuy = true,
		b_cir_snek = true,
		b_cir_hack = true,
		b_cir_sycophant = true
		-- TODO: momo, kaizur, vileelf, octo
	},
	-- debugTables = {},
	weirdArtCreditExceptionalCircumstanceKeys = {}, -- Some things seem to do weird things, like Wild cards.
	descExtensionTooltips = {},
	alphabetNumberConv = {
		numToAlphabet = {},
		alphabetToNum = {}
	},
	deckSkinNames = {}, -- How the custom deck skins are referred to internally. Used for art credit tooltips.
	deckSkinWhich = {}, -- Differentiate between different deck skins we might want to add, in case we have different crediting to do per skin.
	mainFloatingSpriteFixAttempt = {},
	keysOfAllCirnoModItems = {}, -- This will be used for any effects the focus on stuff edited or introduced by this mod
	jkrLoadOrder = {},
	jkrKeyGroups = {},
	jkrKeyGroupArrays = {},
	mlvrk_tex_keys = {},
	funnyAtlases = {},
	otherAtlases = {},
	otherModPresences = {},
	switchKeys = {},
	switchTables = {},
	force_remove_cir_badge = {
		j_greedy_joker = true,
		j_lusty_joker = true,
		j_wrathful_joker = true,
		j_gluttenous_joker = true,
		j_sly = true,
		j_ceremonial = true,
		j_raised_fist = true,
		j_supernova = true,
		j_vampire = true,
		j_golden = true,
		j_flash = true,
		j_certificate = true,
		j_glass = true
	},
	createErrorLocTxt = function(custName) return { name = custName or 'ERROR', text = {
			'This text should {C:red}not{} be visible.',
			'If you are seeing this, please contact',
			'your local {C:dark_edition}system administrator',
			'for {C:attention}troubleshooting{}.',
			'{s:0.8,C:inactive}Seriously, this shouldn\'t be',
			'{s:0.8,C:inactive}appearing anywhere. This IS a bug.'
		} }
	end,
	titleDissolveColours = function()
		if CirnoMod.config.titleColours then
			return { G.C.BLACK, CirnoMod.miscItems.colours.cirBlue, CirnoMod.miscItems.colours.cirCyan, CirnoMod.miscItems.colours.cirCyan }
		end
		
		return { G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD }
	end,
	cardShorthander = function(card)
		if
			card
			and card.base.suit
			and CirnoMod.miscItems.ID_To_String[card:get_id()]
		then
			if CirnoMod.miscItems.AKQJ_Shorthander[CirnoMod.miscItems.ID_To_String[card:get_id()]] then
				return CirnoMod.miscItems.AKQJ_Shorthander[CirnoMod.miscItems.ID_To_String[card:get_id()]]..'_'..CirnoMod.miscItems.SuitShorthander[card.base.suit]
			end
			
			return CirnoMod.miscItems.SuitShorthander[card.base.suit]..'_'..CirnoMod.miscItems.ID_To_String[card:get_id()]
		end
	end,
	baseValueCheck_IgnoreNoRank = function(card, value)
		return not SMODS.has_no_rank(card) and card.base.value == value
	end,
	--[[ This is what compares the two colours in a badge to see if
	they're	the same colour. 	...This isn't really the best way
	to do what I'm trying to do, but... Eh? ]]
	eq_col = function(x, y)
		for i = 1, 4 do
			if x[1] ~= y[1] then
				return false
			end
		end
		return true
	end,
	get_cir_data = function(sub_table, nil_check)
		if sub_table then
			return (G.PROFILES[G.SETTINGS.profile]
			and G.PROFILES[G.SETTINGS.profile].cir_data
			and G.PROFILES[G.SETTINGS.profile].cir_data[sub_table]) or (not nil_check and {})
		end
		
		return (G.PROFILES[G.SETTINGS.profile]
		and G.PROFILES[G.SETTINGS.profile].cir_data) or (not nil_check and {})
	end
}

miscItems.profileStoredVarsInitCheck = function()
	local doSave = false
	if not G.PROFILES[G.SETTINGS.profile].cir_data then
		if CirnoMod.config.jkrVals[G.SETTINGS.profile] then
			G.PROFILES[G.SETTINGS.profile].cir_data = copy_table(CirnoMod.config.jkrVals[G.SETTINGS.profile])
		else
			G.PROFILES[G.SETTINGS.profile].cir_data = {}
		end
		
		doSave = true
	end
	
	if G.PROFILES[G.SETTINGS.profile].cir_data then
		if not G.PROFILES[G.SETTINGS.profile].cir_data.store then
			if
				CirnoMod.config.jkrVals[G.SETTINGS.profile]
				and CirnoMod.config.jkrVals[G.SETTINGS.profile].store
			then
				G.PROFILES[G.SETTINGS.profile].cir_data.store = copy_table(CirnoMod.config.jkrVals[G.SETTINGS.profile].store)
			else
				G.PROFILES[G.SETTINGS.profile].cir_data.store = { friendDeckUnlocks = {} }
			end
			
			doSave = true
		end
		
		if not G.PROFILES[G.SETTINGS.profile].cir_data.encountered then
			if
				CirnoMod.config.jkrVals[G.SETTINGS.profile]
				and CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered
			then
				G.PROFILES[G.SETTINGS.profile].cir_data.encountered = copy_table(CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered)
			else
				G.PROFILES[G.SETTINGS.profile].cir_data.encountered = {}
			end
			
			doSave = true
		end
		
		if not G.PROFILES[G.SETTINGS.profile].cir_data.store.friendDeckUnlockCount then
			G.PROFILES[G.SETTINGS.profile].cir_data.store.friendDeckUnlockCount = 0
			doSave = true
		end
		
		if not G.PROFILES[G.SETTINGS.profile].cir_data.store.friendDeckUnlocks then
			G.PROFILES[G.SETTINGS.profile].cir_data.store.friendDeckUnlocks = {}
			doSave = true
		end
		
		if not G.PROFILES[G.SETTINGS.profile].cir_data.store.wonDecks then
			G.PROFILES[G.SETTINGS.profile].cir_data.store.wonDecks = {}
			doSave = true
		end
	end
	
	-- Deprecation of the old saved value system in mod config
	if CirnoMod.config.jkrVals[G.SETTINGS.profile] then
		CirnoMod.config.jkrVals[G.SETTINGS.profile] = nil
		doSave = true
		
		--[[
		if not CirnoMod.config.jkrVals[G.SETTINGS.profile].store then
			CirnoMod.config.jkrVals[G.SETTINGS.profile].store = { friendDeckUnlocks = {} }
			doSave = true
		end
		
		if not CirnoMod.config.jkrVals[G.SETTINGS.profile].store.friendDeckUnlockCount then
			CirnoMod.config.jkrVals[G.SETTINGS.profile].store.friendDeckUnlockCount = 0
			doSave = true
		end
		
		if not CirnoMod.config.jkrVals[G.SETTINGS.profile].store.friendDeckUnlocks then
			CirnoMod.config.jkrVals[G.SETTINGS.profile].store.friendDeckUnlocks = {}
			doSave = true
		end
		
		if not CirnoMod.config.jkrVals[G.SETTINGS.profile].store.wonDecks then
			CirnoMod.config.jkrVals[G.SETTINGS.profile].store.wonDecks = {}
			doSave = true
		end
		
		if not CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered then
			CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered = {}
			doSave = true
		end
		]]
	end
	
	if doSave then
		SMODS.save_mod_config(CirnoMod)
		G:save_progress()
	end
end

miscItems.modify_suit = function(card, amount, manual_sprites)
    local other_suit
    for k, v in pairs(SMODS.Suit.obj_buffer) do
        if v == card.base.suit then
            if amount > 0 then
                for i=1, amount do
                    if k+1 > #SMODS.Suit.obj_buffer then
                        k = 1
                        other_suit = SMODS.Suit.obj_buffer[1]
                    else
                        k = k+1
                        other_suit = SMODS.Suit.obj_buffer[k+1]
                    end
                end
            else
                for i=1, -amount do
                    if k <= 1 then
                        k = #SMODS.Suit.obj_buffer
                        other_suit = SMODS.Suit.obj_buffer[#SMODS.Suit.obj_buffer]
                    else
                        k = k-1
                        other_suit = SMODS.Suit.obj_buffer[k-1]
                    end
                end
            end
        end
    end
    return SMODS.change_base(card, other_suit, nil, manual_sprites)
end

miscItems.cirGunsSpriteX = 0

miscItems.upgradedExtraValue = {
	3,
	6,
	12,
	15
}
	
miscItems.matureReferencesOpt = { "(Hopefully) Safest", "Some", "All" } -- These are the options that appear on the new cycle option for mature references.

-- Table containing keys of jokers and what contexts should be ignored for red seal retriggers, should be deprecated in the future at some point maybe, this is a dumb solution to what was the problem at the time don't do this
miscItems.redSealRetriggerIgnoreTable = {
		j_fortune_teller = { 'using_consumeable' },
		j_cir_naro_l = { 'using_consumeable' },
		j_cir_arumia_l = { 'using_consumeable', 'setting_blind', 'hand_drawn' },
		j_cir_comfyVibes = { 'using_consumeable' },
		j_cir_somnolent = { 'using_consumeable', 'setting_blind', 'hand_drawn' },
		j_cir_b3313 = { 'modify_scoring_hand' }
	}

miscItems.itmReferenceTable = {
	j_jolly = { { miscItems.cirFriends.nrp } },
	j_zany = { { miscItems.cirFriends.han } },
	j_mad = { { miscItems.cirFriends.cir } },
	j_crazy = { { miscItems.cirFriends.dm } },
	j_droll = { { miscItems.cirFriends.dck } },
	j_crazy = { { miscItems.cirFriends.dm } },
	j_droll = { { miscItems.cirFriends.dck } },
	j_sly = { { miscItems.cirFriends.nrp, miscItems.cirFriends.cir } },
	j_wily = { { miscItems.cirFriends.han } },
	j_clever = { { miscItems.cirFriends.cir } },
	j_devious = { { miscItems.cirFriends.dm } },
	j_crafty = { { miscItems.cirFriends.dck } },
	j_greedy_joker = { { miscItems.cirFriends.dm } },
	j_lusty_joker = { { miscItems.cirFriends.han } },
	j_wrathful_joker = { { miscItems.cirFriends.dck } },
	j_gluttenous_joker = { { miscItems.cirFriends.cir } },
	
	j_juggler = { { miscItems.cirFriends.cir } },
	j_drunkard = { { miscItems.cirFriends.cir, miscItems.cirFriends.han, miscItems.cirFriends.nrp, miscItems.cirFriends.mom, miscItems.cirFriends.dm } },
	j_acrobat = { { miscItems.cirFriends.cir } },
	j_mime = { { miscItems.cirFriends.cir } },
	j_credit_card = { { miscItems.cirFriends.cir } },
	j_troubadour = { { miscItems.cirFriends.cir, miscItems.cirFriends.mom } },
	j_banner = { { miscItems.cirFriends.cir } },
	j_mystic_summit = { { miscItems.cirFriends.cir } },
	j_marble = { { miscItems.cirFriends.cir, miscItems.cirFriends.tom, miscItems.cirFriends.dm } },
	j_hack = { { miscItems.cirFriends.cir } },
	j_misprint = { { miscItems.cirFriends.cir } },
	j_golden = { { miscItems.cirFriends.cir } },
	
	j_scary_face = { { miscItems.cirFriends.cir, miscItems.cirFriends.tom, miscItems.cirFriends.dm } },
	j_abstract = { { miscItems.cirFriends.cir, miscItems.cirFriends.thr, miscItems.cirFriends.dm } },
	j_delayed_grat = { { miscItems.cirFriends.cir, miscItems.cirFriends.mom } },
	j_even_steven = { { miscItems.cirFriends.cir, miscItems.cirFriends.tom, miscItems.cirFriends.han, miscItems.cirFriends.dck, miscItems.cirFriends.rmi } },
	j_odd_todd = { { miscItems.cirFriends.cir, miscItems.cirFriends.tom, miscItems.cirFriends.han, miscItems.cirFriends.dck, miscItems.cirFriends.rmi } },
	j_scholar = { { miscItems.cirFriends.cir } },
	j_mr_bones = { { miscItems.cirFriends.cir } },
	j_seeing_double = { { miscItems.cirFriends.cir } },
	j_duo = { { miscItems.cirFriends.cir } },
	j_family = { { miscItems.cirFriends.cir } },
	j_tribe = { { miscItems.cirFriends.cir } },
	j_matador = { { miscItems.cirFriends.cir, miscItems.cirFriends.rmi, miscItems.cirFriends.nrp, miscItems.cirFriends.thr } },
	j_swashbuckler = { { miscItems.cirFriends.dm, miscItems.cirFriends.mom, miscItems.cirFriends.cir, miscItems.cirFriends.han, miscItems.cirFriends.nrp, miscItems.cirFriends.thr } },
	j_ring_master = { { miscItems.cirFriends.cir } },
	j_hit_the_road = { { miscItems.cirFriends.cir } },
	j_flower_pot = { { miscItems.cirFriends.cir } },
	j_gros_michel = { { miscItems.cirFriends.cir } },
	j_stuntman = { { miscItems.cirFriends.cir } },
	j_throwback = { { miscItems.cirFriends.cir } },
	j_rough_gem = { { miscItems.cirFriends.dm, miscItems.cirFriends.mom, miscItems.cirFriends.rmi, miscItems.cirFriends.nrp } },
	
	j_caino = { { miscItems.cirFriends.dm } },
	j_triboulet = { { miscItems.cirFriends.han } },
	j_yorick = { { miscItems.cirFriends.thr } },
	j_chicot = { { miscItems.cirFriends.mom } },
	j_perkeo = { { miscItems.cirFriends.dck } },
	j_certificate = { { miscItems.cirFriends.cir } },
	j_bootstraps = { { miscItems.cirFriends.cir } },
	j_egg = { { miscItems.cirFriends.cir } },
	j_burglar = { { miscItems.cirFriends.cir } },
	j_blackboard = { { miscItems.cirFriends.cir } },
	j_ice_cream = { { miscItems.cirFriends.cir } },
	j_runner = { { miscItems.cirFriends.cir, miscItems.cirFriends.nrp, miscItems.cirFriends.rmi } },
	j_splash = { { miscItems.cirFriends.cir, miscItems.cirFriends.dm } },
	j_sixth_sense = { { miscItems.cirFriends.cir } },
	j_hiker = { { miscItems.cirFriends.cir } },
	j_faceless = { { miscItems.cirFriends.cir, miscItems.cirFriends.dm, miscItems.cirFriends.tom, miscItems.cirFriends.dck } },
	
	j_superposition = { { miscItems.cirFriends.cir } },
	j_todo_list = { { miscItems.cirFriends.cir } },
	j_red_card = { { miscItems.cirFriends.cir } },
	j_madness = { { miscItems.cirFriends.cir, miscItems.cirFriends.dm } },
	j_square = { { miscItems.cirFriends.cir } },
	j_riff_raff = { { miscItems.cirFriends.cir } },
	j_shortcut = { { miscItems.cirFriends.cir } },
	j_vagabond = { { miscItems.cirFriends.cir } },
	j_rocket = { { miscItems.cirFriends.cir } },
	j_obelisk = { { miscItems.cirFriends.cir } },
	j_midas_mask = { { miscItems.cirFriends.cir, miscItems.cirFriends.han, miscItems.cirFriends.dck } },
	j_photograph = { { miscItems.cirFriends.cir } },
	j_gift = { { miscItems.cirFriends.cir } },
	j_turtle_bean = { { miscItems.cirFriends.cir } },
	j_erosion = { { miscItems.cirFriends.cir } },
	j_reserved_parking = { { miscItems.cirFriends.cir } },
	j_mail = { { miscItems.cirFriends.cir } },
	j_hallucination = { { miscItems.cirFriends.cir, miscItems.cirFriends.dm, miscItems.cirFriends.han } },
	
	j_bull = { { miscItems.cirFriends.cir } },
	j_trading = { { miscItems.cirFriends.cir } },
	j_flash = { { miscItems.cirFriends.cir } },
	j_popcorn = { { miscItems.cirFriends.cir } },
	j_ramen = { { miscItems.cirFriends.cir } },
	j_selzer = { { miscItems.cirFriends.cir } },
	j_trousers = { { miscItems.cirFriends.cir } },
	j_campfire = { { miscItems.cirFriends.cir, miscItems.cirFriends.dm } },
	j_ancient = { { miscItems.cirFriends.cir } },
	j_walkie_talkie = { { miscItems.cirFriends.cir } },
	j_castle = { { miscItems.cirFriends.cir } },
	
	c_fool = { { miscItems.cirFriends.cir } },
	c_wheel_of_fortune = { { miscItems.cirFriends.ntf } },
	c_death = { { miscItems.cirFriends.cir } },
	c_temperance = { { miscItems.cirFriends.cir, miscItems.cirFriends.dck } },
	c_devil = { { miscItems.cirFriends.cir, miscItems.cirFriends.tom, miscItems.cirFriends.han, miscItems.cirFriends.dck } },
	c_tower = { { miscItems.cirFriends.cir } },
	c_moon = { { miscItems.cirFriends.cir } },
	c_sun = { { miscItems.cirFriends.cir, miscItems.cirFriends.tom, miscItems.cirFriends.nrp, miscItems.cirFriends.thr } },
	
	c_black_hole = { { miscItems.cirFriends.cir } },
	c_grim = { { miscItems.cirFriends.cir } },
	c_aura = { { miscItems.cirFriends.cir } },
	c_ouija = { { miscItems.cirFriends.cir } },
	c_trance = { { miscItems.cirFriends.dm, miscItems.cirFriends.cir } },
	
	v_grabber = { { miscItems.cirFriends.cir } },
	v_nacho_tong = { { miscItems.cirFriends.cir } },
	v_overstock_plus = { { miscItems.cirFriends.cir } },
	v_hone = { { miscItems.cirFriends.cir, miscItems.cirFriends.han, miscItems.cirFriends.tom } },
	v_glow_up = { { miscItems.cirFriends.cir, miscItems.cirFriends.han, miscItems.cirFriends.tom } },
	v_antimatter = { { miscItems.cirFriends.cir } },
	
	tag_garbage = { { miscItems.cirFriends.cir } },
}

miscItems.colours = {
	cirInactiveAtt = HEX('BFB199FF'),
	cirBgInactive = HEX('66666600'),
	cirFaintLavender = HEX('ABA3CCFF'),
	cirBlue = HEX('0766EBFF'),
	cirCyan = HEX('0AD0F7FF'),
	cirCyanAlt = HEX('11AEF7FF'), -- Needed to distinguish cirGuns badge from mod badge
	cirLucy = HEX('7BB083FF'),
	cirNep = HEX('D066ADFF'),
	cirUpgradedJkrClr = HEX('CCB35AFF'),
	cirKeepsakeClr = HEX('CC7812FF'),
	dmDark = HEX('395A2FFF'),
	hanDark = HEX('312842FF'),
	momoCyan = HEX('068170FF'),
	houAqua = HEX('62D9D9FF'),
	bbBlack = HEX('000000FF'),
	bbInvisText = HEX('00000000'),
	whiteOnly = HEX('FFFFFFFF')
}

miscItems.creditLinkTypeToColour = {
		BSky = miscItems.colours.cirCyan,
		Twitch = G.C.PURPLE,
		Nexus = G.C.FILTER,
		GitHub = G.C.GREY,
		Twitter = G.C.UI.TEXT_DARK,
		Carrd = G.C.UI.TEXT_LIGHT
	}

for _, c in ipairs(miscItems.cardSuits) do
	miscItems.colours[string.lower(c)..'_hc'] = G.C.SO_2[c]
end

miscItems.FriendToClr_Raw = {
	Girl_DM_ = function() return { G.C.GREEN, CirnoMod.miscItems.colours.dmDark } end,
	Cirno_TV = function() return {
		CirnoMod.miscItems.colours.cirCyan,
		CirnoMod.miscItems.colours.cirBlue
	} end,
	Vileelf = function() return {
		CirnoMod.miscItems.colours.cirCyan,
		CirnoMod.miscItems.colours.cirNep,
		G.C.JOKER_GREY,
		CirnoMod.miscItems.colours.cirNep,
		CirnoMod.miscItems.colours.cirCyan
	} end,
	HannahHyrule = function() return { G.C.PURPLE, CirnoMod.miscItems.colours.hanDark } end,
	ReimMomo = function() return { G.C.PURPLE, CirnoMod.miscItems.colours.momoCyan } end,
	ArumiaTheSleepy = function() return { G.C.RED, CirnoMod.miscItems.colours.cirCyan } end,
	KaizurTV = function() return { CirnoMod.miscItems.colours.diamonds_hc } end,
	UnsanityLIVE = function() return { G.C.GREEN } end,
	Naro = function() return { G.C.RED, CirnoMod.miscItems.colours.cirNep, G.C.BLUE } end,
	ThorW = function() return { CirnoMod.miscItems.colours.diamonds_hc } end,
	Houdini111 = function() return { G.C.ORANGE, CirnoMod.miscItems.colours.houAqua } end,
	Wolsk = function() return { CirnoMod.miscItems.colours.cirCyan, G.C.PURPLE } end,
	Demeorin = function() return { G.C.RED, G.C.BLACK } end,
	Biggdeck = function() return { G.C.PURPLE, G.C.RED, G.C.GREEN } end,
	Octopimp = function() return { G.C.PURPLE } end,
	NopeTooFast = function() return { G.C.PURPLE, CirnoMod.miscItems.colours.cirNep } end 
}

miscItems.friendDeckBadgeClrs = {}

miscItems.colours.cirDM = SMODS.Gradient({
	key = 'cirDM',
	colours = {
		G.C.GREEN,
		miscItems.colours.dmDark
	}
})

miscItems.colours.cirVile = SMODS.Gradient({
	key = 'cirVile',
	colours = {
		miscItems.colours.cirCyan,
		miscItems.colours.cirNep,
		G.C.JOKER_GREY,
		miscItems.colours.cirNep,
		miscItems.colours.cirCyan
	}
})

miscItems.colours.cirNo = SMODS.Gradient({
	key = 'cirNo',
	colours = {
		miscItems.colours.cirCyan,
		miscItems.colours.cirBlue
	}
})

miscItems.colours.cirHan = SMODS.Gradient({
	key = 'cirHan',
	colours = {
		G.C.PURPLE,
		miscItems.colours.hanDark
	}
})

miscItems.colours.cirNaro = SMODS.Gradient({
	key = 'cirNaro',
	colours = {
		G.C.RED,
		miscItems.colours.cirNep,
		G.C.BLUE
	}
})

miscItems.colours.cirThor = SMODS.Gradient({
	key = 'cirThor',
	colours = {
		G.C.MONEY,
		miscItems.colours.cirInactiveAtt
	}
})

miscItems.colours.cirMomo = SMODS.Gradient({
	key = 'cirMomo',
	colours = {
		G.C.PURPLE,
		miscItems.colours.momoCyan
	}
})

miscItems.colours.cirRumi = SMODS.Gradient({
	key = 'cirRumi',
	colours = {
		G.C.RED,
		miscItems.colours.cirCyan
	}
})

miscItems.colours.cirDeck = SMODS.Gradient({
	key = 'cirDeck',
	colours = {
		G.C.PURPLE,
		G.C.RED,
		G.C.GREEN
	}
})

miscItems.colours.cirHoudini = SMODS.Gradient({
	key = 'cirHoudini',
	colours = {
		G.C.ORANGE,
		miscItems.colours.houAqua
	}
})

miscItems.colours.cirWolsk = SMODS.Gradient({
	key = 'cirWolsk',
	colours = {
		miscItems.colours.cirCyan,
		G.C.PURPLE
	}
})

miscItems.colours.cirDeme = SMODS.Gradient({
	key = 'cirDeme',
	colours = {
		G.C.RED,
		G.C.BLACK
	}
})

miscItems.colours.cirNope = SMODS.Gradient({
	key = 'cirNope',
	colours = {
		G.C.PURPLE,
		miscItems.colours.cirNep
	}
})

miscItems.FriendToClr = {
	Girl_DM_ = function() return CirnoMod.miscItems.colours.cirDM end,
	Cirno_TV = function() return CirnoMod.miscItems.colours.cirNo end,
	Vileelf = function() return CirnoMod.miscItems.colours.cirVile end,
	HannahHyrule = function() return CirnoMod.miscItems.colours.cirHan end,
	ReimMomo = function() return CirnoMod.miscItems.colours.cirMomo end,
	ArumiaTheSleepy = function() return  CirnoMod.miscItems.colours.cirRumi end,
	KaizurTV = function() return CirnoMod.miscItems.colours.diamonds_hc end,
	UnsanityLIVE = function() return G.C.GREEN end,
	Naro = function() return CirnoMod.miscItems.colours.cirNaro end,
	ThorW = function() return CirnoMod.miscItems.colours.diamonds_hc end,
	Houdini111 = function() return CirnoMod.miscItems.colours.cirHoudini end,
	Wolsk = function() return CirnoMod.miscItems.colours.cirWolsk end,
	Demeorin = function() return CirnoMod.miscItems.colours.cirDeme end,
	Biggdeck = function() return CirnoMod.miscItems.colours.cirDeck end,
	Octopimp = function() return G.C.PURPLE end,
	NopeTooFast = function() return CirnoMod.miscItems.colours.cirNope end 
}

miscItems.checkBlueprintCompat = function(compatVar)
	return compatVar == nil
		or compatVar == true
end

miscItems.checkSkinCard = function(cardRank)
	for i, rank in ipairs(CirnoMod.miscItems.allFaceCards) do
		if cardRank == rank then
			return true
		end		
	end
	return false
end

miscItems.changeVarWhileRespectingAdditions = function(var, orgVal, newVal)
	local preservedAddition = math.max(to_big(var) - to_big(orgVal), to_big(0))
	
	var = to_big(newVal) + to_big(preservedAddition)
	
	return var
end

miscItems.suitRankToFriend_NmClr = {
	Diamonds = {
		Ace = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.kzr, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.kzr](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		King = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.thr, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.thr](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Queen = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.dm, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.dm](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Jack = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.hou, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.hou](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end
	},
	
	Hearts = {
		Ace = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.mom, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.mom](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		King = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.han, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.han](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Queen = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.ntf, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.ntf](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Jack = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.rmi, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.rmi](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end
	},
	
	Clubs = {
		Ace = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.vle, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.vle](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		King = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.nrp, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.nrp](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Queen = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.cir, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.cir](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Jack = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.tom, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.tom](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end
	},
	
	Spades = {
		Ace = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.oct, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.oct](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		King = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.wls, CirnoMod.miscItems.colours.cirWolsk, G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Queen = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.dck, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.dck](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end,
		Jack = function(textSize)
				return create_badge(CirnoMod.miscItems.cirFriends.dme, CirnoMod.miscItems.FriendToClr[CirnoMod.miscItems.cirFriends.dme](), G.C.UI.TEXT_LIGHT, textSize or 0.8)
			end
	}
}

miscItems.colours.cirUpgradedJkrClr_tbl = {
	SMODS.Gradient({
		key = 'cirUpgCmn',
		colours = {
			G.C.RARITY[1],
			miscItems.colours.cirUpgradedJkrClr
		}
	}),
	
	SMODS.Gradient({
		key = 'cirUpgUnc',
		colours = {
			G.C.RARITY[2],
			miscItems.colours.cirUpgradedJkrClr
		}
	}),
	
	SMODS.Gradient({
		key = 'cirUpgRare',
		colours = {
			G.C.RARITY[3],
			miscItems.colours.cirUpgradedJkrClr
		}
	}),
	
	SMODS.Gradient({
		key = 'cirUpgLgnd',
		colours = {
			G.C.RARITY[4],
			miscItems.colours.cirUpgradedJkrClr
		}
	}),
	
	SMODS.Gradient({
		key = 'cirUpgKpsk',
		colours = {
			miscItems.colours.cirKeepsakeClr,
			miscItems.colours.cirUpgradedJkrClr
		}
	})
}

miscItems.badges = {
	allegations = function(bootstrapsName) return create_badge(bootstrapsName or 'You Forgot To Pass The Name In', G.C.GREEN, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	TwoMax = function() return create_badge("2 Max", miscItems.colours.cirNep, G.C.UI.TEXT_LIGHT, 0.8) end,
	fingerGuns = function() return create_badge("cirGuns", miscItems.colours.cirCyanAlt, G.C.UI.TEXT_LIGHT, 0.8) end,
	unhinged = function() return create_badge("Unhinged", G.C.RED, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	chatBrainrot = function() return create_badge("Chat Brainrot", miscItems.colours.cirBlue, G.C.UI.TEXT_LIGHT, 0.8) end,
	upgradedJkr = {
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Common' }, { string = 'Upgraded' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[1], nil, 1.3)
		end,
		
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Uncommon' }, { string = 'Upgraded' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[2], nil, 1.3)
		end,
		
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Rare' }, { string = 'Upgraded' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[3], nil, 1.3)
		end,
		
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Legendary' }, { string = 'Upgraded' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[4], nil, 1.3)
		end,
		
		cir_keepsake_r = function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Keepsake' }, { string = 'Upgraded' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[5], nil, 1.3)
		end
	}
}

miscItems.createDynaTextBadge = function(badgeStrings, badgeColour, badgeTextColours, badgeScale)
	local ret = nil
	local bScale = badgeScale or 1
	
	if
		badgeStrings
		and type(badgeStrings) == 'table'
		and #badgeStrings > 0
		and (type(badgeStrings[1]) == 'table'
		or type(badgeStrings[1]) == 'string')
	then
		local badge_text = {}
		
		if
			badgeStrings[1]
			and type(badgeStrings[1]) == 'table'
			and badgeStrings[1].string
		then
			badge_text = badgeStrings
		elseif type(badgeStrings[1]) == 'string' then
			for i, str in ipairs(badgeStrings) do
				table.insert(badge_text, { string = str })
			end
		end
		
		--[[
		This seems to work out the scale factor for
		the badge based on the fact that it's going
		to be a badge, the length of the text and
		based on the font being used.]]
		local function calc_scale_fac(text)
			local size = 0.9 * bScale
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Maths reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		
		local scale_fac = {}
		local min_scale_fac = 1
			
		--[[
		Basically, the longer the longest text will be, the
		smaller the badge text should be]]
		for i, tbl in ipairs(badge_text) do
			scale_fac[i] = calc_scale_fac(tbl.string)
			min_scale_fac = math.min(min_scale_fac, scale_fac[i])
		end
		
		ret = {
			n = G.UIT.R,
			config = { align = 'cm' },
			nodes = { {
				n = G.UIT.R, -- ...Yes, I know. This is how Cryptid does it, I don't understand, but it works for them and it seems to work for Cardsauce too? So, whatever
				config = {
					align = 'cm',
					colour = badgeColour,
					r = 0.1,
					minw = 1.875 / min_scale_fac,
					minh = 0.36 * bScale,
					emboss = 0.05,
					padding = 0.03 * 0.9,
				},
				nodes = {
				{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } }, -- Spacer
				{ -- The actual badge object itself.
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = badge_text,
							colours = { badgeTextColours or G.C.WHITE },
							silent = true,
							float = true,
							shadow = true,
							offset_y = -0.03,
							spacing = 1,
							min_cycle_time = 5,
							scale = 0.33 * 0.9 * bScale
						})
					}
				},
				{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } } -- Spacer
				}
			} }
		}
	else
		print('CirnoMod.miscItems.createDynaTextBadge() expected a table with length > 0, got '..(badgeStrings and type(badgeStrings) or 'nil'))
	end
	
	return ret
end

miscItems.addBadgesToJokerByKey = function(badgesTable, jkrKey, extArg)
	for k, g in pairs(CirnoMod.miscItems.jkrKeyGroups) do
		if
			g[jkrKey]
			and CirnoMod.miscItems.badges[k]
			and (type(g[jkrKey]) ~= 'function'
			or g[jkrKey]())
		then
			badgesTable[#badgesTable+1] = CirnoMod.miscItems.badges[k](extArg)
		end
	end
end

miscItems.addUITextNode = function(nodes, text, colour, scale)
	nodes[#nodes + 1] = {
		n = G.UIT.T,
		config = {
			text = text,
			colour = colour,
			scale = scale*0.32
		}
	}
	
	return nodes[#nodes]
end
	
miscItems.addUISpriteNode = function(nodes, sprite)
	local RV = nil
	
	if nodes then
		nodes[#nodes + 1] = {
			n = G.UIT.O,
			config = { object = sprite }
		}
		RV = nodes[#nodes]
	else
		RV = {
			n = G.UIT.O,
			config = { object = sprite }
		}
	end
	
	if sprite.atlas.manualFrameParsing	then
		RV.config.thisObjFrameParse = copy_table(sprite.atlas.manualFrameParsing)
		RV.config.thisObjFrameParse.counter = 0
		CirnoMod.miscItems.manuallyAnimateAtlasItem(RV.config)
	elseif sprite.atlas.typewriterFrameParsing then
		RV.config.thisObjFrameParse = copy_table(sprite.atlas.typewriterFrameParsing)
		RV.config.thisObjFrameParse.counter = 0
		CirnoMod.miscItems.doTypewriterAtlasAnimation(RV.config)
	end
	
	return RV
end
	
miscItems.addUIColumnOrRowNode = function(nodes, alignment, type, colour, radius, padding)
	if
		type == 'C'
		or type == 'R'
	then
		nodes[#nodes + 1] = {
			n = G.UIT[type],
			config = {
				align = alignment,
				colour = colour,
				r = radius,
				padding = padding,
				res = 0.15
			},
			nodes = {}
		}
	end
	
	return nodes[#nodes]
end
	
miscItems.restructureNodesTableIntoRowsOrColumns = function(nodesTable, orderedKeysTable, RowOrColumn, config)
	local RV = {}
	
	if
		RowOrColumn == 'R'
		or RowOrColumn == 'C'
	then		
		for i, k in ipairs (orderedKeysTable) do
			table.insert(RV, {
				n = G.UIT[RowOrColumn],
				config = config,
				nodes = nodesTable[k]
			})
		end
	end
	
	return RV
end
	
miscItems.addHighlightedUITextNode = function(nodes, alignment, HColour, radius, padding, text, TColour, scale)
	nodes[#nodes + 1] = {
		n = G.UIT.C,
		config = {
			align = alignment,
			colour = HColour,
			r = radius,
			padding = padding,
			res = 0.15
		},
		nodes = {{
			n = G.UIT.T,
			config = {
				text = text,
				colour = TColour,
				scale = scale*0.32
			}
		}}
	}
	
	return nodes[#nodes]
end

miscItems.addJokerToTableIfDiscovered = function(t, joker, noDuplicate)
	if joker and joker.discovered then
		if noDuplicate then
			CirnoMod.miscItems.addItemToTableIfNotDuplicate(t, joker)
			return
		end
		
		table.insert(t, joker)
	end
end

miscItems.addJokerToTableIfEncountered = function(t, joker, noDuplicate)	
	if joker and CirnoMod.miscItems.hasEncounteredJoker(joker.key) then
		if noDuplicate then
			CirnoMod.miscItems.addItemToTableIfNotDuplicate(t, joker)
			return
		end
		
		table.insert(t, joker)
	end
end

miscItems.addItemToTableIfNotDuplicate = function(t, item)
	if (not t) or (not item) then return end
	
	if #t > 0 then
		for i, ent in ipairs(t) do
			if ent == item then
				return
			end
		end
	else
		for k, ent in pairs(t) do
			if ent == item then
				return
			end
		end
	end
	
	table.insert(t, item)
end

miscItems.unhighlightAllJokerAreas = function(additionalAreas, ignoreAreas)
	jkrAreas = SMODS.get_card_areas('jokers')
	
	if additionalAreas then
		jkrAreas = SMODS.merge_lists{ jkrAreas, additionalAreas }
	end
	
	for _, area in ipairs(jkrAreas) do
		local skip = false
		if ignoreAreas and #ignoreAreas > 0 then
			for i, ignore in ipairs(ignoreAreas) do
				if area == ignore then skip = true break end
			end
		end
		
		if not skip then
			if area.unhighlight_all and type(area.unhighlight_all) == 'function' then
				area:unhighlight_all()
			end
		end
	end
end

miscItems.create_open_booster = function(b_key, args)
	if b_key then
		local args = args or {}
		if args.clear_stored_back_key and G.GAME then
			G.GAME.selected_back.effect.config.open_booster = nil
		end
		if args.save_action then
			save_with_action(args.save_action)
		end
		local booster = SMODS.create_card{ key = b_key, area = G.play }
		booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
		booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
		booster.T.w = G.CARD_W * 1.27
		booster.T.h = G.CARD_H * 1.27
		booster.cost = 0
		G.FUNCS.use_card({ config = { ref_table = booster } }, args.mute, args.use_card_nosave)
		booster:start_materialize()
	end
end

function updateVisibleCards()
	for _, card in pairs(G.I.CARD) do
        if card.set_sprites and not card.params.texture_pack then
            local _center = G.P_CENTERS[card.config.center_key]
            if _center.atlas or G.ASSET_ATLAS[_center.set] then
                card.children.center.scale = {
                    x=G.ASSET_ATLAS[_center.atlas or _center.set].px,
                    y=G.ASSET_ATLAS[_center.atlas or _center.set].py
                }
            end
            card:set_sprites(_center)
        end
    end
end

function Card:visualDissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.skip_destroy_animation then
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                self.T.r = -0.2
                self:juice_up(0.3, 0.4)
                self.states.drag.is = true
                self.children.center.pinch.x = true
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                    func = function()
                            self.states.visible = false
                        return true; end})) 
                return true
            end
        })) 
        return
    end
    dissolve_colours = dissolve_colours or (type(self.destroyed) == 'table' and self.destroyed.colours) or nil
    dissolve_time_fac = dissolve_time_fac or (type(self.destroyed) == 'table' and self.destroyed.time) or nil
    local dissolve_time = 0.7*(dissolve_time_fac or 1)
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours
        or {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    if not no_juice then self:juice_up() end
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.7*dissolve_time,
        func = (function() childParts:fade(0.3*dissolve_time) return true end)
    }))
    if not silent then 
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = (function()
                    play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                    play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
                return true end)
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.05*dissolve_time,
        func = (function() self.states.visible = false return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.051*dissolve_time,
    }))
end

miscItems.indexedTableContainsItem = function(t, item)
	if #t > 0 then
		for i = 1, #t do
			if t[i] == item then
				return true
			end
		end
	end
	
	return false
end

miscItems.doTitleCardCycle = function(viable_unlockables, attemptNo) -- , SC_scale)	
	if CirnoMod.miscItems.cyclerRunning then
		return
	end
		
	attemptNo = attemptNo or 0
	local holdUntilNew = false
	local texPack_ProbablyNotActive = false
	local lastFive = {}
	local titleCard = nil
	local decidedItem = nil
	local doRandomEdition = false
	local materialiseColours = nil
	
	for _, crd in ipairs(G.title_top.cards) do
		if
			crd.mod_flag == 'CTVaF'
			and crd.config.center.key == 'j_blueprint'
		then
			titleCard = crd
			break
		end
	end
	
	if not titleCard then
		if attemptNo < 10 then
			G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 1.0,
					blocking = false,
					blockable = true,
					func = function()
						CirnoMod.miscItems.doTitleCardCycle(nil, attemptNo + 1)
						return true
					end
				}))
		end
		
		return
	end
	
	CirnoMod.miscItems.cyclerRunning = true
					
	titleCard.bypass_discovery_ui = false
	titleCard.bypass_discovery_center = false
	titleCard.params.bypass_discovery_ui = false
	titleCard.params.bypass_discovery_center = false
	
	--[[
	Scale correction for create sprites, otherwise they appear shrunk
	Have to have two seperate args for card and center because floating
	sprite hierarchy is different ]]
	local correctCenterSpriteScaling = function(card, center, normalise)
		local scale = (normalise and 1) or (1.3*(G.debug_splash_size_toggle and 0.8 or 1))
		local setH = 95
		local setW = 71
		
		if not center.display_size then
			center.display_size = { h = setH*scale, w = setW*scale }
		else
			center.display_size.h = setH*scale
			center.display_size.w = setW*scale
		end
		
		if center.key == "j_half" then
			card.T.h = setH*scale/1.7*scale
			card.T.w = setW*scale
		elseif center.key == "j_wee" then
			card.T.h = setH*scale*0.7*scale
			card.T.w = setW*scale*0.7*scale
		elseif center.key == "j_photograph" then
			card.T.h = setH*scale/1.2*scale
			card.T.w = setW*scale
		elseif center.key == "j_square" then
			setH = setW
			card.T.h = setH*scale
			card.T.w = setW*scale
		end
		
		if center.display_size and center.display_size.h then
			if center.key == "j_half" then
				card.T.h = (G.CARD_H*(center.display_size.h/95))/1.7
			elseif center.key == "j_wee" then
				card.T.h = (G.CARD_H*(center.display_size.h/95))*0.7
			elseif center.key == "j_photograph" then
				card.T.h = (G.CARD_H*(center.display_size.h/95))/1.2
			elseif center.key == "j_square" then
				card.T.h = G.CARD_W*(center.display_size.w/71)
			else
				card.T.h = G.CARD_H*(center.display_size.h/95)
			end			
		elseif center.pixel_size and center.pixel_size.h then
			if center.key == "j_half" then
				card.T.h = (G.CARD_H*(center.pixel_size.h/95))/1.7
			elseif center.key == "j_wee" then
				card.T.h = (G.CARD_H*(center.pixel_size.h/95))*0.7
			elseif center.key == "j_photograph" then
				card.T.h = (G.CARD_H*(center.pixel_size.h/95))/1.2
			elseif center.key == "j_square" then
				card.T.h = G.CARD_W*(center.pixel_size.w/71)
			else
				card.T.h = G.CARD_H*(center.pixel_size.h/95)
			end
		end
		
		if center.display_size and center.display_size.w then
			if center.key == "j_wee" then
				card.T.w = (G.CARD_W*(center.display_size.w/71))*0.7
			else
				card.T.w = G.CARD_W*(center.display_size.w/71)
			end
		elseif center.pixel_size and center.pixel_size.w then
			if center.key == "j_wee" then
				card.T.w = (G.CARD_W*(center.pixel_size.w/71))*0.7
			else
				card.T.w = G.CARD_W*(center.pixel_size.w/71)
			end
		end
	end
	
	if not viable_unlockables then
		viable_unlockables = {}
	end
	
	-- Populate pool with Vouchers, Tarots, Planets, Spectrals and Jokers
	for k, v in pairs(G.P_CENTERS) do
		if
			(v.unlocked == false
			and v.set ~= 'Back')
			-- or (v.discovered
			and ((v.set == 'Voucher'
			or v.set == 'Tarot'
			or v.set == 'Planet'
			or v.set == 'Spectral')
			-- or v.set == 'Enhanced' Remove enhancements for now
			and CirnoMod.miscItems.get_cir_data('store').doneOneRunWMod)
			or ((v.set == 'Joker'
			and CirnoMod.miscItems.hasEncounteredJoker(v.key)))--)
			and not v.demo
		then
			CirnoMod.miscItems.addItemToTableIfNotDuplicate(viable_unlockables, v)
		end
	end
	
	if CirnoMod.miscItems.debugTables then
		CirnoMod.miscItems.debugTables.menuPool = SMODS.shallow_copy(viable_unlockables)
	end
	
	CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS.j_blueprint, true)
		
	CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS.j_egg, true)
	
	if CirnoMod.miscItems.jkrKeyGroups.fingerGuns then
		for k, b in pairs (CirnoMod.miscItems.jkrKeyGroups.fingerGuns) do
			if
				k == 'j_ring_master'
				or CirnoMod.miscItems.hasEncounteredJoker(k)
			then
				CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS[k], true)
			end
		end
	end
	
	if CirnoMod.miscItems.jkrKeyGroups.allegations then
		for k, b in pairs (CirnoMod.miscItems.jkrKeyGroups.allegations) do
			CirnoMod.miscItems.addJokerToTableIfEncountered(viable_unlockables, G.P_CENTERS[k], true)
		end
	end
	
	local jkrKeys_AddIfEncountered = {
		'j_joker',
		'j_mime',
		'j_credit_card',
		'j_duo',
		'j_family',
		'j_mr_bones',
		'j_smiley',
		'j_caino',
		'j_triboulet',
		'j_yorick',
		'j_chicot',
		'j_perkeo',
	}
	
	if CirnoMod.config.addCustomJokers then
		if G.P_CENTERS.j_cir_crazyFace.unlocked then
			CirnoMod.miscItems.addItemToTableIfNotDuplicate(viable_unlockables, G.P_CENTERS.j_cir_crazyFace)
		end
		
		if G.P_CENTERS.j_cir_dabber.unlocked then
			CirnoMod.miscItems.addItemToTableIfNotDuplicate(viable_unlockables, G.P_CENTERS.j_cir_dabber)
		end
		
		jkrKeys_AddIfEncountered = SMODS.merge_lists({ jkrKeys_AddIfEncountered, {
			'j_cir_cirno_l',
			'j_cir_nope_l',
			'j_cir_naro_l',
			'j_cir_arumia_l',
			'j_cir_vileelf_l',
			'j_cir_houdini_l',
			'j_cir_wolsk_l',
			'j_cir_demeorin_l',
			'j_cir_villainess',
			'j_cir_baka',
			'j_cir_captain',
			'j_cir_comfyVibes',
			'j_cir_enthusiast',
			'j_cir_challenger',
			'j_cir_somnolent',
			'j_cir_maiden',
			'j_cir_anon',
			'j_cir_enigma',
			'j_cir_catboy',
			'j_cir_softSpoken',
			'j_cir_qualityAssured',
			'j_cir_sadist'
		} })
	end
	
	for i, k in ipairs (jkrKeys_AddIfEncountered) do
		CirnoMod.miscItems.addJokerToTableIfEncountered(viable_unlockables, G.P_CENTERS[k], true)
	end
	
	-- Add playing cards
	viable_unlockables = SMODS.merge_lists({ viable_unlockables, {
		{ set = 'Playing', key = "C_A", rank = "Ace", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		{ set = 'Playing', key = "C_K", rank = "King", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		{ set = 'Playing', key = "C_Q", rank = "Queen", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		{ set = 'Playing', key = "C_J", rank = "Jack", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		
		{ set = 'Playing', key = "D_A", rank = "Ace", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_K", rank = "King", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", rank = "Queen", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", rank = "Queen", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", rank = "Queen", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		-- No problem here.
		{ set = 'Playing', key = "D_J", rank = "Jack", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		
		{ set = 'Playing', key = "H_A", rank = "Ace", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		{ set = 'Playing', key = "H_K", rank = "King", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		{ set = 'Playing', key = "H_Q", rank = "Queen", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		{ set = 'Playing', key = "H_J", rank = "Jack", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		
		{ set = 'Playing', key = "S_A", rank = "Ace", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" },
		{ set = 'Playing', key = "S_K", rank = "King", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" },
		{ set = 'Playing', key = "S_Q", rank = "Queen", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" },
		{ set = 'Playing', key = "S_J", rank = "Jack", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" }
	} })
	
	local cycleEvent
	cycleEvent = Event({
		trigger = 'after',
		timer = 'UPTIME',
		delay = 20,
		blockable = false,
		blocking = false,
		func = function()
			if
				not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU)
				or CirnoMod.startRunInterrupt
			then
				CirnoMod.miscItems.cyclerRunning = false
				return true
			end
			
			if
				holdUntilNew
				or texPack_ProbablyNotActive
			then
				cycleEvent.start_timer = false
				return false
			end
			
			-- Pick a random item from the pool and dissolve the initial title screen card.
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 4.04,
                func = (function()
					if
						not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU)
						or CirnoMod.startRunInterrupt
					then
						correctCenterSpriteScaling(titleCard, titleCard.config.center, true)
						return true
					end
					
					-- Clear previous pick, pick random
					decidedItem = nil
					local decidedElement = pseudorandom_element(viable_unlockables)
					
					if
						CirnoMod.miscItems.debugTables
						and CirnoMod.miscItems.debugTables.forceNextMenuKey
					then
						-- Debug
						decidedElement = G.P_CENTERS[CirnoMod.miscItems.debugTables.forceNextMenuKey]
						
						CirnoMod.miscItems.debugTables.forceNextMenuKey = nil
					else
						-- Enforce uniqueness
						for i = 1, 10 do
							if not CirnoMod.miscItems.indexedTableContainsItem(lastFive, decidedElement) then
								if decidedElement.set == 'Playing' then
									if G.SETTINGS.CUSTOM_DECK.Collabs[decidedElement.suit] == decidedElement.skin then
										texPack_ProbablyNotActive = false
										break
									end
								else
									if
										decidedElement.unlocked
									then
										if
											(decidedElement.atlas
											or (decidedElement.config
											and decidedElement.config.center
											and decidedElement.config.center.atlas))
											and CirnoMod.miscItems.atlasCheck(decidedElement)
										then
											texPack_ProbablyNotActive = false
											break
										else
											texPack_ProbablyNotActive = true
											if i >= 10 then
												return false
											end
										end
									else
										texPack_ProbablyNotActive = false
										break
									end
								end
							end
							
							decidedElement = pseudorandom_element(viable_unlockables)
						end
					end
					
					if decidedElement.set == 'Playing' then
						-- Set up table for playing card info
						decidedItem = { set = 'Base', rank = decidedElement.rank, suit = decidedElement.suit }
						
						if decidedElement.key == 'D_Q' then
							doRandomEdition = 'dm'
							materialiseColours = { G.C.GOLD, G.C.GREEN, G.C.GOLD, G.C.GREEN, G.C.GOLD }
						else
							doRandomEdition = 'nrm'
							materialiseColours = CirnoMod.miscItems.titleDissolveColours()
						end
					else
						-- Set up table for anything else
						decidedItem = { set = decidedElement.set, key = decidedElement.key }
						
						-- Specific materialise colours for specific things
						if
							decidedElement.unlocked
							and CirnoMod.miscItems.jokerInKeyGroup(decidedElement.key, 'allegations')
						then
							materialiseColours = { G.C.GREEN, G.C.BLACK, G.C.GREEN, G.C.BLACK, G.C.GREEN }
						else
							materialiseColours = nil
						end
						
						-- Decide edition rolling on known items
						if
							decidedElement.discovered
							and decidedElement.unlocked
						then
							if
								decidedElement.key == 'j_caino'
								or decidedElement.key == 'j_cir_villainess'
							then
								doRandomEdition = 'dm'
							else
								doRandomEdition = 'nrm'
							end
						else
							doRandomEdition = nil
						end
					end
					
					if decidedElement.key ~= 'D_Q' then -- No problem here, move along
						table.insert(lastFive, decidedElement.key)
					end
					
					-- Ensure last five picks only has 5 max items in it
					if #lastFive > 5 then
						table.remove(lastFive, 1)
					end
					
					--[[
					print(tprint(decidedItem))
					
					if texPack_ProbablyNotActive then
						print('txpkvar true')
					else
						print('txpkvar false')
					end
					]]
					
					-- If an item has been decided and isn't nil, 
					if
						decidedItem
						and not texPack_ProbablyNotActive
					then
						if
							decidedElement.set == 'Playing' 
							or (decidedElement.set == 'Joker'
							and decidedElement.unlocked
							and not CirnoMod.miscItems.hasEncounteredJoker(decidedElement.key))
						then
							decidedItem.no_ui = true
						else
							decidedItem.no_ui = false
						end
						
						if not CirnoMod.miscItems.cyclerRunning then
							CirnoMod.miscItems.cyclerRunning = true
						end
						
						titleCard:visualDissolve(CirnoMod.miscItems.titleDissolveColours())
						
						if titleCard.edition then
							titleCard:set_edition(nil, true, true)
						end
						
						return true
					end
					return false
            end)}))
			
			-- Materialise and emplace the new title screen card
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1.04,
                func = (function()
					correctCenterSpriteScaling(titleCard, titleCard.config.center, true)
					SMODS.clean_up_children(titleCard.children)
					
					if
						not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU)
						or CirnoMod.startRunInterrupt
					then
						return true
					end
					
					if
						texPack_ProbablyNotActive
						or not decidedItem
					then
						return false
					end
					
					-- local printMsg = 'Attempting to change to '
					
					if decidedItem.set == 'Base' then
						titleCard:set_ability('c_base', false, true)
						SMODS.change_base(titleCard, decidedItem.suit, decidedItem.rank)
						-- printMsg = printMsg..decidedItem.rank..' of '..decidedItem.suit
					else
						titleCard:set_ability(decidedItem.key, false, true)
						-- printMsg = printMsg..localize{ type = "name_text", set = decidedItem.set, key = decidedItem.key }
					end
					-- print(printMsg)
					
					titleCard.no_ui = decidedItem.no_ui
					
					correctCenterSpriteScaling(titleCard, titleCard.config.center)
					
					if not CirnoMod.miscItems.cyclerRunning then
						CirnoMod.miscItems.cyclerRunning = true
					end
					
					titleCard.states.visible = true
                    titleCard:start_materialize(materialiseColours)					
					
					if doRandomEdition == 'dm' and pseudorandom('dmEdition', 1, 2) < 2 then
						titleCard:set_edition(poll_edition('dmEdition', 1, false, true), true)
					elseif doRandomEdition == 'nrm' then
						titleCard:set_edition(poll_edition('titleCard_edition'), true)
					end
					
					holdUntilNew = false
                    return true
            end)}))
			
			-- Restart the event
			holdUntilNew = true
			cycleEvent.start_timer = false
			return false
		end })
	
	G.E_MANAGER:add_event(cycleEvent)
end

miscItems.flippyFlip = {
	fStart = function(card, pitchPercent, delay)
		local percent = pitchPercent and math.max(pitchPercent - 0.09, 0.3) or 1
		local flipDelay = delay or 0.1
		
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = flipDelay,
			blocking = true,
			blockable = true,
			func = function()
				card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true 
			end }))
		
		pitchPercent = percent
	end,
	
	fEnd = function(card, pitchPercent, delay)
		local percent = pitchPercent and math.max(pitchPercent - 0.09, 0.3) or 1
		local flipDelay = delay or 0.15
		
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = flipDelay,
			blocking = true,
			blockable = true,
			func = function()
				card:flip();play_sound('tarot2', percent, 0.6);card:juice_up(0.3, 0.3);return true
			end }))
		
		pitchPercent = percent
	end
}

miscItems.pullEditionModifierValue = function(edition)
	if edition and edition.type == 'foil' then
		return to_big(edition.chips)
	elseif edition and edition.type == 'holo' then
		return to_big(edition.mult)
	elseif edition and edition.type == 'polychrome' then
		return to_big(edition.x_mult)
	end
	return nil
end

miscItems.pullCardFHPEditionInfo = function(card)
	if card.edition and card.edition.type == 'foil' then
		return card.edition.chips..' Chips'
	elseif card.edition and card.edition.type == 'holo' then
		local ret = localize{ type = 'variable', key = 'a_mult', vars = { card.edition.mult } }
		return string.sub(ret, 2, #ret)
	elseif card.edition and card.edition.type == 'polychrome' then
		return localize{ type = 'variable', key = 'a_xmult', vars = { card.edition.x_mult } }
	end
	return nil
end

miscItems.cardEditionTypeToSfx = function(card)
	if card.edition and card.edition.type == 'foil' then
		if math.random() < 0.5 then
			return 'foil1'
		else
			return 'foil2'
		end
	elseif card.edition and card.edition.type == 'holo' then
		return 'holo1'
	elseif card.edition and card.edition.type == 'polychrome' then
		return 'polychrome1'
	end
	return nil
end

miscItems.cardEditionTypeToColour = function(card)
	if card.edition and card.edition.type == 'foil' then
		return G.C.CHIPS
	elseif
		card.edition
		and (card.edition.type == 'holo'
		or card.edition.type == 'polychrome')
	then
		return G.C.MULT
	end
	return nil
end

miscItems.getEditionScalingInfo = function(edition, scalar)	
	if scalar > 0 then
		if edition and edition.type == 'foil' then
			return { key = 'foilScale',
				set = 'Other',
				vars = { to_big(edition.chips), to_big(edition.chips) + to_big(50) * to_big(scalar) } }
		elseif edition and edition.type == 'holo' then
			return { key = 'holoScale',
				set = 'Other',
				vars = { to_big(edition.mult), to_big(edition.mult) + to_big(10) * to_big(scalar) } }
		elseif edition and edition.type == 'polychrome' then
			return { key = 'polyScale',
				set = 'Other',
				vars = { to_big(edition.x_mult), to_big(edition.x_mult) + to_big(0.5) * to_big(scalar) } }
		elseif edition and edition.type == 'example' then
			return { key = 'editionScaling',
				set = 'Other',
				vars = {
					to_big(scalar),
					to_big(edition.x_mult or 1.5),
					to_big(edition.x_mult or 1.5) + to_big(0.5) * to_big(scalar),
					to_big(edition.mult or 10),
					to_big(edition.mult or 10) + to_big(10) * to_big(scalar),
					to_big(edition.chips or 50),
					to_big(edition.chips or 50) + to_big(50) * to_big(scalar)
				} }
		end
	end
	
	return nil
end

miscItems.scaleEdition_FHP = function(card, scalar)
	local sTable = { val = scalar }
	local scaleTable = nil
	local localizeKey = nil
	
	if card.edition.type == 'foil' then
		scaleTable = {
				ref_table = card.edition,
				ref_value = 'chips',
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = to_big(initial) + (to_big(50) * to_big(scalar))
				end,
				scalar_table = sTable,
				scalar_value = 'val',
				no_message = true
			}
	elseif card.edition.type == 'holo' then
		scaleTable = {
				ref_table = card.edition,
				ref_value = 'mult',
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = to_big(initial) + (to_big(10) * to_big(scalar))
				end,
				scalar_table = sTable,
				scalar_value = 'val',
				no_message = true
			}
		
		localizeKey = 'a_mult'
	elseif card.edition.type == 'polychrome' then
		scaleTable = {
				ref_table = card.edition,
				ref_value = 'x_mult',
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = to_big(initial) + (to_big(0.5) * to_big(scalar))
				end,
				scalar_table = sTable,
				scalar_value = 'val',
				no_message = true
			}
		
		localizeKey = 'a_xmult'
	end
	
	if scaleTable then
		SMODS.scale_card(card, scaleTable)
		
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.editionScaling = {}
		
		if card.edition.type == 'foil' then
			card.ability.extra.editionScaling.chips = card.edition.chips
			return card.edition.chips..' Chips'
		end
		
		if localizeKey then
			if card.edition.type == 'holo' then
				local ret = localize{
					type = 'variable',
					key = localizeKey,
					vars = { card.edition[scaleTable.ref_value] } }
				
				card.ability.extra.editionScaling.mult = card.edition.mult
				
				return string.sub(ret, 2, #ret)
			else
				card.ability.extra.editionScaling.x_mult = card.edition.x_mult
				return localize{
					type = 'variable',
					key = localizeKey,
					vars = { card.edition[scaleTable.ref_value] } }
			end
		end
	end
	
end

miscItems.manuallyAnimateAtlasItem = function(UINodeConfigTable)
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		blocking = false,
		blockable = false,			
		func = function()
			if
				UINodeConfigTable
				and UINodeConfigTable.object
				and UINodeConfigTable.object.sprite_pos
				and UINodeConfigTable.object.atlas
				and UINodeConfigTable.thisObjFrameParse
			then
				if UINodeConfigTable.thisObjFrameParse.counter < UINodeConfigTable.thisObjFrameParse.delay then
					UINodeConfigTable.thisObjFrameParse.counter = UINodeConfigTable.thisObjFrameParse.counter + 0.1
				else
					if UINodeConfigTable.object.sprite_pos.x < (UINodeConfigTable.object.atlas.frames - 1) then
						UINodeConfigTable.object.sprite_pos.x = UINodeConfigTable.object.sprite_pos.x + 1
					else
						UINodeConfigTable.object.sprite_pos.x = 0
					end
					
					UINodeConfigTable.thisObjFrameParse.counter = 0
				end
				
				return false
			else
				return true
			end
		end
	}))
end

miscItems.doTypewriterAtlasAnimation = function(UINodeConfigTable)
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		blocking = false,
		blockable = false,			
		func = function()
			if
				UINodeConfigTable
				and UINodeConfigTable.object
				and UINodeConfigTable.object.sprite_pos
				and UINodeConfigTable.object.atlas
				and UINodeConfigTable.thisObjFrameParse
			then
				local XendPoint = UINodeConfigTable.thisObjFrameParse.rowLength
				
				if UINodeConfigTable.object.sprite_pos.y == UINodeConfigTable.thisObjFrameParse.finalRowY then
					XendPoint = UINodeConfigTable.thisObjFrameParse.finalRowFrames
				end
				
				if UINodeConfigTable.thisObjFrameParse.counter < UINodeConfigTable.thisObjFrameParse.delay then
					UINodeConfigTable.thisObjFrameParse.counter = UINodeConfigTable.thisObjFrameParse.counter + 0.1
				else
					if UINodeConfigTable.object.sprite_pos.x < XendPoint then
						UINodeConfigTable.object.sprite_pos.x = UINodeConfigTable.object.sprite_pos.x + 1
					else
						if UINodeConfigTable.object.sprite_pos.y == UINodeConfigTable.thisObjFrameParse.finalRowY then
							UINodeConfigTable.object.sprite_pos.y = 0
						else
							UINodeConfigTable.object.sprite_pos.y = UINodeConfigTable.object.sprite_pos.y + 1
						end
						
						UINodeConfigTable.object.sprite_pos.x = 0
					end
					
					UINodeConfigTable.thisObjFrameParse.counter = 0
				end
				
				return false
			else
				return true
			end
		end
	}))
end

miscItems.filterTable = function(sourceTable, destinationTable, filterTable)
	for i, F in ipairs (filterTable) do
		if sourceTable[F] then
			destinationTable[F] = sourceTable[F]
		end
	end
end
	
miscItems.newFilteredTable = function(inputTable, filterTable)
local RV = {}
	for i, F in ipairs (filterTable) do
		if inputTable[F] then
			RV[F] = inputTable[F]
		end
	end
return RV
end

miscItems.getAllDebuffedCardsInCardTable = function(cardTable)
	RV = {}
	
	for i, card in ipairs (cardTable) do
		if
			card.debuff
			and Card:can_calculate(true)
		then
			table.insert(RV, card)
		end
	end
	
	return RV
end

miscItems.isNegativePlayingCard = function(card)
	return (card
		and card.edition
		and card.edition.type == 'negative'
		and (card.ability.set == 'Default'
		or card.ability.set == 'Enhanced'))
end

miscItems.isState = function(curGameState, stateToCheck)
	if
		curGameState
		and stateToCheck
	then 
		return curGameState == stateToCheck
	end
	return false
end

miscItems.isAnyOfTheseStates = function(curGameState, statesToCheck)
	for i, state in ipairs(statesToCheck) do
		if CirnoMod.miscItems.isState(curGameState, state) then
			return true
		end
	end
	
	return false
end

miscItems.isStage = function(curGameStage, stageToCheck)
	if
		curGameStage
		and stageToCheck
	then 
		return curGameStage == stageToCheck
	end
	return false
end

miscItems.roundEvalDollarCalc = {
	part = function(CDBret, CDBret_opts, dollars_, pitch_, card_, i_)
		local ret = { i = i_ + 1, pitch = pitch_, dollars = dollars_ + CDBret }
		if not CDBret_opts.no_eval_row then
			add_round_eval_row{
				dollars = CDBret,
				bonus = true,
				name='joker'..ret.i,
				pitch = ret.pitch,
				card = card_,
				loc_opts = CDBret_opts
			}
			ret.pitch = ret.pitch + 0.06
		end
		dollars_ = dollars_ + CDBret
		return ret
	end,
	
	full = function(CDBret, CDBret_opts, dollars_, pitch_, card_, i_)
		local ret = CirnoMod.miscItems.roundEvalDollarCalc.part(CDBret, CDBret_opts, dollars_, pitch_, card_, i_)
		
		if
			card_.seal
			and card_.seal == 'Red'
		then
			SMODS.calculate_effect({ message = localize('k_again_ex'), colour = G.C.FILTER, card = card_ }, card_)
			
			ret = CirnoMod.miscItems.roundEvalDollarCalc.part(CDBret, CDBret_opts, ret.dollars, ret.pitch, card_, ret.i)
		end
		
		return ret
	end
}

miscItems.buildArrayFromKVPTable = function(kvpTable)
	local RV = {}
	
	for k, v in kvpTable do
		table.insert(RV, k)
	end
	
	if #RV == 0 then
		print("buildArrayFromKVPTable() created empty table from")
		print(tprint(kvpTable))
	end
	
	return RV
end

--[[ Thank you aikoooo T_T
Honestly dumb that I need to do this
in the first place for what I initially
want it for, but I guess it's a useful
tool we can keep around]]
for i = 97, 122 do
	table.insert(miscItems.alphabetNumberConv.numToAlphabet, string.char(i))
	miscItems.alphabetNumberConv.alphabetToNum[string.char(i)] = i - 96
end

--[[
TODO: Describe what these are and how they work.
I probably won't and this will stay like this
forever, which would be even funnier. Good luck.]]
miscItems.createABSwitchLatch = function(itemKey, chance, startOnAOrB)
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

miscItems.processSwitch = function(itemKey)
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

miscItems.getJokerNameByKey = function(jkrKey, default)
	local RV = default
	
	if
		jkrKey
		and G.localization.descriptions.Joker[jkrKey]
		and G.localization.descriptions.Joker[jkrKey].name
	then
		RV = localize{ type = "name_text", set = "Joker", key = jkrKey }
	end
	
	return RV
end

miscItems.getJokerRarityByKey = function(jkrKey)
	return G.P_CENTERS[jkrKey].config and G.P_CENTERS[jkrKey].config.center and G.P_CENTERS[jkrKey].config.center.rarity or G.P_CENTERS[jkrKey].rarity
end

miscItems.cir_buttonUI = function(card)
	return UIBox { definition = {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = { {
			n = G.UIT.C,
			config = {
				align = 'cm',
				padding = 0.15,
				r = 0.08,
				hover = true,
				shadow = true,
				colour = card.btn_clr or G.C.MULT,
				button = 'cir_btn_use',
				func = 'cir_btn_can_use',
				ref_table = card
			},
			nodes = { {
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.B,
						config = { w = 0.05, h = 0.7 }
					}, {
						n = G.UIT.C,
						config = { align = 'bm' },
						nodes = { {
							n = G.UIT.T,
							config = {
								align = 'bm',
								text = card.btn_txt or localize('b_use'),
								colour = G.C.UI.TEXT_LIGHT,
								scale = 0.5
							}
						} }
					}, {
						n = G.UIT.B,
						config = { w = 0.05, h = 0.7 }
					}
				}
			} }
		} }
	},
    config = {
      align = 'bm',
      major = card,
      parent = card,
      offset = { x = 0, y = -0.465 }
    } }
end

G.FUNCS.cir_btn_use = function(e)
	if
		e.config.ref_table.config.center.cir_btn_use
		and type(e.config.ref_table.config.center.cir_btn_use) == 'function'
	then
		e.config.ref_table.config.center:cir_btn_use(e.config.ref_table)
	end
end

G.FUNCS.cir_btn_can_use = function(e)
	local can_use = false
	
	if
		e.config.ref_table.config.center.cir_btn_use
		and type(e.config.ref_table.config.center.cir_btn_can_use) == 'function'
	then
		can_use = e.config.ref_table.config.center:cir_btn_can_use(e.config.ref_table)
	end
	
	e.config.button = can_use and 'cir_btn_use' or nil
	e.config.colour = can_use and (e.config.ref_table.config.center.cir_btn_clr or G.C.MULT) or G.C.UI.BACKGROUND_INACTIVE
end

miscItems.jkrKeyGroups.allegations = {}
miscItems.jkrKeyGroups.fingerGuns = {}
miscItems.jkrKeyGroups.TwoMax = {}
miscItems.jkrKeyGroups.unhinged = {}
miscItems.jkrKeyGroups.chatBrainrot = {}

if
	CirnoMod.config.malverkReplacements
then
	miscItems.jkrKeyGroups.allegations.j_bootstraps = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_bootstraps) end
	
	miscItems.jkrKeyGroups.allegations.j_riff_raff = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_riff_raff) end
	
	miscItems.jkrKeyGroups.allegations.j_trading = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_trading) end
	
	miscItems.jkrKeyGroups.allegations.j_superposition = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_superposition) end
	
	miscItems.jkrKeyGroups.TwoMax.j_duo = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_duo) end
	
	miscItems.jkrKeyGroups.TwoMax.j_sly = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_sly) end
	
	miscItems.jkrKeyGroups.fingerGuns.j_golden = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_golden) end
		
	miscItems.jkrKeyGroups.fingerGuns.j_ring_master = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_ring_master) end
		
	miscItems.jkrKeyGroups.fingerGuns.j_stuntman = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_stuntman) end
		
	miscItems.jkrKeyGroups.unhinged.j_chaos = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_chaos) end
	
	miscItems.jkrKeyGroups.unhinged.j_crazy = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_crazy) end
	
	miscItems.jkrKeyGroups.unhinged.j_drunkard = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_drunkard) end
	
	miscItems.jkrKeyGroups.unhinged.j_sock_and_buskin = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_sock_and_buskin) end
	
	miscItems.jkrKeyGroups.unhinged.j_mime = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_mime) end
	
	miscItems.jkrKeyGroups.unhinged.j_greedy_joker = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_greedy_joker) end
	
	miscItems.jkrKeyGroups.unhinged.j_lusty_joker = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_lusty_joker) end
	
	miscItems.jkrKeyGroups.unhinged.j_marble = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_marble) end
	
	miscItems.jkrKeyGroups.unhinged.j_delayed_grat = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_delayed_grat) end
	
	miscItems.jkrKeyGroups.unhinged.j_even_steven = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_even_steven) end
	
	miscItems.jkrKeyGroups.unhinged.j_odd_todd = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_odd_todd) end
	
	miscItems.jkrKeyGroups.unhinged.j_scholar = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_scholar) end
	
	miscItems.jkrKeyGroups.unhinged.j_supernova = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_supernova) end
	
	miscItems.jkrKeyGroups.unhinged.j_space = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_space) end
	
	miscItems.jkrKeyGroups.unhinged.j_swashbuckler = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_swashbuckler) end
	
	miscItems.jkrKeyGroups.unhinged.j_shoot_the_moon = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_shoot_the_moon) end
	
	miscItems.jkrKeyGroups.unhinged.j_astronomer = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_astronomer) end
	
	miscItems.jkrKeyGroups.unhinged.j_burnt = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_burnt) end
	
	miscItems.jkrKeyGroups.unhinged.j_caino = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_caino) end
	
	miscItems.jkrKeyGroups.unhinged.j_triboulet = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_triboulet) end
	
	miscItems.jkrKeyGroups.unhinged.j_yorick = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_yorick) end
	
	miscItems.jkrKeyGroups.unhinged.j_chicot = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_chicot) end
	
	miscItems.jkrKeyGroups.unhinged.j_constellation = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_constellation) end
	
	miscItems.jkrKeyGroups.unhinged.j_card_sharp = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_card_sharp) end
	
	miscItems.jkrKeyGroups.unhinged.j_vampire = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_vampire) end
	
	miscItems.jkrKeyGroups.unhinged.j_midas_mask = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_midas_mask) end
	
	miscItems.jkrKeyGroups.unhinged.j_gift = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_gift) end
	
	miscItems.jkrKeyGroups.unhinged.j_wily = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_wily) end
	
	miscItems.jkrKeyGroups.unhinged.j_devious = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_devious) end
	
	miscItems.jkrKeyGroups.unhinged.j_lucky_cat = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_lucky_cat) end
	
	miscItems.jkrKeyGroups.unhinged.j_flash = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_flash) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_merry_andy = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_merry_andy) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_drunkard = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_drunkard) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_acrobat = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_acrobat) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_sock_and_buskin = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_sock_and_buskin) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_credit_card = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_credit_card) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_marble = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_marble) end
		
	miscItems.jkrKeyGroups.chatBrainrot.j_abstract = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_abstract) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_delayed_grat = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_delayed_grat) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_mr_bones = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_mr_bones) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_seeing_double = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_seeing_double) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_family = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_family) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_four_fingers = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_four_fingers) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_gros_michel = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_gros_michel) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_hanging_chad = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_hanging_chad) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_invisible = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_invisible) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_arrowhead = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_arrowhead) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_onyx_agate = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_onyx_agate) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_certificate = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_certificate) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_egg = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_egg) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_ice_cream = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_ice_cream) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_dna = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_dna) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_splash = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_splash) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_sixth_sense = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_sixth_sense) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_hiker = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_hiker) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_todo_list = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_todo_list) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_madness = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_madness) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_riff_raff = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_riff_raff) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_shortcut = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_shortcut) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_baron = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_baron) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_midas_mask = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_midas_mask) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_luchador = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_luchador) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_photograph = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_photograph) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_gift = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_gift) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_turtle_bean = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_turtle_bean) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_erosion = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_erosion) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_lucky_cat = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_lucky_cat) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_bull = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_bull) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_popcorn = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_popcorn) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_trousers = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_trousers) end
	
	miscItems.jkrKeyGroups.chatBrainrot.j_ancient = function() return CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_ancient) end
end

if CirnoMod.config.addCustomJokers then
	miscItems.jkrKeyGroups.TwoMax.j_cir_naro_l = true
	
	miscItems.jkrKeyGroups.chatBrainrot.j_cir_moneyLaundry = true
	
	miscItems.jkrKeyGroups.unhinged.j_cir_crazyFace = true
	miscItems.jkrKeyGroups.unhinged.j_cir_confusedRumi = true
	miscItems.jkrKeyGroups.unhinged.j_cir_moneyLaundry = true
	
	miscItems.jkrKeyGroups.unhinged.j_cir_nope_l = true
	miscItems.jkrKeyGroups.unhinged.j_cir_arumia_l = true
	miscItems.jkrKeyGroups.unhinged.j_cir_wolsk_l = true
	miscItems.jkrKeyGroups.unhinged.j_cir_tom_l = true
	
	miscItems.jkrKeyGroups.unhinged.j_cir_villainess = true
	miscItems.jkrKeyGroups.unhinged.j_cir_captain = true
	miscItems.jkrKeyGroups.unhinged.j_cir_enthusiast = true
	miscItems.jkrKeyGroups.unhinged.j_cir_challenger = true
	miscItems.jkrKeyGroups.unhinged.j_cir_somnolent = true
	miscItems.jkrKeyGroups.unhinged.j_cir_catboy = true
	miscItems.jkrKeyGroups.unhinged.j_cir_qualityAssured = true
	miscItems.jkrKeyGroups.unhinged.j_cir_sadist = true
	
	miscItems.jkrKeyGroups.TwoMax.j_cir_smug = true
	miscItems.jkrKeyGroups.TwoMax.j_cir_comfyVibes = true
	
	miscItems.jkrKeyGroups.unhinged.j_cir_queenOfDiamonds = true
	miscItems.jkrKeyGroups.unhinged.j_cir_kingOfHearts = true
	miscItems.jkrKeyGroups.unhinged.j_cir_albedo = true
	miscItems.jkrKeyGroups.unhinged.j_cir_utsuho = true
	miscItems.jkrKeyGroups.unhinged.j_cir_obsessiveFace = true
	miscItems.jkrKeyGroups.unhinged.j_cir_charismaticMistress = true
	miscItems.jkrKeyGroups.unhinged.j_cir_smug = true
	miscItems.jkrKeyGroups.unhinged.j_cir_SPGP = true
	
	miscItems.jkrKeyGroups.fingerGuns.j_cir_platinum = true
end

miscItems.jkrKeyGroupTotalEncounters = function(groupName, stopAt1)
	local RV = 0
	
	if miscItems.jkrKeyGroups[groupName] then
		for k, v in pairs(miscItems.jkrKeyGroups[groupName]) do
			if
				CirnoMod.miscItems.get_cir_data('encountered')[k]
				and (type(v) ~= 'function'
				or v())
			then
				RV = RV + G.PROFILES[G.SETTINGS.profile].cir_data.encountered[k]
			end
		
			if stopAt1 and RV > 0 then
				break
			end
		end
	end
	
	return RV
end

miscItems.keyGroupsOfJokerKey = function(jkrKey)
	local RV = {}
	
	for k, t in pairs(CirnoMod.miscItems.jkrKeyGroups) do
		if
			t[jkrKey]
			and (type(t[jkrKey]) ~= 'function'
			or t[jkrKey]())
		then
			RV[#RV + 1] = k
		end
	end
	
	return RV
end

miscItems.jokerInKeyGroup = function(jkrKey, group)
	for i, v in ipairs(miscItems.keyGroupsOfJokerKey(jkrKey)) do
		if v == group then
			return true
		end
	end
	
	return false
end

miscItems.jokerInAnyOfTheseKeyGroups = function(jkrKey, groupsArray)
	for i, v in ipairs(miscItems.keyGroupsOfJokerKey(jkrKey)) do
		for _, grp in ipairs(groupsArray) do
			if v == grp then
				return true
			end
		end
	end
	
	return false
end

miscItems.encounterJoker = function(jkrKey, noSave)
	if
		CirnoMod.miscItems.get_cir_data('encountered', true)
	then
		if not G.PROFILES[G.SETTINGS.profile].cir_data.encountered[jkrKey] then
			G.PROFILES[G.SETTINGS.profile].cir_data.encountered[jkrKey] = 0
		end
		
		G.PROFILES[G.SETTINGS.profile].cir_data.encountered[jkrKey] = G.PROFILES[G.SETTINGS.profile].cir_data.encountered[jkrKey] + 1
		
		-- For bulk
		if not noSave then
			G:save_progress()
		end
		
		return true
	end
	
	return false
end

miscItems.hasEncounteredJoker = function(jkrKey)
	if
		CirnoMod.miscItems.get_cir_data('encountered')[jkrKey]
	then
		return G.PROFILES[G.SETTINGS.profile].cir_data.encountered[jkrKey] > 0
	end
	
	return false
end

miscItems.obscureJokerNameIfNotEncountered = function(jkrKey)
	if not G.P_CENTERS[jkrKey] then
		return '[INVALID KEY]'
	end
	
	if CirnoMod.miscItems.hasEncounteredJoker(jkrKey) then
		return CirnoMod.miscItems.getJokerNameByKey(jkrKey)
	else
		return localize('k_unknown')
	end
end

miscItems.obscureJokerTooltipIfNotEncountered = function(jkrKey, fake_card)
	if CirnoMod.miscItems.hasEncounteredJoker(jkrKey) then
		if G.P_CENTERS[jkrKey] then
			if fake_card then
				local ret = SMODS.shallow_copy(G.P_CENTERS[jkrKey])
				ret.fake_card = true
				return ret
			end
			
			return G.P_CENTERS[jkrKey]
		else
			return { key = 'errorTooltip', set = 'Other' }
		end
	else
		return { key = 'questionMarkTooltip', set = 'Other' }
	end
end

miscItems.obscureJokerNameIfLockedOrUndisc = function(jkrKey)
	if not G.P_CENTERS[jkrKey] then
		return '[INVALID KEY]'
	end
	
	if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS[jkrKey]) then
		return CirnoMod.miscItems.getJokerNameByKey(jkrKey)
	else
		return localize('k_unknown')
	end
end

miscItems.obscureStringIfJokerKeyLockedOrUndisc = function(string, jkrKey, fallback_string)
	if not G.P_CENTERS[jkrKey] then
		return fallback_string or '[INVALID KEY]'
	end
	
	if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS[jkrKey]) then
		return string
	else
		return localize('k_unknown')
	end
end

miscItems.obscureStringIfNoneInJokerKeyGroupEncountered = function(string, groupName)
	if CirnoMod.miscItems.jkrKeyGroupTotalEncounters(groupName, true) > 0 then
		return string
	else
		return localize('k_unknown')
	end
end

miscItems.atlasCheck = function(card)
	return CirnoMod.miscItems.mlvrk_tex_keys[card.atlas]
		or (card.config
		and card.config.center
		and CirnoMod.miscItems.mlvrk_tex_keys[card.config.center.atlas])
end

miscItems.isUsingAnyCustomAtlas = function(card)
	local atlasKey = nil
	
	if card.atlas then
		atlasKey = card.atlas
	elseif card.config and card.config.center then
		atlasKey = card.config.center.atlas
	end
	
	if atlasKey then
		return string.sub(atlasKey, 1, 8) == 'alt_tex_'
	end
	
	return false
end

miscItems.getKeyedTableLength = function(t)
	local ret = 0
	
	for k, v in pairs(t) do
		ret = ret + 1
	end
	
	return ret
end

miscItems.isUnlockedAndDisc = function(card)
	if card then
		return ((card.unlocked
			or card.config and card.config.center and card.config.center.unlocked)
			and (card.discovered
			or card.config and card.config.center and card.config.center.discovered))
			or card.bypass_discovery_center
			or card.bypass_discovery_ui
	end
	
	return false
end

miscItems.updateModAchievementDesc = function(achKey, newDescTable)
	SMODS.process_loc_text(
		G.localization.misc.achievement_descriptions,
		achKey,
		newDescTable)
end

-- Debug commands
--[[
miscItems.encounterAllDiscoveredJokersOnce = function()
	for k, v in pairs(G.P_CENTERS) do
		if
			v.set == 'Joker'
			and v.discovered
		then
			CirnoMod.miscItems.encounterJoker(k, true)
		end
	end
	
	G:save_progress()
	
	return G.PROFILES[G.SETTINGS.profile].cir_data.encountered
end

miscItems.SetJkrValVar = function(primVarName, secVarName, value, profNum)
	profNum = profNum or G.SETTINGS.profile
	
	G.PROFILES[profNum].cir_data[primVarName][secVarName] = value
	G:save_progress()
end

miscItems.undiscoverLock = function(card, doLock)
	card.config.center.discovered = false
	
	if doLock then
		card.config.center.unlocked = false
	end
	
	for i, tbl in ipairs(G.P_LOCKED) do
		if tbl.key == card.key then
			G.P_LOCKED[i] = nil
			break
		end
	end
	
	G:save_progress()
end

miscItems.findItemInJokerTable = function(tbl, jkrKey)
	for i, tbl in ipairs(tbl) do
		if tbl.key == jkrKey then
			print(i)
			return tbl
		end
	end
	
	print('Key "'..jkrKey..'" not found in given table.')
end
]]

miscItems.perfectionismUpgradable_Jokers = {
	j_crazy = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_baron = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_erosion = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_egg = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_four_fingers = function() local ret = { frc_incompatible = true }
		if CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_four_fingers) then
			ret.msg = ' im | || || |_ ible '
		end
	return ret
	end,
	
	j_marble = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_photograph = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_walkie_talkie = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_delayed_grat = function() local ret = { frc_incompatible = true }
			if CirnoMod.miscItems.atlasCheck(G.P_CENTERS.j_delayed_grat) then
				ret.msg = ' impossible '
				ret.clr = CirnoMod.miscItems.colours.cirLucy
			end
		return ret end,
	
	j_cir_solo = function() return { msg = ' lol, lmao ', frc_incompatible = true } end,
	
	j_cir_b3313 = function() return { msg = ' no ', frc_incompatible = true } end,
	
	j_cir_ollie = function() return { msg = ' impossible ', frc_incompatible = true } end,
	
	j_scary_face = 'j_cir_crazyFace',
	
	j_cir_cokeman = function() return { msg = ' seriously? ', frc_incompatible = true } end
}

local unimplementedUpg = function() return { msg = ' planned, but unimplemented :( ', clr = mix_colours(G.C.FILTER, G.C.JOKER_GREY, 0.8), frc_incompatible = true } end
local plannedUpg = {
	'j_madness', 'j_bootstraps', 'j_blackboard', 'j_sixth_sense', 'j_red_card', 'j_mail', 'j_hallucination', 'j_devious', 'j_baseball', 'j_bull', 'j_trouesrs', 'j_smiley'
}

for i, unim in ipairs(plannedUpg) do
	miscItems.perfectionismUpgradable_Jokers[unim] = unimplementedUpg
end

-- These are surprise tools that will help us later. :)
miscItems.funnyAtlases.cirGuns = SMODS.Atlas({
	key = 'cir_Guns',
	path = 'Misc/cirGuns.png',
	px = 71,
	py = 95
})

miscItems.funnyAtlases.japaneseGoblin = SMODS.Atlas({
	key = 'cir_jGoblin',
	path = 'Misc/japaneseGoblin.png',
	px = 64,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 52
})
-- miscItems.funnyAtlases.japaneseGoblin.manualFrameParsing = { delay = 0.2 }

miscItems.funnyAtlases.emotes = SMODS.Atlas({
	key = 'cir_Emotes',
	path = 'Misc/cir_Emotes.png',
	px = 66,
	py = 66
})

miscItems.funnyAtlases.rumiSleep = SMODS.Atlas({
	key = 'cir_rumiSleep',
	path = 'Misc/rumiSleep.png',
	px = 64,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 38
})
-- miscItems.funnyAtlases.rumiSleep.manualFrameParsing = { delay = 0.4 }

--[[ This one I have to do funky stuff with because
Balatro gets weird with big atlases. Can't do the
whole of Bad Apple in one line.]]
miscItems.funnyAtlases.badApple = SMODS.Atlas({
	key = 'cir_badApple',
	path = 'Misc/badApple.png',
	px = 80,
	py = 64
})
miscItems.funnyAtlases.badApple.typewriterFrameParsing = { delay = 0.3, rowLength = 99, finalRowY = 4, finalRowFrames = 77 }

miscItems.funnyAtlases.badAppleInv = SMODS.Atlas({
	key = 'cir_badApple_inv',
	path = 'Misc/badApple_inv.png',
	px = 80,
	py = 64
})
miscItems.funnyAtlases.badAppleInv.typewriterFrameParsing = { delay = 0.3, rowLength = 99, finalRowY = 4, finalRowFrames = 77 }

miscItems.funnyAtlases.hareHareYukai = SMODS.Atlas({
	key = 'cir_hareHareYukai',
	path = 'Misc/hareHareYukai.png',
	px = 128,
	py = 64,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 111
})

miscItems.funnyAtlases.canadaFlag = SMODS.Atlas({
	key = 'cir_Canada',
	path = 'Misc/canadaFlag.png',
	px = 40,
	py = 20
})

miscItems.funnyAtlases.didYouMeanGermany = SMODS.Atlas({
	key = 'cir_Many',
	path = 'Misc/didYouMeanGermany.png',
	px = 176,
	py = 36
})

miscItems.otherAtlases.miscSprites = SMODS.Atlas({
	key = 'cir_miscSprites',
	path = 'Misc/miscSprites.png',
	px = 71,
	py = 95
})

--[[ DrawStep to fix the discovered sprite appearing
on locked cards in the menu menu, Credit to SomethingCom515 for this]]
local oldcenterdrawstepfunc = SMODS.DrawSteps['center'].func
SMODS.DrawSteps['center'].func = function(self, layer)
    local thunk
    if self.config.center.unlocked == false then
        thunk = self.config.center.discovered
        self.config.center.discovered = true
    end
    local g = oldcenterdrawstepfunc(self, layer)
    if self.config.center.unlocked == false then
        self.config.center.discovered = thunk
    end
    return g
end

SMODS.DrawStep{
	key = 'cir_knifeStab',
	order = 52,
	func = function(card, layer)
		if
			card
			and card.stab
		then
			if not card.children.knifeSprite then
				card.children.knifeSprite = Sprite(
					0, 0, -- Sprite X & Y
					0, 0, -- Sprite W & H
					CirnoMod.miscItems.otherAtlases.miscSprites, -- Sprite Atlas
					{ x = 0, y = 0 })
			end
			
			card.children.knifeSprite.role.draw_major = card
			card.children.knifeSprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
		end
	end,
	conditions = { vortex = false, facing = 'front' }
}

SMODS.DrawStep{
	key = 'soulJuice',
	order = 9,
	func = function(card, layer)
		if
			card
			and card.children.floating_sprite
			and card.config.center.soul_juice
			and (not (card.area
			and card.area.config.type == 'title')
			or card.config.center.discovered
			or card.bypass_discovery_center
			or card.bypass_discovery_ui)
		then
			local scale_mod = 0.05 + 0.055*math.sin(1.8*G.TIMERS.REAL) + 0.1*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3.1
			local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
			
			card.children.floating_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
			card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
		end
	end,
	conditions = { vortex = false, facing = 'front' }
}

SMODS.DrawStep {
	key = 'cir_use_btn',
	order = -30, -- before the Card is drawn
	func = function(card, layer)
		if card.children.cir_btn_use then
			card.children.cir_btn_use:draw()
		end
	end
}

SMODS.draw_ignore_keys.cir_use_btn = true

return miscItems