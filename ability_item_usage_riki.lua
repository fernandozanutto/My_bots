

local Abilities = {
	"riki_smoke_screen",
	"riki_blink_strike",
	"riki_permanent_invisibility",
	"riki_tricks_of_the_trade"
}

local Talents = {
	"special_bonus_movement_speed_15", -- lvl 10 talent
	"special_bonus_agility_10", --lvl 15 talent
	"special_bonus_all_stats_8", --lvl 20 talent
	"special_bonus_unique_riki_2" -- lvl 25 talent (not sure if the +agi multplier is 1 or 2)
}

local AbilityPriority = {
	Abilities[3], --lvl 1
	Abilities[2],
	Abilities[3],
	Abilities[1],
	Abilities[3], --lvl 5
	Abilities[4],
	Abilities[3],
	Abilities[2],
	Abilities[2],
	Talents[1],   --lvl 10
	Abilities[2],
	Abilities[1],
	Abilities[1],
	Abilities[1],
	Talents[2],   --lvl 15
	Abilities[4], --lvl 18
	Talents[3],   --lvl 20
	Talents[4]    --lvl 25
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
	
end
