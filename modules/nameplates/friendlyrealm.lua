local E = unpack(ElvUI)
local TUI = E:GetModule('TrenchyUI')

function TUI:InitHideFriendlyRealm()
	if not NamePlateFriendlyFrameOptions or not TextureLoadingGroupMixin then return end
	if not NamePlateFriendlyFrameOptions.updateNameUsesGetUnitName then return end

	local wrapper = { textures = NamePlateFriendlyFrameOptions }
	NamePlateFriendlyFrameOptions.updateNameUsesGetUnitName = 0
	TextureLoadingGroupMixin.RemoveTexture(wrapper, 'updateNameUsesGetUnitName')
end
