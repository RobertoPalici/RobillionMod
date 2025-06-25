SMODS.Joker{
    key = 'break_if_emergency',
    loc_txt ={
        name = 'Break if Emergency',
        text = {
            'All scoring cards become',
            '{C:attention}Glass Cards{} and {C:mult}break',
            'after scoring in {C:attention}final{}',
            '{C:attention}hand{} of round'
        }
    },
    rarity = 2,
    cost = 6,
    atlas = 'Jokers',
    pos = {x = 0, y = 5 },
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 then
            for k, v in ipairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS.m_glass, nil, true)
                play_sound('rob_alarm', 1, 0.5)
                v.ability.name = 'Glass Card'
                context.destroy_card = v
                G.E_MANAGER:add_event(Event({
                        blockable = true,
                        delay = 2,
                        func = function()
                            v:juice_up()
                            
                        return true
                    end
                }))
            end
            return{
                message = "Emergency!",
                colour = G.C.MULT,
            }
        end
    end
}