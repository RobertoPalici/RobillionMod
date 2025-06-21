SMODS.Joker{
    key = 'hollow_purple',
    loc_txt = {
        name = 'Hollow Purple',
        text = {
            '{C:chips}+#1#{} Chips',
            '{C:mult}+#2#{} Mult',
            '{X:mult,C:white}X#3#{} Mult ',
        }
    },
    rarity = "rob_epic",
    cost = 10,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 2 },
    yes_pool_flag = "gojo__purple",
    config = {
        extra = {
            chips = 600,
            mult = 60,
            Xmult = 6
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                Xmult = card.ability.extra.Xmult,
            }
        end
    end
}