--- STEAMODDED HEADER
--- MOD_NAME: ExampleJoker
--- MOD_ID: EXAMPLEJOKER
--- MOD_AUTHOR: Robillion
--- MOD_DESCRIPTION: Exemplu
--- PREFIX: xmpl

SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'xmpl_seven_ate_nine_joker',
    loc_txt = {
        name = 'Seven Ate Nine',
        text = {
            'Retrigger',
            'each played', 
            '{C:attention}7{}, {C:attention}8{}, {C:attention}9{}'
        }
    },
    atlas = 'Jokers',
    pos = {x = 0, y = 0 },
    config = {
        extra = 1
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra + 1}}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and
          (context.other_card:get_id() == 7 or
           context.other_card:get_id() == 8 or
           context.other_card:get_id() == 9) then
            return{
                message = localize('k_again_ex'),
                repetitions = card.ability.extra, 
            }
        end
    end
}

SMODS.Joker{
    key = 'xmpl_blackjack_joker',
    loc_txt = {
        name = 'Blackjack',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'if the sum of values',
            'of scoring hand',
            'is less or equal to C:{attention}21{}'
        }
    },
    atlas = 'Jokers',
    pos = {x = 1, y = 0 },
    config = {
        extra = {
            Xmult = 2
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local sum = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    sum = sum + 10
                elseif context.scoring_hand[i]:get_id() == 14 then
                    sum = sum + 1
                else
                    sum = sum + context.scoring_hand[i]:get_id()
                end
            end
            if sum <= 21 then
                return{
                    message = 'X'.. card.ability.extra.Xmult,
                    Xmult_mod = card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'rob_massive_joker',
    loc_txt = {
        name = 'Massive Joker',
        text = {
            'This Joker gains',
            '{C:mult}+#2#{} Mult when each',
            'played {C:attention}Ace{} is scored',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
            }
    },
    atlas = 'Jokers',
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