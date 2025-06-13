SMODS.Joker{
    key = 'magnetic_field',
    loc_txt = {
        name = 'Magnetic Field',
        text = {
            'Each adjacent {C:attention}Steel Card{}',
            'gains the previous Steel',
            'Card\'s {X:mult,C:white}Xmult{} + {X:mult,C:white}X0.25{}'
        }
    },
    rarity = 3,
    cost = 8,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 0, y = 0},
    calculate = function(self, card, context)
        if context.before then
            local bonus = 0.25
            for i=2, #G.hand.cards do
                prev = G.hand.cards[i-1]
                curr = G.hand.cards[i]
                if prev.ability and curr.ability and prev.ability.name == "Steel Card" and 
                   curr.ability.name == "Steel Card" and curr.ability.h_x_mult and prev.ability.h_x_mult then
                   curr.ability.h_x_mult = prev.ability.h_x_mult + bonus
                end
                print(G.hand.cards[i].base.value, G.hand.cards[i].base.suit, "Inainte")
            end
        end
        if context.after then
            for i=2, #G.hand.cards do
                card = G.hand.cards[i]
                if card.ability and card.ability.name == "Steel Card" then
                    card.ability.h_x_mult = 1.5
                end
            end
        end
    end
}