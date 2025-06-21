SMODS.Joker{
    key = 'kings_jester',
    loc_txt = {
        name = 'King\'s Jester',
        text = {
            'Kings held in hand retrigger',
            'their effects {C:attention}two{} additional times',
            'and score {X:mult,C:white}X#2#{} Mult for every',
            'King held in hand'
        }
    },
    rarity = 'rob_epic',
    cost = 10,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 2, y = 1 },
    config = {
        extra = {
            retrigger = 2,
            xmult = 0.25,
        },
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.retrigger + 1,
                center.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and not context.end_of_round then 
            if context.cardarea == G.hand then
                if context.other_card:get_id() == 13 then
                   if context.other_card.debuff then
                        return{
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                        }
                    else
                        local count = 0
                        for k, v in ipairs(G.hand.cards) do
                            if v:get_id() == 13 then
                                count = count + 1
                            end
                        end
                        return{
                            x_mult = card.ability.extra.xmult * count,
                            colour = G.C.MULT,
                        }
                    end

                end
            end
        end
        if context.repetition then
            if context.cardarea == G.hand then
                if context.other_card:get_id() == 13 and (next(context.card_effects[1]) or #context.card_effects > 1) then
                    if context.other_card.debuff then
                        return{
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                        }
                    else
                        return{
                            message = localize("k_again_ex"),
                            repetitions = card.ability.extra.retrigger,
                        }
                    end
                end
            end

        end 
    end
}