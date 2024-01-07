CREATE TEMPORARY TABLE TsoDGreatPeopleOfCecil (
    IndividualType TEXT NOT NULL,
    ClassType TEXT NOT NULL,
    DistrictType TEXT NOT NULL,
    EraType TEXT NOT NULL,
    Gender TEXT NOT NULL,
    ActionRequiresCompletedDistrictType TEXT NOT NULL,
    ActionCharges INT NOT NULL,
    PRIMARY KEY (IndividualType)
);

INSERT INTO
    TsoDGreatPeopleOfCecil (
        IndividualType,
        ClassType,
        DistrictType,
        EraType,
        Gender,
        ActionRequiresCompletedDistrictType,
        ActionCharges
    )
VALUES
    --(
    --'SIR_PHILIP',
    --'GENERAL',
    --'DISTRICT_ENCAMPMENT',
    --'ERA_CLASSICAL',
    --'M',
    --'DISTRICT_ENCAMPMENT',
    --1
    --),
    --(
    --'BYRON_KIRK',
    --'ADMIRAL',
    --'DISTRICT_HARBOR',
    --'ERA_CLASSICAL',
    --'M',
    --'DISTRICT_HARBOR',
    --1
    --),
    --(
    --'ST_NICHOLAS_EGG_EXEC',
    --'ENGINEER',
    --'DISTRICT_INDUSTRIAL_ZONE',
    --'ERA_CLASSICAL',
    --'M',
    --'DISTRICT_INDUSTRIAL_ZONE',
    --1
    --),
    --(
    --'PITMAN_LAUREN',
    --'MERCHANT',
    --'DISTRICT_COMMERCIAL_HUB',
    --'ERA_CLASSICAL',
    --'M',
    --'DISTRICT_COMMERCIAL_HUB',
    --1
    --),
    (
        'REBECCA_CECIL',
        'SCIENTIST',
        'DISTRICT_CAMPUS',
        'ERA_ANCIENT',
        'F',
        'DISTRICT_CAMPUS',
        3
    ),
    (
        'JENNIE_PERRO',
        'SCIENTIST',
        'DISTRICT_CAMPUS',
        'ERA_CLASSICAL',
        'F',
        'DISTRICT_CITY_CENTER',
        2
    ),
    (
        'SANTIS_SAIDE',
        'SCIENTIST',
        'DISTRICT_CAMPUS',
        'ERA_MEDIEVAL',
        'M',
        'DISTRICT_CAMPUS',
        1
    ),
    (
        'KAMEL_SLAYEN',
        'SCIENTIST',
        'DISTRICT_CAMPUS',
        'ERA_MODERN',
        'M',
        'DISTRICT_CAMPUS',
        1
    ),
    -- (
    --     'LEITE_AVIKEN',
    --     'PROPHET',
    --     'DISTRICT_HOLY_SITE',
    --     'ERA_ANCIENT',
    --     'M',
    --     'DISTRICT_HOLY_SITE',
    --     1
    -- ),
    (
        'HETTIE_CECIL',
        'SCIENTIST',
        'DISTRICT_CAMPUS',
        'ERA_ANCIENT',
        'F',
        'DISTRICT_GOVERNMENT', -- Ep1 R:F
        1
    ),
    (
        'NORRIS',
        'SCIENTIST',
        'DISTRICT_CAMPUS',
        'ERA_ANCIENT',
        'M',
        'DISTRICT_PRESERVE', -- Kublai Khan Vietanam pack
        2
    );

CREATE TEMPORARY TABLE TsoDGreatPersonClasses AS
SELECT
    ClassType,
    DistrictType
FROM
    TsoDGreatPeopleOfCecil
GROUP BY
    ClassType,
    DistrictType;

INSERT INTO
    Types (Type, Kind)
SELECT
    'GREAT_PERSON_CLASS_TSOD_CE_' || ClassType,
    'KIND_GREAT_PERSON_CLASS'
FROM
    TsoDGreatPersonClasses;

INSERT INTO
    Types (Type, Kind)
SELECT
    'GREAT_PERSON_INDIVIDUAL_TSOD_CE_' || IndividualType,
    'KIND_GREAT_PERSON_INDIVIDUAL'
FROM
    TsoDGreatPeopleOfCecil;

INSERT INTO
    GreatPersonClasses (
        GreatPersonClassType,
        Name,
        UnitType,
        DistrictType,
        AvailableInTimeline,
        GenerateDuplicateIndividuals,
        PseudoYieldType,
        IconString,
        ActionIcon
    )
SELECT
    'GREAT_PERSON_CLASS_TSOD_CE_' || ClassType,
    'LOC_GREAT_PERSON_CLASS_TSOD_CE_' || ClassType || '_NAME',
    'UNIT_GREAT_' || ClassType,
    DistrictType,
    0,
    0,
    'PSEUDOYIELD_GPP_' || ClassType,
    '[ICON_Great' || SUBSTR (ClassType, 1, 1) || LOWER(SUBSTR (ClassType, 2)) || ']',
    'ICON_UNITOPERATION_' || ClassType || '_ACTION'
FROM
    TsoDGreatPersonClasses;

INSERT INTO
    GreatPersonIndividuals (
        GreatPersonIndividualType,
        Name,
        GreatPersonClassType,
        EraType,
        Gender,
        ActionRequiresCompletedDistrictType,
        ActionCharges
    )
SELECT
    'GREAT_PERSON_INDIVIDUAL_TSOD_CE_' || IndividualType,
    'LOC_GREAT_PERSON_INDIVIDUAL_TSOD_CE_' || IndividualType || '_NAME',
    'GREAT_PERSON_CLASS_TSOD_CE_' || ClassType,
    EraType,
    Gender,
    ActionRequiresCompletedDistrictType,
    ActionCharges
FROM
    TsoDGreatPeopleOfCecil;

INSERT INTO
    GreatPersonIndividualActionModifiers (
        GreatPersonIndividualType,
        ModifierId,
        AttachmentTargetType
    )
VALUES
    (
        -- Achieved in TsoDCE_CivilizationTraits.lua
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_REBECCA_CECIL',
        'GREATPERSON_DUMMY_TSOD_CE_REBECCA_CECIL',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_JENNIE_PERRO',
        'GREATPERSON_GRANT_TECHNOLOGY_MATHEMATICS',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_JENNIE_PERRO',
        'GREATPERSON_GRANT_BUILDING_TSOD_MANA_OBELISK',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_SANTIS_SAIDE',
        'GREATPERSON_LIBRARY',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_SANTIS_SAIDE',
        'GREATPERSON_UNIVERSITY',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_SANTIS_SAIDE',
        'GREATPERSON_SINGLE_CITY_ADD_4_SCIENCE',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_SANTIS_SAIDE',
        'UNIVERSITY_BONUS_AMENITY_ATTACH',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_KAMEL_SLAYEN',
        'GREATPERSON_ELECTRICITYTECHBOOST',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
    ),
    (
        -- Achieved in TsoDCE_CivilizationTraits.lua
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_KAMEL_SLAYEN',
        'GREATPERSON_DUMMY_TSOD_CE_KAMEL_SLAYEN_INSPIRATION',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_KAMEL_SLAYEN',
        'GREATPERSON_ARTIFACT_SCIENCE',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_NORRIS',
        'GREATPERSON_SINGLE_CITY_20_GROWTH',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_NORRIS',
        'GREATPERSON_CITY_RICEWHEATYIELD',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_CITY'
    ),
    (
	    -- Achieved in TsoDCE_CivilizationTraits.lua
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_HETTIE_CECIL',
        'GREATPERSON_DUMMY_TSOD_CE_HETTIE_CECIL_REFUND_COAL',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
    );

INSERT
OR REPLACE INTO Modifiers (
    ModifierId,
    ModifierType,
    RunOnce,
    Permanent,
    NewOnly,
    OwnerRequirementSetId,
    SubjectRequirementSetId,
    SubjectStackLimit
)
VALUES
    (
        'GREATPERSON_DUMMY_TSOD_CE_REBECCA_CECIL',
        'MODIFIER_ALLIANCE_DO_NOTHING',
        0,
        0,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'GREATPERSON_GRANT_TECHNOLOGY_MATHEMATICS',
        'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', -- Requires EP2
        1,
        1,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'GREATPERSON_GRANT_BUILDING_TSOD_MANA_OBELISK',
        'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',
        1,
        1,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'GREATPERSON_SINGLE_CITY_ADD_4_SCIENCE',
        'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',
        0,
        1,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'UNIVERSITY_BONUS_AMENITY_ATTACH',
        'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',
        0,
        0,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'UNIVERSITY_BONUS_AMENITY',
        'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY',
        0,
        0,
        0,
        NULL,
        'CITY_HAS_UNIVERSITY_REQUIREMENTS',
        1
    ),
    (
        'GREATPERSON_ELECTRICITYTECHBOOST',
        'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',
        1,
        1,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'GREATPERSON_DUMMY_TSOD_CE_KAMEL_SLAYEN_INSPIRATION',
        'MODIFIER_ALLIANCE_DO_NOTHING',
        0,
        0,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'GREATPERSON_SINGLE_CITY_20_GROWTH',
        'MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH',
        1,
        1,
        0,
        NULL,
        NULL,
        NULL
    ),
    (
        'GREATPERSON_CITY_RICEWHEATYIELD',
        'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',
        0,
        0,
        0,
        NULL,
        'RESOURCE_IS_RICE_OR_YIELD',
        NULL
    ),
    (
        'GREATPERSON_DUMMY_TSOD_CE_HETTIE_CECIL_REFUND_COAL',
        'MODIFIER_ALLIANCE_DO_NOTHING',
        0,
        0,
        0,
        NULL,
        NULL,
        NULL
    );

INSERT
OR REPLACE INTO ModifierArguments (ModifierId, Name, Value)
VALUES
    (
        'GREATPERSON_GRANT_TECHNOLOGY_MATHEMATICS',
        'TechType',
        'TECH_MATHEMATICS'
    ),
    (
        'GREATPERSON_GRANT_BUILDING_TSOD_MANA_OBELISK',
        'BuildingType',
        'BUILDING_TSOD_MANA_OBELISK'
    ),
    (
        'GREATPERSON_SINGLE_CITY_ADD_4_SCIENCE',
        'Amount',
        '4'
    ),
    (
        'GREATPERSON_SINGLE_CITY_ADD_4_SCIENCE',
        'YieldType',
        'YIELD_SCIENCE'
    ),
    (
        'UNIVERSITY_BONUS_AMENITY_ATTACH',
        'ModifierId',
        'UNIVERSITY_BONUS_AMENITY'
    ),
    ('UNIVERSITY_BONUS_AMENITY', 'Amount', '1'),
    (
        'GREATPERSON_ELECTRICITYTECHBOOST',
        'TechType',
        'TECH_ELECTRICITY'
    ),
    (
        'GREATPERSON_SINGLE_CITY_20_GROWTH',
        'Amount',
        '20'
    ),
    ('GREATPERSON_CITY_RICEWHEATYIELD', 'Amount', '1'),
    (
        'GREATPERSON_CITY_RICEWHEATYIELD',
        'YieldType',
        'YIELD_FOOD'
    );

INSERT INTO
    RequirementSets (RequirementSetId, RequirementSetType)
VALUES
    (
        'CITY_HAS_UNIVERSITY_REQUIREMENTS',
        'REQUIREMENTSET_TEST_ALL'
    ),
    (
        'RESOURCE_IS_RICE_OR_YIELD',
        'REQUIREMENTSET_TEST_ANY'
    );

INSERT INTO
    RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
    (
        'CITY_HAS_UNIVERSITY_REQUIREMENTS',
        'CITY_HAS_UNIVERSITY_REQUIREMENT'
    ),
    (
        'RESOURCE_IS_RICE_OR_YIELD',
        'REQUIRES_RICE_IN_PLOT'
    ),
    (
        'RESOURCE_IS_RICE_OR_YIELD',
        'REQUIRES_WHEAT_IN_PLOT'
    );

INSERT INTO
    Requirements (RequirementId, RequirementType)
VALUES
    (
        'CITY_HAS_UNIVERSITY_REQUIREMENT',
        'REQUIREMENT_CITY_HAS_BUILDING'
    );

INSERT INTO
    RequirementArguments (RequirementId, Name, Value)
VALUES
    (
        'CITY_HAS_UNIVERSITY_REQUIREMENT',
        'BuildingType',
        'BUILDING_UNIVERSITY'
    );

INSERT INTO
    ModifierStrings (ModifierId, Context, Text)
VALUES
    (
        'GREATPERSON_DUMMY_TSOD_CE_REBECCA_CECIL',
        'Summary',
        'LOC_GREATPERSON_DUMMY_TSOD_CE_REBECCA_CECIL_DUMMY_DESCRIPTION'
    ),
    (
        'GREATPERSON_GRANT_TECHNOLOGY_MATHEMATICS',
        'Summary',
        'LOC_GREATPERSON_GRANT_TECHNOLOGY_MATHEMATICS_DESCRIPTION'
    ),
    (
        'GREATPERSON_GRANT_BUILDING_TSOD_MANA_OBELISK',
        'Summary',
        'LOC_GREATPERSON_GRANT_BUILDING_TSOD_MANA_OBELISK_DESCRIPTION'
    ),
    (
        'GREATPERSON_SINGLE_CITY_ADD_4_SCIENCE',
        'Summary',
        'LOC_GREATPERSON_SINGLE_CITY_ADD_4_SCIENCE_DESCRIPTION'
    ),
    (
        'UNIVERSITY_BONUS_AMENITY_ATTACH',
        'Summary',
        'LOC_UNIVERSITY_BONUS_AMENITY_ATTACH_DESCRIPTION'
    ),
    (
        'GREATPERSON_ELECTRICITYTECHBOOST',
        'Summary',
        'LOC_GREATPERSON_ELECTRICITYTECHBOOST_DESCRIPTION'
    ),
    (
        'GREATPERSON_DUMMY_TSOD_CE_KAMEL_SLAYEN_INSPIRATION',
        'Summary',
        'LOC_GREATPERSON_DUMMY_TSOD_CE_KAMEL_SLAYEN_INSPIRATION_DESCRIPTION'
    ),
    (
        'GREATPERSON_SINGLE_CITY_20_GROWTH',
        'Summary',
        'LOC_GREATPERSON_SINGLE_CITY_20_GROWTH_DESCRIPTION'
    ),
	(
        'GREATPERSON_CITY_RICEWHEATYIELD',
        'Summary',
        'LOC_GREATPERSON_CITY_RICEWHEATYIELD_DESCRIPTION'
    ),
    (
        'GREATPERSON_DUMMY_TSOD_CE_HETTIE_CECIL_REFUND_COAL',
        'Summary',
        'LOC_GREATPERSON_DUMMY_TSOD_CE_HETTIE_CECIL_REFUND_COAL_DESCRIPTION'
    );