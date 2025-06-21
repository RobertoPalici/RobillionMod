SMODS.Joker{
    key = 'cloaked_colossus',
    loc_txt = {
        name = 'Cloaked Colossus',
        text = {
            '{C:attention}Stone Cards{} each give {X:chips,C:white} X#1#{} Chips',
            'in final hand of the round',
            'if no other {C:attention}Stone Cards{} played',
            'in previous hands of the round'
        }
    },
    discovered = true,
    rarity = 2, 
    cost = 7,
    atlas = 'Jokers',
    pos = {x = 1, y = 3},
    config = {
        extra = 2,
        stones = 0,
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.stones = 0
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.name == "Stone Card" then
                if G.GAME.current_round.hands_left == 0 and card.ability.stones == 0 then
                    return{
                        x_chips = card.ability.extra,
                        colour = G.C.CHIPS,
                    }
                else
                    card.ability.stones = card.ability.stones + 1
                end
            end
        end
    end


    
}