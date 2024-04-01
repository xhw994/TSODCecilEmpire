INSERT INTO
    Types (Type, Kind)
VALUES
    ('BUILDING_TSOD_MANA_OBELISK', 'KIND_BUILDING');

INSERT INTO
    BuildingReplaces (CivUniqueBuildingType, ReplacesBuildingType)
VALUES
    ('BUILDING_TSOD_MANA_OBELISK', 'BUILDING_MONUMENT');

INSERT INTO
    Buildings (BuildingType, Name, Description, PrereqDistrict, PurchaseYield, Cost, AdvisorType, PrereqTech, TraitType, Entertainment)
VALUES
    (
        'BUILDING_TSOD_MANA_OBELISK',
        'LOC_BUILDING_TSOD_MANA_OBELISK_NAME',
        'LOC_BUILDING_TSOD_MANA_OBELISK_DESCRIPTION',
        'DISTRICT_CITY_CENTER',
        'YIELD_GOLD',
        60,
        'ADVISOR_CULTURE',
        'TECH_MATHEMATICS',
        'TRAIT_BUILDING_TSOD_MANA_OBELISK',
        1
    );

INSERT INTO
    Building_YieldChanges (BuildingType, YieldType, YieldChange)
VALUES
    ('BUILDING_TSOD_MANA_OBELISK', 'YIELD_SCIENCE', 2),
    ('BUILDING_TSOD_MANA_OBELISK', 'YIELD_PRODUCTION', 2);

-- District adjacency bonus
CREATE TEMPORARY TABLE TsoDDistrictYields (District TEXT NOT NULL, YieldType TEXT NOT NULL, PRIMARY KEY (District));

INSERT INTO
    TsoDDistrictYields (District, YieldType)
VALUES
    ('HOLY_SITE', 'FAITH'),
    ('CAMPUS', 'SCIENCE'),
    ('HARBOR', 'GOLD'),
    ('COMMERCIAL_HUB', 'GOLD'),
    ('THEATER', 'CULTURE'),
    ('INDUSTRIAL_ZONE', 'PRODUCTION'),
    ('ENCAMPMENT', 'PRODUCTION'),
    ('PRESERVE', 'FOOD');

INSERT INTO
    BuildingModifiers (BuildingType, ModifierId)
SELECT
    'BUILDING_TSOD_MANA_OBELISK',
    'TSOD_MANA_OBELISK_' || District || '_ADJACENCY'
FROM
    TsoDDistrictYields;

INSERT INTO
    Modifiers (ModifierId, ModifierType, RunOnce, Permanent)
SELECT
    'TSOD_MANA_OBELISK_' || District || '_ADJACENCY',
    'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY',
    1,
    1
FROM
    TsoDDistrictYields;

INSERT INTO
    ModifierArguments (ModifierId, Name, Value)
SELECT
    'TSOD_MANA_OBELISK_' || t.District || '_ADJACENCY' AS ModifierId,
    x.Name,
    CASE
        WHEN x.Name = 'Amount' THEN '1'
        WHEN x.Name = 'Description' THEN 'LOC_DISTRICT_DISTRICT_1_' || t.YieldType
        WHEN x.Name = 'DistrictType' THEN 'DISTRICT_' || t.District
        WHEN x.Name = 'YieldType' THEN 'YIELD_' || t.YieldType
    END AS Value
FROM
    TsoDDistrictYields t,
    (
        SELECT
            'Amount' AS Name
        UNION ALL
        SELECT
            'Description'
        UNION ALL
        SELECT
            'DistrictType'
        UNION ALL
        SELECT
            'YieldType'
    ) x;

-- Building double yield
INSERT INTO
    BuildingModifiers (BuildingType, ModifierId)
SELECT
    'BUILDING_TSOD_MANA_OBELISK',
    'TSOD_MANA_OBELISK_DOUBLE_YIELD_' || BuildingType || '_' || YieldType
FROM
    Building_YieldChanges;

INSERT INTO
    Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
SELECT
    'TSOD_MANA_OBELISK_DOUBLE_YIELD_' || BuildingType || '_' || YieldType,
    'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',
    'PLAYER_HAS_TECH_ELECTRICITY_REQUIREMENTS'
FROM
    Building_YieldChanges;

INSERT INTO
    ModifierArguments (ModifierId, Name, VALUE)
SELECT
    'TSOD_MANA_OBELISK_DOUBLE_YIELD_' || BuildingType || '_' || YieldType,
    'YieldType',
    YieldType
FROM
    Building_YieldChanges
UNION
SELECT
    'TSOD_MANA_OBELISK_DOUBLE_YIELD_' || BuildingType || '_' || YieldType,
    'BuildingType',
    BuildingType
FROM
    Building_YieldChanges
UNION
SELECT
    'TSOD_MANA_OBELISK_DOUBLE_YIELD_' || BuildingType || '_' || YieldType,
    'Amount',
    YieldChange
FROM
    Building_YieldChanges;

INSERT INTO
    RequirementSets (RequirementSetId, RequirementSetType)
VALUES
    ('PLAYER_HAS_TECH_ELECTRICITY_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO
    RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
    ('PLAYER_HAS_TECH_ELECTRICITY_REQUIREMENTS', 'PLAYER_HAS_TECH_ELECTRICITY_REQUIREMENT');

INSERT INTO
    Requirements (RequirementId, RequirementType)
VALUES
    ('PLAYER_HAS_TECH_ELECTRICITY_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');

INSERT INTO
    RequirementArguments (RequirementId, Name, VALUE)
VALUES
    ('PLAYER_HAS_TECH_ELECTRICITY_REQUIREMENT', 'TechnologyType', 'TECH_ELECTRICITY');