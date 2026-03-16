local E = unpack(ElvUI)
local TUI = E:GetModule('TrenchyUI')
local UF = E:GetModule('UnitFrames')

local LCG = E.Libs.CustomGlow
local GLOW_KEY = 'TUI_PixelGlow'
local glowColor = { 1, 1, 1, 1 }

local function GetPixelGlowDB()
	local db = TUI.db and TUI.db.profile and TUI.db.profile.pixelGlow
	if not db then return false, 8, 0.25, 2 end
	return db.enabled, db.lines, db.speed, db.thickness
end

function TUI:InitPixelGlow()
	local enabled = GetPixelGlowDB()
	if not enabled then return end
	if not LCG or not LCG.PixelGlow_Start then return end

	hooksecurefunc(UF, 'PostUpdate_AuraHighlight', function(_, frame, _, aura, debuffType)
		if not frame then return end
		local element = frame.AuraHighlight
		if not element then return end

		local _, lines, speed, thickness = GetPixelGlowDB()
		local glowTarget = frame.Health or frame

		if aura or debuffType then
			glowColor[1], glowColor[2], glowColor[3] = element:GetVertexColor()
			element:SetVertexColor(0, 0, 0, 0)
			if frame.AuraHightlightGlow then frame.AuraHightlightGlow:Hide() end
			LCG.PixelGlow_Start(glowTarget, glowColor, lines, speed, nil, thickness, 0, 0, false, GLOW_KEY)
		else
			element:SetVertexColor(0, 0, 0, 0)
			if frame.AuraHightlightGlow then frame.AuraHightlightGlow:Hide() end
			LCG.PixelGlow_Stop(glowTarget, GLOW_KEY)
		end
	end)
end
