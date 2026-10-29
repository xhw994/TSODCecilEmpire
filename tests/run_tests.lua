-- Pure-Lua tests for src/Core/TsoDCE_CivilizationTraits.lua. Stubs stand in for the
-- game API, so this catches syntax errors, nil values and logic mistakes. It cannot
-- tell whether the engine fires an event or whether a modifier takes effect: only
-- the in-game Lua.log shows that.
-- Run from the repo root: luajit tests/run_tests.lua

local ROOT = (arg and arg[0] and arg[0]:match('^(.*)[/\\]tests[/\\]')) or '.'
local SCRIPT = ROOT .. '/src/Core/TsoDCE_CivilizationTraits.lua'
local failures, passes = 0, 0

local function check(bCond, sName)
    if bCond then
        passes = passes + 1
    else
        failures = failures + 1
        print('FAIL: ' .. sName)
    end
end

-- GameInfo table: indexable by key and by Index, and callable as an iterator.
local function InfoTable(aRows, sKey)
    local t = {}
    for i, row in ipairs(aRows) do
        row.Index = i - 1
        row.Hash = 1000 + i
        if sKey then t[row[sKey]] = row end
        t[row.Index] = row
    end
    return setmetatable(t, { __call = function()
        local i = 0
        return function()
            i = i + 1
            return aRows[i]
        end
    end })
end

-- Cecil's great people, as defined in TsoDCE_GreatPeople.sql.
local CECIL_PEOPLE = {
    SIR_PHILIP = 'GENERAL', BYRON_KIRK = 'ADMIRAL', NICHOLAS_EGG = 'ENGINEER', PITMAN_LAUREN = 'MERCHANT',
    FELM = 'WRITER', REBECCA_CECIL = 'SCIENTIST', JENNIE_PERRO = 'SCIENTIST', SANTIS_SAIDE = 'SCIENTIST',
    KAMEL_SLAYEN = 'SCIENTIST', LEITE_AVIKEN = 'PROPHET', HETTIE_CECIL = 'GOVERNOR', NORRIS = 'SCIENTIST', SELENA_GELFIN = 'SCIENTIST',
}
local OFFICIAL_CLASSES = { 'GENERAL', 'ADMIRAL', 'ENGINEER', 'MERCHANT', 'PROPHET', 'SCIENTIST', 'WRITER', 'ARTIST', 'MUSICIAN' }
local CECIL_CLASSES = { 'GENERAL', 'ADMIRAL', 'ENGINEER', 'MERCHANT', 'PROPHET', 'SCIENTIST', 'WRITER', 'GOVERNOR' }

local World

local function NewUnit(iPlayer, iID, sType)
    local u = { player = iPlayer, id = iID, sType = sType, xp = 0, abilities = {}, promotions = {} }
    function u:GetID() return self.id end
    function u:GetType() return GameInfo.Units[self.sType].Index end
    function u:GetExperience()
        local unit = self
        return {
            ChangeExperience = function(_, n) unit.xp = unit.xp + n end,
            HasPromotion = function(_, i) return unit.promotions[GameInfo.UnitPromotions[i].UnitPromotionType] == true end,
        }
    end
    function u:GetAbility()
        local unit = self
        return {
            GetAbilityCount = function(_, s) return unit.abilities[s] or 0 end,
            ChangeAbilityCount = function(_, s, n) unit.abilities[s] = (unit.abilities[s] or 0) + n end,
        }
    end
    return u
end

local function NewCity(tBuildings)
    return { GetBuildings = function()
        return { HasBuilding = function(_, i) return tBuildings[GameInfo.Buildings[i].BuildingType] == true end }
    end }
end

local function NewPlayer(iID, sLeader, sCiv)
    local p = { id = iID, leader = sLeader, civ = sCiv, human = true, units = {}, cities = {}, props = {},
        gppPerTurn = {}, gppAdded = {}, coal = 0, modifiers = {}, boosts = {}, research = {} }
    -- The engine returns "no value" for a missing property.
    function p:GetProperty(k) local v = self.props[k]; if v == nil then return end; return v end
    function p:SetProperty(k, v) self.props[k] = v end
    function p:GetUnits()
        local pl = self
        return {
            FindID = function(_, i) return pl.units[i] end,
            Members = function()
                local a = {}
                for _, u in pairs(pl.units) do table.insert(a, u) end
                table.sort(a, function(x, y) return x.id < y.id end)
                local i = 0
                return function() i = i + 1; if a[i] then return i, a[i] end end
            end,
        }
    end
    function p:GetCities()
        local pl = self
        return { Members = function()
            local i = 0
            return function() i = i + 1; if pl.cities[i] then return i, pl.cities[i] end end
        end }
    end
    function p:GetGreatPeoplePoints()
        local pl = self
        return {
            CalculatePointsPerTurn = function(_, iClass) return pl.gppPerTurn[iClass] or 0 end,
            ChangePointsTotal = function(_, iClass, n) pl.gppAdded[iClass] = (pl.gppAdded[iClass] or 0) + n end,
        }
    end
    function p:GetResources()
        local pl = self
        return { ChangeResourceAmount = function(_, iRes, n)
            if GameInfo.Resources[iRes].ResourceType == 'RESOURCE_COAL' then pl.coal = pl.coal + n end
        end }
    end
    function p:GetTechs()
        local pl = self
        return {
            GetResearchingTech = function() return 7 end,
            GetResearchCost = function() return 300 end,
            SetResearchProgress = function(_, iTech, n) pl.research[iTech] = n end,
        }
    end
    function p:GetCulture()
        local pl = self
        return { TriggerBoost = function(_, iCivic) pl.boosts[iCivic] = true end }
    end
    function p:AttachModifierByID(s) table.insert(self.modifiers, s) end
    -- districts: list of { type = 'DISTRICT_X', complete = bool }
    p.districts = {}
    function p:GetDistricts()
        local pl = self
        return { Members = function()
            local i = 0
            return function()
                i = i + 1
                local d = pl.districts[i]
                if d then
                    return i, { GetType = function() return GameInfo.Districts[d.type].Index end,
                        IsComplete = function() return d.complete end }
                end
            end
        end }
    end
    function p:IsHuman() return self.human end
    return p
end

local function Fire(sName, ...)
    for _, f in ipairs(World.handlers[sName] or {}) do f(...) end
end

-- Builds a fresh world, runs fSetup to customise it, then loads the script (which
-- initialises itself on load, as it does in game).
local function Load(fSetup)
    World = { handlers = {}, grants = {}, revealed = {}, killed = {} }
    local function Event(sPrefix)
        return setmetatable({}, { __index = function(t, k)
            local e = { Add = function(f)
                local sName = sPrefix .. k
                World.handlers[sName] = World.handlers[sName] or {}
                table.insert(World.handlers[sName], f)
            end }
            rawset(t, k, e)
            return e
        end })
    end
    Events = Event('Events.')
    GameEvents = Event('GameEvents.')
    include = function() end
    print = function() end
    UnitOperationTypes = { BUILD_ROUTE = 11, BUILD_IMPROVEMENT = 12 }
    UnitManager = { Kill = function(u)
        table.insert(World.killed, u.id)
        Players[u.player].units[u.id] = nil
    end }

    local aIndividuals, aClasses = {}, {}
    for sName, sClass in pairs(CECIL_PEOPLE) do
        table.insert(aIndividuals, { GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_TSOD_CE_' .. sName,
            GreatPersonClassType = 'GREAT_PERSON_CLASS_TSOD_CE_' .. sClass })
    end
    table.sort(aIndividuals, function(a, b) return a.GreatPersonIndividualType < b.GreatPersonIndividualType end)
    table.insert(aIndividuals, { GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_HYPATIA',
        GreatPersonClassType = 'GREAT_PERSON_CLASS_SCIENTIST' })
    for _, s in ipairs(OFFICIAL_CLASSES) do table.insert(aClasses, { GreatPersonClassType = 'GREAT_PERSON_CLASS_' .. s }) end
    for _, s in ipairs(CECIL_CLASSES) do table.insert(aClasses, { GreatPersonClassType = 'GREAT_PERSON_CLASS_TSOD_CE_' .. s }) end

    GameInfo = {
        GreatPersonIndividuals = InfoTable(aIndividuals, 'GreatPersonIndividualType'),
        GreatPersonClasses = InfoTable(aClasses, 'GreatPersonClassType'),
        Eras = InfoTable({ { EraType = 'ERA_ANCIENT' }, { EraType = 'ERA_CLASSICAL' }, { EraType = 'ERA_MEDIEVAL' }, { EraType = 'ERA_MODERN' } }, 'EraType'),
        Units = InfoTable({ { UnitType = 'UNIT_TSOD_SCOUT_AMBER' }, { UnitType = 'UNIT_MILITARY_ENGINEER' }, { UnitType = 'UNIT_SCOUT' } }, 'UnitType'),
        Buildings = InfoTable({ { BuildingType = 'BUILDING_LIBRARY' }, { BuildingType = 'BUILDING_UNIVERSITY' },
            { BuildingType = 'BUILDING_RESEARCH_LAB' }, { BuildingType = 'BUILDING_GOV_CITYSTATES' }, { BuildingType = 'BUILDING_MONUMENT' } }, 'BuildingType'),
        Districts = InfoTable({ { DistrictType = 'DISTRICT_CAMPUS' }, { DistrictType = 'DISTRICT_GOVERNMENT' },
            { DistrictType = 'DISTRICT_HOLY_SITE' }, { DistrictType = 'DISTRICT_AQUEDUCT' },
            { DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX' }, { DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' },
            { DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER' } }, 'DistrictType'),
        Resources = InfoTable({ { ResourceType = 'RESOURCE_IRON' }, { ResourceType = 'RESOURCE_COAL' } }, 'ResourceType'),
        UnitPromotions = InfoTable({ { UnitPromotionType = 'PROMOTION_TSOD_CE_SHADOW_REALM' },
            { UnitPromotionType = 'PROMOTION_TSOD_CE_SHADOW_AUTHORITY' } }, 'UnitPromotionType'),
        Civics = InfoTable({ { CivicType = 'CIVIC_CULTURAL_HERITAGE' } }, 'CivicType'),
        Features = InfoTable({ { FeatureType = 'FEATURE_FOREST', NaturalWonder = false },
            { FeatureType = 'FEATURE_ULURU', NaturalWonder = true }, { FeatureType = 'FEATURE_KILIMANJARO', NaturalWonder = true } }, 'FeatureType'),
        LeaderTraits = InfoTable({ { LeaderType = 'LEADER_TSOD_GAWAIN_CECIL', TraitType = 'TRAIT_LEADER_TSOD_SWORD_OF_DAWN' } }),
        CivilizationTraits = InfoTable({ { CivilizationType = 'CIVILIZATION_TSOD_CECIL_EMPIRE', TraitType = 'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE' } }),
    }

    -- Player 0 is Cecil, player 1 is someone else.
    Players = { [0] = NewPlayer(0, 'LEADER_TSOD_GAWAIN_CECIL', 'CIVILIZATION_TSOD_CECIL_EMPIRE'),
        [1] = NewPlayer(1, 'LEADER_TRAJAN', 'CIVILIZATION_ROME') }
    PlayerConfigurations = {}
    for i, p in pairs(Players) do
        PlayerConfigurations[i] = { GetLeaderTypeName = function() return p.leader end,
            GetCivilizationTypeName = function() return p.civ end }
    end
    PlayerManager = { GetWasEverAliveIDs = function() return { 0, 1 } end }

    -- Map: plot 0 forest, plot 1 Uluru, plots 2-3 Kilimanjaro.
    local aPlots = { { f = 0, x = 0, y = 0 }, { f = 1, x = 1, y = 0 }, { f = 2, x = 2, y = 0 }, { f = 2, x = 3, y = 0 }, { f = -1, x = 4, y = 0 } }
    Map = {
        GetPlotCount = function() return #aPlots end,
        GetPlotByIndex = function(i)
            local t = aPlots[i + 1]
            return { GetFeatureType = function() return t.f end, GetX = function() return t.x end, GetY = function() return t.y end }
        end,
    }
    PlayersVisibility = setmetatable({}, { __index = function(_, iPlayer)
        return { IsRevealed = function(_, x, y) return World.revealed[iPlayer .. ':' .. x .. ',' .. y] == true end }
    end })
    Game = { GetGreatPeople = function()
        return { GrantPerson = function(_, hInd, hClass, hEra, iCost, iPlayer)
            table.insert(World.grants, { ind = hInd, class = hClass, era = hEra, player = iPlayer })
        end }
    end }

    if fSetup then fSetup() end
    dofile(SCRIPT)
end

local function Reveal(iPlayer, x, y) World.revealed[iPlayer .. ':' .. x .. ',' .. y] = true end
local function Hash(sTable, sKey) return GameInfo[sTable][sKey].Hash end
local function ClassIndex(s) return GameInfo.GreatPersonClasses[s].Index end
local cecil, other

-- Initialisation ------------------------------------------------------------
Load()
cecil, other = Players[0], Players[1]
local tAvail = cecil.props.TSOD_GreatPeopleOfCecilAvailability
check(type(tAvail) == 'table' and #tAvail == 13, 'init: availability list holds the 13 Cecil great people')
check(tAvail and tAvail.GREAT_PERSON_INDIVIDUAL_HYPATIA == nil, 'init: official great people are not in the list')
check(cecil.props.TSOD_GawainGreatPeopleActivated and cecil.props.TSOD_GawainGreatPeopleActivated.SCIENTIST == 0,
    'init: activation counts start at 0')
check(other.props.TSOD_GreatPeopleOfCecilAvailability == nil, 'init: non-Cecil players are left alone')

-- An existing save keeps its lists.
Load(function()
    Players[0].props.TSOD_GreatPeopleOfCecilAvailability = { 'X', X = false }
    Players[0].props.TSOD_GawainGreatPeopleActivated = { SCIENTIST = 3 }
end)
check(Players[0].props.TSOD_GreatPeopleOfCecilAvailability.X == false, 'init: saved availability list is not overwritten')
check(Players[0].props.TSOD_GawainGreatPeopleActivated.SCIENTIST == 3, 'init: saved activation counts are not overwritten')

-- First district / building grants a great person ---------------------------
Load()
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_CAMPUS.Index, 0, 0)
check(#World.grants == 1 and World.grants[1].ind == Hash('GreatPersonIndividuals', 'GREAT_PERSON_INDIVIDUAL_TSOD_CE_REBECCA_CECIL')
    and World.grants[1].player == 0, 'district: first Campus grants Rebecca to Cecil')
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_CAMPUS.Index, 0, 0)
check(#World.grants == 1, 'district: second Campus grants nothing')
Fire('GameEvents.OnDistrictConstructed', 1, GameInfo.Districts.DISTRICT_CAMPUS.Index, 0, 0)
check(#World.grants == 1, 'district: other players get nothing')
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_AQUEDUCT.Index, 0, 0)
check(#World.grants == 1, 'district: districts without a great person grant nothing')
Fire('GameEvents.BuildingConstructed', 0, 0, GameInfo.Buildings.BUILDING_LIBRARY.Index, 0, true)
check(#World.grants == 2 and World.grants[2].ind == Hash('GreatPersonIndividuals', 'GREAT_PERSON_INDIVIDUAL_TSOD_CE_JENNIE_PERRO'),
    'building: first Library grants Jennie')
Fire('GameEvents.BuildingConstructed', 0, 0, GameInfo.Buildings.BUILDING_RESEARCH_LAB.Index, 0, true)
check(World.grants[3] and World.grants[3].era == Hash('Eras', 'ERA_MODERN'), 'building: Research Lab grants Kamel in the Modern era')

-- Every Cecil great person is granted under its own class (a mismatch was the
-- only lead for the report of the AI recruiting them).
Load()
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_HOLY_SITE.Index, 0, 0)
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_GOVERNMENT.Index, 0, 0)
check(#World.grants == 2, 'class: Leite and Hettie are granted')
for _, g in ipairs(World.grants) do
    local ind = GameInfo.GreatPersonIndividuals[g.ind - 1001]
    local sGiven = GameInfo.GreatPersonClasses[g.class - 1001].GreatPersonClassType
    check(ind.GreatPersonClassType == sGiven, 'class: ' .. ind.GreatPersonIndividualType .. ' granted under its own class')
end

-- Gawain: bonus great person points -----------------------------------------
Load()
cecil = Players[0]
local iSci = ClassIndex('GREAT_PERSON_CLASS_SCIENTIST')
cecil.gppPerTurn[iSci] = 10
Fire('Events.TurnBegin')
check(cecil.gppAdded[iSci] == nil, 'gawain: no bonus before any great person is recruited')
Fire('Events.UnitGreatPersonCreated', 0, 1, iSci, 0)
check(cecil.props.TSOD_GawainGreatPeopleActivated.SCIENTIST == 1, 'gawain: recruiting a scientist is counted')
Fire('Events.TurnBegin')
-- 20% of 10 for the type plus ceil(5% of 10) for the total.
check(cecil.gppAdded[iSci] == 3, 'gawain: one scientist gives +2 type and +1 total bonus points')
Fire('Events.UnitGreatPersonCreated', 1, 1, iSci, 0)
check(cecil.props.TSOD_GawainGreatPeopleActivated.SCIENTIST == 1, 'gawain: other players recruiting is not counted')
Fire('Events.UnitGreatPersonCreated', 0, 1, ClassIndex('GREAT_PERSON_CLASS_TSOD_CE_GOVERNOR'), 0)
check(cecil.props.TSOD_GawainGreatPeopleActivated.MERCHANT == 1, 'gawain: Hettie (Governor class) counts as a merchant')
Fire('Events.UnitGreatPersonCreated', 0, 1, ClassIndex('GREAT_PERSON_CLASS_TSOD_CE_PROPHET'), 0)
check(cecil.props.TSOD_GawainGreatPeopleActivated.PROPHET == 1, 'gawain: Leite counts as a prophet')
Fire('Events.UnitGreatPersonCreated', 1, 1, ClassIndex('GREAT_PERSON_CLASS_TSOD_CE_GENERAL'), 0)
check(true, 'gawain: another player receiving a Cecil class only logs a warning')

Load(function() Players[0].props.TSOD_GawainGreatPeopleActivated = { SCIENTIST = 30, GENERAL = 0 } end)
cecil = Players[0]
cecil.gppPerTurn[iSci] = 10
Fire('Events.TurnBegin')
check(cecil.gppAdded[iSci] == 20, 'gawain: both bonuses are capped at 100%')

-- Great person actions --------------------------------------------------------
Load()
cecil = Players[0]
Fire('Events.UnitGreatPersonActivated', 0, 1, 0, GameInfo.GreatPersonIndividuals.GREAT_PERSON_INDIVIDUAL_TSOD_CE_REBECCA_CECIL.Index)
check(cecil.research[7] == 300, 'rebecca: finishes the current research')
Fire('Events.UnitGreatPersonActivated', 0, 1, 0, GameInfo.GreatPersonIndividuals.GREAT_PERSON_INDIVIDUAL_TSOD_CE_KAMEL_SLAYEN.Index)
check(cecil.boosts[GameInfo.Civics.CIVIC_CULTURAL_HERITAGE.Index] == true, 'kamel: boosts Cultural Heritage')

-- Selena: granted by the first entertainment district, 3 turns of points per activation
Load()
cecil = Players[0]
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_WATER_ENTERTAINMENT_COMPLEX.Index, 0, 0)
check(#World.grants == 1 and World.grants[1].ind == Hash('GreatPersonIndividuals', 'GREAT_PERSON_INDIVIDUAL_TSOD_CE_SELENA_GELFIN')
    and World.grants[1].class == Hash('GreatPersonClasses', 'GREAT_PERSON_CLASS_TSOD_CE_SCIENTIST'),
    'selena: the first Water Park grants Selena as a Cecil Great Scientist')
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_ENTERTAINMENT_COMPLEX.Index, 0, 0)
check(#World.grants == 1, 'selena: a later Entertainment Complex does not grant her again')
Load()
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_ENTERTAINMENT_COMPLEX.Index, 0, 0)
check(#World.grants == 1, 'selena: the first Entertainment Complex grants her too')
cecil = Players[0]
cecil.gppPerTurn[ClassIndex('GREAT_PERSON_CLASS_SCIENTIST')] = 8
cecil.gppPerTurn[ClassIndex('GREAT_PERSON_CLASS_GENERAL')] = 2
local iSelena = GameInfo.GreatPersonIndividuals.GREAT_PERSON_INDIVIDUAL_TSOD_CE_SELENA_GELFIN.Index
Fire('Events.UnitGreatPersonActivated', 0, 1, 0, iSelena)
check(cecil.gppAdded[ClassIndex('GREAT_PERSON_CLASS_SCIENTIST')] == 24 and cecil.gppAdded[ClassIndex('GREAT_PERSON_CLASS_GENERAL')] == 6,
    'selena: activation grants 3 turns of each point type')
check(cecil.gppAdded[ClassIndex('GREAT_PERSON_CLASS_ADMIRAL')] == nil, 'selena: types with no output get nothing')
Fire('Events.UnitGreatPersonActivated', 0, 1, 0, iSelena)
check(cecil.gppAdded[ClassIndex('GREAT_PERSON_CLASS_SCIENTIST')] == 48, 'selena: the second charge grants again')
Fire('Events.UnitGreatPersonActivated', 1, 1, 0, iSelena)
check(Players[1].gppAdded[ClassIndex('GREAT_PERSON_CLASS_SCIENTIST')] == nil, 'selena: other players get nothing')

-- Hettie: military engineers building railroads refund coal --------------------
Load()
cecil = Players[0]
cecil.units[5] = NewUnit(0, 5, 'UNIT_MILITARY_ENGINEER')
cecil.units[6] = NewUnit(0, 6, 'UNIT_SCOUT')
Fire('Events.UnitOperationStarted', 0, 5, UnitOperationTypes.BUILD_ROUTE)
check(cecil.coal == 0, 'hettie: no coal before Hettie is activated')
Fire('Events.UnitGreatPersonActivated', 0, 1, 0, GameInfo.GreatPersonIndividuals.GREAT_PERSON_INDIVIDUAL_TSOD_CE_HETTIE_CECIL.Index)
Fire('Events.UnitOperationStarted', 0, 5, UnitOperationTypes.BUILD_ROUTE)
check(cecil.coal == 1, 'hettie: +1 coal after activation')
Fire('Events.UnitOperationStarted', 0, 5, UnitOperationTypes.BUILD_IMPROVEMENT)
Fire('Events.UnitOperationStarted', 0, 6, UnitOperationTypes.BUILD_ROUTE)
check(cecil.coal == 1, 'hettie: other operations and other units refund nothing')

-- Amber: goody huts and natural wonders -----------------------------------------
Load(function() Reveal(0, 1, 0) end) -- Uluru already known when the game loads
cecil = Players[0]
local amber = NewUnit(0, 9, 'UNIT_TSOD_SCOUT_AMBER')
cecil.units[9] = amber
cecil.units[6] = NewUnit(0, 6, 'UNIT_SCOUT')
Fire('Events.GoodyHutReward', 0, 9, 0, 0)
check(amber.xp == 15, 'amber: +15 XP from a goody hut')
Fire('Events.GoodyHutReward', 0, 6, 0, 0)
check(cecil.units[6].xp == 0, 'amber: other units get no goody hut bonus')
Fire('Events.UnitMoveComplete', 0, 9, 0, 0)
check(amber.xp == 15, 'amber: wonders known at load are not rewarded')
Reveal(0, 3, 0) -- Kilimanjaro, second tile
Fire('Events.UnitMoveComplete', 0, 9, 3, 0)
check(amber.xp == 45, 'amber: +30 XP when her move reveals a natural wonder')
Fire('Events.UnitMoveComplete', 0, 9, 3, 0)
check(amber.xp == 45, 'amber: the same wonder is rewarded once')

Load()
cecil = Players[0]
amber = NewUnit(0, 9, 'UNIT_TSOD_SCOUT_AMBER')
cecil.units[9] = amber
cecil.units[6] = NewUnit(0, 6, 'UNIT_SCOUT')
Reveal(0, 1, 0)
Fire('Events.UnitMoveComplete', 0, 6, 1, 0)
Fire('Events.UnitMoveComplete', 0, 9, 1, 0)
check(amber.xp == 0, 'amber: a wonder found by another unit is not credited to her')

-- Amber: retirement ---------------------------------------------------------------
local DQ_DONE = { type = 'DISTRICT_DIPLOMATIC_QUARTER', complete = true }
local function Retire(iPlayer, iUnit) Fire('GameEvents.TsoDCE_AmberRetire', iPlayer, { UnitID = iUnit }) end

Load()
cecil, other = Players[0], Players[1]
amber = NewUnit(0, 9, 'UNIT_TSOD_SCOUT_AMBER')
cecil.units[9] = amber
cecil.units[6] = NewUnit(0, 6, 'UNIT_SCOUT')
Retire(0, 9)
check(#cecil.modifiers == 0 and cecil.units[9] ~= nil, 'retire: not possible without a Diplomatic Quarter')
cecil.districts = { { type = 'DISTRICT_DIPLOMATIC_QUARTER', complete = false } }
Retire(0, 9)
check(#cecil.modifiers == 0 and cecil.units[9] ~= nil, 'retire: an unfinished Diplomatic Quarter does not count')
cecil.districts = { DQ_DONE }
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_DIPLOMATIC_QUARTER.Index, 0, 0)
check(#cecil.modifiers == 0 and cecil.units[9] ~= nil, 'retire: a human player is not retired automatically')
Retire(0, 6)
check(#cecil.modifiers == 0 and cecil.units[6] ~= nil, 'retire: only Amber can retire')
Retire(1, 9)
check(#cecil.modifiers == 0 and #other.modifiers == 0, 'retire: other players cannot retire her')
Retire(0, 9)
check(#cecil.modifiers == 1 and cecil.modifiers[1] == 'MODIFIER_TSOD_CE_AMBER_BUREAU_DIPLO_VISIBILITY',
    'retire: attaches the permanent visibility modifier')
check(cecil.units[9] == nil and World.killed[1] == 9, 'retire: Amber leaves the map')
check(cecil.props.TSOD_CE_AmberRetired == true, 'retire: recorded on the player')
cecil.units[10] = NewUnit(0, 10, 'UNIT_TSOD_SCOUT_AMBER')
Retire(0, 10)
check(#cecil.modifiers == 1 and cecil.units[10] ~= nil, 'retire: only once per player')

Load(function()
    Players[0].districts = { DQ_DONE }
    Players[0].units[9] = NewUnit(0, 9, 'UNIT_TSOD_SCOUT_AMBER')
    Players[0].units[9].promotions.PROMOTION_TSOD_CE_SHADOW_AUTHORITY = true
end)
Retire(0, 9)
check(#Players[0].modifiers == 2 and Players[0].modifiers[2] == 'MODIFIER_TSOD_CE_AMBER_RETIRED_SHADOW_AUTHORITY',
    "retire: Shadow Authority's +1 is kept as a permanent modifier")

Load(function()
    Players[0].human = false
    Players[0].units[9] = NewUnit(0, 9, 'UNIT_TSOD_SCOUT_AMBER')
end)
Players[0].districts = { DQ_DONE }
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_DIPLOMATIC_QUARTER.Index, 0, 0)
check(#Players[0].modifiers == 1 and Players[0].units[9] == nil, 'retire: an AI Cecil retires her when the Diplomatic Quarter is built')

Load(function()
    Players[0].human = false
    Players[0].districts = { DQ_DONE }
    Players[0].units[9] = NewUnit(0, 9, 'UNIT_TSOD_SCOUT_AMBER')
end)
Fire('Events.TurnBegin')
check(#Players[0].modifiers == 1 and Players[0].units[9] == nil, 'retire: an AI save with a Diplomatic Quarter retires her at turn start')

-- No Cecil player in the game ------------------------------------------------------
Load(function()
    Players[0].leader, Players[0].civ = 'LEADER_GANDHI', 'CIVILIZATION_INDIA'
end)
Fire('GameEvents.OnDistrictConstructed', 0, GameInfo.Districts.DISTRICT_CAMPUS.Index, 0, 0)
Fire('Events.TurnBegin')
check(#World.grants == 0 and next(World.handlers) == nil, 'no Cecil: the script stays idle')

io.write(string.format('%d passed, %d failed\n', passes, failures))
os.exit(failures == 0 and 0 or 1)
