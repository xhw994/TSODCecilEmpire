INSERT INTO
    Types (Type, Kind)
VALUES
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'KIND_CIVILIZATION'
    ),
    ('TRAIT_UNIT_TSOD_SCOUT_AMBER', 'KIND_TRAIT'),
    ('TRAIT_BUILDING_TSOD_MANA_OBELISK', 'KIND_TRAIT');

INSERT INTO
    Civilizations (
        CivilizationType,
        Name,
        Description,
        Adjective,
        RandomCityNameDepth,
        StartingCivilizationLevelType,
        Ethnicity
    )
VALUES
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_NAME',
        'LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_DESCRIPTION',
        'LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_ADJECTIVE',
        '5',
        'CIVILIZATION_LEVEL_FULL_CIV',
        'ETHNICITY_EURO'
    );

INSERT INTO
    CivilizationLeaders (CivilizationType, LeaderType, CapitalName)
VALUES
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LEADER_TSOD_GAWAIN_CECIL',
        'LOC_CITY_NAME_TSOD_CECIL'
    );

INSERT INTO
    Traits (TraitType, Name, Description)
VALUES
    (
        'TRAIT_UNIT_TSOD_SCOUT_AMBER',
        'LOC_UNIT_TSOD_SCOUT_AMBER_NAME',
        'LOC_UNIT_TSOD_SCOUT_AMBER_DESCRIPTION'
    ),
    (
        'TRAIT_BUILDING_TSOD_MANA_OBELISK',
        'LOC_BUILDING_TSOD_MANA_OBELISK_NAME',
        'LOC_BUILDING_TSOD_MANA_OBELISK_DESCRIPTION'
    );

INSERT INTO
    CivilizationTraits (CivilizationType, TraitType)
VALUES
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'TRAIT_UNIT_TSOD_SCOUT_AMBER'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'TRAIT_BUILDING_TSOD_MANA_OBELISK'
    );

INSERT INTO
    CityNames (CivilizationType, CityName)
VALUES
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_CECIL'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_SAINT_SUNIL'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_LUAN'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_LONGWIND_FORTRESS'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_RED_MAPLE'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_ROCKSTONE'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_MEGALITH'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_POMPEII'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_ELRON'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_LONGSTONE_TOWN'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_TENWOODS'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_TAMDULUR'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_LUNTATELLE_SHIRE'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_HOLLE_SHIRE'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_FERTILE_WOODLANDS'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_SLANTWOOD_VALLEY'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITY_NAME_TSOD_FROSTWOOD_VILLAGE'
    );

INSERT INTO
    CivilizationCitizenNames (CivilizationType, CitizenName, Female)
VALUES
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_SAM',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_TOM',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_PEA',
        '1'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_BETTY',
        '1'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_JENNIE_PERRO',
        '1'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_GORDON',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_HALL',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_ELVIN_FRANKLIN',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_FENDIL_WILDER',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_VICTORIA_WILDER',
        '1'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_CROMWELL_WHITEMOUNTAIN',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_BODWIN_FRANKLIN',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_VERONICA_MOEN',
        '1'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_SEWEN_TERRY',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_HAMEL',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_HOLM',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_MARGARITA',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_WITCH_GIPLY',
        '0'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_CITIZEN_NAME_TSOD_SCARFACE_ANTON',
        '0'
    );

INSERT INTO
    StartBiasRivers (CivilizationType, Tier)
VALUES
    ('CIVILIZATION_TSOD_CECIL_EMPIRE', '2');

INSERT INTO
    StartBiasResources (CivilizationType, ResourceType, Tier)
VALUES
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'RESOURCE_NITER',
        '2'
    );