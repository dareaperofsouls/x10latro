-- Red Deck
SMODS.Back:take_ownership(
    'red',
    {
        config = {discards = 10}
    }
)

-- Blue Deck
SMODS.Back:take_ownership(
    'blue',
    {
        config = {hands = 10}
    }
)

-- Yellow Deck
SMODS.Back:take_ownership(
    'yellow',
    {
        config = {dollars = 100},
    }
)

-- Green Deck
SMODS.Back:take_ownership(
    'green',
    {
        config = {
            extra_hand_bonus = 20,
            extra_discard_bonus = 10,
            no_interest = true
        }
    }
)

-- Black Deck
SMODS.Back:take_ownership(
    'black',
    {
        config = {
            hands = -1,
            joker_slot = 10,
        }
    }
)

-- Magic Deck
SMODS.Back:take_ownership(
    'magic',
    {
        config = {
            voucher = 'v_crystal_ball',
            consumables = {'c_fool', 'c_fool'},
        }
    }
)

-- Nebula Deck
SMODS.Back:take_ownership(
    'nebula',
    {
        config = {
            voucher = 'v_telescope',
            consumable_slot = -1,
        }
    }
)

-- Ghost Deck
SMODS.Back:take_ownership(
    'ghost',
    {
        config = {
            spectral_rate = 20,
            consumables = {'c_hex'},
        }
    }
)

-- Abandoned Deck
SMODS.Back:take_ownership(
    'abandoned', {config = {no_faces = true}}
) 

-- Checkered Deck -- need x10 so 260 each
SMODS.Back:take_ownership(
    'checkered', {}
)

-- Zodiac Deck
SMODS.Back:take_ownership(
    'zodiac',
    {
        config = {
            vouchers = {'v_tarot_merchant', 'v_planet_merchant', 'v_overstock_norm'},
        }
    }
)

-- Painted Deck
SMODS.Back:take_ownership(
    'painted',
    {
        config = {
            hand_size = 20,
            joker_slot = -1
        },
    }
)

-- Anaglyph Deck
SMODS.Back:take_ownership(
    'anaglyph',{}
) 

-- Plasma Deck
SMODS.Back:take_ownership(
    'plasma',
    {
        config = {
            ante_scaling = 20
        }
    }
) 

-- Erratic Deck
SMODS.Back:take_ownership(
    'erratic', {}
)