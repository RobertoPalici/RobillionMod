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

            elseif (key1 == 'j_baron' and key2 == 'j_mime') or
            (key1 == 'j_mime' and key2 == 'j_baron') then
                card.ability.can_fuse = true
                card.ability.fusion = 'j_rob_kings_jester'

            elseif (key1 == 'j_photograph' and key2 == 'j_hanging_chad') or
            (key1 == 'j_hanging_chad' and key2 == 'j_photograph') then
                card.ability.can_fuse = true
                card.ability.fusion = 'j_rob_photochad'

            elseif (key1 == 'j_rob_boss_raider' and key2 == 'j_rob_cloaked_colossus') or
            (key1 == 'j_rob_cloaked_colossus' and key2 == 'j_rob_boss_raider') then
                card.ability.can_fuse = true
                card.ability.fusion = 'j_rob_golem_cycle'
            
            elseif (key1 == 'j_rob_pure_chaos' and key2 == 'j_rob_lottery_ticket') or
            (key1 == 'j_rob_lottery_ticket' and key2 == 'j_rob_pure_chaos') then
                card.ability.can_fuse = true
                card.ability.fusion = 'j_rob_possible_future_outcomes'
            
            elseif (key1 == 'j_space' and key2 == 'j_satellite') or
            (key1 == 'j_satellite' and key2 == 'j_space') then
                card.ability.can_fuse = true
                card.ability.fusion = 'j_rob_iss'
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
