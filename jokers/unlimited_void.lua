SMODS.Joker{
    key = 'unlimited_void',
    loc_txt = {
        name = 'Unlimited Void',
        text = {
            '{C:dark_edition}??????????????{}',
        }
    },
    rarity = "rob_mythic",
    cost = 30,
    atlas = 'Jokers',
    pos = {x = 0, y = 3 },
    config = {
        extra ={
            Xmult = 1e308
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                Xmult = card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end
    
}