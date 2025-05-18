SMODS.Seal{
    key = 'black_seal',
    loc_txt = {
        name = 'Black Seal',
        label = 'Black Seal',
        text = {
            'Gain a {C:attention}random{} Rare {C:attention}Joker{}',
            'when {C:attention}destroyed{}',
        }
    },
    atlas = "Enhancements",
    pos = {x = 2, y = 0},
    discovered = true,
    badge_colour = HEX("3b4d50"),
    config = {
        is_black = true
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.is_black}}
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            -- print('am distrus carte')
            local count = 0
            for k, v in ipairs(context.removed) do
                if v.config then
                    count = count + 1
                end
            end

            if count > 0 then
                -- print('am distrus ' .. count .. ' carti')
                local jokers_to_create = math.min(count, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                -- print('am creat ' .. jokers_to_create .. ' carti')
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, jokers_to_create do 
                            local card = create_card('Joker', G.jokers, nil, 2, nil, nil, nil, 'rif')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
            end
        end
    end
}
