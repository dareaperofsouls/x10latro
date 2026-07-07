local config = SMODS.current_mod.config
local multiplier = config.multiplier

SMODS.Edition:take_ownership('foil',{config = {chips = 50 * multiplier},weight = 20 * multiplier,})
SMODS.Edition:take_ownership('holo',{config = {mult = 10 * multiplier,},weight = 14 * multiplier,extra_cost = 3 * multiplier,})
SMODS.Edition:take_ownership('polychrome',{config = {x_mult = 1.5 * multiplier},weight = 3 * multiplier, extra_cost = 5 * multiplier,})
SMODS.Edition:take_ownership('negative',{config = {card_limit = 1 * multiplier},weight = 3 * multiplier,extra_cost = 5 * multiplier})