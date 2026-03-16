local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')

local hooksecurefunc = hooksecurefunc
local UnitPower, UnitPowerType, UnitPowerPercent, format = UnitPower, UnitPowerType, UnitPowerPercent, format
local ScaleTo100 = CurveConstants and CurveConstants.ScaleTo100

-- Smart Power tag: shows percentage for mana users, current value otherwise
E:AddTag('tui-smartpower', 'UNIT_DISPLAYPOWER UNIT_POWER_FREQUENT UNIT_MAXPOWER', function(unit)
	local powerType = UnitPowerType(unit)
	if powerType == Enum.PowerType.Mana then
		return format('%d', UnitPowerPercent(unit, nil, true, ScaleTo100))
	else
		return UnitPower(unit)
	end
end)
E:AddTagInfo('tui-smartpower', E:TextGradient('TrenchyUI', 1.00,0.18,0.24, 0.80,0.10,0.20), 'Shows power percentage for mana specs, current power for others')

-- Power tag responsiveness: bypass oUF's 100ms event batching delay
hooksecurefunc(UF, 'Configure_Power', function(_, frame)
	if frame and frame.Power and frame.Power.value then
		frame.Power.value.frequentUpdates = 0.05
	end
end)

-- Fake Power fix
hooksecurefunc(UF, 'Configure_ClassBar', function(_, frame)
	if not frame or not frame.ClassBar then return end
	if frame.ClassBar ~= 'ClassPower' and frame.ClassBar ~= 'Runes' and frame.ClassBar ~= 'Totems' then return end

	local bars = frame[frame.ClassBar]
	if not bars then return end

	local containerW = bars:GetWidth()
	local containerH = bars:GetHeight()
	if not containerW or containerW <= 0 then return end
	if not containerH or containerH <= 0 then return end

	local MAX_CLASS_BAR = frame.MAX_CLASS_BAR or 0
	if MAX_CLASS_BAR < 1 then return end

	for i = 1, MAX_CLASS_BAR do
		local bar = bars[i]
		if not bar then break end
		if bar:GetWidth() > containerW then
			bar:SetWidth(containerW)
		end
		if bar:GetHeight() > containerH then
			bar:SetHeight(containerH)
		end
	end
end)
