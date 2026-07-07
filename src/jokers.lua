local config = SMODS.current_mod.config.options
local multiplier = SMODS.current_mod.config.game.multiplier

-- local joker_table = {}
-- for i, v in pairs(G.P_CENTERS) do 
--     if v.set == "Joker" then
--         table.insert(joker_table, v)
--     end
-- end

-- for i, v in pairs(joker_table) do

-- end

function loyalty_remaining(x)
    return x .. "remaining"
end

function troubadour_hplays()
    if config.game_playing_hand == true then return -1 * multiplier end
    return -1
end

function merryandy_hsize()
    if config.game_handsize == true then return -1 * multiplier end
    return -1
end

function stuntman_hsize()
    if config.game_handsize == true then return 2 * multiplier end
    return 2
end

function getChance(n)
    if config.chance == true then
        return n * config.multiplier
    end

    return n
end


SMODS.Joker:take_ownership('joker', {config = {mult = (4 * multiplier)}})
SMODS.Joker:take_ownership('greedy_joker', {config = {extra = {s_mult = (3 * multiplier), suit = 'Diamonds'}}})
SMODS.Joker:take_ownership('lusty_joker', {config = {extra = {s_mult = (3 * multiplier), suit = 'Hearts'}}})
SMODS.Joker:take_ownership('wrathful_joker', {config = {extra = {s_mult = (3 * multiplier), suit = 'Spades'}}})
SMODS.Joker:take_ownership('gluttenous_joker', {config = {extra = {s_mult = (3 * multiplier), suit = 'Clubs'}}})
SMODS.Joker:take_ownership('jolly', {config = { t_mult = (8 * multiplier), type = 'Pair' },})
SMODS.Joker:take_ownership('zany', {config = {t_mult = (12 * multiplier), type = 'Three of a Kind',}})
SMODS.Joker:take_ownership('mad', {config = { t_mult = (10 * multiplier), type = 'Two Pair',}})
SMODS.Joker:take_ownership('crazy', {config = { t_mult = (12 * multiplier), type = 'Straight',}})
SMODS.Joker:take_ownership('droll', {order = 10, config = { t_mult = 10 * multiplier, type = 'Flush',}})
SMODS.Joker:take_ownership('sly', { order = 11,  config = { t_chips = 50 * multiplier, type = 'Pair',}})
SMODS.Joker:take_ownership('wily', { order = 12,  config = { t_chips = 100 * multiplier, type = 'Three of a Kind',}})
SMODS.Joker:take_ownership('clever', { order = 13,  config = { t_chips = 80 * multiplier, type = 'Two Pair', }})
SMODS.Joker:take_ownership('devious', { order = 14, config = { t_chips = 100 * multiplier, type = 'Straight',}})
SMODS.Joker:take_ownership('crafty', { order = 15, config = { t_chips = 80 * multiplier, type = 'Flush',}})
SMODS.Joker:take_ownership('half', { order = 16 , config = { extra = { mult = 20 * multiplier, size = 3 * multiplier, }},})

SMODS.Joker:take_ownership(
    'stencil', 
    {
        config = {},

        loc_vars = function(self, info_queue, card)
            local x_mult = 0
            if G.jokers then
                x_mult = G.jokers.config.card_limit - #G.jokers.cards

                for i=1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.name == 'Joker Stencil' then
                        x_mult = x_mult + 1
                    end
                end

                x_mult = math.max(1, x_mult * config.multiplier)
            end

            return {vars = {x_mult}}
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                local x_mult = 0
            
                x_mult = G.jokers.config.card_limit - #G.jokers.cards

                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.name == 'Joker Stencil' then
                        x_mult = x_mult + 1
                    end
                end

                x_mult = math.max(1, x_mult * config.multiplier)

                return {
                    xmult = x_mult
                }
            end
        end
    }
)

SMODS.Joker:take_ownership('four_fingers', { order = 18, config = {}})
SMODS.Joker:take_ownership(
    'mime', 
    { 
        order = 19, 
        config = { extra = 1 * multiplier, },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra }}
        end,
    }
)

SMODS.Joker:take_ownership('credit_card', { order = 20, config = {extra = 20 * multiplier,},})

SMODS.Joker:take_ownership(
    'ceremonial', 
    {
        order = 21, 
        config = { 
            mult = 0
        },

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.mult } }
        end,

        calculate = function(self, card, context)
            if context.setting_blind and not context.blueprint then
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        my_pos = i
                        break
                    end
                end
                if my_pos and G.jokers.cards[my_pos + 1] and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced then
                    local sliced_card = G.jokers.cards[my_pos + 1]
                    sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.joker_buffer = 0
                            -- See note about SMODS Scaling Manipulation on the wiki
                            card.ability.mult = card.ability.mult + sliced_card.sell_cost * (2 * multiplier)
                            card:juice_up(0.8, 0.8)
                            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                            play_sound('slice1', 0.96 + math.random() * 0.08)
                            return true
                        end
                    }))
                    return {
                        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.mult + 2 * sliced_card.sell_cost } },
                        colour = G.C.RED,
                        no_juice = true
                    }
                end
            end
            if context.joker_main then
                return {
                    mult = card.ability.mult
                }
            end
        end
    }
) -- localization

SMODS.Joker:take_ownership('banner', { order = 22, config = {extra = 30 * multiplier},})
SMODS.Joker:take_ownership('mystic_summit', { order = 23, config = { extra = { mult = 15 * multiplier, d_remaining = 0, },},})
SMODS.Joker:take_ownership('marble', { order = 24, config = {extra = 1 * multiplier},}) 
SMODS.Joker:take_ownership('loyalty_card', { order = 25, config = { extra = { Xmult = 4 * multiplier, every = 5 * multiplier, remaining = loyalty_remaining(multiplier) },},})
SMODS.Joker:take_ownership('8_ball', { order = 26, config = {extra = getChance(4)},})
SMODS.Joker:take_ownership('misprint', { order = 27, config = { extra = { max = 23 * multiplier, min = 0}},})
SMODS.Joker:take_ownership('dusk', { order = 28, config = { extra = 1 * multiplier },})

SMODS.Joker:take_ownership(
    'raised_fist', 
    {
        order = 29,
        config = {},

        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.hand and not context.end_of_round then
                local temp_Mult, temp_ID = 15, 15
                local raised_card = nil
                for i = 1, #G.hand.cards do
                    if temp_ID >= G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then
                        temp_Mult = G.hand.cards[i].base.nominal
                        temp_ID = G.hand.cards[i].base.id
                        raised_card = G.hand.cards[i]
                    end
                end
                if raised_card == context.other_card then
                    if context.other_card.debuff then
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED
                        }
                    else
                        return {
                            mult = 20 * temp_Mult
                        }
                    end
                end
            end
        end
    }
)

SMODS.Joker:take_ownership(
    'chaos', 
    {
        order = 30,
        config = {
            extra = 1 * multiplier
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra}}
        end,
        add_to_deck = function(self, card, from_debuff)
            SMODS.change_free_rerolls(card.ability.extra - 1)
        end,
        remove_from_deck = function(self, card, from_debuff)
            SMODS.change_free_rerolls(-card.ability.extra)
        end
    }
)
SMODS.Joker:take_ownership('fibonacci', { order = 31, config = { extra = 8 * multiplier },})
SMODS.Joker:take_ownership('steel_joker', { order = 32, config = { extra = 2 * multiplier },})
SMODS.Joker:take_ownership('scary_face', { order = 33, config = { extra = 30 * multiplier },})
SMODS.Joker:take_ownership('abstract', { order = 34, config = { extra = 3 * multiplier }, })
SMODS.Joker:take_ownership('delayed_grat', { order = 35,  config = { extra = 2 * multiplier },})

SMODS.Joker:take_ownership(
    'hack', 
    { 
        order = 36,  
        config = { extra = 1 * multiplier }, 
        
        loc_vars = function(self, info_queue, card) 
            return { vars = { card.ability.extra } }
        end,
    }
)

SMODS.Joker:take_ownership('pareidolia', { order = 37, config = {},})
SMODS.Joker:take_ownership('gros_michel', { order = 38, config = { extra = { odds = getChance(6), mult = 15 * multiplier }},})
SMODS.Joker:take_ownership('even_steven', { order = 39, config = { extra = 4 * multiplier, }, })
SMODS.Joker:take_ownership('odd_todd', { order = 40,  config = { extra = 31 * multiplier }, })
SMODS.Joker:take_ownership('scholar', { order = 41, config = { extra = { mult = 4 * multiplier, chips = 20 * multiplier,}},})
SMODS.Joker:take_ownership('business', {order = 42, config = { extra = getChance(2)},})
SMODS.Joker:take_ownership('supernova', { order = 43, config = {extra = multiplier},})
SMODS.Joker:take_ownership('ride_the_bus', { order = 44, config = { extra = 1 * multiplier },})
SMODS.Joker:take_ownership ('space', { order = 45,  config = { extra = getChance(4) },})
SMODS.Joker:take_ownership ('egg', { order = 46, config = { extra = 3 * multiplier, },})
SMODS.Joker:take_ownership ('burglar', { order = 47, config = { extra = 3 * multiplier, },})
SMODS.Joker:take_ownership ('blackboard', { order = 48, config = { extra = 3 * multiplier, },})
SMODS.Joker:take_ownership ('runner', { order = 49, config = { extra = { chips = 0, chip_mod = 15 * multiplier,}},})
SMODS.Joker:take_ownership ('ice_cream', { order = 50, config = { extra = { chips = 100 * multiplier, chip_mod = 5 * multiplier,}},})
SMODS.Joker:take_ownership('dna', { order = 51,config = {}}) -- need to dupe x10
SMODS.Joker:take_ownership ('splash', { order = 52, config = {},})
SMODS.Joker:take_ownership ('blue_joker', { order = 53, config = { extra = 2 * multiplier, },})
SMODS.Joker:take_ownership ('sixth_sense', { order = 54, config = {},})
SMODS.Joker:take_ownership ('constellation', { order = 55,  config = {extra = 0.1 * multiplier, Xmult = 1, },})
SMODS.Joker:take_ownership ('hiker', { order = 56, config = { extra = 5 * multiplier, },})
SMODS.Joker:take_ownership ('faceless', { order = 57, config = {extra = {dollars = 5 * multiplier, faces = 3, }},})
SMODS.Joker:take_ownership ('green_joker', {order = 58, config = { extra = { hand_add = 1 * multiplier, discard_sub = 1 * multiplier,}},})
SMODS.Joker:take_ownership('superposition', {order = 59, config = {},})
SMODS.Joker:take_ownership ('todo_list',{order = 60, config = {extra = {dollars = 4 * multiplier, poker_hand = 'High Card',}},})
SMODS.Joker:take_ownership ('cavendish',{order = 61, config = {extra = {odds = getChance(1000),Xmult = 3 * multiplier,}},})
SMODS.Joker:take_ownership ('card_sharp',{order = 62, config = {extra = { Xmult = 3 * multiplier, }},})
SMODS.Joker:take_ownership ('red_card', { order = 63, config = { extra = 3 * multiplier, },})
SMODS.Joker:take_ownership ('madness', { order = 64, config = { extra =  0.5 * multiplier },})
SMODS.Joker:take_ownership ('square', {order = 65, config = {extra = {chips = 0,chip_mod = 4 * multiplier, },},})
SMODS.Joker:take_ownership ('seance', {order = 66, config = {extra = {poker_hand = 'Straight Flush',},},})
SMODS.Joker:take_ownership(
    'riff_raff', 
    {
        order = 67,
        config = {extra = 2 * multiplier},

        calculate = function(self, card, context)
            if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local jokers_to_create = math.min(card.ability.extra,
                    G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _ = 1, jokers_to_create do
                            local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'rif')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_joker'),
                    colour = G.C.BLUE,
                }
            end
        end,
    }
) -- need to reflect 
SMODS.Joker:take_ownership ('vampire', { order = 68, config = { extra = 0.1 * multiplier, Xmult = 1,},})
SMODS.Joker:take_ownership ('shortcut', { order = 69, config = {},})
SMODS.Joker:take_ownership ('hologram', { order = 70, config = {extra = 0.25 * multiplier, Xmult = 1},})
SMODS.Joker:take_ownership ('vagabond', { order = 71, config = {extra = 4 * multiplier},})
SMODS.Joker:take_ownership ('baron', { order = 72, config = {extra = 1.5 * multiplier},})
SMODS.Joker:take_ownership ('cloud_9', { order = 73, config = {extra = 1 * multiplier},})
SMODS.Joker:take_ownership ('rocket', { order = 74, config = {extra = { dollars = 1 * multiplier, increase = 2 * multiplier}},})
SMODS.Joker:take_ownership ('obelisk', { order = 75, config = { extra = 0.2 * multiplier, Xmult = 1,},})
SMODS.Joker:take_ownership ('midas_mask', { order = 76, config = {} })
SMODS.Joker:take_ownership ('luchador', { order = 77, config = {} })
SMODS.Joker:take_ownership ('photograph', { order = 78, config = {extra = 2 * multiplier}})
SMODS.Joker:take_ownership ('gift', { order = 79, config = {extra = 1 * multiplier}})
SMODS.Joker:take_ownership ('turtle_bean', { order = 80, config = { extra = {h_size = 5 * multiplier, h_mod = 1 * multiplier}},})
SMODS.Joker:take_ownership ('erosion', { order = 81, config = {extra = 4 * multiplier}  })
SMODS.Joker:take_ownership ('reserved_parking', { order = 82, config = {extra = {odds = getChance(2), dollars = 1 * multiplier}} })
SMODS.Joker:take_ownership ('mail', { order = 83, config = {extra = 5 * multiplier} })
SMODS.Joker:take_ownership ('to_the_moon', {order = 84, config = {extra = 1 * multiplier}})
SMODS.Joker:take_ownership ('hallucination', { order = 85, config = {extra = getChance(2)}})
SMODS.Joker:take_ownership(
    'fortune_teller', 
    { 
        order = 86, 
        config = { 
            extra = {
                add_mult = 1 * multiplier,
                current_mult = 0
            },
        },

        loc_vars = function(self, info_queue, card)
            return { 
                vars = { 
                    card.ability.extra.add_mult, 
                    card.ability.extra.current_mult
                }
            }
        end,

        calculate = function(self, card, context)
            if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Tarot" then
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.add_mult
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { G.GAME.consumeable_usage_total.tarot * card.ability.extra } },
                }
            end
            if context.joker_main then
                return {
                    mult = card.ability.extra.current_mult
                }
            end
        end,
    }
)

SMODS.Joker:take_ownership ('juggler', { order = 87, config = { h_size = 1 * multiplier },})
SMODS.Joker:take_ownership ('drunkard', { order = 88, config = { d_size = 1 * multiplier },})
SMODS.Joker:take_ownership ('stone', { order = 89, config = {extra = 25 * multiplier}})
SMODS.Joker:take_ownership ('golden', { order = 90, config = {extra = 4 * multiplier}})
SMODS.Joker:take_ownership ('lucky_cat', { order = 91, config = {Xmult = 1, extra = 0.25 * multiplier}})
SMODS.Joker:take_ownership ('baseball', { order = 92, config = {extra = 1.5 * multiplier}})
SMODS.Joker:take_ownership ('bull', { order = 93, config = {extra = 2 * multiplier}})
SMODS.Joker:take_ownership ('diet_cola', { order = 94, config = {}})
SMODS.Joker:take_ownership ('trading', { order = 95, config = {extra = 3 * multiplier}})
SMODS.Joker:take_ownership ('flash', { order = 96, config = {extra = 2 * multiplier, mult = 0}})
SMODS.Joker:take_ownership ('popcorn', {order = 97, config = {mult = 20 * multiplier, extra = 4 * multiplier}})
SMODS.Joker:take_ownership ('trousers', {order = 98, config = {extra = 2 * multiplier}})
SMODS.Joker:take_ownership ('ancient', {order = 99, config = {extra = 1.5 * multiplier}})
SMODS.Joker:take_ownership ('ramen', {order = 100, config = {Xmult = 2 * multiplier, extra = 0.01 * multiplier}})
SMODS.Joker:take_ownership ('walkie_talkie', {order = 101, config = {extra = {chips = 10 * multiplier, mult = 4 * multiplier}}})
SMODS.Joker:take_ownership ('selzer', {order = 102, config = {extra = 5 * multiplier}})
SMODS.Joker:take_ownership ('castle', { order = 103, config = { extra = { chips = 0, chip_mod = 3 * multiplier, },},})
SMODS.Joker:take_ownership ('smiley', {order = 104, config = {extra = 5 * multiplier}})
SMODS.Joker:take_ownership ('campfire', {order = 105, config = {extra = 0.5 * multiplier},})
SMODS.Joker:take_ownership ('ticket', {order = 106, config = {extra = 4 * multiplier}})
SMODS.Joker:take_ownership ('mr_bones', {order = 107, config = {}})
SMODS.Joker:take_ownership ('acrobat', {order = 108, config = {extra = 3 * multiplier}})
SMODS.Joker:take_ownership ('sock_and_buskin', {order = 109, config = {extra = 1 * multiplier}}) -- localization 

-- something wrong
SMODS.Joker:take_ownership (
    'swashbuckler', 
    {
        order = 110, 
        config = {mult = 1 * multiplier},
        calculate = function(self, card, context)
            if context.joker_main then
                local sell_cost = 0
                for _, joker in ipairs(G.jokers.cards) do
                    if joker ~= card then
                        sell_cost = (sell_cost + joker.sell_cost)
                    end
                end
                return {
                    mult = card.ability.extra.mult * sell_cost
                }
            end
        end,
    }
)

SMODS.Joker:take_ownership('troubadour', {order = 111, config = {extra = {h_size = 2 * multiplier ,h_plays = troubadour_hplays()}}})
SMODS.Joker:take_ownership ('certificate', {order = 112, config = {}})
SMODS.Joker:take_ownership ('smeared', {order = 113, config = {}})
SMODS.Joker:take_ownership ('throwback', {order = 114, config = {extra = 0.25 * multiplier}})
SMODS.Joker:take_ownership ('hanging_chad', {order = 115, config = {extra = 2 * multiplier}})
SMODS.Joker:take_ownership('rough_gem', { order = 116, config = { extra = 1 * multiplier },})
SMODS.Joker:take_ownership('bloodstone', { order = 117, config = { extra = { odds = getChance(2), Xmult = 1.5 * multiplier, }},})
SMODS.Joker:take_ownership('arrowhead', { order = 118, config = { extra = 50 * multiplier },})
SMODS.Joker:take_ownership('onyx_agate', { order = 119, config = { extra = 7 * multiplier },})
SMODS.Joker:take_ownership ('glass', { order = 120, config = { extra = 0.75 * multiplier, Xmult = 1,},})
SMODS.Joker:take_ownership ('ring_master', { order = 121, config = {}, })
SMODS.Joker:take_ownership ('flower_pot', {order = 122,config = {extra = 3 * multiplier,},})
SMODS.Joker:take_ownership ('blueprint', {order = 123, config = {}})
SMODS.Joker:take_ownership ('wee', {order = 124, config = {extra = {chips = 0, chip_mod = 8 * multiplier}}})
SMODS.Joker:take_ownership('merry_andy', {order = 125, config = {d_size = 3 * multiplier, h_size = merryandy_hsize()}})
SMODS.Joker:take_ownership ('oops', {order = 126, config = {type='chip score', chips = 10000}})
SMODS.Joker:take_ownership ('idol', {order = 127, config = {extra = 2 * multiplier}})
SMODS.Joker:take_ownership ('seeing_double', {order = 128, config = { extra = 2 * multiplier }})
SMODS.Joker:take_ownership ('matador', {order = 129, config = {extra = 8 * multiplier}})
SMODS.Joker:take_ownership ('hit_the_road', {order = 130, config = {extra = 0.5 * multiplier}})
SMODS.Joker:take_ownership ('duo', {order = 131, config = {Xmult = 2 * multiplier, type = 'Pair'}})
SMODS.Joker:take_ownership ('trio', {order = 132, config = {Xmult = 3 * multiplier, type = 'Three of a Kind'}})
SMODS.Joker:take_ownership ('family', {order = 133, config = {Xmult = 4 * multiplier, type = 'Four of a Kind'}})
SMODS.Joker:take_ownership ('order', {order = 134, config = {Xmult = 3 * multiplier, type = 'Straight'}})
SMODS.Joker:take_ownership ('tribe', {order = 135, config = {Xmult = 2 * multiplier, type = 'Flush'}})
SMODS.Joker:take_ownership('stuntman', { order = 126, config = {extra = {h_size = stuntman_hsize(), chip_mod = 250 * multiplier}}})
SMODS.Joker:take_ownership ('invisible', { order = 137, config = { extra = 2 * multiplier,}, })
SMODS.Joker:take_ownership ('brainstorm', { order = 138, config = {},})
SMODS.Joker:take_ownership ('satellite', { order = 139, config = { extra = 1 * multiplier },})
SMODS.Joker:take_ownership ('shoot_the_moon', {order = 140, config = {extra = (13 * multiplier) },})
SMODS.Joker:take_ownership('drivers_license', {order = 141, config = {extra = 3 * multiplier}})
SMODS.Joker:take_ownership('cartomancer', {order = 142, config = {}}) -- x10, and localization
SMODS.Joker:take_ownership ('astronomer', {order = 143, config = {}, } )
SMODS.Joker:take_ownership('burnt', {order = 144, config = {h_size = 0, extra = 4}}) -- add multiplier and localization
SMODS.Joker:take_ownership ('bootstraps', {order = 145,  config = { extra = { mult = 2 * multiplier, dollars = 5 * multiplier, },},})
SMODS.Joker:take_ownership ('caino', {order = 146, config = { extra = 1 * multiplier,},})
SMODS.Joker:take_ownership ('triboulet', {order = 147,  config = { extra = 2 * multiplier,},})
SMODS.Joker:take_ownership ('yorick', {order = 148,  config = { extra = { xmult = 1 * multiplier, discards = 23 * multiplier, },},})
SMODS.Joker:take_ownership ('chicot', {order = 149,  config = {},})
SMODS.Joker:take_ownership ('perkeo', {order = 150, config = {},})