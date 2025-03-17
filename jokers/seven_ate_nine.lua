SMODS.Joker{
    key = 'seven_ate_nine',
    loc_txt = {
        name = 'Seven Ate Nine',
        text = {
            'Retrigger',
            'each played', 
            '{C:attention}7{}, {C:attention}8{}, {C:attention}9{}'
        }
    },
    rarity = 1,
    cost = 4,
    atlas = 'Jokers',
    pos = {x = 0, y = 0 },
    config = {
        extra = 1
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra + 1}}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and
          (context.other_card:get_id() == 7 or
           context.other_card:get_id() == 8 or
           context.other_card:get_id() == 9) then
            return{
                message = localize('k_again_ex'),
                repetitions = card.ability.extra, 
            }
        end
    end
}