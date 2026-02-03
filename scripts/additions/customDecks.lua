SMODS.ObjectType({
	key = 'cir_keepsake_o',
	default = 'j_cir_zayne',
	cards = {}
})

loccal SMODS_injectItems_ref = SMODS.injectItems
function SMODS.injectItems()
	SMODS_injectUtens_ref()
	for i, v in ipairs(G.P_CENTER_POOLS.Joker) do
		if
			v.config
			and v.config.extra
			and type(v.config.extra) == 'table'
			and v.rarity = 'cir_keepsake_r'
		then
			SMODS.ObjectTypes.cir_keepsake_o:inject_card(v)
		end
	end
end

