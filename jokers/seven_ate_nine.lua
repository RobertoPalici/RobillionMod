SMODS.Joker{
    key = 'seven_ate_nine',
    loc_txt = {
        name = 'Seven Ate Nine',
        text = {
            'Played {C:attention}7s{}',
            'each give {X:mult,C:white} X#2# {} Mult',
            'for every {C:attention}9{} destroyed',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
    },
    rarity = 2,
    cost = 8,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 0 },
    config = {
        extra = 1,
        x_mult_mod = 0.1
        
    },
    loc_vars = function(card, info_queue, center)
        return {vars = {center.ability.extra, center.ability.x_mult_mod}}
    end,
    calculate = function(self,card,context)
        if context.card_destroyed and not context.blueprint then
            local count = 0
            for k, v in ipairs(context.glass_shattered) do
                if v:get_id() == 9 then
                    count = count + 1
                end
            end
            if count > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- Update the Joker's ability
                        card.ability.extra = card.ability.extra + count * card.ability.x_mult_mod
                        -- Display a status message
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize {
                                type = 'variable',
                                key = 'a_xmult',
                                vars = { card.ability.extra }
                            }
                        })
                        return true
                    end
                }))
            end
            return
        end

        if context.remove_playing_cards and not context.blueprint then
            local count = 0
            for k, v in ipairs(context.removed) do
                if v:get_id() == 9 then
                    count = count + 1
                end
            end
    
            if count > 0 then
                card.ability.extra = card.ability.extra + count * card.ability.x_mult_mod
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize {
                                type = 'variable',
                                key = 'a_xmult',
                                vars = { card.ability.extra }
                            }
                        })
                        return true
                    end
                }))
            end
            return
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 and card.ability.extra > 1 then
                return{
                    x_mult = card.ability.extra,
                    color = G.C.RED
                }
            end
        end
    end
}