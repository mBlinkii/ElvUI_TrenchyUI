local E = unpack(ElvUI)
local TUI = E:GetModule('TrenchyUI')
local NP = E:GetModule('NamePlates')

local UnitIsTapDenied = UnitIsTapDenied

function TUI:HookNameplateThreat()
	if self._hookedThreatPost then return end
	self._hookedThreatPost = true

	hooksecurefunc(NP, 'ThreatIndicator_PostUpdate', function(Indicator, unit, status)
		local nameplate = Indicator.__owner

		if not status then
			-- Abrupt combat drop (Shadowmeld, Feign Death, etc.): restore color flags
			NP:Health_SetColors(nameplate, false)
			NP.Health_UpdateColor(nameplate, nil, unit)
			return
		end

		local db = NP.db.threat
		if not db or not db.enable or not db.useThreatColor or UnitIsTapDenied(unit) then return end

		local isTank = Indicator.isTank
		local isGoodThreat = isTank and (status == 3) or (not isTank and status == 0)
		if not isGoodThreat then return end

		nameplate.threatStatus = status
		nameplate.threatScale = 1
		NP:ScalePlate(nameplate, 1)
		NP:Health_SetColors(nameplate, false)
		NP.Health_UpdateColor(nameplate, nil, unit)
	end)
end
