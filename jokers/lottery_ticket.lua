SMODS.Joker{
    key = 'lottery_ticket',
    loc_txt = {
        name = 'Lottery Ticket',
        text = {
            'Gives {C:money}#5#${} for every',
            '{C:attention}#3#{} of {V:1}#4#{} you draw',
            'with a probability {C:red}less than{}',
            '{C:blue}or equal{} to {C:attention}15%{}',
            'after {C:blue}play{} or {C:red}discard{}',
            '{s:0.8}Card changes every round',
            '{C:inactive}(Currently #1#-#2#%){}'
        }
    },
    rarity = 1,
    cost = 5,
    discovered = true,
    blueprint_compat = false,
    atlas = 'Jokers',
    pos = {x = 4, y = 0},
    config = {
        probability = nil,
        min_probability = 0,
        max_probability= 100,
        money = 25,
    },
    calculate = function(self, card, context)
        local function get_card_key(card)
            return tostring(card.base.value) .. "_" .. tostring(card.base.suit)
        end
        local function get_unique_card_key(card)
            return tostring(card.base.value) .. "_" .. tostring(card.base.suit) .. "_" .. tostring(card.ID)
        end

        local function remove_last_segment(s)
            return s:match("(.+)_[^_]+$")
        end

        local key_target = tostring(G.GAME.current_round.giveaway_card.rank).. "_" .. tostring(G.GAME.current_round.giveaway_card.suit)

        local function get_new_drawn_cards(initial_keys, final_keys)
            -- Creează un set cu frecvențele din mâna inițială
            local key_counts = {}
            for _, key in ipairs(initial_keys) do
                key_counts[key] = (key_counts[key] or 0) + 1
            end

            local drawn = {}
            for _, key in ipairs(final_keys) do
                if key_counts[key] and key_counts[key] > 0 then
                    key_counts[key] = key_counts[key] - 1
                else
                    table.insert(drawn, key)
                end
            end
            return drawn
        end


        if context.pre_discard then
            self._initial_hand_keys = {}
            for _, c in ipairs(G.hand.cards) do
                table.insert(self._initial_hand_keys, get_unique_card_key(c))
            end
            -- print("Saved initial hand keys:", table.concat(self._initial_hand_keys, ", "))
        end

        if context.before then
            self._initial_hand_keys = nil
        end

        if context.hand_drawn then

            local final_hand_keys = {}
            for _, c in ipairs(G.hand.cards) do
                table.insert(final_hand_keys, get_unique_card_key(c))
            end

            local give_money = false
            if self._initial_hand_keys then
                local drawn = get_new_drawn_cards(self._initial_hand_keys or {}, final_hand_keys)
                for _, k in ipairs(drawn) do
                    local drawn_card = remove_last_segment(k)
                    -- print("Drawn card:", drawn_card)
                    -- print("Target card:", key_target)
                    -- print("Probability:", card.ability.probability)
                    if drawn_card == key_target and card.ability.probability and card.ability.probability <= 15 then
                        give_money = true
                        break
                    end
                end
            end


            local deck = G.deck.cards
            local N = #deck

            local function factorial(n)
                if n == 0 then return 1 end
                local r = 1
                for i = 2, n do r = r * i end
                return r
            end

            local function combination(n, k)
                if k > n then return 0 end
                return factorial(n) / (factorial(k) * factorial(n - k))
            end

            local matching = 0
            for _, c in ipairs(deck) do
                if get_card_key(c) == key_target then
                    matching = matching + 1
                end
            end

            local p_zero_hits = combination(N - matching, 5) / combination(N, 5)
            local p_at_least_one = 1 - p_zero_hits
            card.ability.max_probability = p_at_least_one *100
            local p_zero_hits = combination(N - matching, 1) / combination(N, 1)
            local p_at_least_one = 1 - p_zero_hits
            card.ability.min_probability = p_at_least_one * 100

            if give_money then
                return{
                    message = 'Jackpot!',
                    dollars = card.ability.money,
                    colour = G.C.MONEY,
                }
            end
            
        end

        -- Calculăm probabilitatea
        if context.discard then
            
            local deck = G.deck.cards
            local N = #deck
            local x = #G.hand.highlighted

            local function factorial(n)
                if n == 0 then return 1 end
                local r = 1
                for i = 2, n do r = r * i end
                return r
            end

            local function combination(n, k)
                if k > n then return 0 end
                return factorial(n) / (factorial(k) * factorial(n - k))
            end

            local matching = 0
            for _, c in ipairs(deck) do
                if get_card_key(c) == key_target then
                    matching = matching + 1
                end
            end

            if matching == 0 then
                card.ability.probability = 0
             end
            if x >= N then
                card.ability.probability = 100
            end

            local p_zero_hits = combination(N - matching, x) / combination(N, x)
            local p_at_least_one = 1 - p_zero_hits
            card.ability.probability = p_at_least_one * 100
            -- print("Probabilitatea skibidi:", card.ability.probability)
        end
    end
}
