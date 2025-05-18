SMODS.Consumable{
    key = "meteor",
    set = "Planet",
    loc_txt = {
        name = "Meteor",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}Stone Flush{}",
            "{C:mult}+5{} Mult and",
            "{C:chips}+10{} chips"
        }
    },
    config = {hand_type = "rob_stone_flush", softlock = true},
    cost = 4,
    atlas = "Consumables",
    pos = {x = 0, y = 0},
    unlocked = true,
    generate_ui = 0,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge("Rock?", get_type_colour(self or card.config, card), nil, 1.2)
		end
}