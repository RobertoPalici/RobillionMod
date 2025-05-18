SMODS.Seal{
    key = 'green_seal',
    loc_txt = {
        name = 'Green Seal',
        label = 'Green Seal',
        text = {
            'Draw one {C:attention}extra{} card',
            'when discarded'

        }
    },
    atlas = "Enhancements",
    pos = {x = 0, y = 0},
    discovered = true,
    badge_colour = HEX("3dd53e"),
    config = {
        drawn_cards = 1
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.drawn_cards}}
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            G.GAME.green_seal_draws = G.GAME.green_seal_draws + card.ability.seal.drawn_cards
            return{
                message = "Extra card!",
                colour = G.C.GREEN,
                card = card
            }
        end
    end

}