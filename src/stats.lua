G.E_MANAGER:add_event(Event({
    func = function() 
        G.GAME.starting_params.dollars = G.GAME.starting_params.dollars * 10
        G.GAME.round_resets.hands = G.GAME.starting_params.hands * 10
        G.GAME.round_resets.discards = G.GAME.starting_params.discards * 10
        G.GAME.round_resets.reroll_cost = G.GAME.starting_params.reroll_cost * 10
        return true 
    end
}))