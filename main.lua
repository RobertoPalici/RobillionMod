--- STEAMODDED HEADER
--- MOD_NAME: ExampleJoker
--- MOD_ID: EXAMPLEJOKER
--- MOD_AUTHOR: Robillion
--- MOD_DESCRIPTION: Exemplu
--- PREFIX: xmpl

-- Store the original load function
local original_set_ability = Card.set_ability
local original_load = Card.load


Card.load = function(self, cardTable, other_card)
    original_load(self, cardTable, other_card)
    
    if self.config.center and self.config.center.name == "j_RobMod_rob_massive_joker" then
        self.T.h = self.T.h * 1.25
        self.T.w = self.T.w * 1.25
    end
end

Card.set_ability = function(self, center, initial, delay_sprites)
    --print("Setting ability for:", center and center.name or "Unknown")

    original_set_ability(self, center, initial, delay_sprites)

    if center and center.name == "j_RobMod_rob_massive_joker" then
        print("Resizing Massive Joker in set_ability")
        self.T.h = self.T.h * 1.35 
        self.T.w = self.T.w * 1.35 
        --print("New dimensions - Width:", self.T.w, "Height:", self.T.h)
    end
end

SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'xmpl_seven_ate_nine_joker',
    loc_txt = {
        name = 'Seven Ate Nine',
        text = {
            'Retrigger',
            'each played', 
            '{C:attention}7{}, {C:attention}8{}, {C:attention}9{}'
        }
    },
    rarity = 1,
    cost = 4,
    atlas = 'Jokers',
    pos = {x = 0, y = 0 },
    config = {
        extra = 1
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra + 1}}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and
          (context.other_card:get_id() == 7 or
           context.other_card:get_id() == 8 or
           context.other_card:get_id() == 9) then
            return{
                message = localize('k_again_ex'),
                repetitions = card.ability.extra, 
            }
        end
    end
}

SMODS.Joker{
    key = 'xmpl_blackjack_joker',
    loc_txt = {
        name = 'Blackjack',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'if the sum of values',
            'of scoring hand',
            'is less or equal to {C:attention}21{}'
        }
    },
    rarity = 2,
    cost = 6,
    atlas = 'Jokers',
    pos = {x = 1, y = 0 },
    config = {
        extra = {
            Xmult = 2
        }
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local sum = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    sum = sum + 10
                elseif context.scoring_hand[i]:get_id() == 14 then
                    sum = sum + 1
                else
                    sum = sum + context.scoring_hand[i]:get_id()
                end
            end
            if sum <= 21 then
                return{
                    message = 'X'.. card.ability.extra.Xmult,
                    Xmult_mod = card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'rob_massive_joker',
    loc_txt = {
        name = 'Massive Joker',
        text = {
            'This Joker gains',
            '{C:mult}+#2#{} Mult when each',
            'played {C:attention}Ace{} is scored',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
        }
    },
    rarity = 3,
    cost = 8,
    atlas = 'Jokers',
    pos = {x = 2, y = 0 },
    loc_vars = function(self, info_queue, center)
        return {vars = { center.ability.extra.mult,
                         center.ability.extra.mult_mod
                        }
                }
    end,
    config = {
        extra = {
            mult = 0,
            mult_mod = 2
        }
    },
    calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == G.play then
                if context.other_card:get_id() == 14 and not context.blueprint then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    return{
                        message = localize('k_upgrade_ex'),
                        colour = G.C.RED
                    }
                end
            end
        elseif context.joker_main then
            if card.ability.extra.mult > 0 then
                return{
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'rob_architect_joker',
    loc_txt = {
        name = 'Architect',
        text = {
            'This Joker has {C:green}#1# in #2#{}',
            'chance to create a', 
            '{C:dark_edition}Negative{} {C:attention}Blueprint{}',
            'when {C:attention}Blind{} is selected'
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    atlas = 'Jokers',
    pos = {x = 3, y = 0 },
    config = {
        extra = 10
    },
    loc_vars = function(self, info_queue, center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if pseudorandom('architect') < G.GAME.probabilities.normal/card.ability.extra then
                local new_blueprint = create_card('Joker', G.jokers, nil,nil,nil,nil, 'j_blueprint')
                new_blueprint:set_edition({negative = true}, true)
                new_blueprint:add_to_deck()
                G.jokers:emplace(new_blueprint)
            return{
                message = '+ Blueprint',
                colour = G.C.BLUE
            }
            end
        end
    end
    
}

G.P_CENTERS['rob_massive_joker'] = {
    name = 'Massive Joker',
    text = {
        'This Joker gains',
        '{C:mult}+#2#{} Mult when each',
        'played {C:attention}Ace{} is scored',
        '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
    },
    config = {
        extra = {
            mult = 0,
            mult_mod = 2
        }
    },
    pos = {x = 2, y = 0 },
    atlas = 'Jokers'
}

print("Registering Flush Rock Poker Hand")
SMODS.PokerHand{
    key = 'Flush Rock',
    mult = 200,
    chips = 10,
    l_mult = 20,
    l_chips = 10,
    visible = true,
    example = {
        { 'S_K', false }, -- King of Spades, does not score
        { 'S_9', true }, -- 9 of Spades, scores
        { 'D_9', true }, -- 9 of Diamonds, scores
        { 'H_6', false }, -- 6 of Hearts, does not score
        { 'D_3', false } -- 3 of Diamonds, does not score
    },
    loc_txt = {

            name = 'Flush Rock',
            description = {
                '5 cards with the Stone enhancement'
            }
    },  
    evaluate = function(parts, hand)
        print("Evaluating Flush Rock")
        -- Add evaluation logic here
    end,
}


-- Debug: Verify that the Massive Joker is registered
print("Massive Joker registered:", G.P_CENTERS['rob_massive_joker'] and G.P_CENTERS['rob_massive_joker'].name or "Not found")