local multiplier = SMODS.current_mod.config.game.multiplier

SMODS.Seal:take_ownership(
    'red',{
        config = {
            extra = 1 * multiplier,
        },

        calculate = function(self, card, context)
            if context.repetition then
                return {
                    repetitions = card.ability.seal.extra,
                }
            end
        end,
    }
)
SMODS.Seal:take_ownership('blue',{config = {},})
SMODS.Seal:take_ownership(
    'gold',{
        config = {
            extra = 3 * multiplier,
        },

        get_p_dollars = function(self, card)
            return card.ability.seal.extra
        end,
        loc_vars = function(self, info_queue, card)
            return { vars = { self.config.extra } }
        end,
    }
)
SMODS.Seal:take_ownership('purple',{config = {},})