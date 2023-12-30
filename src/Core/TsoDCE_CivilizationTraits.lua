local CecilPlayersNum = nil;
local CecilPlayersMap = nil;

local TraitCecilEmpire = "TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE";
local GreatPeopleTypePrefix = "GREAT_PERSON_INDIVIDUAL_TSOD_";
local GreatPeopleClassPrefix = "GREAT_PERSON_CLASS_TSOD_CECIL_EMPIRE_";

function GetPlayersWithTrait(sTrait)
    local tValid = {};
    local iLength = 0;

    for _, iPlayer in pairs(PlayerManager.GetWasEverAliveIDs()) do
        local leaderType = PlayerConfigurations[iPlayer]:GetLeaderTypeName();
        for trait in GameInfo.LeaderTraits() do
            if trait.LeaderType == leaderType and trait.TraitType == sTrait then
                tValid[iPlayer] = Players[iPlayer];
                iLength = iLength + 1;
            end
        end
        if not tValid[iPlayer] then
            local civType = PlayerConfigurations[iPlayer]:GetCivilizationTypeName();
            for trait in GameInfo.CivilizationTraits() do
                if trait.CivilizationType == civType and trait.TraitType == sTrait then
                    tValid[iPlayer] = Players[iPlayer];
                    iLength = iLength + 1;
                end
            end
        end
    end
    return tValid, iLength
end

function GrantGreatPeopleOfCecil(iPlayer, sType, sClass, sEra)
    local sFullType = GreatPeopleTypePrefix .. sType
    local sFullClass = GreatPeopleClassPrefix .. sClass

    local hIndividual = GameInfo.GreatPersonIndividuals[sFullType].Hash;
    local hClass = GameInfo.GreatPersonClasses[sFullClass].Hash;
    local hEra = GameInfo.Eras[sEra].Hash;

    Game.GetGreatPeople():GrantPerson(hIndividual, hClass, hEra, 0, iPlayer, false);
    print("Granted great person " .. sFullType .. " to TSOD Cecil Empire player")
end

function TsodCecilEmpireDistrictConstructed(iPlayer, iDistrictType, iX, iY)
    print("TSOD it triggered the event")

    if CecilPlayersMap == nil then
        print("Somehow the TSOD map is nil")
        return
    end

    local pPlayer = CecilPlayersMap[iPlayer]
    if not pPlayer then
        print("Somehow the TSOD player doesn't exist in the map")
        return
    end

    local sDistrict = GameInfo.Districts[iDistrictType].DistrictType
    if sDistrict == "DISTRICT_CAMPUS" then
        GrantGreatPeopleOfCecil(iPlayer, "REBECCA_CECIL", "SCIENTIST", "ERA_CLASSICAL")
    end
end

function InitGreatPeopleOfCecil()
    print("Initializing TSOD Cecil Empire civilization traits...")

    CecilPlayersMap, CecilPlayersNum = GetPlayersWithTrait(TraitCecilEmpire)
    if (CecilPlayersNum < 1) then
        print("TSOD Cecil Empire player not found, exit the script")
        return
    end

    GameEvents.OnDistrictConstructed.Add(TsodCecilEmpireDistrictConstructed)
    print("Successfully initialized TSOD Cecil Empire players")
end

InitGreatPeopleOfCecil();
