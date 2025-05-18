SMODS.Seal{
    key = "orange_seal",
    loc_txt = {
        name = "Orange Seal",
        label = "Orange Seal",
        text = {
            "Gain a {C:mult}discard{} when discarded",
            "{C:inactive}(Can't get multiple discards in one discard){}"
        }
    },
    atlas = "Enhancements",
    pos = {x = 1, y = 0},
    discovered = true,
    badge_colour = HEX("df7126"),
    calculate = function(self, card, context)
        local ok = false
        if context.discard and context.other_card == card then
            ok = true
            if ok then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_discard(1)
                        return true
                    end
                }))
            end
        end

    end
    
}