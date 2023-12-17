INSERT INTO
    Types (Type, Kind)
VALUES
    ('LEADER_TSOD_GAWAIN_CECIL', 'KIND_LEADER');

INSERT INTO
    Leaders (LeaderType, Name, InheritFrom, Sex)
VALUES
    (
        'LEADER_TSOD_GAWAIN_CECIL',
        'LOC_LEADER_TSOD_GAWAIN_CECIL_NAME',
        'LEADER_DEFAULT',
        'Male'
    );

INSERT INTO
    LeaderQuotes (LeaderType, Quote)
VALUES
    (
        'LEADER_TSOD_GAWAIN_CECIL',
        'LOC_LEADER_TSOD_GAWAIN_CECIL_GREETING'
    );

INSERT INTO
    LoadingInfo (
        LeaderType,
        ForegroundImage,
        BackgroundImage,
        PlayDawnOfManAudio,
        LeaderText
    )
VALUES
    (
        'LEADER_TSOD_GAWAIN_CECIL',
        'IMG_LOADING_FOREGROUND_CECIL_EMPIRE',
        'IMG_LOADING_BACKGROUND_CECIL_EMPIRE',
        '1',
        'LOC_LOADING_INFO_LEADER_TSOD_GAWAIN_CECIL'
    );

INSERT INTO
    DiplomacyInfo (Type, BackgroundImage)
VALUES
    (
        'LEADER_TSOD_GAWAIN_CECIL',
        'IMG_DIPLOMACY_BACKGROUND_CECIL_EMPIRE'
    );