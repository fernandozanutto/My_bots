

Utility = require( GetScriptDirectory().."/Utility");

function AbilityUsageThink()
	
	local npcBot=GetBot();

	if npcBot:IsUsingAbility() then return end

	theSwarm = npcBot:GetAbilityByName("weaver_the_swarm")
	shukuchi = npcBot:GetAbilityByName("weaver_shukuchi")
	timeLapse = npcBot:GetAbilityByName("weaver_time_lapse")

	castTheSwarm, target = ConsiderTheSwarm()
	castShukuchi = ConsiderShukuchi()
	castTimeLapse = ConsiderTimeLapse()

	if (castTimeLapse>0) then
		npcBot:Action_UseAbility(timeLapse)
		return
	end

	if(castTheSwarm > 0) then
		npcBot:Action_UseAbilityOnEntity(theSwarm, target)
	end

	if (castShukuchi > 0) then
		npcBot:Action_UseAbility(shukuchi)
	end

end


function ConsiderTheSwarm()
	--TODO change this to target as many heroes as possible
	local npcBot = GetBot();
	if( not theSwarm:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE
	end

	local npcMode = npcBot:GetActiveMode()

	if (npcMode == BOT_MODE_GANK or
		npcMode == BOT_MODE_ROAM or
		npcMode == BOT_MODE_TEAM_ROAM or
		npcMode == BOT_MODE_DEFEND_ALLY) then

		local npcTarget = npcBot:GetTarget()

		if (npcTarget ~= nil) then
			return BOT_ACTION_DESIRE_HIGH, npcTarget:GetLocation()
		end
	end

	if (npcMode == BOT_MODE_LANING) then

		damage = 0

		local nearbyAllies = npc:GetNearbyHeroes(1200, false, BOT_MODE_NONE)
		local nearbyEnemies = npcBot:GetNearbyHeroes(900, true, BOT_MODE_NONE)

		for _, enemy in pairs (nearbyEnemies) do
			for _, ally in pairs (nearbyAllies) do
				damage = damage + ally:GetEstimatedDamageToTarget(true, enemy, 7, DAMAGE_TYPE_ALL)
			end

			if damage > enemy:GetHealth()*0.7 then
				return BOT_ACTION_DESIRE_MODERATE, enemy
			end
		end

	return BOT_ACTION_DESIRE_NONE, 0

end



function ConsiderShukuchi()

	local npcBot = GetBot();


	if( not shukuchi:IsFullyCastable() or Utility.GetDistance(Utility.Fountain(GetTeam()), npcBot:GetLocation()) < 300) then
		return BOT_ACTION_DESIRE_NONE
	end

	local npcMode = npcBot:GetActiveMode()
	

	if (npcMode == BOT_MODE_RETREAT) then
		return BOT_ACTION_DESIRE_HIGH
	end


	if (npcMode == BOT_MODE_GANK or
		npcMode == BOT_MODE_ROAM or
		npcMode == BOT_MODE_TEAM_ROAM or
		npcMode == BOT_MODE_DEFEND_ALLY) then

		local npcTarget = npcBot:GetTarget()

		if (npcTarget ~= nil) then
			return BOT_ACTION_DESIRE_HIGH
		end
	end

	return BOT_ACTION_DESIRE_NONE

end

function ConsiderTimeLapse()

	local npcBot = GetBot();

	if (not timeLapse:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE
	end


	--if weaver is in danger
	if((npcBot:GetNearbyHeroes(800, true, BOT_MODE_NONE)>0) and (npcBot:GetHealth() < npcBot:GetMaxHealth()*0.25)) then
		return BOT_ACTION_DESIRE_HIGH
	end

	return BOT_ACTION_DESIRE_NONE

end