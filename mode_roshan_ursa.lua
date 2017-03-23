
function OnStart()
	print ("URSA GOING ROSH")
	rosh = nil
	npcBot=GetBot()
	npcBot.RoshState = "going"

end

function OnEnd()
	return
end

function GetDesire()

	local npcBot = GetBot();

	if (Utility.IsItemInInventory("item_helm_of_the_dominator") and GetRoshanKillTime()>DotaTime()-660) and npcBot:GetLevel()>=6 then
		npcBot.IsRoshing = true;
		return 0.3
	end


	return 0;
end

function Think()

	local npcBot = GetBot()

	--print(npcBot:GetUnitName())

	--print(npcBot.RoshState)

	if not npcBot.IsRoshing then
		return
	end


	if npcBot.RoshState == nil then
		npcBot.RoshState = "going"
		return
	end

	if npcBot.RoshState == "going" then
		npcBot:Action_MoveToLocation(Utility.Locations.Rosh)
	end

	if npcBot.RoshState == "roshing" then

		npcBot.W()

		if npcBot:HasModifier("modifier_ursa_overpower") and npcBot:GetHealth()<npcBot:GetMaxHealth()*0.5 then
			npcBot.R()
		end
		npcBot:Action_AttackUnit(rosh)
	end

	local distance = GetUnitToLocationDistance(npcBot, Utility.ROSHAN)
	
	print(distance)
	if distance > 500 then
		npcBot.RoshState = "going"
	end

	if distance < 2000 then
		npcBot.W();
	end

	if distance < 200 then

		near = npcBot:GetNearbyCreeps(400, true);

		if near ~= nil and #near~=0 then

			for _, creep in pairs(near) do

				if (creep:GetUnitName() == "npc_dota_roshan") then
					npcBot:Action_Chat("ROSH", true)
					rosh = creep
					npcBot.RoshState = "roshing"
				end
			end
		else
			print("nenhum creep")
		end

	end

end
