------------------------------------------------------------
--- AUTHOR: PLATINUM_DOTA2 (Pooya J.)
--- EMAIL ADDRESS: platinum.dota2@gmail.com
------------------------------------------------------------
local pontosQ =0;
local pontosW = 0;
local pontosE = 0;
local pontosR = 0;

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

local npcBot=GetBot();

npcBot.ItemsToBuy = {
"item_ring_of_protection",
"item_circlet",
"item_branches",
"item_tango",
"item_flask",
"item_sobi_mask",
"item_slippers",
"item_wraith_band_recipe",
"item_boots",
"item_blight_stone",
"item_ring_of_health",
"item_boots_of_elves",
"item_gloves",
"item_mithril_hammer",
"item_mithril_hammer",
"item_void_stone",
"item_ultimate_orb",
"item_recipe_sphere"
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
		npcBot:Action_LevelAbility(AbilityPriority[1]);
		table.remove( AbilityPriority, 1 );
	else
		table.remove( AbilityPriority, 1 );
	end
end

function ItemPurchaseThink()

	local npcBot = GetBot();
	
	if npcBot:GetAbilityPoints()>0 then
		LevelUp();
	end
	
	
	if ( npcBot.ItemsToBuy==nil or #npcBot.ItemsToBuy == 0 ) then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local NextItem = npcBot.ItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( NextItem ) );

	if (not IsItemPurchasedFromSecretShop(NextItem)) and (not(IsItemPurchasedFromSideShop(NextItem) and npcBot:DistanceFromSideShop()<=2200)) then
		if ( npcBot:GetGold() >= GetItemCost( NextItem ) ) then
			npcBot:Action_PurchaseItem( NextItem );
			table.remove( npcBot.ItemsToBuy, 1 );
		end
	end
end