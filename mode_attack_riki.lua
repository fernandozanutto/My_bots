
require( GetScriptDirectory().."/mode_attack_generic" )
Utility = require(GetScriptDirectory().."/Utility")
MyU = require(GetScriptDirectory().."/MyUtilityFile")

function OnStart()
	mode_generic_attack.OnStart();
end

function OnEnd()
	mode_generic_attack.OnEnd();
end

function GetDesire()
	npcBot = GetBot()

	if npcBot.Action == "Ganking" then

		for _, target in pairs (npcBot.Target) do
			if GetUnitToUnitDistance(npcBot, target)<3000 then
				return 1;
			end
		end
	end

end


function Think()
	mode_generic_attack.Think();
end
