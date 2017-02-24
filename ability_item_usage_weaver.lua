

Utility = require( GetScriptDirectory().."/Utility");

local AbilityPriority = {
"weaver_shukuchi",
"weaver_geminate_attack",
"weaver_the_swarm",
"weaver_shukuchi",
"weaver_shukuchi",
"weaver_time_lapse",
"weaver_shukuchi",
"weaver_the_swarm",
"weaver_the_swarm",
"special_bonus_strength_6",
"weaver_the_swarm",
"weaver_time_lapse",
"weaver_geminate_attack",
"weaver_geminate_attack",
"weaver_geminate_attack",
"special_bonus_all_stats_7",
"weaver_time_lapse",
"special_bonus_agility_15",
"special_bonus_unique_weaver_2 "
};

local function LevelUp()
	if #AbilityPriority==0 then
		return;
	end

	if DotaTime()<0 then
		return;
	end

    local npcBot = GetBot();

	local ability=npcBot:GetAbilityByName(AbilityPriority[1]);

	if (ability~=nil and ability:CanAbilityBeUpgraded() and ability:GetLevel()<ability:GetMaxLevel()) then
		npcBot:ActionImmediate_LevelAbility(AbilityPriority[1]);
		table.remove( AbilityPriority, 1 );
	else
		table.remove( AbilityPriority, 1 );
	end
end



function AbilityUsageThink()

	local npcBot=GetBot();

	LevelUp()

	if npcBot:IsUsingAbility() then return end

	theSwarm = npcBot:GetAbilityByName("weaver_the_swarm")
	shukuchi = npcBot:GetAbilityByName("weaver_shukuchi")
	timeLapse = npcBot:GetAbilityByName("weaver_time_lapse")

	castTheSwarm, target = ConsiderTheSwarm()
	castShukuchi, targetShukuchi = ConsiderShukuchi()
	castTimeLapse = ConsiderTimeLapse()

	if (castTimeLapse>0) then
		npcBot:Action_UseAbility(timeLapse)
		return
	end

	if(castTheSwarm > 0 and castTheSwarm > castShukuchi and target~=nil) then
		npcBot:Action_UseAbilityOnLocation(theSwarm, target:GetLocation())
	end

	if (castShukuchi > 0) then
		if targetShukuchi ~= nil then
			npcBot:Action_UseAbility(shukuchi)
			npcBot:Action_MoveToLocation(targetShukuchi:GetLocation())
		else
			npcBot:Action_UseAbility(shukuchi)
		end
	end

end


function ConsiderTheSwarm()

	--TODO change this to target as many heroes as possible
	local npcBot = GetBot();

	if( not theSwarm:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE
	end

	local npcMode = npcBot:GetActiveMode()


	if (npcMode == BOT_MODE_LANING and #npcBot:GetNearbyTowers(1500 + GetUnitToUnitDistance(npcBot, npcTarget), true)==0 and npcBot:GetMana()>200) then

		local damage = 0

		local nearbyAllies = npcBot:GetNearbyHeroes(1200, false, BOT_MODE_NONE)
		local nearbyEnemies = npcBot:GetNearbyHeroes(900, true, BOT_MODE_NONE)

		for _, enemy in pairs (nearbyEnemies) do
			for _, ally in pairs (nearbyAllies) do
				damage = damage + ally:GetEstimatedDamageToTarget(true, enemy, 7, DAMAGE_TYPE_ALL)
			end

			if damage > enemy:GetHealth()*0.7 then

				return BOT_ACTION_DESIRE_MODERATE, enemy
			end
			return BOT_ACTION_DESIRE_HIGH, enemy;
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


	if (npcMode == BOT_MODE_RETREAT and npcBot:GetHealth() < npcBot:GetMaxHealth()*0.3) then
		return BOT_ACTION_DESIRE_HIGH
	end


	--[[if (npcMode == BOT_MODE_GANK or
		npcMode == BOT_MODE_ROAM or
		npcMode == BOT_MODE_TEAM_ROAM or
		npcMode == BOT_MODE_DEFEND_ALLY or
		npcMode == BOT_MODE_ATTACK) then

		local npcTarget = npcBot:GetTarget()

		if (npcTarget ~= nil) then
			return BOT_ACTION_DESIRE_HIGH, npcTarget
		end
	end]]

	return BOT_ACTION_DESIRE_NONE

end

function ConsiderTimeLapse()

	local npcBot = GetBot();

	if (not timeLapse:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE
	end

	local nearbyEnemies = npcBot:GetNearbyHeroes(800, true, BOT_MODE_NONE);


	--if weaver is in danger
	if(	#nearbyEnemies>0 and (npcBot:GetHealth() < npcBot:GetMaxHealth()*0.25)) then

		return BOT_ACTION_DESIRE_HIGH
	end

	return BOT_ACTION_DESIRE_NONE

end
