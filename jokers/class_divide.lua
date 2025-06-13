SMODS.Joker{
    key = 'class_divide',
    loc_txt = {
        name = 'Class Divide',
        text = {
            "Gives {C:chips}+#2#{} Chips if you have",
            "{C:money}$10{} or less when hand is played,",
            "{C:mult}+#3#{} Mult if you have between",
            "{C:money}$15{} and {C:money}$25{} or {X:mult,C:white}X#1#{} and {C:money}$#4#{}",
            "if you have more than {C:money}$25{}",
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
        return {vars = {center.ability.extra.Xmult, center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.money}}
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