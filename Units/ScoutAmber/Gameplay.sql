INSERT INTO
    Types (Type, Kind)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'KIND_UNIT');

INSERT INTO
    UnitAiInfos (UnitType, AiType)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'UNITAI_EXPLORE'),
    ('UNIT_TSOD_SCOUT_AMBER', 'UNITTYPE_LAND_COMBAT');

INSERT INTO
    TypeTags (Type, Tag)
VALUES
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_RECON'),
    ('UNIT_TSOD_SCOUT_AMBER', 'CLASS_REVEAL_STEALTH');

INSERT INTO
    Units (
        UnitType,
        Domain,
        ZoneOfControl,
        FormationClass,
        Combat,
        Description,
        CanRetreatWhenCaptured,
        PseudoYieldType,
        BaseSightRange,
        Name,
        Cost,
        AdvisorType,
        BaseMoves,
        TraitType
    )
VALUES
    (
        'UNIT_TSOD_SCOUT_AMBER',
        'DOMAIN_LAND',
        1,
        'FORMATION_CLASS_LAND_COMBAT',
        5,
        'LOC_UNIT_TSOD_SCOUT_AMBER_DESCRIPTION',
        1,
        'PSEUDOYIELD_UNIT_EXPLORER',
        4,
        'LOC_UNIT_TSOD_SCOUT_AMBER_NAME',
        30,
        'ADVISOR_GENERIC',
        3,
        'TRAIT_UNIT_TSOD_SCOUT_AMBER'
    );