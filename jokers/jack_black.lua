SMODS.Joker{
    key = 'jackblack',
    loc_txt = {
        name = 'Jack The Black',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'if the {C:attention}sum of values{}',
            'of scoring hand',
            'is less or equal to {C:attention}21{}'
        }
    },
    rarity = 2,
    cost = 6,
    atlas = 'Jokers',
    pos = {x = 1, y = 0 },
    config = {
        extra = {
            Xmult = 3
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