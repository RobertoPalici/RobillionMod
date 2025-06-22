SMODS.Joker{
    key = "earfquake",
    loc_txt = {
        name = "Earfquake",
        text = {
            "Retrigger each played {C:attention}Stone{}",
            "card {C:attention}1{} time if played hand",
            "contains {C:attention}5 Stone cards{}",
        }
    },
    rarity = 2,
    cost = 6,
    discovered = true,
    blueprint_compat = true,
    atlas= 'Jokers',
    pos = {x = 4, y = 0},
    config = {
        extra = 0
    },

    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra + 1}}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            local stone_count = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == "Stone Card" then
                    stone_count = stone_count + 1
                end
            end
            if stone_count == 5 then
                card.ability.extra = 2
            end
            if context.other_card.ability.name == "Stone Card" then
                return{
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra, 
                    }   
            end
        end
    end
}