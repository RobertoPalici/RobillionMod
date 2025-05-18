SMODS.Joker{
    key = 'lapse_blue',
    loc_txt = {
        name = 'Lapse Blue',
        text = {
            '{C:chips}+#1#{} Chips',
        }
    },
    rarity = 2,
    cost = 6,
    atlas = 'Jokers',
    pos = {x = 4, y = 1 },
    config = {
        chips = 100,
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                chips = card.ability.chips,
                colour = G.C.CHIPS
            }
        end
    end
}
