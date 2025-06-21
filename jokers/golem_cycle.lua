SMODS.Joker{
    key = 'golem_cycle',
    loc_txt = {
        name = 'Golem Cycle',
        text = {
            '{C:attention}Stone Cards{} each give',
            '{X:chips,C:white} X#2#{} Chips when scored',
            'and also give {C:money}$3{} if scored',
            'against a {C:attention}Boss Blind{}'
        }
    },
    discovered = true,
    rarity = 'rob_epic',
    cost = 10,
    atlas = 'Jokers',
    pos = {x = 1, y = 2},
    config = {
        money = 0,
        x_chips = 2
    },
    loc_vars = function(self,info_queue,center)
        return{
            vars = {
                center.ability.money,
                center.ability.x_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.name == "Stone Card" then
                if card.ability.money > 0 then
                    return {
                        x_chips = card.ability.x_chips,
                        colour = G.C.CHIPS,
                        dollars = card.ability.money,
                    }
                else
                    return {
                        x_chips = card.ability.x_chips,
                        colour = G.C.CHIPS,
                    }
                end
            end
        end
        if context.setting_blind then
            if context.blind.boss then
                card.ability.money = 3
            else
                card.ability.money = 0
            end
        end
    end
}