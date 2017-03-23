

local Abilities = {
	"ursa_earthshock",
	"ursa_overpower",
	"ursa_fury_swipes",
	"ursa_enrage"
}

local Talents = {
	"special_bonus_attack_damage_25", -- lvl 10 talent
	"special_bonus_attack_speed_20", --lvl 15 talent
	"special_bonus_movement_speed_15", --lvl 20 talent
	"special_bonus_all_stats_14" -- lvl 25 talent
}

local AbilityPriority = {
	Abilities[3],
	Abilities[2],
	Abilities[3],
	Abilities[2],
	Abilities[3],
	Abilities[4],
	Abilities[3],
	Abilities[2],
	Abilities[1],
	Talents[1],
	Abilities[1],
	Abilities[2],
	Abilities[1],
	Abilities[1],
	Talents[2],
	Abilities[4],
	Talents[3],
	Talents[4]
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



function UseQ()
	local npcBot = GetBot()

	local ability = npcBot:GetAbilityByName(Abilities[1])

	if ability ~= nil and ability:IsFullyCastable() then
		npcBot:Action_UseAbility(ability)
	end

end

function UseW()
	local npcBot = GetBot()

	local ability = npcBot:GetAbilityByName(Abilities[2])

	if ability ~= nil and ability:IsFullyCastable() then
		npcBot:Action_UseAbility(ability)
	end

end

function UseR()
	local npcBot = GetBot()

	local ability = npcBot:GetAbilityByName(Abilities[4])

	if ability ~= nil and ability:IsFullyCastable() then
		npcBot:Action_UseAbility(ability)
	end
end


function AbilityUsageThink()

	local npcBot=GetBot();

	if npcBot:GetAbilityPoints()>0 then
		LevelUp();
	end

	npcBot.Q = UseQ;
	npcBot.W = UseW;
	npcBot.R = UseR;

	npcBot:Action_UseAbility(GetItemByName("item_phase_boots"));




end
