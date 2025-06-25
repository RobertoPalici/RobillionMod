SMODS.Joker{
    key = 'iss',
    loc_txt = {
        name = "I.S.S.",
        text = {
            "Upgrade the level of",
            "of the played hand",

        }
    },
    rarity = "rob_epic",
    cost = 10,
    atlas = 'Jokers',
    pos = {x = 2, y = 5},
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.hook then
            print("ISS Joker triggered before play")
            local text,disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
            level_up_hand(context.blueprint_card or card, text, nil, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
    end   
}