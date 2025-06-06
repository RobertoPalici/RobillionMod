SMODS.Joker{
    key="jimnaldo",
    loc_txt = {
        name = "Jimnaldo",
        text = {
            "Retrigger each",
            "played {C:attention}7{} two",
            "additional times"
        }

    },
    rarity = 2,
    cost = 6,
    discovered = true,
    blueprint_compat = true,
    atlas = "Jokers",
    pos = {x = 2, y = 1},
    config ={
        extra = 2
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra + 1}}
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 7 then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra
                }
            end
        end
    end
}