SMODS.Joker{
    key = 'class_divide',
    loc_txt = {
        name = 'Class Divide',
        text = {
            "Gives {X:mult,C:white}X#1#{} and {C:money}$#3#{} or",
            "{C:blue}+#2#{} and lose {C:money}$1{} otherwise",
            "for every hand played",
            "with {C:money}$25{} or more",
        }
    },
    rarity = 2,
    cost = 7,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 5},
    config = {
        extra = {
            Xmult = 2.5,
            chips = 125,
            money = 2

        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.chips, center.ability.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.dollars < 25 then
                return{
                    message = 'Poor!',
                    chips = card.ability.extra.chips,
                    dollars = -1,
                    color = G.C.CHIPS
                }
            else
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