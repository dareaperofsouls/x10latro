local function multiply_numbers(tbl, visited)
    if type(tbl) ~= "table" then return end
    visited = visited or {}
    if visited[tbl] then return end
    visited[tbl] = true

    for k, v in pairs(tbl) do
        if type(v) == "number" then
            tbl[k] = v * 10
        elseif type(v) == "table" then
            multiply_numbers(v, visited)
        end
    end
end

-- Generic registry patcher
local function patch_registry(reg)
    if not reg then return end

    for _, item in pairs(reg) do
        if item and not item._insane_x10 then
            if item.config then
                multiply_numbers(item.config)
            end
            if item.config and item.config.extra then
                multiply_numbers(item.config.extra)
            end
            item._insane_x10 = true
        end
    end
end

local function patch_defs()

    -- Jokers
    if SMODS then
        patch_registry(SMODS.Jokers)

        -- Tarots
        patch_registry(SMODS.Tarots)

        -- Planets (poker hand scaling cards)
        patch_registry(SMODS.Planets)

        -- Spectrals (Cryptid content)
        patch_registry(SMODS.Spectrals)

        -- Vouchers
        patch_registry(SMODS.Vouchers)
    end

    -- Poker hand base values
    if G and G.GAME and G.GAME.hands then
        multiply_numbers(G.GAME.hands)
    end

    -- Hand upgrade centers (used by planet cards)
    if G and G.P_CENTERS then
        multiply_numbers(G.P_CENTERS)
    end
end

local function patch_owned()

    -- Owned jokers
    if G and G.jokers and G.jokers.cards then
        for _, card in ipairs(G.jokers.cards) do
            if card and card.ability and not card.ability._insane_x10 then
                multiply_numbers(card.ability)
                if card.ability.extra then
                    multiply_numbers(card.ability.extra)
                end
                card.ability._insane_x10 = true
            end
        end
    end

    -- Consumables currently held (tarots, planets, spectrals)
    if G and G.consumeables and G.consumeables.cards then
        for _, card in ipairs(G.consumeables.cards) do
            if card and card.ability and not card.ability._insane_x10 then
                multiply_numbers(card.ability)
                if card.ability.extra then
                    multiply_numbers(card.ability.extra)
                end
                card.ability._insane_x10 = true
            end
        end
    end
end

G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 1,
    blockable = false,
    blocking = false,
    func = function()
        patch_defs()
        patch_owned()
        return false -- keep repeating forever (important for new shop items)
    end
}))