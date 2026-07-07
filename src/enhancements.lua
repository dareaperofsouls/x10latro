local config = SMODS.current_mod.config.options
local multiplier = SMODS.current_mod.config.game.multiplier

function getChance(n)
    if config.chance == true then
        return n * multiplier
    end

    return n
end

SMODS.Enhancement:take_ownership('bonus', {config = {bonus = 30 * multiplier}})
SMODS.Enhancement:take_ownership('mult', {config = {mult = 4 * multiplier}})
SMODS.Enhancement:take_ownership('wild', {})
SMODS.Enhancement:take_ownership('glass', {config = {Xmult = 2 * multiplier, extra = getChance(4)}})
SMODS.Enhancement:take_ownership('steel', {config = {h_x_mult = 1.5 * multiplier}})
SMODS.Enhancement:take_ownership('stone', {config = {bonus = 50 * multiplier}})
SMODS.Enhancement:take_ownership('gold', {config = {h_dollars = 3 * multiplier}})
SMODS.Enhancement:take_ownership('lucky', {config = {mult = 20 * multiplier, p_dollars = 20 * multiplier}})

-- SMODS.Enhancement:take_ownership(
--     'lucky', 
--     {
--         config = {
--             mult = 20 * multiplier, 
--             p_dollars = 20 * multiplier,
--             mult_odds = getChance(5),
--             dollars_odds = getChance(15),
--         },

--         -- these code were staightup copied for vanillaremade, will implement my own soon
--         loc_vars = function(self, info_queue, card)
--             local mult_numerator, mult_denominator = SMODS.get_probability_vars(card, 1, card.ability.mult_odds,
--                 'vremade_lucky_mult')
--             local dollars_numerator, dollars_denominator = SMODS.get_probability_vars(card, 1,
--                 card.ability.dollars_odds, 'vremade_lucky_money')
--             return { vars = { mult_numerator, dollars_numerator, card.ability.mult, mult_denominator, card.ability.dollars, dollars_denominator } }
--         end,
--         calculate = function(self, card, context)
--             if context.main_scoring and context.cardarea == G.play then
--                 local ret = {}
--                 if SMODS.pseudorandom_probability(card, 'vremade_lucky_mult', 1, card.ability.mult_odds) then
--                     card.lucky_trigger = true
--                     ret.mult = card.ability.mult
--                 end
--                 if SMODS.pseudorandom_probability(card, 'vremade_lucky_money', 1, card.ability.dollars_odds) then
--                     card.lucky_trigger = true
--                     ret.dollars = card.ability.dollars
--                 end
--                 -- 'lucky_trigger' is for Lucky Cat. Steamodded cleans this particular variable up for you, but in the general case you should do this:
--                 --[[
--                 G.E_MANAGER:add_event(Event {
--                 func = function()
--                     card.lucky_trigger = nil
--                     return true
--                 end
--                 )
--                 --]]
--                 return ret
--             end
--         end,

--     }
-- )