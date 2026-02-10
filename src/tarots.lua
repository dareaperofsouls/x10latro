
-- The Fool
SMODS.Consumable:take_ownership('fool', {cost = 30}) 
SMODS.Consumable:take_ownership('magician', {cost = 30, config = {mod_conv = 'm_lucky', max_highlighted = 20}}) 
SMODS.Consumable:take_ownership('high_priestess', {cost = 30, config = {planets = 20}}) 
SMODS.Consumable:take_ownership('empress', {cost = 30, config = {mod_conv = 'm_mult', max_highlighted = 20}}) 
SMODS.Consumable:take_ownership(
    'emperor', 
    {
        cost = 30, 
        config = {extra = 20},
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,
        use = function(self, card, area, copier)
            for i = 1, math.min(card.ability.extra, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Tarot' })
                            card:juice_up(0.3, 0.5)
                        end
                        return true
                    end
                }))
            end
            delay(0.6)
        end,
        can_use = function(self, card)
            return (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit) or
                (card.area == G.consumeables)
        end
    }
) 
SMODS.Consumable:take_ownership('hierophant', {cost = 30, config = {mod_conv = 'm_bonus', max_highlighted = 20}}) 
SMODS.Consumable:take_ownership('lovers', {cost = 30, config = {mod_conv = 'm_wild', max_highlighted = 10}}) 
SMODS.Consumable:take_ownership('chariot', {cost = 30, config = {mod_conv = 'm_steel', max_highlighted = 10}}) 
SMODS.Consumable:take_ownership('justice', {cost = 30, config = {mod_conv = 'm_glass', max_highlighted = 10}}) 
SMODS.Consumable:take_ownership('hermit', {cost = 30, config = {extra= 200}}) 
SMODS.Consumable:take_ownership('wheel_of_fortune', {cost = 30, config = {extra = 40}}) 
SMODS.Consumable:take_ownership('strength', {cost = 30, config = {mod_conv = 'up_rank', max_highlighted = 20}})
SMODS.Consumable:take_ownership('hanged_man', {cost = 30, config = {remove_card= true, max_highlighted = 20}}) 
SMODS.Consumable:take_ownership('death', {cost = 30, config = {mod_conv = 'card', max_highlighted = 2, min_highlighted = 2}}) -- crashes, need to do 2 for now
SMODS.Consumable:take_ownership('temperance', {cost = 30, config = {extra= 500}}) 
SMODS.Consumable:take_ownership('devil', {cost = 30, config = {mod_conv = 'm_gold', max_highlighted = 10}}) 
SMODS.Consumable:take_ownership('tower', {cost = 30, config = {mod_conv = 'm_stone', max_highlighted = 10}})
SMODS.Consumable:take_ownership('star', {cost = 30, config = {suit_conv = 'Diamonds', max_highlighted = 30}}) 
SMODS.Consumable:take_ownership('moon', {cost = 30, config = {suit_conv = 'Clubs', max_highlighted = 30}}) 
SMODS.Consumable:take_ownership('sun', {cost = 30, config = {suit_conv = 'Hearts', max_highlighted = 30}}) 
SMODS.Consumable:take_ownership('judgement', {cost = 30, config = {}}) 
SMODS.Consumable:take_ownership('world', {cost = 30, config = {suit_conv = 'Spades', max_highlighted = 30}}) 
