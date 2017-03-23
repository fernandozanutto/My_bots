------------------------------------------------------------
--- AUTHOR: PLATINUM_DOTA2 (Pooya J.)
--- EMAIL ADDRESS: platinum.dota2@gmail.com
------------------------------------------------------------

local MyBots={"npc_dota_hero_luna", "npc_dota_hero_ursa", "npc_dota_hero_weaver", "npc_dota_hero_riki", "npc_dota_hero_dazzle"};

function Think()
	local IDs=GetTeamPlayers(GetTeam());
	for i,id in pairs(IDs) do
		if IsPlayerBot(id) then
			SelectHero(id,MyBots[i]);
		end
	end
end

------------------------

function UpdateLaneAssignments()  
	
	
    if ( GetTeam() == TEAM_RADIANT )
    then
        return {
        [1] = LANE_BOT,
		[2] = LANE_MID,
		[3] = LANE_TOP,
		[4] = LANE_TOP,
		[5] = LANE_BOT,
        };
		
    elseif ( GetTeam() == TEAM_DIRE )
    then
        return {
        [1] = LANE_TOP,
		[2] = LANE_MID,
		[3] = LANE_BOT,
		[4] = LANE_BOT,
		[5] = LANE_TOP,
       
        };
    end
end
