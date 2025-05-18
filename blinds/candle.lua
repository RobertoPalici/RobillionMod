SMODS.Blind{
    key = "candle",
    boss = {showdown = false, min = 1, max = 10},
    loc_txt = {
        name = "Candle",
        text = {
            "First card in each scoring hand",
            "is destroyed",
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
                    local _, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
                    if scoring_hand and #scoring_hand > 0 and #G.play.cards > 1 then

                        local first_card = scoring_hand[1]
                        local destroyed_card = nil
        
                        for i = 1, #G.play.cards do
                            if G.play.cards[i] == first_card then
                                destroyed_card = G.play.cards[i]
                                break
                            end
                        end

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
