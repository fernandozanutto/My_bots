MyU = require(GetScriptDirectory().."/MyUtilityFile")

local AlliesTopLane = {}
local AlliesMidLane = {}
local AlliesBotLane = {}

local Targets = {}
local LaneToGank = nil
local FinalTarget = nil

function OnStart()
	local npcBot = GetBot()
	npcBot.Action = "LookingForGank"

end


function OnEnd()
end

function UpdateAllies()

	AlliesTopLane = {}
	AlliesMidLane = {}
	AlliesBotLane = {}

	local npcBot = GetBot()

	for j=1,5,1 do

		local ally=GetTeamMember(j);

		if ally~=nil and ally:GetUnitName() ~= "npc_dota_hero_riki" then

			local allyLane = ally:GetAssignedLane()

			if allyLane == LANE_TOP then
				table.insert(AlliesTopLane, ally)
				--print(ally:GetUnitName() .. " inserido no top")
			elseif allyLane == LANE_MID then
				table.insert(AlliesMidLane, ally)
				--print(ally:GetUnitName() .." inserido no mid")
			elseif allyLane == LANE_BOT then
				table.insert(AlliesBotLane, ally)
				--print(ally:GetUnitName() .." inserido no bot")
			end

		end
	end

end

function GetLaneToGank()

	local Lanes = {AlliesTopLane, AlliesMidLane, AlliesBotLane};
	local Desire = {}
	local Enemies = {}
	local Target = {}

	for x, lane in pairs(Lanes) do

		local desire = 1;

		if #lane ~= 0 and lane~=nil then
			for x, ally in pairs(lane) do

				if ally ~= nil then

					local EnemiesNearAllies = ally:GetNearbyHeroes(1500, true, BOT_MODE_NONE)


					if #EnemiesNearAllies~=0 and EnemiesNearAllies~=nil then

						--this should check how hard is to gank the lane
						local EnemiesWithDisables = 0
						local EnemiesWithHeals = 0
						local EnemiesWithInvi = 0
						local EnemiesWithEscapes = 0


						for _, enemy in pairs(EnemiesNearAllies) do
							--print(enemy:GetUnitName() )

							if MyU.HasEscape(enemy) then
								EnemiesWithEscapes = EnemiesWithEscapes + 1
							end

							if MyU.HasInvisibility(enemy) then
								EnemiesWithInvi = EnemiesWithInvi + 1
							end

							if MyU.HasHeal(enemy) then
								EnemiesWithHeals = EnemiesWithHeals + 1
							end

							if MyU.HasDisable(enemy) then
								EnemiesWithDisables = EnemiesWithDisables + 1
							end


						end

						desire = desire - EnemiesWithEscapes*0.15

						desire = desire - EnemiesWithInvi*0.05

						desire = desire - EnemiesWithHeals*0.10

						desire = desire - EnemiesWithDisables*0.15

						Target[x] = EnemiesNearAllies
					else
						print("nenhum inimigo perto, lane: " .. x)
					end

				end
			end
			print(desire)
			Desire[x] = desire;
		end


	end

	local max = 0
	local Lane = nil

	for index, value in pairs(Desire) do
		if value > max then
			Lane = index
		end
	end

	return Lane, Target[Lane]


end

function GetDesire()

	--local npcBot = GetBot()

	if DotaTime()>30 then
		return 0.1
	end

	return 0
end


function Think()
	local npcBot = GetBot()

	print(npcBot.Action)

	if npcBot.Action == "LookingForGank" then

		UpdateAllies()

		LaneToGank, Targets = GetLaneToGank()

		if LaneToGank~=nil and Targets~=nil then
			npcBot.Action = "Ganking"
			return
		end
	end

	if npcBot.Action == "Ganking" then
		npcBot.Targets = Targets
		MyU.MoveToLane(LaneToGank)
		return
	end


end
