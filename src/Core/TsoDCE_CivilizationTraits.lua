include('GameCapabilities')

local CecilPlayersNum = nil
local CecilPlayersMap = nil

local TraitCecilEmpire = 'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE'
local GreatPeopleTypePrefix = 'GREAT_PERSON_INDIVIDUAL_TSOD_CE_'
local GreatPeopleClassPrefix = 'GREAT_PERSON_CLASS_TSOD_CE_'
local GreatPeopleOfCecilAvailability = 'TSOD_GreatPeopleOfCecilAvailability'

local IsHettiCecilActivated = GreatPeopleTypePrefix .. 'HETTIE_CECIL_ACTIVATED'

local AllClasses = { 'GENERAL', 'ADMIRAL', 'ENGINEER', 'MERCHANT', 'PROPHET', 'SCIENTIST', 'WRITER', 'ARTIST', 'MUSICIAN' }
local GawainGreatPeopleActivated = 'TSOD_GawainGreatPeopleActivated'

local function startsWith(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

local function endsWith(str, ending)
    return ending == '' or str:sub(- #ending) == ending
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

function GrantGreatPeopleOfCecil(playerId, sType, sClass, sEra)
    local pPlayer = Players[playerId]
    local tList = pPlayer:GetProperty(GreatPeopleOfCecilAvailability)
    if not tList or #tList < 1 then
        return
    end

    local sFullType = GreatPeopleTypePrefix .. sType
    local sFullClass = GreatPeopleClassPrefix .. sClass

    if tList[sFullType] == false then
        return
    end

    if not GameInfo.GreatPersonIndividuals[sFullType] or not GameInfo.GreatPersonClasses[sFullClass] or not GameInfo.Eras[sEra] then
        print(string.format('Error: Invalid Great Person - Type: %s, Class: %s, Era: %s', sType, sClass, sEra))
        return
    end

    local hIndividual = GameInfo.GreatPersonIndividuals[sFullType].Hash
    local hClass = GameInfo.GreatPersonClasses[sFullClass].Hash
    local hEra = GameInfo.Eras[sEra].Hash

    Game.GetGreatPeople():GrantPerson(hIndividual, hClass, hEra, 0, playerId, false)

    tList[sFullType] = false
    pPlayer:SetProperty(GreatPeopleOfCecilAvailability, tList)
end

function OnDistrictFirstConstructedGrantGreatPerson(playerId, districtId, _, _)
    if CecilPlayersMap == nil then
        return
    end

    local pPlayer = CecilPlayersMap[playerId]
    if not pPlayer then
        return
    end

    local sDistrict = GameInfo.Districts[districtId].DistrictType
    if sDistrict == 'DISTRICT_CAMPUS' then
        GrantGreatPeopleOfCecil(playerId, 'REBECCA_CECIL', 'SCIENTIST', 'ERA_ANCIENT')
    elseif sDistrict == 'DISTRICT_GOVERNMENT' then
        GrantGreatPeopleOfCecil(playerId, 'HETTIE_CECIL', 'MERCHANT', 'ERA_ANCIENT')
    elseif sDistrict == 'DISTRICT_ENCAMPMENT' then
        GrantGreatPeopleOfCecil(playerId, 'SIR_PHILIP', 'GENERAL', 'ERA_ANCIENT')
    elseif sDistrict == 'DISTRICT_HARBOR' then
        GrantGreatPeopleOfCecil(playerId, 'BYRON_KIRK', 'ADMIRAL', 'ERA_ANCIENT')
    elseif sDistrict == 'DISTRICT_HOLY_SITE' then
        GrantGreatPeopleOfCecil(playerId, 'LEITE_AVIKEN', 'GENERAL', 'ERA_ANCIENT')
    elseif sDistrict == 'DISTRICT_THEATER' then
        GrantGreatPeopleOfCecil(playerId, 'FELM', 'WRITER', 'ERA_ANCIENT')
    elseif sDistrict == 'DISTRICT_COMMERCIAL_HUB' then
        GrantGreatPeopleOfCecil(playerId, 'PITMAN_LAUREN', 'MERCHANT', 'ERA_ANCIENT')
	elseif sDistrict == 'DISTRICT_INDUSTRIAL_ZONE' then
        GrantGreatPeopleOfCecil(playerId, 'NICHOLAS_EGG', 'ENGINEER', 'ERA_ANCIENT')
    elseif sDistrict == 'DISTRICT_PRESERVE' then
        GrantGreatPeopleOfCecil(playerId, 'NORRIS', 'SCIENTIST', 'ERA_ANCIENT')
    end
end

function OnCampusBuildingFirstConstructedGrantGreatPerson(iPlayer, _, buildingID, _, _)
    if CecilPlayersMap == nil then
        return
    end

    local pPlayer = CecilPlayersMap[iPlayer]
    if not pPlayer then
        return
    end

    local sBuilding = GameInfo.Buildings[buildingID].BuildingType
    if sBuilding == 'BUILDING_LIBRARY' then
        GrantGreatPeopleOfCecil(iPlayer, 'JENNIE_PERRO', 'SCIENTIST', 'ERA_CLASSICAL')
    elseif sBuilding == 'BUILDING_UNIVERSITY' then
        GrantGreatPeopleOfCecil(iPlayer, 'SANTIS_SAIDE', 'SCIENTIST', 'ERA_MEDIEVAL')
    elseif sBuilding == 'BUILDING_RESEARCH_LAB' then
        GrantGreatPeopleOfCecil(iPlayer, 'KAMEL_SLAYEN', 'SCIENTIST', 'ERA_MODERN')
    end
end

function OnGreatPersonActivated(playerId, _, _, greatPersonIndividualId)
    if CecilPlayersMap == nil then
        return
    end

    local pPlayer = CecilPlayersMap[playerId]
    if not pPlayer then
        return
    end

    local sIndividual = GameInfo.GreatPersonIndividuals[greatPersonIndividualId].GreatPersonIndividualType
    if sIndividual == GreatPeopleTypePrefix .. 'REBECCA_CECIL' then
        local playerTech = pPlayer:GetTechs()
        local currentTechId = playerTech:GetResearchingTech()
        playerTech:SetResearchProgress(currentTechId, playerTech:GetResearchCost(currentTechId))
    elseif sIndividual == GreatPeopleTypePrefix .. 'KAMEL_SLAYEN' then
        local culturaHerritageCivicId = GameInfo.Civics['CIVIC_CULTURAL_HERITAGE'].Index
        pPlayer:GetCulture():TriggerBoost(culturaHerritageCivicId)
    elseif sIndividual == GreatPeopleTypePrefix .. 'HETTIE_CECIL' then
        pPlayer:SetProperty(IsHettiCecilActivated, true)
    end
end

function OnUnitGreatPersonCreated(playerId, _, classId, _)
    if CecilPlayersMap == nil then
        return
    end

    local pPlayer = CecilPlayersMap[playerId]
    if not pPlayer then
        return
    end

    local tGreatPeopleActivatedList = pPlayer:GetProperty(GawainGreatPeopleActivated)
    if not tGreatPeopleActivatedList then
        print('Great person activated list was not intialized properly')
        return
    end

    local classType = GameInfo.GreatPersonClasses[classId].GreatPersonClassType
    for _, suffix in ipairs(AllClasses) do
        print('Class type: ' .. classType .. ', suffix: ' .. suffix)
        if (endsWith(classType, suffix)) then
            tGreatPeopleActivatedList[suffix] = tGreatPeopleActivatedList[suffix] + 1
            pPlayer:SetProperty(GawainGreatPeopleActivated, tGreatPeopleActivatedList)
            print('Set activation count for ' .. classType .. ': ' .. tGreatPeopleActivatedList[suffix])
            return
        end
    end
end

function OnTurnBegin()
    if CecilPlayersMap == nil then
        return
    end

    for playerId, pPlayer in pairs(CecilPlayersMap) do
        local tGreatPeopleActivatedList = pPlayer:GetProperty(GawainGreatPeopleActivated)
        if not tGreatPeopleActivatedList then
            print('Great person activated list was not intialized properly')
            for k, v in pairs(tGreatPeopleActivatedList) do
                print('key:' .. k .. ',value:' .. v)
                pPlayer:SetProperty(GawainGreatPeopleActivated, tGreatPeopleActivatedList)
            end
            print('Not?' .. tostring(not tGreatPeopleActivatedList))
            print('Length:' .. tostring(#tGreatPeopleActivatedList))
            return
        end
        print('Player ID:', playerId)

        for _, classSuffix in ipairs(AllClasses) do
            local classType = 'GREAT_PERSON_CLASS_' .. classSuffix
            local classId = GameInfo.GreatPersonClasses[classType].Index
            local points = pPlayer:GetGreatPeoplePoints():CalculatePointsPerTurn(classId)
            print(classSuffix .. ': ' .. points)

            local activationCount = tGreatPeopleActivatedList[classSuffix]
            if (activationCount and activationCount > 0) then
                local multiplier = math.min(0.2 + 0.1 * (activationCount - 1), 1)
            local bonusPoints = math.ceil(points * multiplier)
            print('Granting ' .. bonusPoints .. ' points for ' .. activationCount .. ' activated greatpersons')
            pPlayer:GetGreatPeoplePoints():ChangePointsTotal(classId, bonusPoints)
            end
        end
    end
end

function OnMilitaryEngineerBuildRailroad(playerId, unitId, operationId)
    if CecilPlayersMap == nil then
        return
    end

    local pPlayer = CecilPlayersMap[playerId]
    if not pPlayer or pPlayer:GetProperty(IsHettiCecilActivated) ~= true then
        return
    end

    -- One of the worst and useless APIs FML
    local pUnit = pPlayer:GetUnits():FindID(unitId)
    if (not pUnit) then
        return
    end

    local unitType = GameInfo.Units[pUnit:GetType()].UnitType
    if (unitType ~= 'UNIT_MILITARY_ENGINEER') then
        return
    end

    if operationId == UnitOperationTypes.BUILD_ROUTE then
        local coal = GameInfo.Resources['RESOURCE_COAL'].Index
        pPlayer:GetResources():ChangeResourceAmount(coal, 1)
    end
end

function InitTsoDCecilEmpireTraits()
    print('Initializing TSOD Cecil Empire civilization traits...')
    local tGreatPeopleAvailability = {}

    CecilPlayersMap, CecilPlayersNum = GetPlayersWithTrait(TraitCecilEmpire)
    if (CecilPlayersNum < 1) then
        return
    end

    for _, pPlayer in pairs(CecilPlayersMap) do
        local tList = pPlayer:GetProperty(GreatPeopleOfCecilAvailability)
        if (not tList) or (#tList < 1) then
            for tRow in GameInfo.GreatPersonIndividuals() do
                if startsWith(tRow.GreatPersonIndividualType, GreatPeopleTypePrefix) then
                    tGreatPeopleAvailability[tRow.GreatPersonIndividualType] = true
                    table.insert(tGreatPeopleAvailability, tRow.GreatPersonIndividualType)
                end
            end

            pPlayer:SetProperty(GreatPeopleOfCecilAvailability, tGreatPeopleAvailability)
            pPlayer:SetProperty(IsHettiCecilActivated, false)
        end

        local tGreatPeopleActivatedList = pPlayer:GetProperty(GawainGreatPeopleActivated)
        if (not tGreatPeopleActivatedList) or (#tGreatPeopleActivatedList < 1) then
            tGreatPeopleActivatedList = {}
            for _, classSuffix in ipairs(AllClasses) do
                tGreatPeopleActivatedList[classSuffix] = 0
            end

            pPlayer:SetProperty(GawainGreatPeopleActivated, tGreatPeopleActivatedList)
        end
    end

    GameEvents.OnDistrictConstructed.Add(OnDistrictFirstConstructedGrantGreatPerson)
    GameEvents.BuildingConstructed.Add(OnCampusBuildingFirstConstructedGrantGreatPerson)
    Events.UnitGreatPersonActivated.Add(OnGreatPersonActivated)
    Events.UnitOperationStarted.Add(OnMilitaryEngineerBuildRailroad)
    Events.UnitGreatPersonCreated.Add(OnUnitGreatPersonCreated)
    Events.TurnBegin.Add(OnTurnBegin)
    print('Successfully initialized TSOD Cecil Empire civilization traits')
end

InitTsoDCecilEmpireTraits()
