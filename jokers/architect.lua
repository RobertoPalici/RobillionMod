SMODS.Joker{
    key = 'architect',
    loc_txt = {
        name = 'Architect',
        text = {
            '{C:green}#1# in #2#{} chance',
            'this joker is destroyed', 
            'and creates a {C:attention}Blueprint{}',
            'at the end of the round'
        }
    },
    rarity = 3,
    cost = 9,
    discovered = true,
    blueprint_compat = false,
    atlas = 'Jokers',
    pos = {x = 3, y = 0 },
    config = {
        extra = 3,
        is_destroyed = false
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
      if context.cardarea == G.jokers then 
                if pseudorandom('architect') <       G.GAME.probabilities.normal/card.ability.extra
                and not card.ability.is_destroyed then
                card.ability.is_destroyed = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    local new_blueprint = create_card('Joker', G.jokers, nil,nil,nil,nil, 'j_blueprint')
                                    new_blueprint:add_to_deck()
                                    G.jokers:emplace(new_blueprint)
                                    return true
                                end
                            }))
                    return true
                    end  
                    }))
                return{
                    message = "Done!",
                    color = G.C.BLUE
                    }
            else
                return{
                    message = "Designing..."
                }
            end
            end
               
        end
    end
    
}