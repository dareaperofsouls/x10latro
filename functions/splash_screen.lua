local multiplier = SMODS.current_mod.config.multiplier

function get_splash_card()
    if multiplier == 2 then
        return G.P_CARDS.S_2
    elseif multiplier == 3 then
        return G.P_CARDS.S_3
    elseif multiplier == 4 then
        return G.P_CARDS.S_4
    elseif multiplier == 5 then
        return G.P_CARDS.S_5
    elseif multiplier == 6 then
        return G.P_CARDS.S_6
    elseif multiplier == 7 then
        return G.P_CARDS.S_7
    elseif multiplier == 8 then
        return G.P_CARDS.S_8
    elseif multiplier == 9 then
        return G.P_CARDS.S_9
    elseif multiplier == 10 then
        return G.P_CARDS.S_T
    else
        return G.P_CARDS.S_A 
    end
end

-- Override Game:main_menu to change the start screen card
local original_main_menu = Game.main_menu
function Game:main_menu(change_context)
    -- Call the original function first
    original_main_menu(self, change_context)
    
    -- Delay the card change to ensure the menu is fully loaded
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            if self.title_top and self.title_top.cards and self.title_top.cards[1] then
                local card = self.title_top.cards[1]
                -- Change the card to the configured splash card
                card:set_base(get_splash_card())
            end
            return true
        end
    }))
end

-- Override Game:splash_screen to change the splash card
local original_splash_screen = Game.splash_screen
function Game:splash_screen()
    -- Call the original function first
    original_splash_screen(self)
    
    -- Change the splash card
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            -- Find and change the splash card
            for k, v in pairs(G.I.CARD) do
                if v.area and v.area.config.type == 'title' then
                    v:set_base(get_splash_card())
                end
            end
            return true
        end
    }))
end
