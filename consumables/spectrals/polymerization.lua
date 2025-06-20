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
        can_fuse = false,
        fusion = nil,
    },
    atlas = "Consumables",
    pos = {x = 1, y = 0},
    cost = 5,
    can_use = function(self, card, area)
        card.ability.can_fuse = false
        
        local j1 = G.jokers.cards[1]
        local j2 = G.jokers.cards[2]

        if j1 and j2 then
            local key1 = j1.config.center.key
            local key2 = j2.config.center.key

            if (key1 == 'j_rob_gojo' and key2 == 'j_rob_six_eyes') or
            (key1 == 'j_rob_six_eyes' and key2 == 'j_rob_gojo') then
                card.ability.can_fuse = true
                card.ability.fusion = 'j_rob_unlimited_void'
            end
        end
        return card.ability.can_fuse
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.jokers.cards[1]:start_dissolve({G.C.RED}, nil, 1.6)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 2, blockable = true,
            func = function()
                G.jokers.cards[1]:start_dissolve({G.C.RED}, nil, 1.6)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after', delay = 2, blockable = true,
            func = function()
                local fusion = create_card('Joker', G.jokers, nil,nil,nil,nil, card.ability.fusion)
                fusion:add_to_deck()
                G.jokers:emplace(fusion)
                return true
            end

        }))
    end
}   



        -- local gojo = nil
        -- local hollow_purple = nil
        -- local six_eyes = nil
        -- for _, v in ipairs(G.jokers.cards) do
        --     if v.config and v.config.center and v.config.center.key == 'j_rob_gojo' then
        --         gojo = v
        --     elseif v.config and v.config.center and v.config.center.key == 'j_rob_hollow_purple' then
        --         hollow_purple = v
        --     elseif v.config and v.config.center and v.config.center.key == 'j_rob_six_eyes' then
        --         six_eyes = v
        --     end   
        -- end

        -- gojo.getting_sliced = true
        -- hollow_purple.getting_sliced = true
        -- six_eyes.getting_sliced = true

        -- G.E_MANAGER:add_event(Event({
        --     func = function()
        --         gojo:start_dissolve({G.C.RED}, nil, 1.6)
        --         return true
        --     end
        -- }))
        -- G.E_MANAGER:add_event(Event({
        --     trigger = 'after', delay = 2, blockable = true,
        --     func = function()
        --         hollow_purple:start_dissolve({G.C.RED}, nil, 1.6)
        --         return true
        --     end
        -- }))
        -- G.E_MANAGER:add_event(Event({
        --     trigger = 'after', delay = 2, blockable = true,
        --     func = function()
        --         six_eyes:start_dissolve({G.C.RED}, nil, 1.6)
        --         return true
        --     end
        -- }))
        -- G.E_MANAGER:add_event(Event({
        --     trigger = 'after', delay = 2, blockable = true,
        --     func = function()
        --         local new_unlimited_void = create_card('Joker', G.jokers, nil,nil,nil,nil, 'j_rob_unlimited_void')
        --         new_unlimited_void:add_to_deck()
        --         G.jokers:emplace(new_unlimited_void)
        --         return true
        --     end

        -- }))


        -- if G.jokers.cards[1].config.center.key == 'j_rob_gojo' and G.jokers.cards[2].config.center.key == 'j_rob_six_eyes' or G.jokers.cards[2].config.center.key == 'j_rob_gojo' and G.jokers.cards[1].config.center.key == 'j_rob_six_eyes' then