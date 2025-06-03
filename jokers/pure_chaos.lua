SMODS.Joker{
    key = 'pure_chaos',
    loc_txt = {
        name = 'Pure Chaos',
        text = {
            'Gives {X:mult,C:white}Xmult{}',
            'based on the {C:dark_edition}entropy{}',
            '{C:inactive}(diversity){} of your deck', 
            'when {C:attention}Blind{} is selected',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    atlas = 'Jokers',
    pos = {x = 3, y = 0 },
    config = {
        extra = {
            Xmult = 1
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return
            {
                message = 'X'.. card.ability.extra.Xmult,
                Xmult_mod = card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
        if context.setting_blind then
            print('End of round test joker')
            card.ability.extra.Xmult = G.GAME.entropy
            print('Xmult: ',  card.ability.extra.Xmult)
            return{
                message = "Entropy!"
            }
        end
    end
    
}