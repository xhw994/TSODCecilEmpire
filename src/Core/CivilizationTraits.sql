INSERT INTO
    Types (Type, Kind)
VALUES
    (
        'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE',
        'KIND_TRAIT'
    ),
    ('TRAIT_UNIT_TSOD_SCOUT_AMBER', 'KIND_TRAIT'),
    ('TRAIT_BUILDING_TSOD_MANA_OBELISK', 'KIND_TRAIT');

INSERT INTO
    Traits (TraitType, Name, Description)
VALUES
    (
        'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE',
        'LOC_TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE_NAME',
        'LOC_TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE_DESCRIPTION'
    ),
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
        'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'TRAIT_UNIT_TSOD_SCOUT_AMBER'
    ),
    (
        'CIVILIZATION_TSOD_CECIL_EMPIRE',
        'TRAIT_BUILDING_TSOD_MANA_OBELISK'
    );

INSERT INTO
    TraitModifiers (TraitType, ModifierId)
VALUES
    (
        'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE',
        'TSOD_QUARRY_BONUS_TECH'
    ),
    (
        'TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE',
        'TSOD_NITER_MINE_BONUS_FAITH'
    );

INSERT INTO
    Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
VALUES
    (
        'TSOD_QUARRY_BONUS_TECH',
        'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',
        'PLOT_HAS_QUARRY_REQUIREMENTS'
    ),
    (
        'TSOD_NITER_MINE_BONUS_FAITH',
        'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',
        'PLOT_HAS_NITER_MINE_REQUIREMENTS'
    );

INSERT INTO
    ModifierArguments (ModifierId, Name, Value)
VALUES
    (
        'TSOD_QUARRY_BONUS_TECH',
        'YieldType',
        'YIELD_SCIENCE'
    ),
    ('TSOD_QUARRY_BONUS_TECH', 'Amount', '1'),
    (
        'TSOD_NITER_MINE_BONUS_FAITH',
        'YieldType',
        'YIELD_FAITH'
    ),
    ('TSOD_NITER_MINE_BONUS_FAITH', 'Amount', '3');

INSERT
OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES
    (
        'PLOT_HAS_NITER_MINE_REQUIREMENTS',
        'REQUIREMENTSET_TEST_ALL'
    );

INSERT
OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
    (
        'PLOT_HAS_NITER_MINE_REQUIREMENTS',
        'REQUIRES_PLOT_HAS_MINE'
    ),
    (
        'PLOT_HAS_NITER_MINE_REQUIREMENTS',
        'REQUIRES_PLOT_HAS_STRATEGIC_NITER'
    );

INSERT
OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES
    (
        'REQUIRES_PLOT_HAS_STRATEGIC_NITER',
        'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'
    );

INSERT
OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
VALUES
    (
        'REQUIRES_PLOT_HAS_STRATEGIC_NITER',
        'ResourceType',
        'RESOURCE_NITER'
    );

INSERT INTO
    ModifierStrings (ModifierId, Context, Text)
VALUES
    (
        'TSOD_QUARRY_BONUS_TECH',
        'Preview',
        'LOC_TSOD_QUARRY_BONUS_TECH_DESCRIPTION'
    ),
    (
        'TSOD_NITER_MINE_BONUS_FAITH',
        'Preview',
        'LOC_TSOD_NITER_MINE_BONUS_FAITH_DESCRIPTION'
    );