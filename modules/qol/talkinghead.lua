local E = unpack(ElvUI)
local TUI = E:GetModule('TrenchyUI')

local tremove = tremove

local function KillTalkingHead()
	local thf = TalkingHeadFrame
	if not thf then return end

	thf:UnregisterEvent('TALKINGHEAD_REQUESTED')
	thf:UnregisterEvent('TALKINGHEAD_CLOSE')
	thf:UnregisterEvent('SOUNDKIT_FINISHED')
	thf:UnregisterEvent('LOADING_SCREEN_ENABLED')
	thf:Hide()

	if AlertFrame and AlertFrame.alertFrameSubSystems then
		for i = #AlertFrame.alertFrameSubSystems, 1, -1 do
			local sub = AlertFrame.alertFrameSubSystems[i]
			if sub.anchorFrame and sub.anchorFrame == thf then
				tremove(AlertFrame.alertFrameSubSystems, i)
			end
		end
	end

	if not TUI:IsHooked(thf, 'Show') then
		TUI:SecureHook(thf, 'Show', function(self) self:Hide() end)
	end
end

function TUI:InitHideTalkingHead()
	KillTalkingHead()
end
