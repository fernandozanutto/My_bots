Utility = require(GetScriptDirectory().."/Utility")

local npcBot = GetBot()

npcBot.ItemsToBuy = {
	"item_courier",
	"item_tango",
	"item_ward_observer",
    "item_ward_observer",
    "item_branches",
    "item_branches",
    "item_boots",
    "item_energy_booster",
	"item_chainmail",
	"item_recipe_buckler",
	"item_ring_of_health",
	"item_recipe_headdress",
	"item_recipe_mekansm",
    "item_ring_of_regen",
	"item_staff_of_wizardry",
	"item_force_staff"
}


function ItemPurchaseThink()

	local npcBot = GetBot();

	if ( npcBot.ItemsToBuy==nil or #npcBot.ItemsToBuy == 0 ) then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end


    if (Utility.IsItemInInventory("item_boots")) and GetItemStockCount("item_ward_observer")>0 then
		npcBot:ActionImmediate_PurchaseItem("item_ward_observer")
		return
	end

	local Next = npcBot.ItemsToBuy[1]

	if (not IsItemPurchasedFromSecretShop(Next)) and (not(IsItemPurchasedFromSideShop(Next) and npcBot:DistanceFromSideShop()<=2200)) then
		if ( npcBot:GetGold() >= GetItemCost( Next ) ) then
			npcBot:ActionImmediate_PurchaseItem( Next );
			table.remove( npcBot.ItemsToBuy, 1 );
		end
	end

end
