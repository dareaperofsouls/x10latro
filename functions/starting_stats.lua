local multiplier = 10

local originalFuncRef = get_starting_params
function get_starting_params()
	newTable = originalFuncRef()
	newTable.joker_slots = newTable.joker_slots * 10
	newTable.dollars = newTable.dollars * multiplier
	newTable.discards = newTable.discards * multiplier
	newTable.hands = newTable.hands * multiplier
	newTable.hand_size = newTable.hand_size * multiplier
	newTable.consumable_slots = newTable.consumable_slots * multiplier
	newTable.reroll_cost = newTable.reroll_cost * multiplier
	newTable.ante_scaling = newTable.ante_scaling * multiplier
	return newTable
end

-- function Game:init_item_prototypes()
-- 	newTable = originalFuncRef()

-- 	jokerTable = newTable.P_CENTERS

-- 	for i, v in pairs(jokerTable) do
-- 		print(v.name)
-- 	end


-- 	-- return newTable
-- end

