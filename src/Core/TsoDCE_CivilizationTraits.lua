local CecilPlayersNum = nil
local CecilPlayersMap = nil

local TraitCecilEmpire = 'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE'
local GreatPeopleTypePrefix = 'GREAT_PERSON_INDIVIDUAL_TSOD_CE_'
local GreatPeopleClassPrefix = 'GREAT_PERSON_CLASS_TSOD_CE_'
local GreatPeopleOfCecilAvailability = 'TSOD_GreatPeopleOfCecilAvailability'

local function startsWith(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function GetPlayersWithTrait(sTrait)
    local tValid = {}
    local iLength = 0

    for _, iPlayer in pairs(PlayerManager.GetWasEverAliveIDs()) do
        local leaderType = PlayerConfigurations[iPlayer]:GetLeaderTypeName()
        for trait in GameInfo.LeaderTraits() do
            if trait.LeaderType == leaderType and trait.TraitType == sTrait then
                tValid[iPlayer] = Players[iPlayer]
                iLength = iLength + 1
            end
        end
        if not tValid[iPlayer] then
            local civType = PlayerConfigurations[iPlayer]:GetCivilizationTypeName()
            for trait in GameInfo.CivilizationTraits() do
                if trait.CivilizationType == civType and trait.TraitType == sTrait then
                    tValid[iPlayer] = Players[iPlayer]
                    iLength = iLength + 1
                end
            end
        end
    end
    return tValid, iLength
end

function GrantGreatPeopleOfCecil(iPlayer, sType, sClass, sEra)
    print('Start granting great people')
    local pPlayer = Players[iPlayer]
    local tList = pPlayer:GetProperty(GreatPeopleOfCecilAvailability)
    if not tList or #tList < 1 then
		if tList == nil then
			print("null tList")
		else
			print("Length of tList: " .. #tList)
		end
        return
    end

	 for key, value in pairs(tList) do
        print(key .. ': ' .. tostring(value))
    end

    local sFullType = GreatPeopleTypePrefix .. sType
    local sFullClass = GreatPeopleClassPrefix .. sClass

	if tList[sFullType] == false then
		print(sFullType .. ' has already been granted')
		return
	end

    print('Granting ' .. sFullType)

    if not GameInfo.GreatPersonIndividuals[sFullType] or not GameInfo.GreatPersonClasses[sFullClass] or not GameInfo.Eras[sEra] then
        print(string.format('Error: Invalid Great Person - Type: %s, Class: %s, Era: %s', sType, sClass, sEra))
        return
    end

    local hIndividual = GameInfo.GreatPersonIndividuals[sFullType].Hash
    local hClass = GameInfo.GreatPersonClasses[sFullClass].Hash
    local hEra = GameInfo.Eras[sEra].Hash

    Game.GetGreatPeople():GrantPerson(hIndividual, hClass, hEra, 0, iPlayer, false)

    tList[sFullType] = false
    pPlayer:SetProperty(GreatPeopleOfCecilAvailability, tList)

    print('Granted great person ' .. sFullType .. ' to TSOD Cecil Empire player')
end

function TsodCecilEmpireDistrictConstructed(iPlayer, iDistrictType, iX, iY)
    print('TSOD it triggered the event')

    if CecilPlayersMap == nil then
        print('Somehow the TSOD map is nil')
        return
    end

    local pPlayer = CecilPlayersMap[iPlayer]
    if not pPlayer then
        print("Somehow the TSOD player doesn't exist in the map")
        return
    end

    local sDistrict = GameInfo.Districts[iDistrictType].DistrictType
    print('District type is ' .. sDistrict)
    if sDistrict == 'DISTRICT_CAMPUS' then
        GrantGreatPeopleOfCecil(iPlayer, 'REBECCA_CECIL', 'SCIENTIST', 'ERA_CLASSICAL')
    end
end

function InitGreatPeopleOfCecil()
    print('Initializing TSOD Cecil Empire civilization traits...')
    local tGreatPeopleAvailability = {}

    CecilPlayersMap, CecilPlayersNum = GetPlayersWithTrait(TraitCecilEmpire)
    if (CecilPlayersNum < 1) then
        return
    end

    for _, pPlayer in pairs(CecilPlayersMap) do
        local tList = pPlayer:GetProperty(GreatPeopleOfCecilAvailability)

		if tList == nil then
			print("null tList")
		else
			print("Length of tList: " .. #tList)
		end

        if (not tList) or (#tList < 1) then
            for tRow in GameInfo.GreatPersonIndividuals() do
                if startsWith(tRow.GreatPersonIndividualType, GreatPeopleTypePrefix) then
					tGreatPeopleAvailability[tRow.GreatPersonIndividualType] = true
                    table.insert(tGreatPeopleAvailability, tRow.GreatPersonIndividualType)
                end
            end
            for key, value in pairs(tGreatPeopleAvailability) do
                print(key .. ': ' .. tostring(value))
            end
            pPlayer:SetProperty(GreatPeopleOfCecilAvailability, tGreatPeopleAvailability)
        end
    end

    GameEvents.OnDistrictConstructed.Add(TsodCecilEmpireDistrictConstructed)
    print('Successfully initialized TSOD Cecil Empire civilization traits')
end

InitGreatPeopleOfCecil()
