SMODS.Joker{
    key = "mahoraga",
    loc_txt = {
        name = "Mahoraga",
        text = {
            "{X:mult,C:white} X#2# {} Mult but can",
            "only play {C:attention}one{} hand",
        }
    },
    rarity = 3,
    cost = 9,
    discovered = true,
    atlas = "Jokers",
    blueprint_compat = true,
    pos = {x = 3, y = 1},
    config = {
        Xmult = 5,
        hands = 1,
    },
    loc_vars = function(card, info_queue, center)
        return {vars = {center.ability.hands, center.ability.x_mult}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.getting_sliced and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.current_round.hands_left = 1
                return true
                end
            }))
            return{
                message = "1 hand!"
            }
        end
        if context.joker_main then
            return{
                message = 'X'.. card.ability.Xmult,
                Xmult_mod = card.ability.Xmult,
                colour = G.C.MULT
            }
        end
    end
}