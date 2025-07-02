SMODS.Voucher{
    key = "seal_the_deal",
    set = "Voucher",
    loc_txt = {
        name = "Seal the Deal",
        text = {
            "Cards with {C:attention}Seals{} appear",
            "{C:attention}#1#X{} more frequently",
            "in all card packs"
        }
    },
    atlas = 'Vouchers',
    pos = {x = 0, y = 0},
    cost = 10,
    config = {
        extra = 2
    },
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