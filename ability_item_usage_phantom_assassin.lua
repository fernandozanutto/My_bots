------------------------------------------------------------
--- AUTHOR: PLATINUM_DOTA2 (Pooya J.)
--- EMAIL ADDRESS: platinum.dota2@gmail.com
------------------------------------------------------------
--- edited by /u/zanutto

Utility = require( GetScriptDirectory().."/Utility");

local Abilities={
	"phantom_assassin_stifling_dagger",
	"phantom_assassin_phantom_strike",
	"phantom_assassin_blur",
	"phantom_assassin_coup_de_grace"
};


local function UseQ()
	local npcBot = GetBot();
	
	local ability=npcBot:GetAbilityByName(Abilities[1]);
	
	if not ability:IsFullyCastable() then
		return;
	end
	
	local plus_damage = {0.25, 0.40, 0.55, 0.70}
	
	local levelQ = ability:GetLevel()
	
	local damage = 65 + (npcBot:GetAttackDamage()*plus_damage[levelQ])
	
	
	local creep=nil;
	local chealth=10000;
	
	creep,chealth=Utility.GetWeakestCreep(ability:GetCastRange()+200);
	if creep~=nil and chealth<creep:GetActualDamage(damage,DAMAGE_TYPE_PHYSICAL) then
		if (Utility.GetDistance(creep:GetLocation(),npcBot:GetLocation())>npcBot:GetAttackRange()+150 or Utility.GetUnitsAttacking(creep)>2) and (npcBot:GetMana()>60)  then
			npcBot:Action_UseAbilityOnEntity(ability,creep);
			return;
		end
	end
	
	
	local enemy=nil;
	local health=10000;
	
	enemy,health=Utility.GetWeakestHero(ability:GetCastRange()+100);
	if enemy~=nil and (npcBot:GetMana()>100) then
		npcBot:Action_UseAbilityOnEntity(ability,enemy);
		return;
	end
	
end


local function UseW()
	local npcBot = GetBot();
	
	local ability = npcBot:GetAbilityByName(Abilities[2]);
	
	if not ability:IsFullyCastable() then
		return;
	end
	
	
	local enemy=nil;
	local health = 10000;
	
	enemy,health = Utility.GetWeakestHero(ability:GetCastRange()+100);
	if((enemy~=nil and health<250) ) then
		npcBot:Action_UseAbilityOnEntity(ability, enemy);
		return;
	end
end


-----------
function AbilityUsageThink()
	
	local npcBot=GetBot();

	if npcBot:GetActiveMode()==BOT_MODE_RETREAT then
		return;
	end
	UseQ();
	UseW();
	
end
