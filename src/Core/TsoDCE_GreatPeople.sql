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
    );

--(
--'LEITE_AVIKEN',
--'PROPHET',
--'DISTRICT_HOLY_SITE',
--'ERA_ANCIENT',
--'M',
--'DISTRICT_HOLY_SITE',
--1
--),
--(
--'HETTIE_CECIL',
--'MERCHANT',
--'DISTRICT_GOVERNMENT', -- Ep1 R:F
--'ERA_ANCIENT',
--'F',
--'DISTRICT_GOVERNMENT',
--1
--),
--(
--'NORRIS',
--'SCIENTIST',
--'DISTRICT_CAMPUS',
--'ERA_CLASSICAL',
--'M',
--'DISTRICT_PRESERVE', -- Kublai Khan Vietanam pack
--1
--);
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
        ActionCharges,
        ActionEffectTextOverride
    )
SELECT
    'GREAT_PERSON_INDIVIDUAL_TSOD_CE_' || IndividualType,
    'LOC_GREAT_PERSON_INDIVIDUAL_TSOD_CE_' || IndividualType || '_NAME',
    'GREAT_PERSON_CLASS_TSOD_CE_' || ClassType,
    EraType,
    Gender,
    ActionRequiresCompletedDistrictType,
    ActionCharges,
    'LOC_GREATPERSON_TSOD_CE_' || IndividualType || '_ACTIVE'
FROM
    TsoDGreatPeopleOfCecil;

INSERT INTO
    GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId,AttachmentTargetType)
VALUES
    -- Rebecca's ability is in TsoDCE_CivilizationTraits.lua
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_JENNIE_PERRO',
        'GRANT_TECHNOLOGY_MATHEMATICS',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
    ),
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_JENNIE_PERRO',
        'GRANT_BUILDING_TSOD_MANA_OBELISK',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
    );

INSERT
OR REPLACE INTO Modifiers (
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
        'GRANT_TECHNOLOGY_MATHEMATICS',
        'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY',
        1,
        1,
        0,
        NULL,
        NULL
    ),
    (
        'GRANT_BUILDING_TSOD_MANA_OBELISK',
        'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',
        1,
        1,
        0,
        NULL,
        NULL
    );

INSERT
OR REPLACE INTO ModifierArguments (ModifierId, Name, Value)
VALUES
    (
        'GRANT_TECHNOLOGY_MATHEMATICS',
        'TechType',
        'TECH_MATHEMATICS'
    ),
    (
        'GRANT_BUILDING_TSOD_MANA_OBELISK',
        'BuildingType',
        'BUILDING_TSOD_MANA_OBELISK'
    );