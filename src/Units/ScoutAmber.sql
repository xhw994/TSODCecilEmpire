INSERT INTO
    Types (Type, Kind)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'KIND_UNIT'),
    (
        'ABILITY_TSOD_SCOUT_AMBER_IGNORE_TERRAIN',
        'KIND_ABILITY'
    );

INSERT INTO
    UnitAiInfos (UnitType, AiType)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'UNITAI_EXPLORE'),
    ('UNIT_TSOD_SCOUT_AMBER', 'UNITTYPE_LAND_COMBAT');

INSERT INTO
    Tags (Tag, Vocabulary)
VALUES
    ('CLASS_TSOD_SCOUT_AMBER', 'ABILITY_CLASS');

INSERT INTO
    TypeTags (Type, Tag)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_RECON'),
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_REVEAL_STEALTH'),
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_TSOD_SCOUT_AMBER');

INSERT INTO
    Units (
        UnitType,
        Domain,
        ZoneOfControl,
        FormationClass,
        PromotionClass,
        Combat,
        Description,
        CanCapture,
        CanRetreatWhenCaptured,
        PseudoYieldType,
        BaseSightRange,
        Name,
        Cost,
        AdvisorType,
        BaseMoves,
        CanTrain,
        TraitType
    )
VALUES
    (
        'UNIT_TSOD_SCOUT_AMBER',
        'DOMAIN_LAND',
        1,
        'FORMATION_CLASS_LAND_COMBAT',
        'PROMOTION_CLASS_RECON',
        5,
        'LOC_UNIT_TSOD_SCOUT_AMBER_DESCRIPTION',
        1,
        1,
        'PSEUDOYIELD_UNIT_EXPLORER',
        4,
        'LOC_UNIT_TSOD_SCOUT_AMBER_NAME',
        66,
        'ADVISOR_GENERIC',
        3,
        0,
        'TRAIT_UNIT_TSOD_SCOUT_AMBER'
    );

INSERT INTO
    Units_XP2 (
        UnitType,
        CanEarnExperience,
        CanFormMilitaryFormation
    )
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 1, 0);

INSERT INTO
    UnitRetreats_XP1 (UnitRetreatType, UnitType, BuildingType)
VALUES
    (
        'UNIT_RETREAT_TSOD_SCOUT_AMBER_TO_CAPITAL',
        'UNIT_TSOD_SCOUT_AMBER',
        'BUILDING_PALACE'
    );

INSERT INTO
    DistrictModifiers (DistrictType, ModifierId)
VALUES
    (
        'DISTRICT_CITY_CENTER',
        'MODIFIER_GRANT_TSOD_SCOUT_AMBER_ON_SETTLE'
    );

INSERT INTO
    Modifiers (
        ModifierId,
        ModifierType,
        RunOnce,
        Permanent,
        NewOnly,
        OwnerRequirementSetId,
        SubjectRequirementSetId
    )
VALUES
    (
        'MODIFIER_GRANT_TSOD_SCOUT_AMBER_ON_SETTLE',
        'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL',
        0,
        0,
        0,
        'REQUIREMENT_TSOD_AMBER_NEVER_SPAWN',
        NULL
    );

INSERT INTO
    ModifierArguments (ModifierId, Name, Value)
VALUES
    (
        'MODIFIER_GRANT_TSOD_SCOUT_AMBER_ON_SETTLE',
        'AllowUniqueOverride',
        '0'
    ),
    (
        'MODIFIER_GRANT_TSOD_SCOUT_AMBER_ON_SETTLE',
        'Amount',
        '1'
    ),
    (
        'MODIFIER_GRANT_TSOD_SCOUT_AMBER_ON_SETTLE',
        'UnitType',
        'UNIT_TSOD_SCOUT_AMBER'
    );

INSERT INTO
    RequirementSets (RequirementSetId, RequirementSetType)
VALUES
    (
        'REQUIREMENT_TSOD_AMBER_NEVER_SPAWN',
        'REQUIREMENTSET_TEST_ALL'
    );

INSERT INTO
    RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
    (
        'REQUIREMENT_TSOD_AMBER_NEVER_SPAWN',
        'REQUIREMENT_PLAYER_NEVER_SETTLED'
    );

INSERT INTO
    Requirements (
        RequirementId,
        RequirementType,
        Inverse,
        ProgressWeight
    )
VALUES
    (
        'REQUIREMENT_PLAYER_NEVER_SETTLED',
        'REQUIREMENT_PLAYER_HAS_BUILDING',
        1,
        0
    );

INSERT INTO
    RequirementArguments (RequirementId, Name, Value)
VALUES
    (
        'REQUIREMENT_PLAYER_NEVER_SETTLED',
        'BuildingType',
        'BUILDING_PALACE'
    );

INSERT INTO
    UnitAbilities (UnitAbilityType, Name, Description, Inactive)
VALUES
    (
        'ABILITY_TSOD_SCOUT_AMBER_IGNORE_TERRAIN',
        'LOC_ABILITY_TSOD_SCOUT_AMBER_IGNORE_TERRAIN_TERRAIN_NAME',
        'LOC_ABILITY_TSOD_SCOUT_AMBER_IGNORE_TERRAIN_DESCRIPTION',
        0
    );

INSERT INTO
    UnitAbilityModifiers (UnitAbilityType, ModifierId)
VALUES
    (
        'ABILITY_TSOD_SCOUT_AMBER_IGNORE_TERRAIN',
        'MOD_IGNORE_TERRAIN_COST'
    ),
    (
        'ABILITY_TSOD_SCOUT_AMBER_IGNORE_TERRAIN',
        'MOD_IGNORE_CROSSING_RIVERS_COST'
    );