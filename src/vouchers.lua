SMODS.Voucher:take_ownership(
    'overstock_norm', 
    {
        cost = 100, 
        config = {extra = 10},
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,

        redeem = function(self, card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_shop_size(card.ability.extra)
                    return true
                end
            }))
        end,
    }
)

SMODS.Voucher:take_ownership(
    'overstock_plus', 
    {
        cost = 100, 
        config = {extra = 10},
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,

        redeem = function(self, card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_shop_size(card.ability.extra)
                    return true
                end
            }))
        end,
    }
)

SMODS.Voucher:take_ownership('clearance_sale', {cost = 100, config = {extra = 250}})
SMODS.Voucher:take_ownership('liquidation', {cost = 100, config = {extra = 500}})

SMODS.Voucher:take_ownership('home', {cost = 100, config = {extra = 20}})
SMODS.Voucher:take_ownership('glow_up', {cost = 100, config = {extra = 40}})

SMODS.Voucher:take_ownership('reroll_surplus', {cost = 100, config = {extra = 20}})
SMODS.Voucher:take_ownership('reroll_glut', {cost = 100, config = {extra = 20}})

SMODS.Voucher:take_ownership(
    'crystal_ball', 
    {
        cost = 100, 
        config = {
            extra = 10
        },
        redeem = function(self, card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra
                    return true
                end
            }))
        end
    }
)
SMODS.Voucher:take_ownership('omen_globe', {cost = 100, config = {extra = 40}})

SMODS.Voucher:take_ownership('telescope', {cost = 100, config = {extra = 30}})
SMODS.Voucher:take_ownership('observatory', {cost = 100, config = {extra = 15}})

SMODS.Voucher:take_ownership('grabber', {cost = 100, config = {extra = 10}})
SMODS.Voucher:take_ownership('nacho_tong', {cost = 100, config = {extra = 10}})

SMODS.Voucher:take_ownership('wasteful', {cost = 100, config = {extra = 10}})
SMODS.Voucher:take_ownership('recyclomancy', {cost = 100, config = {extra = 10}})

SMODS.Voucher:take_ownership('tarot_merchant', {cost = 100, config = {extra = 96/40, extra_disp = 20}})
SMODS.Voucher:take_ownership('tarot_tycoon', {cost = 100, config = {extra = 320/40, extra_disp = 40}})

SMODS.Voucher:take_ownership('planet_merchant', {cost = 100, config = {extra = 96/40, extra_disp = 20}})
SMODS.Voucher:take_ownership('planet_tycoon', {cost = 100, config = {extra = 320/40, extra_disp = 40}})

SMODS.Voucher:take_ownership('seed_money', {cost = 100, config = {extra = 500}})
SMODS.Voucher:take_ownership('money_tree', {cost = 100, config = {extra = 1000}})

SMODS.Voucher:take_ownership('blank', {cost = 100, config = {extra = 50}})
SMODS.Voucher:take_ownership(
    'antimatter', 
    {
        cost = 100, 
        config = {extra = 10},
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,

        redeem = function(self, card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra
                    end
                    return true
                end,
            }))
        end,
    }
)

SMODS.Voucher:take_ownership('magic_trick', {cost = 100, config = {extra = 40}})
SMODS.Voucher:take_ownership('illusion', {cost = 100, config = {extra = 40}})

SMODS.Voucher:take_ownership(
    'hieroglyph', 
    {
        cost = 100, 
        config = {
            extra = {
                reduce_ante = 10,
                reduce_hands = 1,
            },
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.reduce_ante, card.ability.extra.reduce_hands
                }
            }
        end,
        
        redeem = function(self,card)
            ease_ante(-card.ability.extra.reduce_ante)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.reduce_ante

            -- Apply hand change
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.reduce_hands
            ease_hands_played(-card.ability.extra.reduce_hands)
        end
    }
)

SMODS.Voucher:take_ownership(
    'petroglyph', 
    {
        cost = 100, 
        config = {
            extra = {
                reduce_ante = 10,
                reduce_discard = 1,
            },
        },
        loc_vars = function(self, info_queue, card)
            return { 
                vars = { 
                    card.ability.extra.reduce_ante, card.ability.extra.reduce_discard
                }
            }
        end,

        redeem = function(self, card)
            -- Apply ante change
            ease_ante(-card.ability.extra.reduce_ante)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.reduce_ante

            -- Apply discard change
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.reduce_discard
            ease_discard(-card.ability.extra.reduce_discard)
        end,
    }
)

SMODS.Voucher:take_ownership('directors_cut', {cost = 100, config = {extra = 100}})
SMODS.Voucher:take_ownership('retcon', {cost = 100, config = {extra = 100}})

SMODS.Voucher:take_ownership(
    'paint_brush', 
    {
        cost = 100, 
        config = {
            extra = 10
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,
        redeem = function(self, card)
            G.hand:change_size(card.ability.extra)
        end
    }
)

SMODS.Voucher:take_ownership(
    'palette', 
    {
        cost = 100, 
        config = {extra = 10},
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,
        redeem = function(self, card)
            G.hand:change_size(card.ability.extra)
        end,
    }
)



