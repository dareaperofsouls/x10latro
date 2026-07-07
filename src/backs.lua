local multiplier = SMODS.current_mod.config.game.multiplier

-- Red Deck
SMODS.Back:take_ownership(
    'red',
    {
        config = {discards = (1*multiplier)}
    }
)

-- Blue Deck
SMODS.Back:take_ownership(
    'blue',
    {
        config = {hands = (1 * multiplier)}
    }
)

-- Yellow Deck
SMODS.Back:take_ownership(
    'yellow',
    {
        config = {dollars = (10 * multiplier)},
    }
)

-- Green Deck
SMODS.Back:take_ownership(
    'green',
    {
        config = {
            extra_hand_bonus = (2 * multiplier),
            extra_discard_bonus = (1 * multiplier),
            no_interest = true
        }
    }
)

-- Black Deck
SMODS.Back:take_ownership(
    'black',
    {
        config = {
            hands = (-1),
            joker_slot = (1 * multiplier),
        }
    }
)

-- Magic Deck
SMODS.Back:take_ownership(
    'magic',
    {
        config = {
            voucher = 'v_crystal_ball',
            amount = 2 * multiplier,
            consumables = {'c_fool', 'c_fool', 'c_fool', 'c_fool', 'c_fool', 'c_fool', 'c_fool', 'c_fool', 'c_fool', 'c_fool',},
        },

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.voucher, card.ability.amount, "The Fool", }}
        end
    }
)

-- Nebula Deck
SMODS.Back:take_ownership(
    'nebula',
    {
        config = {
            voucher = 'v_telescope',
            consumable_slot = (-1),
        }
    }
)

-- Ghost Deck
SMODS.Back:take_ownership(
    'ghost',
    {
        config = {
            spectral_rate = (2 * multiplier) ,
            consumables = {'c_hex', 'c_hex', 'c_hex', 'c_hex', 'c_hex'},
        }
    }
)

-- Abandoned Deck
-- SMODS.Back:take_ownership(
--     'abandoned', {config = {no_faces = true}}
-- ) 

-- Checkered Deck -- need x10 so 260 each
-- SMODS.Back:take_ownership(
--     'checkered', {}
-- )

-- Zodiac Deck
-- SMODS.Back:take_ownership(
--     'zodiac',
--     {
--         config = {
--             vouchers = {'v_tarot_merchant', 'v_planet_merchant', 'v_overstock_norm'},
--         }
--     }
-- )

-- Painted Deck
SMODS.Back:take_ownership(
    'painted',
    {
        config = {
            hand_size = (2 * multiplier),
            joker_slot = -1
        },
    }
)

-- Anaglyph Deck
-- SMODS.Back:take_ownership(
--     'anaglyph',{}
-- ) 

-- Plasma Deck
SMODS.Back:take_ownership(
    'plasma',
    {
        config = {
            ante_scaling = (2 * multiplier)
        }
    }
) 

-- Erratic Deck
-- SMODS.Back:take_ownership(
--     'erratic', {}
-- )