----------
Utility = require( GetScriptDirectory().."/Utility")
----------
local ClosestRune = nil
function  OnStart()

	local npcBot = GetBot()

	for _,r in pairs(Utility.RuneSpots) do
		local loc=GetRuneSpawnLocation(r);
		if Utility.GetDistance(npcBot:GetLocation(),loc)<900 and GetRuneStatus(r)==RUNE_STATUS_AVAILABLE then
			npcBot:Action_PickUpRune(r);
			return;
		end
	end

end

function OnEnd()
end

function GetDesire()

	local npcBot=GetBot();

	if DotaTime()<0 then
		return 0.5;
	end

	local minutes = math.floor(DotaTime() / 60);
	local seconds = math.floor(DotaTime());
	local seconds=seconds % 60;


	local TimeToRuneSpawn = 10000

	if minutes % 2 == 1 then
		TimeToRuneSpawn = 60 - seconds
	else
		TimeToRuneSpawn = 120 - seconds
	end

	if (npcBot.Action~="Ganking" and TimeToRuneSpawn<10) or (MyU.GetDistanceToClosestRune()<1000 and TimeToRuneSpawn<10) then
		
		return 0.5
	end

	return 0.0;
end

function Think()
	local npcBot=GetBot();

	if DotaTime()<-1 then
		npcBot:Action_MoveToLocation(Utility.Locations["DireBotRune"])
	end

	for _,r in pairs(Utility.RuneSpots) do
		local loc=GetRuneSpawnLocation(r);
		if Utility.GetDistance(npcBot:GetLocation(),loc)<900 and GetRuneStatus(r)==RUNE_STATUS_AVAILABLE then
			npcBot:Action_PickUpRune(r);
			return;
		end
	end
end
