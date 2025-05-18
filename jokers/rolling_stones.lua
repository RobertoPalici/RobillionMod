SMODS.Joker{
    key = "rolling_stones",
    loc_txt = {
        name = "Rolling Stones",
        text = {
            "Played {C:attention}Stone{} cards",
            "each give {X:chips,C:white} X#1# {} Chips",
            "when scored"
        }

    },
    rarity = 3,
    cost = 15,
    blueprint_compat = true,
    atlas = 'Jokers',
    pos = { x = 0, y = 1},
    config = {
        extra = 1.5
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.name == "Stone Card" then
                return{
                    x_chips = card.ability.extra,
                    colour = G.C.BLUE,
                }
            end
        end
    end

}