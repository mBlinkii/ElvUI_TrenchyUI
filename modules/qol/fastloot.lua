local E = unpack(ElvUI)
local TUI = E:GetModule('TrenchyUI')

function TUI:InitFastLoot()
	TUI:RegisterEvent('LOOT_READY', function()
		local slots = GetNumLootItems()
		if slots == 0 then return end
		for i = slots, 1, -1 do
			LootSlot(i)
		end
	end)
end
