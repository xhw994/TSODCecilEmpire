--INSERT INTO
--Types (Type, Kind)
--VALUES
--('UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE', 'KIND_UNIT');
--
--INSERT INTO Units
--(
--UnitType,
--Name,
--Description,
--
--TraitType,
--Cost,
--
--BaseSightRange,
--BaseMoves,
--ZoneOfControl,
--
--Domain,
--FormationClass,
--
--CanCapture,
--CanRetreatWhenCaptured,
--CanTrain
--)
--SELECT
--'UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE',
--'LOC_UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE_NAME',
--'LOC_UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE_DESCRIPTION',
--
--'TRAIT_UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE',
--Cost,
--
--BaseSightRange,
--BaseMoves,
--ZoneOfControl,
--
--Domain,
--FormationClass,
--
--CanCapture,
--CanRetreatWhenCaptured,
--CanTrain
--
--FROM Units WHERE UnitType = 'UNIT_GREAT_GENERAL';
--
--INSERT INTO
--TypeTags (Type, Tag)
--VALUES
--(
--'UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE',
--'CLASS_LANDCIVILIAN'
--),
--(
--'UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE',
--'CLASS_ALL_ERAS'
--);
--
--INSERT INTO
--UnitAiInfos (UnitType, AiType)
--VALUES
--(
--'UNIT_TSOD_CECIL_EMPIRE_GREATPEOPLE',
--'UNITTYPE_CIVILIAN'
--);
-- Great people
INSERT INTO
    Types (Type, Kind)
VALUES
    -- Great person classes
    (
        'GREAT_PERSON_CLASS_TSOD_CECIL_EMPIRE_SCIENTIST',
        'KIND_GREAT_PERSON_CLASS'
    ),
    -- Great person individuals
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_REBECCA_CECIL',
        'KIND_GREAT_PERSON_INDIVIDUAL'
    );

--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_SANTIS_SAIDE',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_KAMEL_SLAYEN',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_JENNIE_PERRO',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_HETTIE_CECIL',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_NORRIS',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_LEITE_AVIKEN',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_PITMAN_LAUREN',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_ST_NICHOLAS_EGG_EXEC',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_SIR_PHILIP',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_BYRON_KIRK',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_GINA',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--),
--(
--'GREAT_PERSON_INDIVIDUAL_TSOD_VISCOUNT_MARYLAND',
--'KIND_GREAT_PERSON_INDIVIDUAL'
--);
--INSERT INTO
--Traits (TraitType, Name, Description)
--VALUES
--(
--'TRAIT_TSOD_CECIL_GREATPEOPLE',
--'LOC_TRAIT_TSOD_CECIL_GREATPEOPLE_NAME',
--'LOC_TRAIT_TSOD_CECIL_GREATPEOPLE_DESCRIPTION'
--);
--
--INSERT INTO
--CivilizationTraits (CivilizationType, TraitType)
--VALUES
--(
--'CIVILIZATION_TSOD_CECIL_EMPIRE',
--'TRAIT_TSOD_CECIL_GREATPEOPLE'
--);
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
VALUES
    (
        'GREAT_PERSON_CLASS_TSOD_CECIL_EMPIRE_SCIENTIST',
        'LOC_GREAT_PERSON_CLASS_TSOD_CECIL_EMPIRE_SCIENTIST_NAME',
        'UNIT_GREAT_SCIENTIST',
        'DISTRICT_CAMPUS',
        0,
        0,
        'PSEUDOYIELD_GPP_SCIENTIST',
        '[ICON_GreatScientist]',
        'ICON_UNITOPERATION_SCIENTIST_ACTION'
    );

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
VALUES
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_REBECCA_CECIL',
        'LOC_GREAT_PERSON_INDIVIDUAL_TSOD_REBECCA_CECIL_NAME',
        'GREAT_PERSON_CLASS_TSOD_CECIL_EMPIRE_SCIENTIST',
        'ERA_CLASSICAL',
        'F',
        'DISTRICT_CAMPUS',
        1
    );

INSERT INTO
    GreatPersonIndividualActionModifiers (
        GreatPersonIndividualType,
        ModifierId,
        AttachmentTargetType
    )
VALUES
    (
        'GREAT_PERSON_INDIVIDUAL_TSOD_REBECCA_CECIL',
        'GREAT_PERSON_TSOD_REBECCA_CECIL_GIVE_SETTLER',
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
        'GREAT_PERSON_TSOD_REBECCA_CECIL_GIVE_SETTLER',
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
        'GREAT_PERSON_TSOD_REBECCA_CECIL_GIVE_SETTLER',
        'AllowUniqueOverride',
        '0'
    ),
    (
        'GREAT_PERSON_TSOD_REBECCA_CECIL_GIVE_SETTLER',
        'Amount',
        '1'
    ),
    (
        'GREAT_PERSON_TSOD_REBECCA_CECIL_GIVE_SETTLER',
        'UnitType',
        'UNIT_SETTLER'
    );
