SMODS.Joker{
    key = 'massive_joker',
    loc_txt = {
        name = 'Massive Joker',
        text = {
            'This Joker gains',
            '{C:mult}+#2#{} Mult when each',
            'played {C:attention}Ace{} is scored',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
        }
    },
    rarity = 3,
    cost = 8,
    discovered = true,
    atlas = 'Jokers',
    blueprint_compat = true,
    pos = {x = 2, y = 0 },
    loc_vars = function(self, info_queue, center)
        return {vars = { center.ability.extra.mult,
                         center.ability.extra.mult_mod
                        }
                }
    end,
    config = {
        extra = {
            mult = 0,
            mult_mod = 2
        }
    },
    calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == G.play then
                if context.other_card:get_id() == 14 and not context.blueprint then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    return{
                        message = localize('k_upgrade_ex'),
                        colour = G.C.RED
                    }
                end
            end
        elseif context.joker_main then
            if card.ability.extra.mult > 0 then
                return{
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.RED
                }
            end
        end
    end
}