local modOptions = require("ST_Sprinting_ModOptions")
modOptions.init()

local sprintMultiplier = {1, 5, 10, 25, 50, 100, 1000};
local sprintDelay = {250, 500, 1000, 1500, 2000, 3000, 5000, 10000};

-- xpThrottle is used to control the frequency of XP gain
local xpThrottle = 0;

local function SprintingBonusXP()
	local player = getPlayer();
	local xp = player:getXp();
	-- if you're running and your endurance has changed
	if 
		(player:IsRunning() or player:isSprinting())
		and player:getStats():getEndurance() > player:getStats():getEndurancewarn()
	then
		-- you may gain 1 instance of Sprinting XP
		if xpThrottle > sprintDelay[modOptions.ComboBoxDelay:getValue()] then
			xp:AddXP(Perks.Sprinting, sprintMultiplier[modOptions.ComboBoxReward:getValue()]);
			xpThrottle = 0;
		end
		xpThrottle = xpThrottle + 1;
	end
end

Events.OnPlayerMove.Add(SprintingBonusXP);