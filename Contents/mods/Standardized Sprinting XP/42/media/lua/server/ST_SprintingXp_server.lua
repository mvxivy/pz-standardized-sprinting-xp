local utils = require("MVXIVY_Utils")
local config = require("ST_Sprinting_Config")

local lastGrantAt = {} -- key -> time seconds
local function getXPPerPulse()
  return utils.sandbox.getOptionValue({"STSPRINT_B42", "XPPerPulse"}, 5)
end

local function getMinInterval()
  return utils.sandbox.getOptionValue({"STSPRINT_B42", "MinIntervalSeconds"}, 1.0)
end

--- allow grant for 
---@param player IsoPlayer
local function allowGrantSprintingXp(player)
  local key = utils.getPlayerUniqueId(player)
  local t = utils.nowSeconds()
  local prev = lastGrantAt[key] or 0
  local minInterval = tonumber(getMinInterval()) or 1.0
  local dt = t - prev

  -- print("[SprintXP] allowGrantSprintingXp player=" .. tostring(key)
  --   .. " t=" .. tostring(t)
  --   .. " prev=" .. tostring(prev)
  --   .. " dt=" .. tostring(dt)
  --   .. " minInterval=" .. tostring(minInterval))

  if dt < minInterval then return false end

  lastGrantAt[key] = t
  return true
end

local function serverValidate(player)
  if not player or player:isDead() then
    return false
  end

  if player.isPlayerMoving and (not player:isPlayerMoving()) then
    return false
  end

  if player.getVehicle and player:getVehicle() then
    return false
  end

  -- TODO: need check it
  if player.isSprinting and (not player:isSprinting()) then
    return false
  end

  return true
end

local function grantSprintingXP(player)
  -- print("[SprintXP] Granting Sprinting XP to player " .. tostring(player:getDisplayName()))
  -- print("[SprintXP] XP per pulse: " .. tostring(getXPPerPulse()))
  player:getXp():AddXP(Perks.Sprinting, getXPPerPulse(), false, true, true)
end

local function onClientCommand(module, command, player, args)
  -- print("[SprintXP] onClientCommand called")
  -- print("[SprintXP] module: " .. tostring(module))
  -- print("[SprintXP] command: " .. tostring(command)) 
  -- print("[SprintXP] player: " .. tostring(player))
  if module ~= config.modId then return end
  if command ~= config.command then return end
  if not player then return end

  -- print("[SprintXP] Passed initial checks")

  if not allowGrantSprintingXp(player) then return end
  -- if not serverValidate(player) then return end

  -- print("[SprintXP] Passed validation checks, granting XP")

  grantSprintingXP(player)
end

Events.OnClientCommand.Add(onClientCommand)
