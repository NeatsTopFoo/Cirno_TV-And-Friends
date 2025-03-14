-- Oh boy, do I sure love working with the bullshit UI in this.
local extraUI = function()
	return {
		{
			label = 'Credits',
			tab_definition_function = function()
			return {
						n = G.UIT.ROOT,
						config = {
							r = 0.1,
							padding = 0.0,
							-- h = 6,
							-- maxw = G.ROOM.T.w,
							align = 'tm',
							colour = G.C.CLEAR
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
										text = "Todo (Heck doing UI stuff in this)",
										maxw = G.ROOM.T.w*0.9,
										scale = 0.5,
										colour = G.C.TEXT_LIGHT,
										align = 'tm'
									}
							}
						}
				}
			end
		}
	}
end

return extraUI