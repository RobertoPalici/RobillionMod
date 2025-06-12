SMODS.Joker{
    key = 'class_divide',
    loc_txt = {
        name = 'Class Divide',
        text = {
            'placeholder'
        }
    },
    rarity = 2,
    cost = 7,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            Xmult = 2.5,
            chips = 125,
            mult = 25,
            money = 2

        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.chips, center.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.dollars <= 10 then
                return{
                    message = 'Poor!',
                    chips = card.ability.extra.chips,
                    color = G.C.CHIPS
                }
            elseif G.GAME.dollars <= 25 then
                return{
                    message = 'Middle Class!',
                    mult = card.ability.extra.mult,
                    color = G.C.MULT
                }
            elseif G.GAME.dollars > 25 then
                return{
                    message = 'Rich!',
                    x_mult = card.ability.extra.Xmult,
                    dollars = card.ability.extra.money,
                    color = G.C.MULT
                }
            end
        end
    end

}