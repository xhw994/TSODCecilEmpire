-- =============================================================================
-- TsoDCE_AI.sql
-- AI 偏好：让电脑玩家的高文·塞西尔会走「魔导科技 + 招募伟人」的路线，
-- 并认得塞西尔自己的特色建筑、特色单位。
-- 动作：InGame UpdateDatabase（风云变幻 criteria），排在 TsoDCE_Leaders.sql 之后。
--
-- 挂载点（AiLists.LeaderType 填的是 Trait，不是 Leader；AI 表对类型无外键，仅作引用）：
--   TRAIT_LEADER_TSOD_GAWAIN_CECIL    领袖特性，见 TsoDCE_Leaders.sql
--   TRAIT_AGENDA_TSOD_TRUTH_SEEKER    议程「真理探求」的特性，走 AgendaType 列
--
-- 已由官方特性覆盖、本文件不重复的部分（LeaderTraits 里已挂）：
--   TRAIT_LEADER_SCIENCE_MAJOR_CIV         偏好科技胜利（FavorScienceVictory）
--   TRAIT_LEADER_NONRELIGIOUS_MAJOR_CIV    不走宗教胜利（ForbidReligiousVictory）
--   TRAIT_LEADER_AGGRESSIVE_MILITARY       好战（AgressiveDiplomacy / AggressivePseudoYields）
--
-- 数值全部取自官方同类清单，没有自拟范围：
--   Technologies / Buildings / Districts：Favored=true，同官方 VictoriaTechs、PeterTechs、
--     KristinaBuildings、ScottishEnlightnmentDistricts 等。
--   Units：Value=1，同官方 VictoriaUnits / JadwigaUnitBuilds 的 UNIT_MILITARY_ENGINEER。
--   PseudoYields：领袖级偏好用 50（官方 KublaiKhanPseudoYieldPreferences、
--     HammurabiFavoredDistricts、JoaoExplorationObsessed 等），
--     次要方向用 25（官方 ModernPseudoYields 的艺术家 / 作家 / 音乐家、ScienceVictoryPseudoYields）。
--   议程 Yields：YIELD_SCIENCE = 20，同官方科技迷议程 ScienceLoverSciencePreference
--     （AGENDA_TECHNOPHILE → TRAIT_AGENDA_PREFER_SCIENCE）。
-- =============================================================================


INSERT INTO AiListTypes (ListType)
VALUES
    ('TSOD_CE_GAWAIN_TECHS'),
    ('TSOD_CE_GAWAIN_DISTRICTS'),
    ('TSOD_CE_GAWAIN_BUILDINGS'),
    ('TSOD_CE_GAWAIN_UNITS'),
    ('TSOD_CE_GAWAIN_GREATPEOPLE'),
    ('TSOD_CE_TRUTH_SEEKER_YIELDS');

INSERT INTO AiLists (ListType, LeaderType, AgendaType, System)
VALUES
    ('TSOD_CE_GAWAIN_TECHS', 'TRAIT_LEADER_TSOD_GAWAIN_CECIL', NULL, 'Technologies'),
    ('TSOD_CE_GAWAIN_DISTRICTS', 'TRAIT_LEADER_TSOD_GAWAIN_CECIL', NULL, 'Districts'),
    ('TSOD_CE_GAWAIN_BUILDINGS', 'TRAIT_LEADER_TSOD_GAWAIN_CECIL', NULL, 'Buildings'),
    ('TSOD_CE_GAWAIN_UNITS', 'TRAIT_LEADER_TSOD_GAWAIN_CECIL', NULL, 'Units'),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'TRAIT_LEADER_TSOD_GAWAIN_CECIL', NULL, 'PseudoYields'),
    ('TSOD_CE_TRUTH_SEEKER_YIELDS', NULL, 'TRAIT_AGENDA_TSOD_TRUTH_SEEKER', 'Yields');

INSERT INTO AiFavoredItems (ListType, Item, Favored, Value)
VALUES
    -- 科技：魔导科技路线。三项正好是塞西尔特色内容的门槛——
    --   数学（魔能方尖碑，也是詹妮·佩罗直接送出的科技）、
    --   电力（魔能方尖碑所有建筑基础产能翻倍）、
    --   计算机（戈尔贡平台，与被替代的无人机同一科技）。
    ('TSOD_CE_GAWAIN_TECHS', 'TECH_MATHEMATICS', 1, 0),
    ('TSOD_CE_GAWAIN_TECHS', 'TECH_ELECTRICITY', 1, 0),
    ('TSOD_CE_GAWAIN_TECHS', 'TECH_COMPUTERS', 1, 0),

    -- 区域：学院（科技主线、学院建筑送伟人）、工业区（方尖碑相邻加成、产能）、
    --   军营（征服路线与菲利普）。同官方苏格兰启蒙清单（学院 + 工业区）。
    ('TSOD_CE_GAWAIN_DISTRICTS', 'DISTRICT_CAMPUS', 1, 0),
    ('TSOD_CE_GAWAIN_DISTRICTS', 'DISTRICT_INDUSTRIAL_ZONE', 1, 0),
    ('TSOD_CE_GAWAIN_DISTRICTS', 'DISTRICT_ENCAMPMENT', 1, 0),

    -- 建筑：特色建筑魔能方尖碑（替代纪念碑）。
    ('TSOD_CE_GAWAIN_BUILDINGS', 'BUILDING_TSOD_MANA_OBELISK', 1, 0),

    -- 单位：特色单位戈尔贡平台（替代无人机）。
    --   被替代的无人机在官方只有 UNITTYPE_SIEGE_SUPPORT 一个 AI 类型，
    --   戈尔贡平台在 TsoDCE_Units.sql 的 UnitAiInfos 里已是同一个，不用补。
    --   琥珀是首都自带、不可生产的单位，不在此列。
    ('TSOD_CE_GAWAIN_UNITS', 'UNIT_TSOD_GORGON_PLATFORM', 1, 1),

    -- 伟人：招募伟人是领袖能力的核心（同类 +20% 起，每位再 +5% 全类型）。
    --   科学家为主线 50，其余类型 25；先知不列——领袖带
    --   TRAIT_LEADER_NONRELIGIOUS_MAJOR_CIV，本来就不走宗教胜利。
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_SCIENTIST', 1, 50),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_ENGINEER', 1, 25),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_GENERAL', 1, 25),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_ADMIRAL', 1, 25),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_MERCHANT', 1, 25),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_WRITER', 1, 25),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_ARTIST', 1, 25),
    ('TSOD_CE_GAWAIN_GREATPEOPLE', 'PSEUDOYIELD_GPP_MUSICIAN', 1, 25),

    -- 议程「真理探求」：设法获得科技值，同官方科技迷议程。
    ('TSOD_CE_TRUTH_SEEKER_YIELDS', 'YIELD_SCIENCE', 1, 20);