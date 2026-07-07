local multiplier = SMODS.current_mod.config.game.multiplier
local config = SMODS.current_mod.config.options

local originalparams = get_starting_params
function get_starting_params()
	newTable = originalparams()

    if config.joker_playing_slot == true then
        newTable.joker_slots = newTable.joker_slots * multiplier
    end

	newTable.dollars = newTable.dollars * multiplier

    if config.game_playing_discard == true then
	    newTable.discards = newTable.discards * multiplier
    end

    if config.game_playing_hand == true then
	    newTable.hands = newTable.hands * multiplier
    end

    if config.game_handsize == true then
	    newTable.hand_size = newTable.hand_size * multiplier
    end

	newTable.consumable_slots = newTable.consumable_slots * multiplier
	newTable.reroll_cost = newTable.reroll_cost * multiplier

    if config.ante_scaling == true then
        newTable.ante_scaling = newTable.ante_scaling * multiplier
    else
        newTable.ante_scaling = newTable.ante_scaling * 1
    end
    return newTable
end

local function multiplyNumbers(tbl)
    for k, v in pairs(tbl) do
        if type(v) == "number" then
            tbl[k] = v * multiplier
        elseif type(v) == "table" then
            multiplyNumbers(v)
        end
    end
end

for key, joker in pairs(G.P_CENTERS) do
    if joker.set == "Joker" then
        -- if joker.config then
        --     multiplyNumbers(joker.config)
        -- end

        if joker.cost then
            joker.cost = joker.cost * multiplier
        end
    end
end

-- for key, tags in pairs(G.P_CENTERS) do
--     if tags.set == "Tag" then
--         if tags.config then
--             multiplyNumbers(tags.config)
--         end

--         if tags.cost then
--             tags.cost = tags.cost * multiplier
--         end
--     end
-- end

for key, consume in pairs(G.P_CENTERS) do
    if consume.set == "Tarot" then
        if consume.config and consume.name == "The High Priestess" and config.tarot_priestess == true then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Emperor" and config.tarot_emperor == true then multiplyNumbers(consume.config) end

        if consume.config and consume.name == "The Fool" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Magician" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Empress" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Hierophant" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Lovers" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Chariot" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "Justice" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Hermit" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Wheel of Fortune" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "Strength" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Hanged Man" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "Temperance" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Devil" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Tower" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Star" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Moon" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The Sun" then multiplyNumbers(consume.config) end
        if consume.config and consume.name == "The World" then multiplyNumbers(consume.config) end

        if consume.cost then
            consume.cost = consume.cost * multiplier
        end
    end
end
-- G.P_CENTERS.c_death.config.min_highlighted = 2
-- G.P_CENTERS.c_death.config.max_highlighted = 2

for key, vouchers in pairs(G.P_CENTERS) do
    if vouchers.set == "Voucher" then
        -- if vouchers.config then
        --     multiplyNumbers(vouchers.config)
        -- end

        if vouchers.cost then
            vouchers.cost = vouchers.cost * multiplier
        end
    end
end

-- for key, decks in pairs(G.P_CENTERS) do
--     if decks.set == "Back" then
--         if decks.config then
--             multiplyNumbers(decks.config)
--         end
--     end
-- end

for key, editions in pairs(G.P_CENTERS) do
    if editions.set == "Edition" then
        if editions.config then
            multiplyNumbers(editions.config)
        end
    end
end

-- for key, enhance in pairs(G.P_CENTERS) do
--     if enhance.set == "Enhanced" then
--         if enhance.config then
--             multiplyNumbers(enhance.config)
--         end
--     end
-- end

for key, spectral in pairs(G.P_CENTERS) do
    if spectral.set == "Spectral" then
        if spectral.config then
            multiplyNumbers(spectral.config)
        end

        if spectral.cost then
            spectral.cost = spectral.cost * multiplier
        end
    end
end

for key, booster in pairs(G.P_CENTERS) do
    if booster.set == "Booster" then

        if config.joker_booster_slot == true then
            if booster.config then
                multiplyNumbers(booster.config)
            end
        end

        if booster.cost then
            booster.cost = booster.cost * multiplier
        end
    end
end

local oldinitgameobject = Game.init_game_object
function Game:init_game_object()
    local g = oldinitgameobject(self)

    if config.poker_hands ~= false then
        for i, hand in pairs(g.hands) do
            hand.mult = hand.mult * multiplier
            hand.chips = hand.chips * multiplier
            hand.s_mult = hand.s_mult * multiplier
            hand.s_chips = hand.s_chips * multiplier

            hand.l_mult = hand.l_mult * multiplier
            hand.l_chips = hand.l_chips * multiplier

            -- print(hand)
        end
    end

    g.starting_deck_size = g.starting_deck_size * multiplier
    g.perishable_rounds = g.perishable_rounds * multiplier
    g.rental_rate = g.rental_rate * multiplier

    if config.joker_shop_slot == true then
        g.shop.joker_max = g.shop.joker_max * multiplier
    end

    -- g.hands = value
    return g
end