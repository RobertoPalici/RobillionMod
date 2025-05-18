SMODS.Consumable{
    key = "polymerization",
    set = "Spectral",
    loc_txt = {
        name = "Polymerization",
        text = {
            "Use this card to",
            "{C:dark_edition}fuse{} two or more",
            "compatible {C:attention}Jokers{}"
        },

    },
    config ={
        compat = {
            gojo = false,
            hollow_purple = false,
            six_eyes = false,
        },
        is_juiced = false,
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.compat.gojo,
                        center.ability.compat.hollow_purple
                        }
                }
    end,
    atlas = "Consumables",
    pos = {x = 1, y = 0},
    cost = 5,
    can_use = function(self,card,area)
        card.ability.compat.gojo = false
        card.ability.compat.hollow_purple = false
        card.ability.compat.six_eyes = false
        for _, v in ipairs(G.jokers.cards) do
            if v.config and v.config.center and v.config.center.key == 'j_rob_gojo' then
                card.ability.compat.gojo = true
            elseif v.config and v.config.center and v.config.center.key == 'j_rob_hollow_purple' then
                card.ability.compat.hollow_purple = true
            elseif v.config and v.config.center and v.config.center.key == 'j_rob_six_eyes' then
                card.ability.compat.six_eyes = true
            end   
        end
        if card.ability.compat.gojo and card.ability.compat.hollow_purple and card.ability.compat.six_eyes then
            return true
        else
            return false
        end
    end,
    calculate = function(self, card, context)
        if self:can_use(card) and not card.ability.is_juiced then
            card.ability.is_juiced = true
            local eval = function() return card.ability.compat.gojo and card.ability.compat.hollow_purple and card.ability.compat.six_eyes  end
            juice_card_until(card, eval, true)
        elseif not self:can_use(card) then
            card.ability.is_juiced = false 
        end
    end,
    use = function(self, card, area, copier)
        local gojo = nil
        local hollow_purple = nil
        local six_eyes = nil
        for _, v in ipairs(G.jokers.cards) do
            if v.config and v.config.center and v.config.center.key == 'j_rob_gojo' then
                gojo = v
            elseif v.config and v.config.center and v.config.center.key == 'j_rob_hollow_purple' then
                hollow_purple = v
            elseif v.config and v.config.center and v.config.center.key == 'j_rob_six_eyes' then
                six_eyes = v
            end   
        end

        gojo.getting_sliced = true
        hollow_purple.getting_sliced = true
        six_eyes.getting_sliced = true

        G.E_MANAGER:add_event(Event({
            func = function()
                gojo:start_dissolve({G.C.RED}, nil, 1.6)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 2, blockable = true,
            func = function()
                hollow_purple:start_dissolve({G.C.RED}, nil, 1.6)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 2, blockable = true,
            func = function()
                six_eyes:start_dissolve({G.C.RED}, nil, 1.6)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 2, blockable = true,
            func = function()
                local new_unlimited_void = create_card('Joker', G.jokers, nil,nil,nil,nil, 'j_rob_unlimited_void')
                new_unlimited_void:add_to_deck()
                G.jokers:emplace(new_unlimited_void)
                return true
            end

        }))
    end
        

}   