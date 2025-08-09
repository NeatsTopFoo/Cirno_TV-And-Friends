local jokerInfo = {
	isMultipleJokers = true,
	
	-- Defines the Atlas
	atlasInfo = {
		key = 'cir_cCommons',
		path = "Additional/cir_custCommons.png",
		px = 71,
		py = 95
	},
	
	jokerConfigs = {
		-- Lemon On A Pear
		{
			key = 'lemonOnAPear',
			matureRefLevel = 1,
			
			loc_txt = {
				name = 'Lemon On A Pear',
				text = {
					'{C:mult}+#1#{} Mult per played hand',
					'containing an {C:attention}unscored{} card',
					'{C:inactive}(Currently {C:mult}+#2#{C:inactive})',
					'{s:0.8,C:inactive}Was drawn in celebration of',
					'{s:0.8,C:inactive}reaching the halfway mark',
					'{s:0.8,C:inactive}of Joker reskins',
					'{s:0.6,C:inactive}Listen, it felt like a good idea',
					'{s:0.6,C:inactive}at the time'
				}
			},
			
			config = { extra = { mult = 0, growth = 1 } },
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF', set = 'Other' }
				end
				
				return { vars = { to_big(card.ability.extra.growth), to_big(card.ability.extra.mult) } }
			end,
			
			pos = { x = 0, y = 0},
			cost = 3,
			
			cir_upgradeInfo = function(self, card)
				return {
					'{C:mult}'..to_big(card.ability.extra.growth)..'{} Mult scaling',
					'->',
					'{C:mult}'..to_big(card.ability.extra.growth) * to_big(2)..'{} Mult scaling'
				}
			end,
			
			cir_upgrade = function(self, card)
				card.ability.extra.growth = to_big(card.ability.extra.growth) * to_big(2)
				
				return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
			end,
			
			calculate = function(self, card, context)
				if
					context.before
					and context.main_eval
					and #context.full_hand ~= #context.scoring_hand
				then
					card.ability.extra.mult = to_big(card.ability.extra.mult) + to_big(card.ability.extra.growth)
					
					return {
							extra = { 
								message = localize {
									type = 'variable',
									key = 'a_mult',
									vars = { to_big(card.ability.extra.mult) }
								},
								colour = G.C.MULT,
								message_card = card
							}
						}
				end
				
				if context.joker_main then
					return { mult = to_big(card.ability.extra.mult) }
				end
			end
		}, 
		-- Dabber
		{
			key = 'dabber',
			matureRefLevel = 1,
			
			loc_txt = {
				name = 'Dabber',
				text = {
					'If played hand is at',
					'least half {C:attention}face cards{},',
					'cards are returned',
					'to hand',
					'{s:0.8,C:inactive}This prerecorded',
					'{s:0.8,C:inactive}stream is bussin\'',
					'{s:0.8,C:inactive}Sheesh!'
				},
				unlock = {
					'While looking at this,',
					'{E:1,C:attention}Press Alt + F4'
				}
			},
			unlocked = false,
			
			blueprint_compat = true,
			loc_vars = function(self, info_queue, card)
				if CirnoMod.config['artCredits'] and not card.fake_card then
					info_queue[#info_queue + 1] = { key = 'jA_NTF', set = 'Other' }
				end
			end,
			
			pos = { x = 1, y = 0},
			cost = 5,
			
			update = function(self, card, dt)
				if
					not CirnoMod.config.jkrVals[G.SETTINGS.profile].store.dabber_altf4
					and (not CirnoMod.dabber
					or CirnoMod.dabber and
					CirnoMod.dabber.REMOVED)
				then
					CirnoMod.dabber = card
				end
			end,
			
			check_for_unlock = function(self, args)
				return CirnoMod.config.jkrVals[G.SETTINGS.profile].store.dabber_altf4
			end,
			
			shouldReturnToHand = function(self, card)
				local halfHandCount = math.floor(#G.play.cards / 2)
				local faceCount = 0
				
				for i, c in ipairs(G.play.cards) do
					if c:is_face() then
						faceCount = faceCount + 1
						
						if faceCount >= halfHandCount then
							return true
						end
					end
				end
				
				return false
			end,
			
			returnToHand_func = function(self, card, isLastIteration, old_dfptd)
				local ret = {}
				
				for i = 1, #G.play.cards do
					if
						not G.play.cards[i].beingRedrawn
						and not G.play.cards[i].shattered
						and not G.play.cards[i].destroyed
					then
						G.play.cards[i].beingRedrawn = true
						table.insert(ret, G.play.cards[i])
						draw_card(G.play, G.hand or G.discard, i*100/#G.play.cards, 'down', false, G.play.cards[i], 0.1, false, false)
					end
				end
				
				return ret
			end,
			
			calculate = function(self, card, context)				
			end
		}
	}
}

--[[ Define things that are constant with every Joker in
this file once in a loop, rather than repeatedly per
table element ]]
for i, jkr in ipairs(jokerInfo.jokerConfigs) do
	jkr.object_type = 'Joker'
	jkr.atlas = 'cir_cCommons'
	jkr.ladOrder = 'cmn'
	jkr.rarity = 1
end

return jokerInfo