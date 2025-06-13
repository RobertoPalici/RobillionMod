SMODS.Joker{
    key = 'miner',
    loc_txt = {
        name = 'Miner',
        text = {
            'Destroys a {C:attention}Stone Card{}',
            'from your deck at',
            'the end of the round',
            'and gives {C:money}$3{} or a',
            '{C:green}1 in 10{} chance',
            'to win {C:money}$25{}',
        }
    },
    rarity = 1,
    cost = 5,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 3, y = 3},
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            print("Miner Joker activated")
            for _, card in ipairs(G.playing_cards) do
                if card.ability.name == "Stone Card" then
                    print("Found Stone Card")
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                           card:remove()
                           return true
                        end
                    }))
                    local money = 0
                    result = math.random(1, 10)
                    if result == 10 then
                        money = 25
                    else
                        money = 3
                    end

                    if money > 0 then
                        ease_dollars(money)
                        return{
                            message = "$".. money,
                            colour = G.C.MONEY,
                            delay = 0.45
                        }
                    end
                end
            end
        end
    end,
}

