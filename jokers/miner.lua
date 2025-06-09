SMODS.Joker{
    key = 'miner',
    loc_txt = {
        name = 'Miner',
        text = {
            'placeholder',
        }
    },
    rarity = 1,
    cost = 5,
    discovered = true,
    atlas = 'Jokers',
    pos = {x = 1, y = 0},
    calculate = function(self, card, context)
        self.sum = 0
        if context.after then
            print("Miner card used in after context")
            for _, v in ipairs(G.play.cards) do
                if v.ability and v.ability.name == "Stone Card" then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after', delay = 1, blockable = true,
                        func = function()
                            v:start_dissolve({G.C.MONEY}, nil, 1.6)
                            G.deck:remove_card(v)
                            return true
                        end
                    }))

                    local money = 0
                    local r = math.random(1, 15)
                    
                    if r <= 10 then
                        money = 5     
                    elseif r <= 14 then
                        money = 10     
                    else
                        money = 25    
                    end
    
                    if money > 0 then
                        self.sum = self.sum + money
                    end
                end
            end

            if self.sum > 0 then
                return{

                    dollars = self.sum,
                    message = "+ $" .. tostring(self.sum),
                    color = G.C.MONEY,
                }
            end    
        end
    end,
}

