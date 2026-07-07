local multiplier = SMODS.current_mod.config.game.multiplier

SMODS.Stake:take_ownership(
    'green',
    {
        modifiers = function()
            G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + multiplier
        end,
    }
)

local function getBlueStakeDiscards()
    if config.game_playing_discard == true then
        return 1 * multiplier
    end

    return 1
end

SMODS.Stake:take_ownership(
    'blue',
    {
        -- loc_vars = function(self)
        --     return { vars = { "10" } }
        -- end,

        modifiers = function()
            G.GAME.starting_params.discards = G.GAME.starting_params.discards - getBlueStakeDiscards()
        end,
    }
)

SMODS.Stake:take_ownership(
    'purple',
    {
        modifiers = function()
            G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + multiplier
        end,
    }
)