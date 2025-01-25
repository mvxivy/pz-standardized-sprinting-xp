--****************************************************************************************************************
--**		Created By: 	Conqueror Koala																		**
--**		Mod:			Standardized Sprinting XP															**
--**																											**		
--**		Information:																						**
--**					This code is totally free for you to edit, use, or copy however you want!				**
--**					Feel free to use any of the code in your own projects, don't worry about crediting. 	**
--****************************************************************************************************************


--************************************************************************************************
--**  Would not recommend changing anything past this point unless you know what you are doing. **
--************************************************************************************************
local SETTINGS = StandardizedSprintingXP_global.SETTINGS

local sprintMult = {1,5,10,25,50,100,1000};
local sprintDelay = {250,500,1000,1500,2000,3000,5000,10000};

xpThrottle = 0; -- Just a counting variable.

-- used everytime the player moves
SprintingBonusXP = function()
xpThrottle = tonumber(xpThrottle);
	local player = getPlayer();
	local xp = player:getXp();
	-- if you're running and your endurance has changed
	if (player:IsRunning() or player:isSprinting()) and player:getStats():getEndurance() > player:getStats():getEndurancewarn() then
		-- you may gain 1 instance of Sprinting XP
		if tonumber(xpThrottle) > tonumber(sprintDelay[tonumber(SETTINGS.options.dropdown2)]) then
			xp:AddXP(Perks.Sprinting, tonumber(sprintMult[tonumber(SETTINGS.options.dropdown1)]));
			xpThrottle = 0;
		end
		xpThrottle = tonumber(xpThrottle) + 1;
	end
end

Events.OnPlayerMove.Add(SprintingBonusXP); -- Calls the above function every time player moves.