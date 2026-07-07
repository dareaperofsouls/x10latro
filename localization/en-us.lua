return {
    descriptions = {
        Joker = {
            j_mime = {
                text = {
                    "Retrigger all",
                    "card {C:attention}held in",
                    "{C:attention}hand{} abilities",
                    "{C:attention}#1#{} times"
                }
            },

            -- j_raised_fist = {
            --     text = {
            --         "Adds {C:attention}twice{} the rank",
            --         "of {C:attention}lowest{} ranked card",
            --         "held in hand to Mult",
            --     },
            -- },

            j_hack = {
                text = {
                    "Retrigger",
                    "each played",
                    "{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{}",
                    "{C:attention}#1#{} times"
                },
            },
        },

        Back = {
            b_magic = {
                text = {
                    "Start run with the",
                    "{C:tarot,T:v_crystal_ball}#1#{} voucher",
                    "and {C:attention}#2#{} copies",
                    "of {C:tarot,T:c_fool}#3#",
                },
            },
        },

        Voucher = {
            v_overstock_norm = {text = {"{C:attention}+#1#{} card slot", "available in shop",}},
            v_overstock_plus = {text = {"{C:attention}+#1#{} card slot", "available in shop",}},
            v_hieroglyph = {text = {"{C:attention}-#1#{} Ante,", "{C:blue}-#2#{} hand", "each round",}},
            v_petroglyph = {text = {"{C:attention}-#1#{} Ante,", "{C:blue}-#2#{} discard", "each round",}},
            v_antimatter = {text = {"{C:dark_edition}+#1#{} Joker Slot",}},
            v_crystal_ball = {text = {"{C:attention}+#1#{} consumable slot",},},
        },

        -- Stake = {
        --     stake_blue = {
        --         text = {
        --             "{C:red}-#1#{} Discard",
        --             "{s:0.8}Applies all previous Stakes",
        --         },
        --     },
        -- }
    },
    misc = {
        dictionary = {
            x_joker_shop_slot = "Multiply shop slots",
            x_joker_booster_slot = "Multiply booster slots",
            x_joker_playing_slot = "Multiply Joker slots",

            x_game_handsize = "Multiply hand size",
            x_game_perishable = "Multiply perishable rounds",
            x_game_rental = "Multiply rental rate",

            x_game_playing_hand = "Multiply playing hand",
            x_game_playing_discard = "Multiply playing discard",

            x_tarot_priestess = "Multiply The High Priestess",
            x_tarot_emperor = "Multiply The Emperor",

            x_text_game = "Game Settings",
            x_text_consumables = "Tarot Settings",
            x_text_slot = "Slot Settings",

            x_ante_scaling = "Multiply Ante Scaling",
            x_blind_scaling = "Multiply Blind Scaling",
            x_chance = "Multiply Chance",
            x_poker_score = "Multiply poker score"
            
        }
    }
}