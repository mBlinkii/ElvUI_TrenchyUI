local E = unpack(ElvUI)
local TUI = E:GetModule('TrenchyUI')
local NP = E:GetModule('NamePlates')

local IsInInstance = IsInInstance

function TUI:HookClassificationInstanceOnly()
	if self._hookedClassificationInstance then return end
	self._hookedClassificationInstance = true

	hooksecurefunc(NP, 'Health_SetColors', function(_, nameplate, threatColors)
		if threatColors then return end
		if not IsInInstance() then
			nameplate.Health.colorClassification = nil
		end
	end)
end
