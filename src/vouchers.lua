local multiplier = SMODS.current_mod.config.game.multiplier

SMODS.Voucher:take_ownership(
    'overstock_norm', 
    {
        config = {extra = 1 * multiplier},
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
        config = {extra = 1 * multiplier},
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

SMODS.Voucher:take_ownership('clearance_sale', {config = {extra = 25 * multiplier}})
SMODS.Voucher:take_ownership('liquidation', {config = {extra = 50 * multiplier}})

SMODS.Voucher:take_ownership('hone', {config = {extra = 2 * multiplier}})
SMODS.Voucher:take_ownership('glow_up', {config = {extra = 4 * multiplier}})

SMODS.Voucher:take_ownership('reroll_surplus', {config = {extra = 2 * multiplier}})
SMODS.Voucher:take_ownership('reroll_glut', {config = {extra = 2 * multiplier}})

SMODS.Voucher:take_ownership(
    'crystal_ball', 
    {
        config = {
            extra = 1 * multiplier
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,
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
SMODS.Voucher:take_ownership('omen_globe', {config = {extra = 4 * multiplier}})

SMODS.Voucher:take_ownership('telescope', {config = {extra = 3 * multiplier}})
SMODS.Voucher:take_ownership('observatory', {config = {extra = 1.5 * multiplier}})

SMODS.Voucher:take_ownership('grabber', {config = {extra = 1 * multiplier}})
SMODS.Voucher:take_ownership('nacho_tong', {config = {extra = 1 * multiplier}})

SMODS.Voucher:take_ownership('wasteful', {config = {extra = 1 * multiplier}})
SMODS.Voucher:take_ownership('recyclomancy', {config = {extra = 1 * multiplier}})

SMODS.Voucher:take_ownership('tarot_merchant', {config = {extra = (9.6/4 *multiplier), extra_disp = (2 * multiplier)}})
SMODS.Voucher:take_ownership('tarot_tycoon', {config = {extra = (32/4 * multiplier), extra_disp = (4 * multiplier)}})

SMODS.Voucher:take_ownership('planet_merchant', {config = {extra = (9.6/4 *multiplier), extra_disp = (2 * multiplier)}})
SMODS.Voucher:take_ownership('planet_tycoon', {config = {extra = (32/4 * multiplier), extra_disp = (4 * multiplier)}})

SMODS.Voucher:take_ownership('seed_money', {config = {extra = 50 * multiplier}})
SMODS.Voucher:take_ownership('money_tree', {config = {extra = 100 * multiplier}})

SMODS.Voucher:take_ownership('blank', {config = {extra = 5 * multiplier}})
SMODS.Voucher:take_ownership(
    'antimatter', 
    {
        config = {extra = 1 * multiplier},
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

SMODS.Voucher:take_ownership('magic_trick', {config = {extra = 4 * multiplier}})
SMODS.Voucher:take_ownership('illusion', {config = {extra = 4 * multiplier}})

SMODS.Voucher:take_ownership(
    'hieroglyph', 
    {
        config = {
            extra = {
                reduce_ante = 1 * multiplier,
                reduce_hands = 1 * multiplier,
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
        config = {
            extra = {
                reduce_ante = 1 * multiplier,
                reduce_discard = 1 * multiplier,
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

SMODS.Voucher:take_ownership('directors_cut', {config = {extra = 10 * multiplier}})
SMODS.Voucher:take_ownership('retcon', {config = {extra = 10 * multiplier}})

SMODS.Voucher:take_ownership(
    'paint_brush', 
    {
        config = {
            extra = 1 * multiplier
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
        config = {extra = 1 * multiplier},
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,
        redeem = function(self, card)
            G.hand:change_size(card.ability.extra)
        end,
    }
)



