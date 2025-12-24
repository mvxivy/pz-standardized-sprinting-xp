local config = require("ST_Sprinting_Config")
local MVXIVY_Utils = require("MVXIVY_Utils")
local modOptions = {}


--- Initialize the mod options
---@param isSingleplayer boolean
function modOptions.init(isSingleplayer)
	local UI = PZAPI.ModOptions:create(config.modId, config.modName)

	local ComboBoxFactory = MVXIVY_Utils.useComboBoxFactory(
		"ST_Sprinting_",
		"UI_options_" .. config.modId .. "_",
		UI
	)

  if isSingleplayer then
    modOptions.ComboBoxReward = ComboBoxFactory{
      name="ComboBoxReward",
      label="reward_label",
      items={ "1xp", "5xp", "10xp", "25xp", "50xp", "100xp", "1000xp" },
      defaultItem=2,
      description="reward_description"
    }
  end

  modOptions.ComboBoxDelay = ComboBoxFactory{
    name="ComboBoxDelay",
    label="delay_label",
    items={ "250", "500", "1000", "1500", "2000", "3000", "5000", "10000" },
    defaultItem=3,
    description="delay_description"
  }
end

return modOptions