INSERT INTO
    Types (Type, Kind)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'KIND_UNIT'),
    ('UNIT_TSOD_GORGON_PLATFORM', 'KIND_UNIT');

INSERT INTO
    UnitAiInfos (UnitType, AiType)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'UNITAI_EXPLORE'),
    ('UNIT_TSOD_SCOUT_AMBER', 'UNITTYPE_LAND_COMBAT'),
    ('UNIT_TSOD_GORGON_PLATFORM', 'UNITTYPE_SIEGE_SUPPORT');

INSERT INTO
    Tags (Tag, Vocabulary)
VALUES
    ('CLASS_TSOD_SCOUT_AMBER', 'ABILITY_CLASS'),
    ('CLASS_TSOD_GORGON_PLATFORM', 'ABILITY_CLASS');

INSERT INTO
    TypeTags (Type, Tag)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_RECON'),
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_REVEAL_STEALTH'),
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_TSOD_SCOUT_AMBER'),
    ('ABILITY_IGNORE_TERRAIN_COST', 'CLASS_TSOD_SCOUT_AMBER'),
    ('ABILITY_IGNORE_CROSSING_RIVERS_COST', 'CLASS_TSOD_SCOUT_AMBER'),
    ('UNIT_TSOD_GORGON_PLATFORM', 'CLASS_TSOD_GORGON_PLATFORM'),
    ('UNIT_TSOD_GORGON_PLATFORM', 'CLASS_OBSERVATION'),
    ('UNIT_TSOD_GORGON_PLATFORM', 'CLASS_SUPPORT'),
    ('ABILITY_DRONE_GRANT_SIEGE_BONUS', 'CLASS_TSOD_GORGON_PLATFORM');

INSERT INTO
    UnitReplaces (CivUniqueUnitType, ReplacesUnitType)
VALUES
    ('UNIT_TSOD_GORGON_PLATFORM', 'UNIT_DRONE');

INSERT INTO
    Units (
        UnitType,
        Name,
        Description,
        TraitType,
        Domain,
        ZoneOfControl,
        FormationClass,
        PromotionClass,
        Combat,
        CanCapture,
        CanRetreatWhenCaptured,
        PseudoYieldType,
        BaseSightRange,
        Cost,
        AdvisorType,
        BaseMoves,
        CanTrain
    )
VALUES
    (
        'UNIT_TSOD_SCOUT_AMBER',
        'LOC_UNIT_TSOD_SCOUT_AMBER_NAME',
        'LOC_UNIT_TSOD_SCOUT_AMBER_DESCRIPTION',
        'TRAIT_UNIT_TSOD_SCOUT_AMBER',
        'DOMAIN_LAND',
        1,
        'FORMATION_CLASS_LAND_COMBAT',
        'PROMOTION_CLASS_RECON',
        5,
        1,
        1,
        'PSEUDOYIELD_UNIT_EXPLORER',
        4,
        66,
        'ADVISOR_GENERIC',
        3,
        0
    ),
    (
        'UNIT_TSOD_GORGON_PLATFORM',
        'LOC_UNIT_TSOD_GORGON_PLATFORM_NAME',
        'LOC_UNIT_TSOD_GORGON_PLATFORM_DESCRIPTION',
        'TRAIT_UNIT_TSOD_GORGON_PLATFORM',
        'DOMAIN_LAND',
        0,
        'FORMATION_CLASS_SUPPORT',
        'PROMOTION_CLASS_SUPPORT',
        0,
        1,
        0,
        NULL,
        5,
        420,
        'ADVISOR_CONQUEST',
        2,
        1
    );

INSERT INTO
    Units_XP2 (UnitType, CanEarnExperience, CanFormMilitaryFormation)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 1, 0),
    ('UNIT_TSOD_GORGON_PLATFORM', 0, 0);

INSERT INTO
    UnitRetreats_XP1 (UnitRetreatType, UnitType, BuildingType)
VALUES
    ('UNIT_RETREAT_TSOD_SCOUT_AMBER_TO_CAPITAL', 'UNIT_TSOD_SCOUT_AMBER', 'BUILDING_PALACE');

INSERT INTO
    TraitModifiers (TraitType, ModifierId)
VALUES
    ('TRAIT_UNIT_TSOD_SCOUT_AMBER', 'GRANT_TSOD_SCOUT_AMBER');

INSERT INTO
    Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId)
VALUES
    ('GRANT_TSOD_SCOUT_AMBER', 'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL', 0, 0, 0, 'PLAYER_HAS_CITY_CENTER_DISTRICT_REQUIREMENTS', NULL);

INSERT INTO
    ModifierArguments (ModifierId, Name, VALUE)
VALUES
    ('GRANT_TSOD_SCOUT_AMBER', 'AllowUniqueOverride', '0'),
    ('GRANT_TSOD_SCOUT_AMBER', 'Amount', '1'),
    ('GRANT_TSOD_SCOUT_AMBER', 'UnitType', 'UNIT_TSOD_SCOUT_AMBER');

INSERT
OR REPLACE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES
    ('PLAYER_HAS_CITY_CENTER_DISTRICT_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');

INSERT
OR REPLACE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
    ('PLAYER_HAS_CITY_CENTER_DISTRICT_REQUIREMENTS', 'PLAYER_HAS_CITY_CENTER_DISTRICT_REQUIREMENT');

INSERT
OR REPLACE INTO Requirements (RequirementId, RequirementType)
VALUES
    ('PLAYER_HAS_CITY_CENTER_DISTRICT_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_DISTRICT');

INSERT
OR REPLACE INTO RequirementArguments (RequirementId, Name, VALUE)
VALUES
    ('PLAYER_HAS_CITY_CENTER_DISTRICT_REQUIREMENT', 'DistrictType', 'DISTRICT_CITY_CENTER');