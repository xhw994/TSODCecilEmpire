INSERT INTO
    Types (Type, Kind)
VALUES
    ('BUILDING_TSOD_MANA_OBELISK', 'KIND_BUILDING');

INSERT INTO
    BuildingReplaces (CivUniqueBuildingType, ReplacesBuildingType)
VALUES
    ('BUILDING_TSOD_MANA_OBELISK', 'BUILDING_MONUMENT');

INSERT INTO
    Buildings (
        BuildingType,
        Name,
        PrereqDistrict,
        PurchaseYield,
        Cost,
        AdvisorType,
        PrereqTech,
        TraitType
    )
VALUES
    (
        'BUILDING_TSOD_MANA_OBELISK',
        'LOC_BUILDING_TSOD_MANA_OBELISK_NAME',
        'DISTRICT_CITY_CENTER',
        'YIELD_GOLD',
        60,
        'ADVISOR_CULTURE',
        'TECH_MATHEMATICS',
        'TRAIT_BUILDING_TSOD_MANA_OBELISK'
    );