local miscItems = {
	artCreditKeys = {},
	creditLinks = {
		daemonTsun = { type = 'BSky', link = 'https://bsky.app/profile/daemontsun.bsky.social' },
		ntf_bsky = { type = 'BSky', link = 'https://bsky.app/profile/nopetoofast.bsky.expert' },
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
	allFaceCards = { 'Jack', 'Queen', 'King' },
	cardSuits = { 'Hearts', 'Clubs', 'Diamonds', 'Spades' },
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
	cirFriends = {
		dm = 'Girl_DM_', -- Pay no attention as to how this list is ordered. There is no specific reasoning behind it.
		cir = 'Cirno_TV',
		han = 'HannahHyrule',
		mom = 'ReimMomo',
		rmi = 'ArumiaTheSleepy',
		tom = 'UnsanityLIVE',
		nrp = 'Naro',
		thr = 'ThorW',
		hou = 'Houdini111',
		wls = 'Wolsk',
		dme = 'Demeorin',
		dck = 'Biggdeck',
		ntf = 'NopeTooFast'
	},
	weirdArtCreditExceptionalCircumstanceKeys = {}, -- Some things seem to do weird things, like Wild cards.
	descExtensionTooltips = {},
	alphabetNumberConv = {
		numToAlphabet = {},
		alphabetToNum = {}
	},
	deckSkinNames = {}, -- How the custom deck skins are referred to internally. Used for art credit tooltips.
	deckSkinWhich = {}, -- Differentiate between different deck skins we might want to add, in case we have different crediting to do per skin.
	keysOfAllCirnoModItems = {}, -- This will be used for any effects the focus on stuff edited or introduced by this mod
	jkrLoadOrder = {},
	jkrKeyGroups = {},
	jkrKeyGroupArrays = {},
	mlvrk_tex_keys = {},
	funnyAtlases = {},
	otherAtlases = {},
	returnToHand_Jokers = {
		'j_cir_dabber',
		'j_cir_somnolent',
		'j_cir_enthusiast',
		'j_cir_b3313'
	},
	switchKeys = {},
	switchTables = {},
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
	end
}

miscItems.cirGunsSpriteX = 0

miscItems.upgradedExtraValue = {
	2,
	5,
	10,
	15
}

miscItems.keysOfJokersToUpdateStateOnLoad = {
	j_cir_crystalTap = true,
	j_cir_b3313 = true,
	j_cir_confusedRumi = true,
	
	j_cir_naro_l = true,
	j_cir_arumia_l = true,
	j_cir_wolsk_l = true,
	
	j_cir_comfyVibes = true,
	j_cir_somnolent = true,
	j_cir_qualityAssured = true
}

miscItems.otherModPresences = {
	isSealsOnJokersPresent = false,
	isTalismanPresent = false
}
	
miscItems.matureReferencesOpt = { "(Hopefully) Safest", "Some", "All" } -- These are the options that appear on the new cycle option for mature references.

-- Table containing keys of jokers and what contexts should be ignored for red seal retriggers
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
	j_splash = { { miscItems.cirFriends.cir } },
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
	cirLucy = HEX('7BB083FF'),
	cirNep = HEX('D066ADFF'),
	cirUpgradedJkrClr = HEX('CCB35AFF'),
	dmDark = HEX('395A2FFF'),
	hanDark = HEX('312842FF'),
	momoCyan = HEX('068170FF'),
	houAqua = HEX('62D9D9FF'),
	bbBlack = HEX('000000FF'),
	bbInvisText = HEX('00000000')
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

miscItems.colours.cirDM = SMODS.Gradient({
	key = 'cirDM',
	colours = {
		G.C.GREEN,
		miscItems.colours.dmDark
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
	})
}

miscItems.badges = {
	allegations = function(bootstrapsName) return create_badge(bootstrapsName or 'You Forgot To Pass The Name In', G.C.GREEN, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	TwoMax = function() return create_badge("2 Max", miscItems.colours.cirNep, G.C.UI.TEXT_LIGHT, 0.8) end,
	fingerGuns = function() return create_badge("cirGuns", miscItems.colours.cirCyan, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	unhinged = function() return create_badge("Unhinged", G.C.RED, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	chatBrainrot = function() return create_badge("Chat Brainrot", miscItems.colours.cirBlue, G.C.UI.TEXT_LIGHT, 0.8 ) end,
	upgradedJkr = {
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Upgraded' }, { string = 'Common' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[1], nil, 1.3)
		end,
		
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Upgraded' }, { string = 'Uncommon' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[2], nil, 1.3)
		end,
		
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Upgraded' }, { string = 'Rare' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[3], nil, 1.3)
		end,
		
		function()
			return CirnoMod.miscItems.createDynaTextBadge({ { string = 'Upgraded' }, { string = 'Legendary' } }, CirnoMod.miscItems.colours.cirUpgradedJkrClr_tbl[4], nil, 1.3)
		end,
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

miscItems.addJokerToTableIfDiscovered = function(t, joker)
	if joker and joker.discovered then
		table.insert(t, joker)
	end
end

miscItems.addJokerToTableIfEncountered = function(t, joker)
	if joker and CirnoMod.miscItems.hasEncounteredJoker(joker.key) then
		table.insert(t, joker)
	end
end

miscItems.doTitleCardCycle = function(viable_unlockables, cardIn, SC_scale)	
	if #viable_unlockables == 0 then
		for k, v in ipairs(G.P_CENTERS) do
			if
				(v.set == 'Voucher'
				or v.set == 'Tarot'
				or v.set == 'Planet'
				or v.set == 'Spectral'
				or v.set == 'Enhanced'
				or v.set == 'Joker')
				and v.discovered
				and not v.demo
			then
				viable_unlockables[#viable_unlockables+1] = v
			end
		end
	else
		CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS.j_blueprint)
		
		CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS.j_egg)
		
		if CirnoMod.miscItems.jkrKeyGroups.fingerGuns then
			for k, b in pairs (CirnoMod.miscItems.jkrKeyGroups.fingerGuns) do
				if
					k == 'j_ring_master'
					or CirnoMod.miscItems.hasEncounteredJoker(k)
				then
					CirnoMod.miscItems.addJokerToTableIfDiscovered(viable_unlockables, G.P_CENTERS[k])
				end
			end
		end
		
		if CirnoMod.miscItems.jkrKeyGroups.allegations then
			for k, b in pairs (CirnoMod.miscItems.jkrKeyGroups.allegations) do
				CirnoMod.miscItems.addJokerToTableIfEncountered(viable_unlockables, G.P_CENTERS[k])
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
				table.insert(viable_unlockables, G.P_CENTERS.j_cir_crazyFace)
			end
			
			if G.P_CENTERS.j_cir_dabber.unlocked then
				table.insert(viable_unlockables, G.P_CENTERS.j_cir_dabber)
			end
			
			jkrKeys_AddIfEncountered = SMODS.merge_lists({ jkrKeys_AddIfEncountered, {
				'j_cir_cirno_l',
				'j_cir_nope_l',
				'j_cir_naro_l',
				'j_cir_arumia_l',
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
				'j_cir_anon',
				'j_cir_enigma',
				'j_cir_catboy',
				'j_cir_softSpoken',
				'j_cir_qualityAssured',
				'j_cir_sadist'
			} })
		end
		
		for i, k in ipairs (jkrKeys_AddIfEncountered) do
			CirnoMod.miscItems.addJokerToTableIfEncountered(viable_unlockables, G.P_CENTERS[k])
		end
	end
	
	viable_unlockables = SMODS.merge_lists({ viable_unlockables, {
		{ set = 'Playing', key = "C_K", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		{ set = 'Playing', key = "C_Q", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		{ set = 'Playing', key = "C_J", suit = 'Clubs', skin = "cir_noAndFriends_Clubs_skin_hc" },
		
		{ set = 'Playing', key = "D_K", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		{ set = 'Playing', key = "D_Q", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		-- No problem here.
		{ set = 'Playing', key = "D_J", suit = 'Diamonds', skin = "cir_noAndFriends_Diamonds_skin_hc" },
		
		{ set = 'Playing', key = "H_K", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		{ set = 'Playing', key = "H_Q", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		{ set = 'Playing', key = "H_J", suit = 'Hearts', skin = "cir_noAndFriends_Hearts_skin_hc" },
		
		{ set = 'Playing', key = "S_K", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" },
		{ set = 'Playing', key = "S_Q", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" },
		{ set = 'Playing', key = "S_J", suit = 'Spades', skin = "cir_noAndFriends_Spades_skin_hc" }
	} })
	
	local holdUntilNew = false
	local texPack_ProbablyNotActive = false
	local lastFive = {}
	local existingCard = cardIn or CirnoMod.titleCard
	local newCard
	local doRandomEdition = false
	local materialiseColours = nil
	
	local isInLastFive = function(decidedElement)
			if #lastFive > 0 then
				for i = 1, #lastFive do
					if lastFive[i] == decidedElement.key then
						return true
					end
				end
			end
			
			return false
		end
	
	local cycleEvent
	cycleEvent = Event({
		trigger = 'after',
		timer = 'UPTIME',
		delay = 20,
		blockable = false,
		blocking = false,
		func = function()
			if not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU) then
				return true
			end
			
			if holdUntilNew or texPack_ProbablyNotActive then
				cycleEvent.start_timer = false
				return false
			end
			
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 4.04,
                func = (function()
					if not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU) then
						return true
					end
					
					local decidedElement = pseudorandom_element(viable_unlockables)
					
					for i = 1, 5 do						
						if not isInLastFive(decidedElement) then
							if decidedElement.set == 'Playing' then
								if G.SETTINGS.CUSTOM_DECK.Collabs[decidedElement.suit] == decidedElement.skin then
									texPack_ProbablyNotActive = false
									break
								end
							else
								if
									decidedElement.set == 'Joker'
									and decidedElement.unlocked
									and (decidedElement.atlas
									or (decidedElement.config
									and decidedElement.config.center
									and decidedElement.config.center.atlas))
								then
									if CirnoMod.miscItems.atlasCheck(decidedElement) then
										texPack_ProbablyNotActive = false
										break
									else
										texPack_ProbablyNotActive = true
										if i >= 5 then
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
					
					if decidedElement.set == 'Playing' then
						newCard = Card(CirnoMod.titleTop.T.x, CirnoMod.titleTop.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS[decidedElement.key], G.P_CENTERS.c_base)
						
						if decidedElement.key == 'D_Q' then
							doRandomEdition = 'dm'
							materialiseColours = { G.C.GOLD, G.C.GREEN, G.C.GOLD, G.C.GREEN, G.C.GOLD }
						else
							doRandomEdition = 'nrm'
							materialiseColours = CirnoMod.miscItems.titleDissolveColours()
						end
					else
						newCard = Card(CirnoMod.titleTop.T.x, CirnoMod.titleTop.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, nil, decidedElement or self.P_CENTERS.j_blueprint)
						
						if
							decidedElement.unlocked
							and CirnoMod.miscItems.keyGroupOfJokerKey(decidedElement.key) == 'allegations'
						then
							materialiseColours = { G.C.GREEN, G.C.BLACK, G.C.GREEN, G.C.BLACK, G.C.GREEN }
						else
							materialiseColours = nil
						end
						
						if
							decidedElement.key == 'j_caino'
							or decidedElement.key == 'j_cir_villainess'
						then
							doRandomEdition = 'dm'
						elseif decidedElement.discovered then
							doRandomEdition = 'nrm'
						else
							doRandomEdition = nil
						end
					end
					
					if decidedElement.key ~= 'D_Q' then -- No problem here, move along
						table.insert(lastFive, decidedElement.key)
					end
					
					if #lastFive > 5 then
						table.remove(lastFive, 1)
					end
					
					if decidedElement.set == 'Playing' then
						newCard.no_ui = true
					elseif not decidedElement.unlocked then
						newCard.no_ui = false
					else
						newCard.no_ui = #viable_unlockables > 0
						and not CirnoMod.miscItems.hasEncounteredJoker(decidedElement.key)
					end
                    
                    newCard.states.visible = false
                    existingCard.parent = nil
                    existingCard:start_dissolve(CirnoMod.miscItems.titleDissolveColours())
					
					if existingCard.edition then
						existingCard:set_edition(nil, true, true)
					end
					
                    return true
            end)}))
			
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1.04,
                func = (function()
					if not CirnoMod.miscItems.isStage(G.STAGE, G.STAGES.MAIN_MENU) then
						return true
					end
					
					if texPack_ProbablyNotActive then
						return false
					end
					
                    newCard:start_materialize(materialiseColours)
                    CirnoMod.titleTop:emplace(newCard)
					existingCard = newCard
					newCard = nil
					
					if doRandomEdition == 'dm' and pseudorandom('dmEdition', 1, 2) < 2 then
						existingCard:set_edition(poll_edition('dmEdition', 1, false, true), true)
					elseif doRandomEdition == 'nrm' then
						existingCard:set_edition(poll_edition('titleCard_edition'), true)
					end
					
					holdUntilNew = false
                    return true
            end)}))
			
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
	if card.edition.type == 'foil' then
		card.edition.chips = to_big(card.edition.chips) + to_big(50) * to_big(scalar)
		return card.edition.chips..' Chips'
	elseif card.edition.type == 'holo' then
		card.edition.mult = to_big(card.edition.mult) + to_big(10) * to_big(scalar)
		local ret = localize{ type = 'variable', key = 'a_mult', vars = { card.edition.mult } }
		return string.sub(ret, 2, #ret)
	elseif card.edition.type == 'polychrome' then
		card.edition.x_mult = to_big(card.edition.x_mult) + to_big(0.5) * to_big(scalar)
		return localize{ type = 'variable', key = 'a_xmult', vars = { card.edition.x_mult } }
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
	part = function(CDBret, dollars_, pitch_, card_, i_)
		local RV = { i = i_ + 1, pitch = pitch_, dollars = dollars_ + CDBret }
		add_round_eval_row({dollars = CDBret, bonus = true, name='joker'..RV.i, pitch = RV.pitch, card = card_})
		RV.pitch = RV.pitch + 0.06
		dollars_ = dollars_ + CDBret
		return RV
	end,
	
	full = function(CDBret, dollars_, pitch_, card_, i_)
		local RV = CirnoMod.miscItems.roundEvalDollarCalc.part(CDBret, dollars_, pitch_, card_, i_)
		
		if
			card_.seal
			and card_.seal == 'Red'
		then
			SMODS.calculate_effect({ message = localize('k_again_ex'), colour = G.C.FILTER, card = card_ }, card_)
			
			RV = CirnoMod.miscItems.roundEvalDollarCalc.part(CDBret, RV.dollars, RV.pitch, card_, RV.i)
		end
		
		return RV
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
	
	miscItems.jkrKeyGroups.unhinged.j_cir_crazyFace = true
	miscItems.jkrKeyGroups.unhinged.j_cir_confusedRumi = true
	
	miscItems.jkrKeyGroups.unhinged.j_cir_nope_l = true
	miscItems.jkrKeyGroups.unhinged.j_cir_arumia_l = true
	miscItems.jkrKeyGroups.unhinged.j_cir_wolsk_l = true
	miscItems.jkrKeyGroups.unhinged.j_cir_tom_l = true
	
	miscItems.jkrKeyGroups.TwoMax.j_cir_comfyVibes = true
	
	miscItems.jkrKeyGroups.unhinged.j_cir_villainess = true
	miscItems.jkrKeyGroups.unhinged.j_cir_captain = true
	miscItems.jkrKeyGroups.unhinged.j_cir_enthusiast = true
	miscItems.jkrKeyGroups.unhinged.j_cir_challenger = true
	miscItems.jkrKeyGroups.unhinged.j_cir_somnolent = true
	miscItems.jkrKeyGroups.unhinged.j_cir_catboy = true
	miscItems.jkrKeyGroups.unhinged.j_cir_qualityAssured = true
	miscItems.jkrKeyGroups.unhinged.j_cir_sadist = true
	
	miscItems.jkrKeyGroups.unhinged.j_cir_queenOfDiamonds = true
	miscItems.jkrKeyGroups.unhinged.j_cir_kingOfHearts = true
	miscItems.jkrKeyGroups.unhinged.j_cir_SPGP = true
	
	miscItems.jkrKeyGroups.fingerGuns.j_cir_platinum = true
end

miscItems.jkrKeyGroupTotalEncounters = function(groupName, stopAt1)
	local RV = 0
	
	if miscItems.jkrKeyGroups[groupName] then
		for i, k in ipairs(miscItems.jkrKeyGroups[groupName]) do
			if
				CirnoMod.config.jkrVals[G.SETTINGS.profile]
				and CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[k]
				and (type(k) ~= 'function'
				or k())
			then
				RV = RV + CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[k]
			end
		
			if stopAt1 and RV > 0 then
				break
			end
		end
	end
	
	return RV
end

miscItems.keyGroupOfJokerKey = function(jkrKey)
	for k, t in pairs(CirnoMod.miscItems.jkrKeyGroups) do
		if
			t[jkrKey]
			and (type(t[jkrKey]) ~= 'function'
			or t[jkrKey]())
		then
			return k
		end
	end
	
	return nil
end

miscItems.encounterJoker = function(jkrKey)
	if
		CirnoMod.config.jkrVals[G.SETTINGS.profile]
		and CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered
	then
		if not CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[jkrKey] then
			CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[jkrKey] = 0
		end
		
		CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[jkrKey] = CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[jkrKey] + 1
		return true
	end
	
	return false
end

miscItems.hasEncounteredJoker = function(jkrKey)
	if
		CirnoMod.config.jkrVals[G.SETTINGS.profile]
		and CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered
		and CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[jkrKey]
	then
		return CirnoMod.config.jkrVals[G.SETTINGS.profile].encountered[jkrKey] > 0
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
		return '?????'
	end
end

miscItems.obscureJokerTooltipIfNotEncountered = function(jkrKey, fake_card)
	if CirnoMod.miscItems.hasEncounteredJoker(jkrKey) then
		if G.P_CENTERS[jkrKey] then
			if fake_card then
				local ret = copy_table(G.P_CENTERS[jkrKey])
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
		return '?????'
	end
end

miscItems.obscureStringIfJokerKeyLockedOrUndisc = function(string, jkrKey)
	if not G.P_CENTERS[jkrKey] then
		return '[INVALID KEY]'
	end
	
	if CirnoMod.miscItems.isUnlockedAndDisc(G.P_CENTERS[jkrKey]) then
		return string
	else
		return '?????'
	end
end

miscItems.obscureStringIfNoneInJokerKeyGroupEncountered = function(string, groupName)
	if CirnoMod.miscItems.jkrKeyGroupTotalEncounters(groupName, true) > 0 then
		return string
	else
		return '?????'
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
	
	j_scary_face = 'j_cir_crazyFace'
}

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

return miscItems