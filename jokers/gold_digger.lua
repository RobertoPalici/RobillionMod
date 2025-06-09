SMODS.Joker{
    key = 'gold_digger',
    loc_txt ={
        name = 'Gold Digger',
        text = {
            'Played {C:attention}Kings{} and',
            '{C:attention}Jacks{} each give',
            '{X:mult,C:white}X#1#{} Mult when scored',
            'if the hand is played',
            'with {C:money}$#2#{} or more'
        }
    },
    config = {
        extra ={
            Xmult = 2,
            money = 25
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.money}}
    end,
    rarity = 3,
    cost = 8,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 2, y = 1},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 13 or context.other_card:get_id() == 11 then
                if G.GAME.dollars >= card.ability.extra.money then
                    return {
                        x_mult = card.ability.extra.Xmult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
}