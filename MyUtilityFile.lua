
MyUtility = {}

function MyUtility.DistanceToClosestRune()

	npcBot=GetBot()

	local distance = 99999

	for _,r in pairs(Utility.RuneSpots) do
		local loc=GetRuneSpawnLocation(r);
		if Utility.GetDistance(npcBot:GetLocation(),loc) < distance then
			distance = Utility.GetDistance(npcBot:GetLocation(),loc)
		end
	end
	return distance

end
function MyUtility.HasEscape(unit)

	local npcBot = unit;

	local name = npcBot:GetUnitName()

	if  name == "npc_dota_hero_queenofpain" or
		name == "npc_dota_hero_puck" or
		name == "npc_dota_hero_faceless_void" or
		name == "npc_dota_hero_antimage" or
		name == "npc_dota_hero_mirana" or
		name == "npc_dota_hero_dark_seer" then

		return true
	end

	return false

end



function MyUtility.HasInvisibility(unit)

	local npcBot = unit;

	local name = npcBot:GetUnitName()

	if  name == "npc_dota_hero_bounty_hunter" or
		name == "npc_dota_hero_riki" or
		name == "npc_dota_hero_clinkz" or
		name == "npc_dota_hero_riki" or
		name == "npc_dota_hero_broodmother" or
		name == "npc_dota_hero_weaver"
		then

		return true
	end

	return false

end


function MyUtility.HasDisable(unit)

	local npcBot = unit

	local name = npcBot:GetUnitName()

	if  name == "npc_dota_hero_lion" or
		name == "npc_dota_hero_vengefulspirit" or
		name == "npc_dota_hero_earth" or
		name = "npc_dota_hero_centaur"
	then

		return true
	end

	return false
end

function MyUtility.HasHeal(unit)

	local npcBot = unit

	local name = npcBot:GetUnitName()

	if  name == "npc_dota_hero_oracle" or
		name == "npc_dota_hero_dazzle" or
		name == "npc_dota_hero_warlock" or
		name == "npc_dota_hero_omniknight" or
		name == "npc_dota_hero_abaddon" or
		name == "npc_dota_hero_necrolyte"
	then
		return true
	end

	return false
end

function MyUtility.MoveToLane(lane)
	npcBot = GetBot()

	local TopLane = Vector(-6300, 4100)
	local MidLane = Vector(-540, -320)
	local BotLane = Vector(5900, -5000)

	if lane == 1 then
		npcBot:Action_MoveToLocation(TopLane)

	elseif lane == 2 then
		npcBot:Action_MoveToLocation(MidLane)


	elseif lane == 3 then
		npcBot:Action_MoveToLocation(BotLane)

	end


end

return MyUtility
