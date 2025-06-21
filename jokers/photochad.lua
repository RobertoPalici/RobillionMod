SMODS.Joker{
    key = 'photochad',
    loc_txt = {
        name = 'Photochad',
        text = {
            '{C:attention}First and last face card{}',
            'gives {X:mult,C:white}X#2#{} Mult and retriggers',
            '{C:attention}2{} additional times'
        }
    },
    discovered = true,
    rarity = 'rob_epic',
    cost = 10,
    atlas = 'Jokers',
    pos = {x = 1, y = 1},
    config = {
        extra = {
            retrigger = 2,
            xmult = 2.5,
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
        if context.individual then
            if context.cardarea == G.play then
                        local first_face = nil
                        local last_face = nil
                        for i = 1, #context.scoring_hand do
                            if context.scoring_hand[i]:is_face() then
                                if not first_face then
                                    first_face = context.scoring_hand[i]
                                end
                                last_face = context.scoring_hand[i]
                            end
                        end
                if context.other_card == first_face or context.other_card == last_face then
                    return{
                        x_mult = card.ability.extra.xmult,
                        colour = G.C.MULT,
                    }
                end
            end 
        end
        if context.repetition then
            if context.cardarea == G.play then
                local first_face = nil
                local last_face = nil
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i]:is_face() then
                        if not first_face then
                            first_face = context.scoring_hand[i]
                        end
                        last_face = context.scoring_hand[i]
                    end
                end
                if context.other_card == first_face and context.other_card == last_face then
                    return{
                        repetitions = card.ability.extra.retrigger + 2,
                        message = localize("k_again_ex"),
                    }
    
                elseif context.other_card == first_face or context.other_card == last_face then
                    return{
                        repetitions = card.ability.extra.retrigger,
                        message = localize("k_again_ex"),
                    }
                end
            end
        end
    end

}