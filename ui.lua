SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK },
        nodes = {
            {
                n = G.UIT.R,
                config = { padding = 0.2 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cm" },
                        nodes = {
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                config = {
                                    text = localize('x_text_slots'), 
                                    colour = G.C.UI.TEXT_LIGHT, 
                                    scale = 0.5, 
                                    align = "cr"
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_joker_shop_slot'),
                                        ref_table = xalatro.config,
                                        ref_value = 'joker_shop_slot'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_joker_booster_slot'),
                                        ref_table = xalatro.config,
                                        ref_value = 'joker_booster_slot'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_joker_playing_slot'),
                                        ref_table = xalatro.config,
                                        ref_value = 'joker_playing_slot'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_ante_scaling'),
                                        ref_table = xalatro.config,
                                        ref_value = 'ante_scaling'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_blind_scaling'),
                                        ref_table = xalatro.config,
                                        ref_value = 'blind_scaling'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_poker_score'),
                                        ref_table = xalatro.config,
                                        ref_value = 'poker_hands'
                                    })
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "cm" },
                        nodes = {
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                config = {
                                    text = localize('x_text_consumables'), 
                                    colour = G.C.UI.TEXT_LIGHT, 
                                    scale = 0.5, 
                                    align = "cr"
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_tarot_emperor'),
                                        ref_table = xalatro.config,
                                        ref_value = 'tarot_emperor'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_tarot_priestess'),
                                        ref_table = xalatro.config,
                                        ref_value = 'tarot_priestess'
                                    })
                                }
                            },
                        }
                    },
                    
                    {
                        n = G.UIT.C,
                        config = { align = "cm" },
                        nodes = {
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                config = {
                                    text = localize('x_text_game'), 
                                    colour = G.C.UI.TEXT_LIGHT, 
                                    scale = 0.5, 
                                    align = "cr"
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_game_handsize'),
                                        ref_table = xalatro.config,
                                        ref_value = 'game_handsize'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_game_perishable'),
                                        ref_table = xalatro.config,
                                        ref_value = 'game_perishable'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_game_rental'),
                                        ref_table = xalatro.config,
                                        ref_value = 'game_rental'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_game_playing_hand'),
                                        ref_table = xalatro.config,
                                        ref_value = 'game_playing_hand'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_game_playing_discard'),
                                        ref_table = xalatro.config,
                                        ref_value = 'game_playing_discard'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R, config = { align = "cm", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = localize('x_chance'),
                                        ref_table = xalatro.config,
                                        ref_value = 'chance'
                                    })
                                }
                            },
                        }
                    },
                }
            },
        }
    }
end