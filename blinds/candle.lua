SMODS.Blind{
    key = "candle",
    boss = {showdown = false, min = 1, max = 10},
    loc_txt = {
        name = "Candle",
        text = {
            "First card in each played",
            "hand is destroyed",
        }
    },
    atlas = "Blinds",
    pos = {y = 0},
    discovered = true,
    dollars = 5,
    mult = 2,
    boss_colour =  HEX("b91408"),
    press_play = function(self)
        if not G.GAME.blind.disabled and G.play and G.play.cards then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    if #G.play.cards > 1 then

                        local destroyed_card = G.play.cards[1]

                        play_sound('tarot1')
                        G.deck:remove_card(destroyed_card)
                        destroyed_card:start_dissolve(nil, 1)
                    end
                    return true
                end
            }))
        end
    end

}
