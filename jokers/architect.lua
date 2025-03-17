SMODS.Joker{
    key = 'architect_joker',
    loc_txt = {
        name = 'Architect',
        text = {
            'This Joker has {C:green}#1# in #2#{}',
            'chance to create a', 
            '{C:dark_edition}Negative{} {C:attention}Blueprint{}',
            'when {C:attention}Blind{} is selected'
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    atlas = 'Jokers',
    pos = {x = 3, y = 0 },
    config = {
        extra = 10
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if pseudorandom('architect') < G.GAME.probabilities.normal/card.ability.extra then
                local new_blueprint = create_card('Joker', G.jokers, nil,nil,nil,nil, 'j_blueprint')
                new_blueprint:set_edition({negative = true}, true)
                new_blueprint:add_to_deck()
                G.jokers:emplace(new_blueprint)
            return{
                message = '+ Blueprint',
                colour = G.C.BLUE
            }
            end
        end
    end
    
}