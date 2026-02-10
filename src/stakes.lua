SMODS.Stake:take_ownership('white', {})
SMODS.Stake:take_ownership('red', {})

-- SMODS.Stake:take_ownership(
--     'red', 
--     {
--         applied_stakes = { "white" },
--         modifiers = function()
--             G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
--             G.GAME.modifiers.no_blind_reward.Small = true
--         end,
--         colour = G.C.RED,
--     }
-- )

SMODS.Stake:take_ownership(
    name = "Green Stake",
    key = "green",
    unlocked_stake = "black",
    applied_stakes = { "red" },
    pos = { x = 2, y = 0 },
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.GREEN,
)

SMODS.Stake {
    name = "Black Stake",
    key = "black",
    unlocked_stake = "blue",
    applied_stakes = { "green" },
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_eternals_in_shop = true
    end,
    colour = G.C.BLACK,
}

SMODS.Stake {
    name = "Blue Stake",
    key = "blue",
    unlocked_stake = "purple",
    applied_stakes = { "black" },
    pos = { x = 3, y = 0 },
    sticker_pos = { x = 4, y = 0 },
    modifiers = function()
        G.GAME.starting_params.discards = G.GAME.starting_params.discards - 1
    end,
    colour = G.C.BLUE,
}

SMODS.Stake {
    name = "Purple Stake",
    key = "purple",
    unlocked_stake = "orange",
    applied_stakes = { "blue" },
    pos = { x = 0, y = 1 },
    sticker_pos = { x = 1, y = 1 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.PURPLE,
}

SMODS.Stake {
    name = "Orange Stake",
    key = "orange",
    unlocked_stake = "gold",
    applied_stakes = { "purple" },
    pos = { x = 1, y = 1 },
    sticker_pos = { x = 2, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_perishables_in_shop = true
    end,
    colour = G.C.ORANGE,
}

SMODS.Stake {
    name = "Gold Stake",
    key = "gold",
    applied_stakes = { "orange" },
    pos = { x = 2, y = 1 },
    sticker_pos = { x = 3, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_rentals_in_shop = true
    end,
    colour = G.C.GOLD,
    shiny = true,
}