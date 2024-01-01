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
        'LEADER_TSOD_GAWAIN_CECIL_LOADING_FOREGROUND',
        'LEADER_TSOD_GAWAIN_CECIL_LOADING_BACKGROUND',
        '1',
        'LOC_LOADING_INFO_LEADER_TSOD_GAWAIN_CECIL'
    );

INSERT INTO
    DiplomacyInfo (Type, BackgroundImage)
VALUES
    (
        'LEADER_TSOD_GAWAIN_CECIL',
        'LEADER_TSOD_GAWAIN_CECIL_DIPLOMACY_BACKGROUND'
    );