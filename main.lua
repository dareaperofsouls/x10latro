assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()
-- assert(SMODS.load_file("src/boosters.lua"))()
assert(SMODS.load_file("src/editions.lua"))()
assert(SMODS.load_file("src/enhancement.lua"))()
assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/planets.lua"))()
assert(SMODS.load_file("src/pokerhands.lua"))() -- upgrading one time decreases it and then upgrades it, deciding if implementing is better or not
assert(SMODS.load_file("src/seals.lua"))()
-- assert(SMODS.load_file("src/spectrals.lua"))()
-- assert(SMODS.load_file("src/stakes.lua"))() -- stakes should NOT be touched
-- assert(SMODS.load_file("src/stickers.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/tarots.lua"))()
assert(SMODS.load_file("src/vouchers.lua"))() -- Hone and Tycoons have x10 spawn rate, might have to remove it.


-- assert(SMODS.load_file("functions/make_everything_10.lua"))() -- Function that makes everything, mods or vanilla, x10 [WIP]
-- assert(SMODS.load_file("src/stats.lua"))() -- Money, Hands, Hand Size, Discards are x10

