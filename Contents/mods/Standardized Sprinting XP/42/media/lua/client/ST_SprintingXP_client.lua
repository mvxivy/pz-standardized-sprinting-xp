
local config = require("ST_Sprinting_Config")
local modOptions = require("ST_Sprinting_ModOptions")
modOptions.init(not isMultiplayer())

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

	local moving = player:isPlayerMoving()
	local sprinting = player:isSprinting()
	local running = player:IsRunning()

	if gameVersionIs4213() then
		return moving and (running or sprinting)
			and player:getStats():getLastEndurance() > player:getStats():getEnduranceWarning()
	else 
		return moving and (running or sprinting)
			and player:getStats():getEndurance() > player:getStats():getEndurancewarn()
	end
end

if isClient() and isMultiplayer() then
	-- MULTIPLAYER CLIENT
	-- get Sprinting XP for a player on the server
	-- @param Player IsoPlayer
	local function getSprintingBonusXPOnServer(Player)
		local player = Player or getPlayer();
		if not player then return end
		if player:isDead() then return end
		if not checkBonusCondition() then return end

		local delay = sprintDelay[modOptions.ComboBoxDelay:getValue()]
		if xpThrottle > delay then
			print("[SprintXP] sending server command for XP grant");
			sendClientCommand(config.modId, config.command, {});
			xpThrottle = 0;
		end
		xpThrottle = xpThrottle + 1;
	end
	Events.OnPlayerUpdate.Add(getSprintingBonusXPOnServer);
else 
	-- SINGLEPLAYER CLIENT
	local function getSprintingBonusXP()
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
	
	Events.OnPlayerMove.Add(getSprintingBonusXP);
end

