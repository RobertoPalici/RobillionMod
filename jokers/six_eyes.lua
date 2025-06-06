SMODS.Joker{
    key = 'six_eyes',
    loc_txt = {
        name = 'Six Eyes',
        text = {
            'Creates {C:blue}Lapse Blue{}',
            'or {C:red}Reversal Red{}',
            'when {C:attention}Blind{} is selected',
        }
    },
    rarity = 3,
    cost = 10,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 4, y = 2 },
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local new_card = nil
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    if math.random() < 0.5 then
                        new_card = create_card('Joker', G.jokers, nil,0,nil,nil, 'j_rob_lapse_blue')
                    else
                        new_card = create_card('Joker', G.jokers, nil,0,nil,nil,'j_rob_reversal_red')
                    end
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)
                    new_card:start_materialize()
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
                
        end
    end
}