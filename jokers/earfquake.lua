SMODS.Joker{
    key = "earfquake",
    loc_txt = {
        name = "Earfquake",
        text = {
            "Retrigger each played {C:attention}Stone{} card",
            "depending on the number of",
            "{C:attention}Stone{} cards played:",
            "{C:attention}3 - 4{} cards: {C:attention}1{} retrigger",
            "{C:attention}5{} cards: {C:attention}2{} retriggers"
        }
    },
    rarity = 2,
    cost = 5,
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
            if stone_count >=3 and stone_count < 5 then
                card.ability.extra = 1
            elseif stone_count == 5 then
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