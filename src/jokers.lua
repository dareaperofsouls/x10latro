SMODS.Joker:take_ownership('joker', { order = 1, cost = 20, config = {mult = 40}})
SMODS.Joker:take_ownership('greedy_joker', { order = 2, cost = 50, config = {extra = { s_mult = 30, suit = 'Diamonds'}}})
SMODS.Joker:take_ownership('lusty_joker', { order = 3, cost = 50, config = {extra = { s_mult = 30, suit = 'Hearts'}}})
SMODS.Joker:take_ownership('wrathful_joker', { order = 4, cost = 50, config = {extra = { s_mult = 30, suit = 'Spades'}}})
SMODS.Joker:take_ownership('gluttenous_joker', { order = 5, cost = 50, config = {extra = { s_mult = 30, suit = 'Clubs'}}})
SMODS.Joker:take_ownership('jolly', { order = 6, cost = 30, config = { t_mult = 80, type = 'Pair' },})
SMODS.Joker:take_ownership('zany', { order = 7, cost = 40, config = { t_mult = 120, type = 'Three of a Kind',}})
SMODS.Joker:take_ownership('mad', { order = 8, cost = 40, config = { t_mult = 100, type = 'Two Pair',}})
SMODS.Joker:take_ownership('crazy', { order = 9, cost = 40, config = { t_mult = 120, type = 'Straight',}})
SMODS.Joker:take_ownership('droll', { order = 10, cost = 40, config = { t_mult = 100, type = 'Flush',}})
SMODS.Joker:take_ownership('sly', { order = 11, cost = 30, config = { t_chips = 500, type = 'Pair',}})
SMODS.Joker:take_ownership('wily', { order = 12, cost = 40, config = { t_chips = 1000, type = 'Three of a Kind',}})
SMODS.Joker:take_ownership('clever', { order = 13, cost = 40, config = { t_chips = 800, type = 'Two Pair', }})
SMODS.Joker:take_ownership('devious', { order = 14, cost = 40, config = { t_chips = 1000, type = 'Straight',}})
SMODS.Joker:take_ownership('crafty', { order = 15, cost = 40, config = { t_chips = 800, type = 'Flush',}})
SMODS.Joker:take_ownership('half', { order = 16, cost = 50, config = { extra = { mult = 200, size = 30, }},})

SMODS.Joker:take_ownership(
    'stencil', 
    {
        order = 17,
        cost = 80,
        config = {},

        loc_vars = function(self, info_queue, card)
            local x_mult = 0
            if G.jokers then
                x_mult = G.jokers.config.card_limit - #G.jokers.cards

                for i=1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.name == 'Joker Stencil' then
                        x_mult = x_mult * 10
                    end
                end

                x_mult = math.max(1, x_mult * 10)
            end

            return {
                vars = {
                    x_mult
                }
            }
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                local x_mult = 0
            
                x_mult = G.jokers.config.card_limit - #G.jokers.cards

                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.name == 'Joker Stencil' then
                        x_mult = x_mult * 10
                    end
                end

                x_mult = math.max(1, x_mult * 2)

                return {
                    xmult = x_mult
                }
            end
        end
    }
)

SMODS.Joker:take_ownership('four_fingers', { order = 18, cost = 70, config = {}})
SMODS.Joker:take_ownership(
    'mime', 
    { 
        order = 19, 
        cost = 50, 
        config = { extra = 10, },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra }}
        end,
    }
)
SMODS.Joker:take_ownership('credit_card', { order = 20, cost = 10, config = {extra = 200,},})

SMODS.Joker:take_ownership(
    'ceremonial', 
    {
        order = 21, 
        cost = 60,
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
                            card.ability.mult = card.ability.mult + sliced_card.sell_cost * 20
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
)

SMODS.Joker:take_ownership('banner', { order = 22, cost = 50, config = {extra = 300},})
SMODS.Joker:take_ownership('mystic_summit', { order = 23, cost = 50, config = { extra = { mult = 150, d_remaining = 0, },},})
SMODS.Joker:take_ownership('marble', { order = 24, cost = 60, config = {extra = 10},}) 
SMODS.Joker:take_ownership('loyalty_card', { order = 25, cost = 50, config = { extra = { Xmult = 40, every = 50, remaining = "50 remaining" },},})
SMODS.Joker:take_ownership('8_ball', { order = 26, cost = 50, config = {extra = 40},})
SMODS.Joker:take_ownership('misprint', { order = 27, cost = 40, config = { extra = { max = 230, min = 0}},})
SMODS.Joker:take_ownership('dusk', { order = 28, cost = 50, config = { extra = 10 },})

SMODS.Joker:take_ownership(
    'raised_fist', 
    {
        order = 29,
        cost = 50,
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
        cost = 40,
        config = {
            extra = 10
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
SMODS.Joker:take_ownership('fibonacci', { order = 31, cost = 80, config = { extra = 80 },})
SMODS.Joker:take_ownership('steel_joker', { order = 32, cost = 70, config = { extra = 2 },})
SMODS.Joker:take_ownership('scary_face', { order = 33, cost = 40, config = { extra = 300 },})
SMODS.Joker:take_ownership('abstract', { order = 34, cost = 40, config = { extra = 30 }, })
SMODS.Joker:take_ownership('delayed_grat', { order = 35, cost = 40, config = { extra = 20 },})
SMODS.Joker:take_ownership('hack', { order = 36, cost = 60, config = { extra = 10 },})
SMODS.Joker:take_ownership('pareidolia', { order = 37, cost = 50, config = {},})
SMODS.Joker:take_ownership('gros_michel', { order = 38, cost = 50, config = { extra = { odds = 60, mult = 150 }},})
SMODS.Joker:take_ownership('even_steven', { order = 39, cost = 40, config = { extra = 40, }, })
SMODS.Joker:take_ownership('odd_todd', { order = 40,  cost = 40, config = { extra = 310 }, })
SMODS.Joker:take_ownership('scholar', { order = 41, cost = 40, config = { extra = { mult = 40, chips = 200,}},})
SMODS.Joker:take_ownership('business', { order = 42, cost = 40, config = { extra = 20 },})
SMODS.Joker:take_ownership('supernova', { order = 43, cost = 50, config = { extra = 10 },})
SMODS.Joker:take_ownership('ride_the_bus', { order = 44, cost = 60, config = { extra = 10 },})
SMODS.Joker:take_ownership ('space', { order = 45, cost = 50, config = { extra = 40 },})
SMODS.Joker:take_ownership ('egg', { order = 46, cost = 40, config = { extra = 30, },})
SMODS.Joker:take_ownership ('burglar', { order = 47, cost = 60, config = { extra = 30, },})
SMODS.Joker:take_ownership ('blackboard', { order = 48, cost = 60, config = { extra = 30, },})
SMODS.Joker:take_ownership ('runner', { order = 49, cost = 50, config = { extra = { chips = 0, chip_mod = 150,}},})
SMODS.Joker:take_ownership ('ice_cream', { order = 50, cost = 50, config = { extra = { chips = 1000, chip_mod = 50,}},})
SMODS.Joker:take_ownership('dna', { order = 51, cost = 80,config = {}}) -- need to dupe x10
SMODS.Joker:take_ownership ('splash', { order = 52, cost = 30, config = {},})
SMODS.Joker:take_ownership ('blue_joker', { order = 53, cost = 50, config = { extra = 20, },})
SMODS.Joker:take_ownership ('sixth_sense', { order = 54, cost = 60, config = {},})
SMODS.Joker:take_ownership ('constellation', { order = 55, cost = 60, config = {extra = 1, Xmult = 10, },})
SMODS.Joker:take_ownership ('hiker', { order = 56, cost = 50, config = { extra = 50, },})
SMODS.Joker:take_ownership ('faceless', { order = 57, cost = 40, config = {extra = {dollars = 50,faces = 30, }},})
SMODS.Joker:take_ownership ('green_joker', { order = 58,cost = 40, config = { extra = { hand_add = 10, discard_sub = 10,}},})
SMODS.Joker:take_ownership('superposition', {order = 59, cost = 40, config = {},})
SMODS.Joker:take_ownership ('todo_list',{order = 60, cost = 40, config = {extra = {dollars = 40,poker_hand = 'High Card',}},})
SMODS.Joker:take_ownership ('cavendish',{order = 61,cost = 40, config = {extra = {odds = 10000,Xmult = 30,}},})
SMODS.Joker:take_ownership ('card_sharp',{order = 62, cost = 60, config = {extra = { Xmult = 30, }},})
SMODS.Joker:take_ownership ('red_card', { order = 63, cost = 50, config = { extra = 30, },})
SMODS.Joker:take_ownership ('madness', { order = 64, cost = 70, config = { extra = 5 },})
SMODS.Joker:take_ownership ('square', {order = 65,cost = 40, config = {extra = {chips = 0,chip_mod = 40, },},})
SMODS.Joker:take_ownership ('seance', {order = 66,cost = 60, config = {extra = {poker_hand = 'Straight Flush',},},})
SMODS.Joker:take_ownership('riff_raff', {order = 67,cost = 60,config = {extra = 20},}) -- need to reflect 
SMODS.Joker:take_ownership ('vampire', { order = 68, cost = 70, config = { extra = 1, Xmult = 10,},})
SMODS.Joker:take_ownership ('shortcut', { order = 69, cost = 70, config = {},})
SMODS.Joker:take_ownership ('hologram', { order = 70, cost = 70, config = {extra = 2.5, Xmult = 10},})
SMODS.Joker:take_ownership ('vagabond', { order = 71, cost = 80, config = {extra = 40},})
SMODS.Joker:take_ownership ('baron', { order = 72, cost = 80, config = {extra = 15},})
SMODS.Joker:take_ownership ('cloud_9', { order = 73, cost = 70, config = {extra = 10},})
SMODS.Joker:take_ownership ('rocket', { order = 74, cost = 60, config = {extra = { dollars = 10, increase = 20}},})
SMODS.Joker:take_ownership ('obelisk', { order = 75, cost = 80, config = { extra = 2, Xmult = 10,},})
SMODS.Joker:take_ownership ('midas_mask', { order = 76, cost = 70, config = {} })
SMODS.Joker:take_ownership ('luchador', { order = 77, cost = 50, config = {} })
SMODS.Joker:take_ownership ('photograph', { order = 78, cost = 50, config = {extra = 20}})
SMODS.Joker:take_ownership ('gift', { order = 79, cost = 60, config = {extra = 10}})
SMODS.Joker:take_ownership ('turtle_bean', { order = 80, cost = 60, config = { extra = {h_size = 50, h_mod = 10}},})
SMODS.Joker:take_ownership ('erosion', { order = 81, cost = 60, config = {extra = 40}  })
SMODS.Joker:take_ownership ('reserved_parking', { order = 82, cost = 60, config = {extra = {odds = 20, dollars = 10}} })
SMODS.Joker:take_ownership ('mail', { order = 83, cost = 40, config = {extra = 50} })
SMODS.Joker:take_ownership ('to_the_moon', {order = 84, cost = 50, config = {extra = 10}})
SMODS.Joker:take_ownership ('hallucination', { order = 85, cost = 40, config = {extra = 10}})
SMODS.Joker:take_ownership ('fortune_teller', { order = 86, cost = 60, config = { extra = 10 },}) -- reflect
SMODS.Joker:take_ownership ('juggler', { order = 87, cost = 40, config = { h_size = 10 },})
SMODS.Joker:take_ownership ('drunkard', { order = 88, cost = 40, config = { d_size = 10 },})
SMODS.Joker:take_ownership ('stone', { order = 89, cost = 60, config = {extra = 250}})
SMODS.Joker:take_ownership ('golden', { order = 90, cost = 60, config = {extra = 40}})
SMODS.Joker:take_ownership ('lucky_cat', { order = 91, cost = 60, config = {Xmult = 10, extra = 2.5}})
SMODS.Joker:take_ownership ('baseball', { order = 92, cost = 80, config = {extra = 15}})
SMODS.Joker:take_ownership ('bull', { order = 93, cost = 60, config = {extra = 20}})
SMODS.Joker:take_ownership ('diet_cola', { order = 94, cost = 60, config = {}})
SMODS.Joker:take_ownership ('trading', { order = 95, cost = 60, config = {extra = 30}})
SMODS.Joker:take_ownership ('flash', { order = 96, cost = 50, config = {extra = 20, mult = 0}})
SMODS.Joker:take_ownership ('popcorn', {order = 97, cost = 50, config = {mult = 200, extra = 40}})
SMODS.Joker:take_ownership ('trousers', {order = 98, cost = 60, config = {extra = 20}})
SMODS.Joker:take_ownership ('ancient', {order = 99, cost = 80, config = {extra = 15}})
SMODS.Joker:take_ownership ('ramen', {order = 100, cost = 60, config = {Xmult = 200, extra = 1}})
SMODS.Joker:take_ownership ('walkie_talkie', {order = 101, cost = 40, config = {extra = {chips = 100, mult = 40}}})
SMODS.Joker:take_ownership ('selzer', {order = 102, cost = 60, config = {extra = 50}})
SMODS.Joker:take_ownership ('castle', { order = 103, cost = 60, config = { extra = { chips = 0, chip_mod = 30, },},})
SMODS.Joker:take_ownership ('smiley', {order = 104, cost = 40, config = {extra = 50}})
SMODS.Joker:take_ownership ('campfire', {order = 105, cost = 90, config = {extra = 5},})
SMODS.Joker:take_ownership ('ticket', {order = 106, cost = 50, config = {extra = 40}})
SMODS.Joker:take_ownership ('mr_bones', {order = 107, cost = 50, config = {}})
SMODS.Joker:take_ownership ('acrobat', {order = 108, cost = 60, config = {extra = 3}})
SMODS.Joker:take_ownership ('sock_and_buskin', {order = 109, cost = 60, config = {extra = 1}})
SMODS.Joker:take_ownership ('swashbuckler', {order = 110, cost = 40, config = {mult = 10}}) -- need to x10 the other jokers
SMODS.Joker:take_ownership ('troubadour', {order = 111, cost = 60, config = {extra = {h_size = 20, h_plays = -1}} })
SMODS.Joker:take_ownership ('certificate', {order = 112, cost = 6, config = {}})
SMODS.Joker:take_ownership ('smeared', {order = 113, cost = 7, config = {}})
SMODS.Joker:take_ownership ('throwback', {order = 114, cost = 60, config = {extra = 2.5}})
SMODS.Joker:take_ownership ('hanging_chad', {order = 115, cost = 40, config = {extra = 20}})
SMODS.Joker:take_ownership('rough_gem', { order = 116, cost = 70, config = { extra = 10 },})
SMODS.Joker:take_ownership('bloodstone', { order = 117, cost = 70, config = { extra = { odds = 20, Xmult = 15, }},})
SMODS.Joker:take_ownership('arrowhead', { order = 118, cost = 70, config = { extra = 500 },})
SMODS.Joker:take_ownership('onyx_agate', { order = 119, cost = 70, config = { extra = 70 },})
SMODS.Joker:take_ownership ('glass', { order = 120, cost = 60, config = { extra = 7.5, Xmult = 10,},})
SMODS.Joker:take_ownership ('ring_master', { order = 121, cost = 50, config = {}, })
SMODS.Joker:take_ownership ('flower_pot', {order = 122,cost = 60, config = {extra = 30,},})
SMODS.Joker:take_ownership ('blueprint', {order = 123, cost = 10, config = {}})
SMODS.Joker:take_ownership ('wee', {order = 124, cost = 8, config = {extra = {chips = 0, chip_mod = 80}}})
SMODS.Joker:take_ownership ('merry_andy', {order = 125, cost = 70, config = {d_size = 30, h_size = -1}})
SMODS.Joker:take_ownership ('oops', {order = 126, cost = 40, config = {type='chip score', chips = 100000}})
SMODS.Joker:take_ownership ('idol', {order = 127, cost = 60, config = {extra = 20}})
SMODS.Joker:take_ownership ('seeing_double', {order = 128, cost = 60, config = { extra = 20 }})
SMODS.Joker:take_ownership ('matador', {order = 129, cost = 70, config = {extra = 80}})
SMODS.Joker:take_ownership ('hit_the_road', {order = 130, cost = 80, config = {extra = 5}})
SMODS.Joker:take_ownership ('duo', {order = 131, cost = 80, config = {Xmult = 20, type = 'Pair'}})
SMODS.Joker:take_ownership ('trio', {order = 132, cost = 80, config = {Xmult = 30, type = 'Three of a Kind'}})
SMODS.Joker:take_ownership ('family', {order = 133, cost = 80, config = {Xmult = 40, type = 'Four of a Kind'}})
SMODS.Joker:take_ownership ('order', {order = 134, cost = 80, config = {Xmult = 30, type = 'Straight'}})
SMODS.Joker:take_ownership ('tribe', {order = 135, cost = 80, config = {Xmult = 20, type = 'Flush'}})
SMODS.Joker:take_ownership('stuntman', {order = 126, cost = 70, config = {extra = {h_size = 2, chip_mod = 2500}}})
SMODS.Joker:take_ownership ('invisible', { order = 137, cost = 80, config = { extra = 20,}, })
SMODS.Joker:take_ownership ('brainstorm', { order = 138, cost = 100, config = {},})
SMODS.Joker:take_ownership ('satellite', { order = 139, cost = 60, config = { extra = 10 },})
SMODS.Joker:take_ownership ('shoot_the_moon', { order = 140, cost = 50, config = { extra = 130 },})
SMODS.Joker:take_ownership('drivers_license', {order = 141, cost = 70, config = {extra = 30}})
SMODS.Joker:take_ownership('cartomancer', {order = 142, cost = 60, config = {}})
SMODS.Joker:take_ownership ('astronomer', { order = 143, cost = 80, config = {}, } )
SMODS.Joker:take_ownership('burnt', {order = 144, cost = 80, config = {h_size = 0, extra = 4}})
SMODS.Joker:take_ownership ('bootstraps', { order = 145, cost = 70, config = { extra = { mult = 20, dollars = 50, },},})
SMODS.Joker:take_ownership ('caino', { order = 146, cost = 200, config = { extra = 10,},})
SMODS.Joker:take_ownership ('triboulet', { order = 147, cost = 200, config = { extra = 20,},})
SMODS.Joker:take_ownership ('yorick', { order = 148, cost = 200, config = { extra = { xmult = 10, discards = 230, },},})
SMODS.Joker:take_ownership ('chicot', { order = 149, cost = 200, config = {},})
SMODS.Joker:take_ownership ('perkeo', { order = 150, cost = 200, config = {},})