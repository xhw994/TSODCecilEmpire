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
        1
    );

--(
--'JENNIE_PERRO',
--'SCIENTIST',
--'DISTRICT_CAMPUS',
--'ERA_CLASSICAL',
--'F',
--'DISTRICT_CAMPUS',
--1
--),
--(
--'SANTIS_SAIDE',
--'SCIENTIST',
--'DISTRICT_CAMPUS',
--'ERA_MEDIEVAL',
--'M',
--'DISTRICT_CAMPUS',
--1
--),
--(
--'KAMEL_SLAYEN',
--'SCIENTIST',
--'DISTRICT_CAMPUS',
--'ERA_MODERN',
--'F',
--'DISTRICT_CAMPUS',
--1
--),
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
        'GREAT_PERSON_INDIVIDUAL_TSOD_CE_REBECCA_CECIL',
        'GREAT_PERSON_TSOD_CE_REBECCA_CECIL_GIVE_SETTLER',
        'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_UNIT_GREATPERSON'
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
        'GREAT_PERSON_TSOD_CE_REBECCA_CECIL_GIVE_SETTLER',
        'MODIFIER_PLAYER_GRANT_UNIT_IN_CAPITAL',
        0,
        0,
        0,
        NULL,
        NULL
    );

INSERT INTO
    ModifierArguments (ModifierId, Name, Value)
VALUES
    (
        'GREAT_PERSON_TSOD_CE_REBECCA_CECIL_GIVE_SETTLER',
        'AllowUniqueOverride',
        '0'
    ),
    (
        'GREAT_PERSON_TSOD_CE_REBECCA_CECIL_GIVE_SETTLER',
        'Amount',
        '1'
    ),
    (
        'GREAT_PERSON_TSOD_CE_REBECCA_CECIL_GIVE_SETTLER',
        'UnitType',
        'UNIT_SETTLER'
    );