------------------------------------------------------------
--- AUTHOR: PLATINUM_DOTA2 (Pooya J.)
--- EMAIL ADDRESS: platinum.dota2@gmail.com
------------------------------------------------------------

-------
require( GetScriptDirectory().."/mode_attack_generic" )
Utility = require(GetScriptDirectory().."/Utility")
----------

local Abilities={
"weaver_the_swarm",
"weaver_shukuchi",
"weaver_geminate_attack",
"weaver_time_lapse"
};

local NearEnemy = false;

function OnStart()
	mode_generic_attack.OnStart();
end

function OnEnd()
	mode_generic_attack.OnEnd();
end

function GetDesire()
	local desire =  mode_generic_attack.GetDesire();
	local npcBot = GetBot()

	if (npcBot.Target ~= nil) then

		if npcBot.Target:HasModifier("modifier_weaver_swarm_debuff") or npcBot.Target:GetHealth() < npcBot.Target:GetMaxHealth()*0.6 then
			return desire + 0.25
		end

	end

	return desire
end

local function UseQ()
	local npcBot=GetBot();

	local ability=npcBot:GetAbilityByName(Abilities[1]);
	if ability==nil or (not ability:IsFullyCastable()) then
		return false;
	end

	if GetUnitToUnitDistance(npcBot.Target,npcBot) < ability:GetCastRange()-75 then
		npcBot:Action_UseAbilityOnLocation(ability,npcBot.Target:GetLocation());
		return true;
	end
	return false;
end

local function UseW()
	local npcBot = GetBot();

	local ability=npcBot:GetAbilityByName(Abilities[2]);

	if ability==nil or (not ability:IsFullyCastable()) then
		return false;
	end


	if (GetUnitToUnitDistance(npcBot, npcBot.Target) > npcBot:GetAttackRange() and npcBot:GetMana() > 100) then
		NearEnemy = false
		npcBot:Action_UseAbility(ability);
		return true
	end

	return false;
end

local function GetCloseToTarget(target)

	local npcBot = GetBot();

	if GetUnitToUnitDistance(npcBot, target)< 175 or NearEnemy then
		return true
	else
		npcBot:Action_MoveToUnit(target)
		return false
	end


end

function Think()

	--mode_generic_attack.Think();

	local npcBot=GetBot();

	if (not npcBot.IsAttacking) or npcBot.Target==nil then
		npcBot.IsAttacking=false;
		return;
	end

	UseQ()

	local shukuchi=npcBot:GetAbilityByName(Abilities[2]);

	if shukuchi~=nil and shukuchi:IsFullyCastable() and GetUnitToUnitDistance(npcBot, npcBot.Target) > npcBot:GetAttackRange() then
		NearEnemy = false;
	end

	if not NearEnemy then

		UseW()
		if(GetCloseToTarget(npcBot.Target)) then
			NearEnemy = true
		end
		return;
	end

	if NearEnemy then

		npcBot:Action_AttackUnit(npcBot.Target, false);
		return;
	end
end

--------
