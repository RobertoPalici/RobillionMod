SMODS.PokerHand{
    key = 'stone_flush',
    mult = 200,
    chips = 10,
    l_mult = 20,
    l_chips = 10,
    l_chips_base = 50,
    l_chips_scaling = 5,
    visible = false,
    example = {
        { "S_2", true, "m_stone" },
        { "S_2", true, "m_stone" },
        { "S_2", true, "m_stone" },
        { "S_2", true, "m_stone" },
        { "S_2", true, "m_stone" }
    },
    loc_txt = {
        name = 'Stone Flush',
        description = {
            '5 cards with the Stone enhancement'
        }
    },
    evaluate = function(parts)
        return parts.rob_sf_base
    end,
}

SMODS.PokerHandPart {
    key = 'sf_base',
    func = function(hand)
      if #hand < 5 then return {} end
      local ret = {}
      local stones = 0
      for i = 1, #hand do
        local v = hand[i].base.value
        if v then
          if hand[i].ability.name == "Stone Card" and not hand[i]:is_face() and stones < 5 then
            stones = stones + 1
            table.insert(ret, hand[i])
          end
        end
      end
      if stones >= 5 and #ret >= 5 then
        return { ret }
      else
        return {}
      end
    end
}