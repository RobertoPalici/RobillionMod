SMODS.Joker{
    key = 'boss_raider',
    loc_txt = {
        name = 'Boss Raider',
        text = {
            'Skipping the {C:attention}Small Blind{}',
            'and {C:attention}Big Blind{} this ante',
            'will disable the {C:attention}Boss Blind{} effect'
        }
    },
    discovered = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
    atlas = 'Jokers',
    pos = {x = 2, y = 4},
    config = {
        skips = 0
    },
    calculate = function(self, card, context)
        if context.setting_blind then
            -- print('Boss Raider Joker: ', card.ability.skips)
            if card.ability.skips == 2 and context.blind.boss and not card.getting_sliced and not context.blueprint then
                    G.E_MANAGER:add_event(Event({func = function()
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.blind:disable()
                        play_sound('timpani')
                        delay(0.4)
                        return true end }))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
                return true end }))
            end
            card.ability.skips = 0
        end
        if context.skip_blind then
            card.ability.skips = card.ability.skips + 1
            -- print('Boss Raider Joker Skips: ', card.ability.skips)
        end
    end
}