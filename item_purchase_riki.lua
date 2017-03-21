local npcBot = GetBot()

npcBot.ItemsToBuy = {
	"item_orb_of_venom",
	"item_tango",
	"item_blight_stone"
	"item_boots",
	"item_magic_stick",
	"item_blade_of_alacrity",
	"item_blade_of_alacrity",
	"item_robe",
	"item_diffusal_blade_recipe",
	"item_basher"
}


function ItemPurchaseThink()

	local npcBot = GetBot();

	if ( npcBot.ItemsToBuy==nil or #npcBot.ItemsToBuy == 0 ) then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local Next = npcBot.ItemsToBuy[1]

	if (not IsItemPurchasedFromSecretShop(Next)) and (not(IsItemPurchasedFromSideShop(Next) and npcBot:DistanceFromSideShop()<=2200)) then
		if ( npcBot:GetGold() >= GetItemCost( Next ) ) then
			npcBot:ActionImmediate_PurchaseItem( Next );
			table.remove( npcBot.ItemsToBuy, 1 );
		end
	end

end
