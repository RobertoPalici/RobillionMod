SMODS.Joker{
    key = "rolling_stones",
    loc_txt = {
        name = "Rolling Stones",
        text = {
            "Each consecutive {C:attention}Stone{} card trigger",
            'trigger gives + {X:chips,C:white}X0.1{} Chips',
            'starting at {X:chips,C:white}X1.5{} Chips'
        }

    },
    rarity = 3,
    cost = 9,
    discovered = true,
    blueprint_compat = true,
    atlas = 'Jokers',
    pos = { x = 0, y = 1},
    config = {
        extra = 1,
        bonus = 0
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.name == "Stone Card" then 
                card.ability.bonus = card.ability.bonus + 0.1
                return{
                    x_chips = card.ability.extra + card.ability.bonus,
                    colour = G.C.BLUE
                }
            else
                card.ability.bonus = 0
            end
        end
        if context.after then
            card.ability.bonus = 0
        end
    end

}