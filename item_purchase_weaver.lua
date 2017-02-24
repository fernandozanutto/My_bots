
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
			npcBot:ActionImmediate_PurchaseItem( NextItem );
			table.remove( npcBot.ItemsToBuy, 1 );
		end
	end
end
