xalatro = {}
xalatro.config = SMODS.current_mod.user_config
-- xalatro.save_mod_config(xalatro)
-- xalatro.mult_config = SMODS.current_mod.game_config
-- print("Multiplier: " .. xalatro.game_config.multiplier)

assert(SMODS.load_file("functions/splash_screen.lua"))()

assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()
assert(SMODS.load_file("src/enhancements.lua"))()
assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/seals.lua"))()
assert(SMODS.load_file("src/stakes.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))() -- Hone and Tycoons have x10 spawn rate, might have to remove it.

assert(SMODS.load_file("functions/multiply.lua"))() -- Function that makes mods x10 [WIP]

assert(SMODS.load_file("ui.lua"))()