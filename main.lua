--- STEAMODDED HEADER
--- MOD_NAME: RobillionMod
--- MOD_ID: RobilionMod
--- MOD_AUTHOR: Robillion
--- MOD_DESCRIPTION: Vanilla Inspired Mod
--- PREFIX: rob

-- Store the original load function


local files = {
    jokers = {
        list = {
            "seven_ate_nine",
            "blackjack",
            "massive_joker",
            "architect",
            "earfquake",
            "rolling_stones",
            "medusa",
            "jimnaldo",
            "mahoraga",
            "lapse_blue",
            "reversal_red",
            "hollow_purple",
            "gojo",
            "six_eyes",
            "unlimited_void",
            "pure_chaos",
            "lottery_ticket",
            "possible_future_outcomes",
            "gold_digger",
            "miner",
            "class_divide",
            "magnetic_field",
            "break_if_emergency",
            "kings_jester",
            "photochad",
            "boss_raider",
            "cloaked_colossus",
            "prime_bottle",
            "golem_cycle"
        },
        directory = 'jokers/'
    },
    poker_hands = {
        list = {
            "stone_flush"
        },
        directory = 'poker_hands/'
    },
    planets = {
        list = {
            "meteor",
        },
        directory = 'consumables/planets/'
    },
    -- vouchers = {
    --     list = {
            
    --         "seal_the_deal",
    --         "sealionaire",
    --     },
    --     directory = 'vouchers/'
    -- },
    seals = {
        list = {
            "green_seal",
            "orange_seal",
            "black_seal",
        },
        directory = 'seals/'
    },
    blinds = {
        list = {
            "candle",
        },
        directory = 'blinds/'
    },
    rarities = {
        list = {
            "mythic",
            "epic",
        },
        directory = 'rarities/'
    },
    spectrals = {
        list = {
            "polymerization",
        },
        directory = 'consumables/spectrals/'
    },
}

----------------------------------------------------------------
--------------------RESURSE-------------------------------------


SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Consumables',
    path = 'Consumables.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Vouchers',
    path = 'Vouchers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Enhancements',
    path = 'Enhancements.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Blinds',
    path = 'Blinds.png',
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21
}

SMODS.Sound{
    key = 'alarm',
    path = 'alarm.ogg',
}
----------------------------------------------------------------
----------------------------------------------------------------


local original_set_ability = Card.set_ability
local original_load = Card.load


Card.load = function(self, cardTable, other_card)
    original_load(self, cardTable, other_card)
    
    if self.config.center and self.config.center.name == "j_rob_massive_joker" then
        self.T.h = self.T.h * 1.25
        self.T.w = self.T.w * 1.25
    end
end

Card.set_ability = function(self, center, initial, delay_sprites)
    --print("Setting ability for:", center and center.name or "Unknown")

    original_set_ability(self, center, initial, delay_sprites)

    if center and center.name == "j_rob_massive_joker" then
        -- print("Resizing Massive Joker in set_ability")
        self.T.h = self.T.h * 1.35 
        self.T.w = self.T.w * 1.35 
        --print("New dimensions - Width:", self.T.w, "Height:", self.T.h)
    end

    if center and center.name == "j_rob_pure_chaos" and G.GAME.entropy then
        self.ability.extra.Xmult = G.GAME.entropy
    end
end


local old_game_init = Game.init_game_object
Game.init_game_object = function(self)
  old_ret = old_game_init(self)

  old_ret.green_seal_draws = 0

  return old_ret
end

local original_calculate_destroying = SMODS.calculate_destroying_cards

SMODS.calculate_destroying_cards = function(context, cards_destroyed, scoring_hand)
    for i,card in ipairs(context.cardarea.cards) do
        local destroyed = nil
        --un-highlight all cards
        local in_scoring = scoring_hand and SMODS.in_scoring(card, context.scoring_hand)
        if scoring_hand and in_scoring then 
            -- Use index of card in scoring hand to determine pitch
            local m = 1
            for j, _card in pairs(scoring_hand) do
                if card == _card then m = j break end
            end
            highlight_card(card,(m-0.999)/(#scoring_hand-0.998),'down')
        end

        local emergency = nil
        for _, v in ipairs(G.jokers.cards) do
            if v.config and v.config.center and v.config.center.key == 'j_rob_break_if_emergency' then
                emergency = true
                break
            end
        end
        

        -- context.destroying_card calculations
        context.destroy_card = card
        context.destroying_card = nil
        if scoring_hand then
            if in_scoring then
                context.cardarea = G.play
                context.destroying_card = card
            else
                context.cardarea = 'unscored'
            end
        end
        local flags = SMODS.calculate_context(context)
        if flags.remove or emergency and G.GAME.current_round.hands_left == 0 and in_scoring then destroyed = true end

        -- TARGET: card destroyed

        if destroyed then
            if SMODS.shatters(card) then
                card.shattered = true
            else
                card.destroyed = flags.remove
            end
            cards_destroyed[#cards_destroyed+1] = card
        end
    end
end

----------------------------------------------------------------
--------------------LOAD FILES----------------------------------


local function load_files(set)
    for i = 1, #files[set].list do
        if files[set].list[i] then assert(SMODS.load_file(files[set].directory .. files[set].list[i] .. '.lua'))() end
    end
end

for key, value in pairs(files) do
  load_files(key)
end

