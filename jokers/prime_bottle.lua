SMODS.Joker{
    key = 'prime_bottle',
    loc_txt = {
        name = 'Prime Bottle',
        text = {
            'Cards with {C:attention}prime{} numbers',
            'each give half of their',
            'number as {X:mult,C:white}Xmult'
        }
    },
    rarity = 4,
    cost = 10,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 3},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 2 or
            context.other_card:get_id() == 3 or
            context.other_card:get_id() == 5 or
            context.other_card:get_id() == 7 then
                local prime_mult = context.other_card:get_id() / 2
                return {
                    x_mult = prime_mult,
                    colour = G.C.MULT,
                }
            end
        end
    end
}