SMODS.Voucher{
    key = "sealionaire",
    set = "Voucher",
    loc_txt = {
        name = "Sealionaire",
        text = {
            "Cards with {C:attention}Seals{} appear",
            "{C:attention}#1#X{} more frequently",
            "in all card packs"
            }
    },
    atlas = 'Vouchers',
    pos = {x = 1, y = 0},
    cost = 10,
    config = {
        extra = 4
    },
    requires = {'v_rob_seal_the_deal'},
    unlocked = true,
    loc_vars = function(self, info_queue)
        return {vars = {self.config.extra}}
    end,
    redeem = function(self)
        local old_create_card = SMODS.create_card

        function SMODS.create_card(t)   
            t.seal = SMODS.poll_seal({mod = 10*self.config.extra})
            return old_create_card(t)
        end
    end


}