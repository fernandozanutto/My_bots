

local npcBot=GetBot();

npcBot.ItemsToBuy = {
"item_stout_shield",
"item_tango",
"item_branches",
"item_flask",
"item_boots",
"item_wind_lace",
"item_blades_of_attack",
"item_blades_of_attack",
"item_gloves",
"item_ring_of_regen",
"item_recipe_headdress",
"item_recipe_helm_of_the_dominator",
"item_blink_dagger",
"item_basher",
"item_ultimate_scepter"
};

function ItemPurchaseThink()

	local npcBot = GetBot();
	
	if ( npcBot.ItemsToBuy==nil or #npcBot.ItemsToBuy == 0 ) then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local NextItem = npcBot.ItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( NextItem ) );

	if (not IsItemPurchasedFromSecretShop(NextItem)) and (not(IsItemPurchasedFromSideShop(NextItem) and npcBot:DistanceFromSideShop()<=2200)) then
		if ( npcBot:GetGold() >= GetItemCost( NextItem ) ) then
			npcBot:ActionImmediate_PurchaseItem( NextItem );
			table.remove( npcBot.ItemsToBuy, 1 );
		end
	end
end