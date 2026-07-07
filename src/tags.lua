local multiplier = SMODS.current_mod.config.game.multiplier

-- -- Uncommon Tag
-- SMODS.Tag:take_ownership('uncommon', {})

-- -- Rare Tag
-- SMODS.Tag:take_ownership('rare', {config = {odds = 3 * multiplier}}) 

-- -- Negative Tag
-- SMODS.Tag:take_ownership('negative', {})

-- -- Foil Tag
-- SMODS.Tag:take_ownership('foil', {}) 

-- -- Holographic Tag
-- SMODS.Tag:take_ownership('holo', {})

-- -- Polychrome Tag
-- SMODS.Tag:take_ownership('polychrome', {})

-- -- Investment Tag
-- SMODS.Tag:take_ownership('investment', {config = {dollars = 25 * multiplier}})

-- -- Voucher Tag
-- SMODS.Tag:take_ownership('voucher', {})

-- -- Boss Tag
-- SMODS.Tag:take_ownership('boss', {})

-- -- Standard Tag
-- SMODS.Tag:take_ownership('standard', {min_ante = 2})

-- -- Charm Tag
-- SMODS.Tag:take_ownership('charm', {}) 

-- -- Meteor Tag
-- SMODS.Tag:take_ownership('meteor', {min_ante = 2})

-- -- Buffoon Tag
-- SMODS.Tag:take_ownership(
--     'buffoon', {min_ante = 2}
-- )

-- -- Handy Tag
-- SMODS.Tag:take_ownership(
--     'handy', {min_ante = 2, config = {dollars_per_hand = 10}}
-- )

-- -- Garbage Tag
-- SMODS.Tag:take_ownership(
--     'garbage', {min_ante = 2, config = {dollars_per_discard = 10}}
-- )

-- -- Ethereal Tag
-- SMODS.Tag:take_ownership(
--     'ethereal', {min_ante = 2}
-- ) 

-- -- Coupon Tag
-- SMODS.Tag: take_ownership(
--     'coupon', {}
-- )

-- -- Double Tag
-- SMODS.Tag:take_ownership(
--     'double', {}
-- )

-- -- Juggle Tag
-- SMODS.Tag:take_ownership('juggle', {config = {h_size = 3 * multiplier}})

-- -- D6 Tag
-- SMODS.Tag:take_ownership(
--     'd_six', {}
-- )

-- -- Top-up Tag
-- SMODS.Tag:take_ownership('top_up', {min_ante = 2, config = {spawn_jokers = 2 * multiplier}})

-- -- Speed Tag
-- SMODS.Tag:take_ownership('skip', {config = {skip_bonus = 5 * multiplier}})

-- -- Orbital Tag
-- SMODS.Tag:take_ownership('orbital', {min_ante = 2, config = {levels = 3 * multiplier}})

-- -- Economy Tag
SMODS.Tag:take_ownership('economy', {config = {max = 40 * multiplier}})