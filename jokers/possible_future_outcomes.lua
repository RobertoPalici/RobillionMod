SMODS.Joker{
    key = 'possible_future_outcomes',
    loc_txt = {
        name = 'Possible Future Outcomes',
        text = {
            'Gives {X:mult,C:white}Xmult{}',
            'based on how many {C:attention}distinct{}',
            'card combinations can form',
            'your played hand {C:attention}type{}',
        }
    },
    atlas = 'Jokers',
    pos = {x = 2, y = 2 },
    soul_pos = {x = 3, y = 2 },
    config ={
        extra = 0
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra}}
    end,
    calculate = function(self, card, context)
        -- Returnează numărul de combinații posibile din deck care pot forma o mână de tipul specificat
        function count_possible_hands(deck, hand_type)
            local function factorial(n)
                local r = 1
                for i = 2, n do r = r * i end
                return r
            end
        
            local function C(n, k)
                if k > n then return 0 end
                return factorial(n) / (factorial(k) * factorial(n - k))
            end
        
            local function build_histogram(deck)
                local value_counts, suit_counts = {}, {}
                for _, card in ipairs(deck) do
                    local val, suit = card.base.value, card.base.suit
                    value_counts[val] = (value_counts[val] or 0) + 1
                    suit_counts[suit] = (suit_counts[suit] or 0) + 1
                end
                return value_counts, suit_counts
            end
        
            local value_counts, suit_counts = build_histogram(deck)
            local total = 0
        
            if hand_type == "Pair" then
                for _, count in pairs(value_counts) do
                    if count >= 2 then
                        total = total + C(count, 2)
                    end
                end
        
            elseif hand_type == "Two Pair" then
                local pair_values = {}
                for val, count in pairs(value_counts) do
                    if count >= 2 then
                        table.insert(pair_values, {val = val, count = count})
                    end
                end
                for i = 1, #pair_values do
                    for j = i + 1, #pair_values do
                        total = total + C(pair_values[i].count, 2) * C(pair_values[j].count, 2)
                    end
                end
        
            elseif hand_type == "Three of a Kind" then
                for _, count in pairs(value_counts) do
                    if count >= 3 then
                        total = total + C(count, 3)
                    end
                end
        
            elseif hand_type == "Four of a Kind" then
                for _, count in pairs(value_counts) do
                    if count >= 4 then
                        total = total + C(count, 4)
                    end
                end
        
            elseif hand_type == "Five of a Kind" then
                for _, count in pairs(value_counts) do
                    if count >= 5 then
                        total = total + C(count, 5)
                    end
                end
        
            elseif hand_type == "Full House" then
                local three_vals, two_vals = {}, {}
                for val, count in pairs(value_counts) do
                    if count >= 3 then table.insert(three_vals, {val = val, count = count}) end
                    if count >= 2 then table.insert(two_vals, {val = val, count = count}) end
                end
                for _, three in ipairs(three_vals) do
                    for _, two in ipairs(two_vals) do
                        if three.val ~= two.val then
                            total = total + C(three.count, 3) * C(two.count, 2)
                        end
                    end
                end
        
            elseif hand_type == "Flush" then
                for suit, count in pairs(suit_counts) do
                    if count >= 5 then
                        total = total + C(count, 5)
                    end
                end
        
            elseif hand_type == "Straight" then
                local straights = {
                    {1,2,3,4,5}, {2,3,4,5,6}, {3,4,5,6,7}, {4,5,6,7,8},
                    {5,6,7,8,9}, {6,7,8,9,10}, {7,8,9,10,11}, {8,9,10,11,12},
                    {9,10,11,12,13}, {10,11,12,13,1}
                }
                for _, straight in ipairs(straights) do
                    local possible, ways = true, 1
                    for _, val in ipairs(straight) do
                        if not value_counts[val] then
                            possible = false
                            break
                        end
                        ways = ways * value_counts[val]
                    end
                    if possible then
                        total = total + ways
                    end
                end
        
            elseif hand_type == "Straight Flush" then
                local straights = {
                    {1,2,3,4,5}, {2,3,4,5,6}, {3,4,5,6,7}, {4,5,6,7,8},
                    {5,6,7,8,9}, {6,7,8,9,10}, {7,8,9,10,11}, {8,9,10,11,12},
                    {9,10,11,12,13}, {10,11,12,13,1}
                }
                for suit in pairs(suit_counts) do
                    local suited_counts = {}
                    for _, card in ipairs(deck) do
                        if card.base.suit == suit then
                            local val = card.base.value
                            suited_counts[val] = (suited_counts[val] or 0) + 1
                        end
                    end
                    for _, straight in ipairs(straights) do
                        local possible, ways = true, 1
                        for _, val in ipairs(straight) do
                            if not suited_counts[val] then
                                possible = false
                                break
                            end
                            ways = ways * suited_counts[val]
                        end
                        if possible then
                            total = total + ways
                        end
                    end
                end
        
            elseif hand_type == "Flush House" then
                for suit in pairs(suit_counts) do
                    local suited = {}
                    for _, card in ipairs(deck) do
                        if card.base.suit == suit then
                            local val = card.base.value
                            suited[val] = (suited[val] or 0) + 1
                        end
                    end
                    for v3, c3 in pairs(suited) do
                        if c3 >= 3 then
                            for v2, c2 in pairs(suited) do
                                if v2 ~= v3 and c2 >= 2 then
                                    total = total + C(c3, 3) * C(c2, 2)
                                end
                            end
                        end
                    end
                end
        
            elseif hand_type == "Flush Five" then
                for suit in pairs(suit_counts) do
                    local suited_vals = {}
                    for _, card in ipairs(deck) do
                        if card.base.suit == suit then
                            local val = card.base.value
                            suited_vals[val] = (suited_vals[val] or 0) + 1
                        end
                    end
                    for _, count in pairs(suited_vals) do
                        if count >= 5 then
                            total = total + C(count, 5)
                        end
                    end
                end
        
            elseif hand_type == "High Card" then
                for _, count in pairs(value_counts) do
                    total = total + count
                end
            end
        
            return math.floor(total)
        end
        

        if context.before then
            local text, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
            local deck = G.playing_cards
            card.ability.extra = count_possible_hands(deck, text)
        end
        if context.joker_main and card.ability.extra > 0 then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra}},
                Xmult = card.ability.extra,
                colour = G.C.MULT
            }
        end
    end

}
