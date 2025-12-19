local modOptions = require("ST_Sprinting_ModOptions")
modOptions.init()

local sprintMultiplier = {1, 5, 10, 25, 50, 100, 1000};
local sprintDelay = {250, 500, 1000, 1500, 2000, 3000, 5000, 10000};

-- xpThrottle is used to control the frequency of XP gain
local xpThrottle = 0;
local gameVersion = tostring(getCore():getGameVersion())
local function gameVersionIs4213() 
  return string.sub(gameVersion, 0, 5) == "42.13"
end

local function checkBonusCondition()
	local player = getPlayer();

	if gameVersionIs4213() then
		return (player:IsRunning() or player:isSprinting())
			and player:getStats():getLastEndurance() > player:getStats():getEnduranceWarning()
	else 
		return (player:IsRunning() or player:isSprinting())
			and player:getStats():getEndurance() > player:getStats():getEndurancewarn()
	end
end

local function SprintingBonusXP()
	local player = getPlayer();
	local xp = player:getXp();
	-- if you're running and your endurance has changed
	if checkBonusCondition() then
		-- you may gain 1 instance of Sprinting XP
		if xpThrottle > sprintDelay[modOptions.ComboBoxDelay:getValue()] then
			xp:AddXP(Perks.Sprinting, sprintMultiplier[modOptions.ComboBoxReward:getValue()]);
			xpThrottle = 0;
		end
		xpThrottle = xpThrottle + 1;
	end
end

Events.OnPlayerMove.Add(SprintingBonusXP);