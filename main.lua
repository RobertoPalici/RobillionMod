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
        },
        directory = 'jokers/'
    },
    poker_hands = {
        list = {
            "stone_flush"
        },
        directory = 'poker_hands/'
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
        print("Resizing Massive Joker in set_ability")
        self.T.h = self.T.h * 1.35 
        self.T.w = self.T.w * 1.35 
        --print("New dimensions - Width:", self.T.w, "Height:", self.T.h)
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

