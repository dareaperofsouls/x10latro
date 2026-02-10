SMODS.Edition:take_ownership(
    'foil',
    {
        config = {
            chips = 500
        },
        weight = 200,
    }
)

SMODS.Edition:take_ownership(
    'holo',
    {
        config = {
            mult = 100,
        },
        weight = 140,
        extra_cost = 30,
    }
) 

SMODS.Edition:take_ownership(
    'polychrome',
    {
        config = {
            x_mult = 15
        },
        weight = 30,
        extra_cost = 50,
    }
)

SMODS.Edition:take_ownership(
    'negative',
    {
        config = {
            card_limit = 10
        },
        weight = 30,
        extra_cost = 50
    }
)