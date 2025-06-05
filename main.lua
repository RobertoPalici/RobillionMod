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
            "jack_black",
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

