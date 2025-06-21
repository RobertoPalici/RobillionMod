SMODS.Joker{
    key = "gojo",
    loc_txt = {
        name = "Gojo",
        text = {
            "Combines {C:blue}Lapse Blue{}",
            "and {C:red}Reversal Red{}",
            "to create {C:attention}Hollow Purple{} ",
            "when {C:attention}Blind{} is selected",
        }
    },
    rarity = 4,
    cost = 20,
    discovered = true,
    atlas = "Jokers",
    pos = {x = 2, y = 2 },
    soul_pos = {x = 3, y = 2 },
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local red = nil
            local blue = nils
            for _, v in ipairs(G.jokers.cards) do
                if v.config and v.config.center and v.config.center.key == 'j_rob_reversal_red' then
                    red = v
                elseif v.config and v.config.center and v.config.center.key == 'j_rob_lapse_blue' then
                    blue = v
                end   

            end
            if red and blue then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = 2, blockable = true,
                    func = function()
                        red:start_dissolve({G.C.RED}, nil, 1.6)
                        red = nil
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = 2, blockable = true,
                    func = function()
                        blue:start_dissolve({G.C.RED}, nil, 1.6)
                        blue = nil
                        return true
                    end
                }))  
            G.E_MANAGER:add_event(Event({
                trigger = 'after', delay = 2, blockable = true,
                func = function()
                    local new_hollow_purple = create_card('Joker', G.jokers, nil,nil,nil,nil, 'j_rob_hollow_purple')
                    new_hollow_purple:add_to_deck()
                    G.jokers:emplace(new_hollow_purple)
                    return true
                end
            }))
                G.GAME.pool_flags.gojo_hollow_purple = true
                return{
                message = "Hollow Purple!"
                }
            end
        end
    end,
}