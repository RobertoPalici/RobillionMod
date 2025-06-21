SMODS.Joker{
    key = 'reversal_red',
    loc_txt = {
        name = 'Reversal Red',
        text = {
            '{C:mult}+#1#{} Mult',
        }
    },
    rarity = 1,
    cost = 6,
    
    atlas = 'Jokers',
    pos = {x = 0, y = 2 },
    config = {
        mult = 15,
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                mult = card.ability.mult,
                colour = G.C.RED
            }
        end
    end
}
