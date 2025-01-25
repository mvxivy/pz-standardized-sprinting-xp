--Default options.
local SETTINGS = { 
	options = {
		dropdown1 = 2,
		dropdown2 = 3,
	},
	names= {
		dropdown1 = "Xp Multiplier",
		dropdown2 = "Xp Delay",
	},
	mod_id = "STSPRINT",
	mod_shortname = "Standardized Sprinting XP"
}

-- Connecting the options to the menu, so user can change them.
if ModOptions and ModOptions.getInstance then
	local settings = ModOptions:getInstance(SETTINGS)
	
	local drop1 = settings:getData("dropdown1")
	drop1[1] = "1xp"
	drop1[2] = "5xp"
	drop1[3] = "10xp"
	drop1[4] = "25xp"
	drop1[5] = "50xp"
	drop1[6] = "100xp"
	drop1[7] = "1000xp"
	drop1.tooltip = "Xp Reward for Sprinting skill"
	local drop2 = settings:getData("dropdown2")
	drop2[1] = "250"
	drop2[2] = "500"
	drop2[3] = "1000"
	drop2[4] = "1500"
	drop2[5] = "2000"
	drop2[6] = "3000"
	drop2[7] = "5000"
	drop2[8] = "10000"
	drop2.tooltip = "Delay between bar xp rewards, default: 1000 (~15.6 sec)."

end

StandardizedSprintingXP_global = {}
StandardizedSprintingXP_global.SETTINGS = SETTINGS