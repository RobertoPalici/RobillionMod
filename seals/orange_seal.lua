SMODS.Seal{
    key = "orange_seal",
    loc_txt = {
        name = "Orange Seal",
        label = "Orange Seal",
        text = {
            "Will not use a {C:mult}discard{}",
            "when discarded"
        }
    },
    atlas = "Enhancements",
    pos = {x = 1, y = 0},
    discovered = true,
    badge_colour = HEX("df7126"),
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            G.GAME.orange_seal = true
        end
    end
    
}