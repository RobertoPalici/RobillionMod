SMODS.Joker{
    key = "medusa",
    loc_txt = {
        name = "Medusa",
        text = {
            "All played {C:attention}face{} cards",
            "become {C:attention}Stone{} cards",
            "when scored",
        }
    },
    rarity = 2,
    cost = 5,
    config = {},
    atlas = "Jokers",
    pos = {x = 1, y = 1},
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local faces = {}
                for k, v in ipairs(context.scoring_hand) do
                    if v:is_face() then 
                        faces[#faces+1] = v
                        v:set_ability(G.P_CENTERS.m_stone, nil, true)
                        G.E_MANAGER:add_event(Event({
                                func = function()
                                v:juice_up()
                                return true
                            end
                        })) 
                    end
                end
                if #faces > 0 then 
                    return {
                        message = "Stone!",
                        colour = G.C.BLUE,
                    }
                end
        end
    end
}