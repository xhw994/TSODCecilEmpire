INSERT
OR REPLACE INTO LocalizedText (Tag, LANGUAGE, Text)
VALUES
    ('LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_NAME', 'zh_Hans_CN', '塞西尔'),
    ('LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_DESCRIPTION', 'zh_Hans_CN', '塞西尔帝国'),
    ('LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_ADJECTIVE', 'zh_Hans_CN', '塞西尔帝国的'),
    ('LOC_TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE_NAME', 'zh_Hans_CN', '丈量真理'),
    (
        'LOC_TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE_DESCRIPTION',
        'zh_Hans_CN',
        '{LOC_TSOD_QUARRY_BONUS_TECH_DESCRIPTION}{LOC_TSOD_NITER_MINE_BONUS_FAITH_DESCRIPTION}首次建成一个特殊区域，或者是首次建造学院区域建筑时，获赠一位塞西尔的独特伟人。'
    ),
    ('LOC_LEADER_TSOD_GAWAIN_CECIL_NAME', 'zh_Hans_CN', '高文·塞西尔'),
    ('LOC_TRAIT_LEADER_TSOD_GAWAIN_CECIL_NAME', 'zh_Hans_CN', '黎明之剑'),
    (
        'LOC_TRAIT_LEADER_TSOD_GAWAIN_CECIL_DESCRIPTION',
        'zh_Hans_CN',
        '招募一名伟人后，每回合将获得该类型伟人点数产出的额外20%。随后每增加一名同类型的伟人都会使这个比例额外增加10%。通过这种方式，每回合最多可获得100%的额外产出。此外，塞西尔的伟人们也将为招募他们的区域提供相应类型的伟人点数产出增益。'
    ),
    (
        'LOC_LOADING_INFO_LEADER_TSOD_GAWAIN_CECIL',
        'zh_Hans_CN',
        '高文·塞西尔，骑士之主，开拓者，保护者，王国奠基之人，在这片土地还被称为安苏的时候，你便是它的南境守护。这些年，你立下了不少丰功伟绩，振兴南境，统一国家，引领一个时代，乃至于整合这颗星球上的文明——你收复了废土，击败了神明，现在你还将引领这个世界对抗魔潮，完成文明迈向星空前的最后一次考验……多么惊人的成就啊，而在许多人心中，这些功绩皆集于你一身，那么在完成这些丰功伟绩的时候，有没有那么一刻，哪怕只是一个瞬间，你意识到自己已经……宛若神明？'
    ),
    -- Quotes
    ('LOC_LEADER_TSOD_GAWAIN_CECIL_INTRO_QUOTE', 'zh_Hans_CN', '骑士比法师牛逼！'),
    ('LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '人类必将永存，纵使忤逆神明。'),
    ('LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '只有更强大的合作伙伴才能带给你更大的利益，我从来不担心别人的发展，我只要能保证自己是发展最快的那个便足够了。'),
    ('LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '人应敬畏自然，但却不可因敬畏自然而止步于自然。'),
    ('LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '道别是为了下次再会，晚安是为了共同迎接下一個黎明。'),
    ('LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '这个世界并不总是会发生好事很多时候，坏事可能还更多一些，但只要明天的太阳还能升起，就不妨对未来多期待一点。'),
    ('LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '唯有更强大的炮火才能给人类带来生存希望。'),
    ('LOC_DIPLO_DECLARE_WAR_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '唯有更强大的炮火才能给人类带来生存希望。'),
    ('LOC_DIPLO_DEFEAT_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '或许并不是所有人都能在这个艰难的世界生存下来，但每一位牺牲者的出现，都只能证明我们的无能。'),
    ('LOC_DIPLO_DEFEAT_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '或许并不是所有人都能在这个艰难的世界生存下来，但每一位牺牲者的出现，都只能证明我们的无能。'),
    ('LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '知识永远都是有价值的，即使文明覆灭，即使最后一个有智慧的生命在星空下闭上了眼睛，知识——作为文明求索未知的脚印，它也永远有其意义。'),
    (
        'LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY',
        'zh_Hans_CN',
        '领袖的一个决定，可能会让成百上千的人付出牺牲，有时候这个决定是必须的，有时候人民的牺牲是自愿的，伫领袖永远不能心安理得地接受这些牺牲，他必须知那些付出牺牲的人站在一起，并随时做好一同流血的准备。'
    ),
    ('LOC_DIPLO_DELEGATION_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '教导，学习，传播，知识的传递只要开始，就不会轻易停下，它会一直持续下去，直到每个人都有权利接触知识，都有权利思考和探究真理。'),
    (
        'LOC_DIPLO_DENOUNCE_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY',
        'zh_Hans_CN',
        '如果一个君主或领主只能用暴力和压迫来统治自己的子民，那么他的统治也就根本不是统治，因为随便换一只豺狼虎豹上去也能做到和他一样的事。[NEWLINE]（谴责你）'
    ),
    ('LOC_DIPLO_DENOUNCE_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '如果一个君主或领主只能用暴力和压迫来统治自己的子民，那么他的统治也就根本不是统治，因为随便换一只豺狼虎豹上去也能做到和他一样的事。[NEWLINE]（谴责你）'),
    ('LOC_DIPLO_FIRST_MEET_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '人类必将永存，纵使忤逆神明。'),
    ('LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '欢迎来到塞西尔，欢迎来到未来。'),
    ('LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '欢迎来到塞西尔，欢迎来到未来。'),
    ('LOC_DIPLO_GREETING_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '高文·塞西尔向你问好'),
    ('LOC_DIPLO_KUDO_EXIT_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '正义和仁慈才会让人民去依附，就像人会自然而然地向往光明一样。'),
    ('LOC_DIPLO_KUDO_TSOD_GAWAIN_CECIL_REASON_ANY', 'zh_Hans_CN', '你向人民传播知识的行为让高文·塞西尔很高兴'),
    ('LOC_DIPLO_WARNING_EXIT_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '你从未真的低头看过，看一眼那些卑微的人。'),
    ('LOC_DIPLO_WARNING_TSOD_GAWAIN_CECIL_REASON_ANY', 'zh_Hans_CN', '你让人民保持愚昧的行为让高文·塞西尔很失望'),
    ('LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '行了，有什么阶级矛盾意识冲突的都先放一边吧。现在咱们是一条船上的人了。'),
    ('LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '路就在那里，门只是一个虚无缥缈的装饰品罢了，只要抛开心理上的问题，哪怕是皇家宝库的大门也只需要一根芹菜而已。'),
    ('LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '我就是规矩。'),
    ('LOC_DIPLO_MAKE_PEACE_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '人人吃饱穿暖，就是最大的正义。'),
    ('LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '高文·塞西尔向你问好'),
    ('LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '我只是单纯地希望知识能传播出去，越广越好。'),
    ('LOC_DIPLO_OPEN_BORDERS_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '教导，学习，传播，知识的传递只要开始，就不会轻易停下，它会一直持续下去，直到每个人都有权利接触知识，都有权利思考和探究真理。你愿意向我们敞开边境吗？'),
    ('LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '请把你的部队从塞西尔的边境上移走。'),
    ('LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY}'),
    ('LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'zh_Hans_CN', '{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY}'),
    -- Pedia
    ('LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN', '原身为安苏南境的塞西尔领，首都为塞西尔（与国名同名），初代皇帝为传奇英雄高文·塞西尔。'),
    (
        'LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_2',
        'zh_Hans_CN',
        '魔潮爆发后，一群难民（含高文·塞西尔在内）逃出刚铎帝国废土，于北方的边境外开拓领土、建立王国，施行封建领主制度。国王（摩恩家族）居住于中央首都白银堡，分封守护公爵（东境：罗伦；西境：法兰克林；南境：塞西尔；北境：维尔德）镇守四方，下辖袭爵领主无数。文明程度由于资源条件匮乏，退化至相当于中世纪中后期。'
    ),
    (
        'LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_3',
        'zh_Hans_CN',
        '七百年后当高文“诈尸”时，安苏王国已因雾月内乱进入第二王朝，封建制度已经僵化腐败，文明进程几乎停滞。'
    ),
    (
        'LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_4',
        'zh_Hans_CN',
        '高文揭棺而起后在安苏南境黑暗山脉地区建立了新塞西尔领（即后世的塞西尔城），大力发展魔导工业和新的社会制度。在安苏内战爆发后统一南境，“神灾”爆发后北上平定灾难。经过第二次内战、晶簇怪物（万物终亡会激活神孽因子）、猎神之战后完成政权交接，和平接管了安苏王国。'
    ),
    ('LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_CAPSULE_BODY', 'zh_Hans_CN', '高文带领人民终结神话时代，抵御魔潮，并最终带领洛伦星球所有文明迈向星空。在游戏中，他尝试用魔网科技以及招贤纳才获得胜利。'),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_DETAILED_BODY',
        'zh_Hans_CN',
        '高文拥有以魔网科技为主导、招募伟人为辅助的游戏玩法。玩家需要在前期通过万神殿等方式获得[ICON_Culture]文化值以弥补无法建造纪念碑的劣势。当玩家可以建造魔能方尖碑后，便可以通过合理规划获得大量的区域相邻加成，并解锁相对自由的发展方向。第一次建造特殊区域都会附赠相应的伟人。他们都会提供改变游戏战术的加成。玩家可以通过建造军营获得菲利普骑士，解锁以炮击饱和轰炸为方向的征服玩法；可以建造圣地解锁莱特，配合宗教信条，通过信仰值反哺文明；通过组合市政广场、工业区、金融中心或保护区，可以高效率发展人口、提升地块产出；玩家也可以继续发展科技，获得学院区建筑赠送的伟人带来的大量加成。不论玩家选择哪种玩法都需要尽可能多的招纳伟人，获得相应领域的伟人点数加成。'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_1',
        'zh_Hans_CN',
        '《黎明之剑》主人公，灵魂来自地球，因飞机失事而穿越，清醒后变成了飘在某颗星球上的一个固定视角，这是星球的一颗同步轨道卫星。后疑似因卫星故障，灵魂被逃逸程序送至星球上，附身于七百年前逝世的安苏王国塞西尔家族先祖高文·塞西尔身上并借此复活。'
    ),
    ('LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_2', 'zh_Hans_CN', '拥有穿越前的记忆与知识，同时也拥有高文·塞西尔的记忆，但是相比700年前的高文·塞西尔实力有一定下降。'),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_3',
        'zh_Hans_CN',
        '后开创塞西尔帝国，任皇帝，在种田、发展魔网科技的同时，追寻“魔潮”、“黑阱”、“神明”及“起航者”等事情的真相，各种努力以求带领大家走出上百万年类似大过滤器的文明轮回。'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_4',
        'zh_Hans_CN',
        '斩杀战神后，联合大陆所有种族，建立“神权理事会”，寻求神明和凡人共处的方法，领导联盟反攻废土。领导联盟与诺伊文明的交流，并最终提出完善的母星屏障方案，带领洛伦诸凡人文明迎来黎明。'
    ),
    -- City names
    ('LOC_CITY_NAME_TSOD_CECIL', 'zh_Hans_CN', '塞西尔城'),
    ('LOC_CITY_NAME_TSOD_SAINT_SUNIL', 'zh_Hans_CN', '圣苏尼尔城'),
    ('LOC_CITY_NAME_TSOD_LONGWIND_FORTRESS', 'zh_Hans_CN', '长风要塞'),
    ('LOC_CITY_NAME_TSOD_FROSTWOOD_VILLAGE', 'zh_Hans_CN', '霜林村'),
    ('LOC_CITY_NAME_TSOD_ROCKSTONE', 'zh_Hans_CN', '磐石城'),
    ('LOC_CITY_NAME_TSOD_MEGALITH', 'zh_Hans_CN', '巨石城'),
    ('LOC_CITY_NAME_TSOD_LUAN', 'zh_Hans_CN', '卢安城'),
    ('LOC_CITY_NAME_TSOD_RED_MAPLE', 'zh_Hans_CN', '红枫城'),
    ('LOC_CITY_NAME_TSOD_POMPEII', 'zh_Hans_CN', '培波城'),
    ('LOC_CITY_NAME_TSOD_ELRON', 'zh_Hans_CN', '埃尔隆城'),
    ('LOC_CITY_NAME_TSOD_FERTILE_WOODLANDS', 'zh_Hans_CN', '丰饶林地'),
    ('LOC_CITY_NAME_TSOD_SLANTWOOD_VALLEY', 'zh_Hans_CN', '斜林河谷'),
    ('LOC_CITY_NAME_TSOD_LONGSTONE_TOWN', 'zh_Hans_CN', '长石镇'),
    ('LOC_CITY_NAME_TSOD_TENWOODS', 'zh_Hans_CN', '十林城'),
    ('LOC_CITY_NAME_TSOD_TAMDULUR', 'zh_Hans_CN', '塔姆杜勒'),
    ('LOC_CITY_NAME_TSOD_LUNTATELLE_SHIRE', 'zh_Hans_CN', '伦塔特尔郡'),
    ('LOC_CITY_NAME_TSOD_HALL_SHIRE', 'zh_Hans_CN', '霍尔郡'),
    ('LOC_CITY_NAME_TSOD_CAROL', 'zh_Hans_CN', '卡洛尔城'),
    ('LOC_CITY_NAME_TSOD_KANT', 'zh_Hans_CN', '康德城'),
    ('LOC_CITY_NAME_TSOD_GRAN', 'zh_Hans_CN', '葛兰城'),
    ('LOC_CITY_NAME_TSOD_LESLIE', 'zh_Hans_CN', '莱斯利城'),
    ('LOC_CITY_NAME_TSOD_HOSMAN', 'zh_Hans_CN', '霍斯曼城'),
    -- Citizen names
    ('LOC_CITIZEN_NAME_TSOD_SAM', 'zh_Hans_CN', '山姆'),
    ('LOC_CITIZEN_NAME_TSOD_TOM', 'zh_Hans_CN', '汤姆'),
    ('LOC_CITIZEN_NAME_TSOD_PEA', 'zh_Hans_CN', '豌豆'),
    ('LOC_CITIZEN_NAME_TSOD_GORDON', 'zh_Hans_CN', '戈登'),
    ('LOC_CITIZEN_NAME_TSOD_HALL', 'zh_Hans_CN', '霍尔'),
    ('LOC_CITIZEN_NAME_TSOD_ELVIN_FRANKLIN', 'zh_Hans_CN', '伊莱文·法兰克林'),
    ('LOC_CITIZEN_NAME_TSOD_FENDIL_WILDER', 'zh_Hans_CN', '芬迪尔·维尔德'),
    ('LOC_CITIZEN_NAME_TSOD_VICTORIA_WILDER', 'zh_Hans_CN', '维多利亚·维尔德'),
    ('LOC_CITIZEN_NAME_TSOD_CROMWELL_WHITEMOUNTAIN', 'zh_Hans_CN', '克伦威尔·白山'),
    ('LOC_CITIZEN_NAME_TSOD_BODWIN_FRANKLIN', 'zh_Hans_CN', '柏德文·法兰克林'),
    ('LOC_CITIZEN_NAME_TSOD_VERONICA_MOEN', 'zh_Hans_CN', '维罗妮卡·摩恩'),
    ('LOC_CITIZEN_NAME_TSOD_SEWEN_TERRY', 'zh_Hans_CN', '赛文·特里'),
    ('LOC_CITIZEN_NAME_TSOD_HAMEL', 'zh_Hans_CN', '汉默尔'),
    ('LOC_CITIZEN_NAME_TSOD_HOLM', 'zh_Hans_CN', '霍姆'),
    ('LOC_CITIZEN_NAME_TSOD_MARGARITA', 'zh_Hans_CN', '玛格丽塔'),
    ('LOC_CITIZEN_NAME_TSOD_BETTY', 'zh_Hans_CN', '贝蒂'),
    ('LOC_CITIZEN_NAME_TSOD_WITCH_GIPLY', 'zh_Hans_CN', ''' 女巫 ''吉普莉'),
    ('LOC_CITIZEN_NAME_TSOD_SCARFACE_ANTON', 'zh_Hans_CN', ''' 疤脸 ''安东'),
    ('LOC_CITIZEN_NAME_TSOD_BELK_LOREN', 'zh_Hans_CN', '贝尔克·罗伦'),
    ('LOC_CITIZEN_NAME_TSOD_GELIN', 'zh_Hans_CN', '葛林'),
    ('LOC_CITIZEN_NAME_TSOD_CODY_BALDWIN', 'zh_Hans_CN', '科德·鲍德温'),
    ('LOC_CITIZEN_NAME_TSOD_PATTY_GRAN', 'zh_Hans_CN', '帕蒂·葛兰'),
    ('LOC_CITIZEN_NAME_TSOD_ROPENI_GRAN', 'zh_Hans_CN', '罗佩妮·葛兰'),
    -- Agendas
    ('LOC_AGENDA_TSOD_TRUTH_SEEKER_NAME', 'zh_Hans_CN', '真理探求'),
    ('LOC_AGENDA_TSOD_TRUTH_SEEKER_DESCRIPTION', 'zh_Hans_CN', '设法获得[ICON_Science]科技值，喜欢同样专注于[ICON_Science]科技的文明。不喜欢[ICON_SCIENCE]科技值低的文明。'),
    -- Traits
    ('LOC_TSOD_QUARRY_BONUS_TECH_DESCRIPTION', 'zh_Hans_CN', '改良的采石场+1[ICON_Science]科技。'),
    ('LOC_TSOD_NITER_MINE_BONUS_FAITH_DESCRIPTION', 'zh_Hans_CN', '正确改良的硝石+3[ICON_Faith]信仰。');

INSERT
OR REPLACE INTO BaseGameText (Tag, Text)
VALUES
    ('LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_NAME', 'Cecil'),
    ('LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_DESCRIPTION', 'Cecil Empire'),
    ('LOC_CIVILIZATION_TSOD_CECIL_EMPIRE_ADJECTIVE', 'Cecil Empire''s'),
    ('LOC_TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE_NAME', 'Quantifying the Truth'),
    (
        'LOC_TRAIT_CIVILIZATION_TSOD_CECIL_EMPIRE_DESCRIPTION',
        '{LOC_TSOD_QUARRY_BONUS_TECH_DESCRIPTION}{LOC_TSOD_NITER_MINE_BONUS_FAITH_DESCRIPTION}Upon first completing a special district, or a campus building for the first time, receive a unique Great Person of Cecil.'
    ),
    ('LOC_LEADER_TSOD_GAWAIN_CECIL_NAME', 'Gawain Cecil'),
    ('LOC_TRAIT_LEADER_TSOD_GAWAIN_CECIL_NAME', 'The Sword of Dawn'),
    (
        'LOC_TRAIT_LEADER_TSOD_GAWAIN_CECIL_DESCRIPTION',
        'After recruiting a Great Person, gain an extra 20% in that type''s Great Person points per turn. Each additional Great Person of the same type adds 10% more, up to 100% extra. Also, Cecil''s Great People boost their type''s point output of their recruitment region.'
    ),
    (
        'LOC_LOADING_INFO_LEADER_TSOD_GAWAIN_CECIL',
        'Gawain Cecil, Lord of Knights, Pioneer, Protector, the Founder of the Kingdom. When this land was still called Ansu, you were its guardian in the south. Over the years, you have achieved numerous remarkable feats: revitalizing the southern lands, unifying a nation, leading an era, and even united the civilizations of this planet. you reclaimed wastelands, defeated deities, and now, you will lead this world against the Mana Tide, completing the final test before civilization steps into the stars... Such astonishing achievements, and to many people, all these feats are embodied in you. So, after these great deeds, was there ever a moment, even just a slight instant, you realized that you have almost become... a God?'
    ),
    ('LOC_LEADER_TSOD_GAWAIN_CECIL_INTRO_QUOTE', 'Gawain Cecil sends his greetings.'),
    -- Quotes
    ('LOC_LEADER_TSOD_GAWAIN_CECIL_INTRO_QUOTE', 'Knights are better than mages!'),
    ('LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_TSOD_GAWAIN_CECIL_ANY', 'Humanity will endure, even if it defies the gods.'),
    (
        'LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_TSOD_GAWAIN_CECIL_ANY',
        'Only stronger partners can bring you greater benefits. I never worry about others'' development, as long as I ensure that I am the fastest developing one.'
    ),
    ('LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_TSOD_GAWAIN_CECIL_ANY', 'Humans should revere nature, but not be hindered by it.'),
    ('LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'Farewell is to meet again; good night is to embrace the next dawn together.'),
    (
        'LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY',
        'The world doesn''t always bring good things; sometimes bad things happen more often. But as long as the sun rises tomorrow, we can look forward to the future.'
    ),
    ('LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'Only stronger firepower can bring hope for human survival.'),
    ('LOC_DIPLO_DECLARE_WAR_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'Only stronger firepower can bring hope for human survival.'),
    (
        'LOC_DIPLO_DEFEAT_FROM_AI_TSOD_GAWAIN_CECIL_ANY',
        'Perhaps not everyone can survive in this harsh world, but each sacrifice only proves our incompetence.'
    ),
    (
        'LOC_DIPLO_DEFEAT_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY',
        'Perhaps not everyone can survive in this harsh world, but each sacrifice only proves our incompetence.'
    ),
    (
        'LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY',
        'Knowledge is always valuable. Even if civilization perishes and the last intelligent being closes their eyes under the starry sky, knowledge remains meaningful as the footprints of civilization''s quest for the unknown.'
    ),
    (
        'LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY',
        'A leader''s decision may lead to the sacrifice of hundreds or thousands of people. Sometimes this decision is necessary, sometimes the people volunteer their sacrifice. But a leader can never accept these sacrifices with a clear conscience. He must stand with those who sacrifice and be ready to bleed with them at any time.'
    ),
    (
        'LOC_DIPLO_DELEGATION_FROM_AI_TSOD_GAWAIN_CECIL_ANY',
        'Teaching, learning, spreading. Once the transmission of knowledge begins, it doesn''t stop easily. It continues until everyone has the right to access knowledge and the right to think and explore the truth.'
    ),
    (
        'LOC_DIPLO_DENOUNCE_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY',
        'If a ruler can only govern their people with violence and oppression, then their rule is not governance at all. Any wild beast could do the same. [NEWLINE] (Denouncing you)'
    ),
    (
        'LOC_DIPLO_DENOUNCE_FROM_AI_TSOD_GAWAIN_CECIL_ANY',
        'If a ruler can only govern their people with violence and oppression, then their rule is not governance at all. Any wild beast could do the same. [NEWLINE] (Denouncing you)'
    ),
    ('LOC_DIPLO_FIRST_MEET_TSOD_GAWAIN_CECIL_ANY', 'Humanity will endure, even if it defies the gods.'),
    ('LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_TSOD_GAWAIN_CECIL_ANY', 'Welcome to Cecil, welcome to the future.'),
    ('LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_TSOD_GAWAIN_CECIL_ANY', 'Welcome to Cecil, welcome to the future.'),
    ('LOC_DIPLO_GREETING_TSOD_GAWAIN_CECIL_ANY', 'Gawain Cecil greets you.'),
    ('LOC_DIPLO_KUDO_EXIT_TSOD_GAWAIN_CECIL_ANY', 'Only justice and kindness will make people adhere, just as they naturally yearn for light.'),
    ('LOC_DIPLO_KUDO_TSOD_GAWAIN_CECIL_REASON_ANY', 'Your efforts in spreading knowledge to the people have pleased Gawain Cecil.'),
    ('LOC_DIPLO_WARNING_EXIT_TSOD_GAWAIN_CECIL_ANY', 'You have never really looked down to see the humble people.'),
    ('LOC_DIPLO_WARNING_TSOD_GAWAIN_CECIL_REASON_ANY', 'Your actions in keeping the people uneducated have disappointed Gawain Cecil.'),
    (
        'LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_TSOD_GAWAIN_CECIL_ANY',
        'Alright, let''s put aside any class struggles or ideological differences. We are now in the same boat.'
    ),
    (
        'LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_TSOD_GAWAIN_CECIL_ANY',
        'The road is there, the door is just an illusion. As long as we let go of mental barriers, even the door to the royal treasury can be opened with just a stalk of celery.'
    ),
    ('LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_TSOD_GAWAIN_CECIL_ANY', 'I am the rule.'),
    ('LOC_DIPLO_MAKE_PEACE_FROM_AI_TSOD_GAWAIN_CECIL_ANY', 'Everyone having enough to eat and wear is the greatest justice.'),
    ('LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'Gawain Cecil greets you.'),
    ('LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_TSOD_GAWAIN_CECIL_ANY', 'I simply wish for knowledge to be spread as widely as possible.'),
    (
        'LOC_DIPLO_OPEN_BORDERS_FROM_AI_TSOD_GAWAIN_CECIL_ANY',
        'Teaching, learning, spreading. Once the transmission of knowledge begins, it doesn''t stop easily. It continues until everyone has the right to access knowledge and the right to think and explore the truth. Are you willing to open your borders to us?'
    ),
    ('LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_TSOD_GAWAIN_CECIL_ANY', 'Please remove your troops from Cecil''s borders.'),
    ('LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_TSOD_GAWAIN_CECIL_ANY', '{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY}'),
    ('LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_TSOD_GAWAIN_CECIL_ANY', '{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_TSOD_GAWAIN_CECIL_ANY}'),
    -- Pedia
    (
        'LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_1',
        'Originally the Cecil territory in the southern Ansu region, the capital is also named Cecil. The first emperor was the legendary hero Gawain Cecil.'
    ),
    (
        'LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_2',
        'After the mana tide outbreak, a group of refugees (including Gawain Cecil) escaped from the Gondor Empire wasteland, opened up territories in the northern border, and established a kingdom, implementing the feudal lord system. The king (of the Morne family) resides in the central capital Silver Castle, with guardianship dukes (East: Loren; West: Franklin; South: Cecil; North: Vilde) guarding the four directions, under which countless fief lords are subordinate. Due to scarce resources, civilization level degraded to be equivalent to the mid-late medieval period.'
    ),
    (
        'LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_3',
        'Seven hundred years later, when Gawain "resurrected," the Ansu Kingdom had entered the second dynasty due to the Fog Moon Rebellion, and the feudal system had stagnated and decayed, with civilization progress almost at a standstill.'
    ),
    (
        'LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_TSOD_CECIL_EMPIRE_CHAPTER_HISTORY_PARA_4',
        'After Gawain''s resurrection, he established the new Cecil territory (later known as Cecil City) in the southern Ansu Dark Mountains region, vigorously developing Arcane Industrialization and new social systems. After unifying the southern region following the Ansu Civil War, and stabilizing the northern disaster during the "Deity Catastrophe," they achieved a peaceful transfer of power and took over the Ansu Kingdom.'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_CAPSULE_BODY',
        'Gawain led the people to end the age of myths, resist the mana tide, and finally led all the civilizations on Loren planet towards the stars. In the game, he attempts to win through magitech and recruiting great people.'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_DETAILED_BODY',
        'Gawain has a gameplay focused on magitech and recruiting great people. Players need to obtain [ICON_Culture] culture points through pantheons in the early game to offset the disadvantage of not being able to build monuments. Once players can build the Mana Obelisk, they can gain significant district adjacency bonuses through strategic planning and unlock relatively free development paths. The first time a unique district is built, it grants a corresponding great person. These great people provide tactical bonuses that can change the game. Players can build barracks to obtain Philip the Knight and unlock a conquest playstyle focused on artillery saturation bombing; build holy sites to unlock Leite and, with religious tenets, use faith points to support civilization; combine government plaza, industrial zone, commercial hub, or preserve to efficiently develop population and increase tile yields; or continue developing technology to gain massive bonuses from great people granted by the campus district buildings. No matter which playstyle the player chooses, recruiting as many great people as possible and gaining great person point bonuses in the respective fields is essential.'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_1',
        'The protagonist of "The Sword Of Dawn," a soul from Earth who crossed over due to a plane crash, awakening as a fixed perspective geostationary satellite floating over a planet. Later, possibly due to satellite failure, the soul was sent to the planet by an escape program and attached to the body of Gawain Cecil, an ancestor of the Cecil family of the Ansu Kingdom who died 700 years ago, and revived.'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_2',
        'He possesses memories and knowledge from before crossing, as well as the memories of Gawain Cecil, but has somewhat weakened abilities compared to the Gawain Cecil of 700 years ago.'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_3',
        'Gawain later founded the Cecil Empire, served as emperor, while farming and developing magitech, pursued the truth of matters such as the "mana tide," "black trap," "deities," and "Pioneers," striving to lead everyone out of the millions of years of Great-Filter-like civilization cycle.'
    ),
    (
        'LOC_PEDIA_LEADERS_PAGE_LEADER_TSOD_GAWAIN_CECIL_CHAPTER_HISTORY_PARA_4',
        'After slaying the War God, Gawain united all races on the continent, established the "Theocracy Council," sought ways for gods and mortals to coexist, led the alliance to counterattack the wasteland, facilitated communications with the Noy civilization, and eventually proposed a complete homeworld barrier plan, leading the Loren mortal civilizations to a new dawn.'
    ),
    -- City names
    ('LOC_CITY_NAME_TSOD_CECIL', 'Cecil'),
    ('LOC_CITY_NAME_TSOD_SAINT_SUNIL', 'Saint Sunil'),
    ('LOC_CITY_NAME_TSOD_LONGWIND_FORTRESS', 'Longwind Fortress'),
    ('LOC_CITY_NAME_TSOD_FROSTWOOD_VILLAGE', 'Frostwood Village'),
    ('LOC_CITY_NAME_TSOD_ROCKSTONE', 'Rockstone'),
    ('LOC_CITY_NAME_TSOD_MEGALITH', 'Megalith'),
    ('LOC_CITY_NAME_TSOD_LUAN', 'Lu''an'),
    ('LOC_CITY_NAME_TSOD_RED_MAPLE', 'Red Maple'),
    ('LOC_CITY_NAME_TSOD_POMPEII', 'Pompeii'),
    ('LOC_CITY_NAME_TSOD_ELRON', 'Elron'),
    ('LOC_CITY_NAME_TSOD_FERTILE_WOODLANDS', 'Fertile Woodlands'),
    ('LOC_CITY_NAME_TSOD_SLANTWOOD_VALLEY', 'Slantwood Valley'),
    ('LOC_CITY_NAME_TSOD_LONGSTONE_TOWN', 'Longstone Town'),
    ('LOC_CITY_NAME_TSOD_TENWOODS', 'Tenwoods'),
    ('LOC_CITY_NAME_TSOD_TAMDULUR', 'Tamdulur'),
    ('LOC_CITY_NAME_TSOD_LUNTATELLE_SHIRE', 'Luntatelle Shire'),
    ('LOC_CITY_NAME_TSOD_HALL_SHIRE', 'Hall Shire'),
    ('LOC_CITY_NAME_TSOD_CAROL', 'Carol'),
    ('LOC_CITY_NAME_TSOD_KANT', 'Kant'),
    ('LOC_CITY_NAME_TSOD_GRAN', 'Gran'),
    ('LOC_CITY_NAME_TSOD_LESLIE', 'Leslie'),
    ('LOC_CITY_NAME_TSOD_HOSMAN', 'Hosman'),
    -- Citizen names
    ('LOC_CITIZEN_NAME_TSOD_SAM', 'Sam'),
    ('LOC_CITIZEN_NAME_TSOD_TOM', 'Tom'),
    ('LOC_CITIZEN_NAME_TSOD_PEA', 'Pea'),
    ('LOC_CITIZEN_NAME_TSOD_GORDON', 'Gordon'),
    ('LOC_CITIZEN_NAME_TSOD_HALL', 'Hall'),
    ('LOC_CITIZEN_NAME_TSOD_ELVIN_FRANKLIN', 'Elvin Franklin'),
    ('LOC_CITIZEN_NAME_TSOD_FENDIL_WILDER', 'Fendil Wilder'),
    ('LOC_CITIZEN_NAME_TSOD_VICTORIA_WILDER', 'Victoria Wilder'),
    ('LOC_CITIZEN_NAME_TSOD_CROMWELL_WHITEMOUNTAIN', 'Cromwell Whitemountain'),
    ('LOC_CITIZEN_NAME_TSOD_BODWIN_FRANKLIN', 'Bodwin Franklin'),
    ('LOC_CITIZEN_NAME_TSOD_VERONICA_MOEN', 'Veronica Moen'),
    ('LOC_CITIZEN_NAME_TSOD_SEWEN_TERRY', 'Sewen Terry'),
    ('LOC_CITIZEN_NAME_TSOD_HAMEL', 'Hamel'),
    ('LOC_CITIZEN_NAME_TSOD_HOLM', 'Holm'),
    ('LOC_CITIZEN_NAME_TSOD_MARGARITA', 'Margarita'),
    ('LOC_CITIZEN_NAME_TSOD_BETTY', 'Betty'),
    ('LOC_CITIZEN_NAME_TSOD_WITCH_GIPLY', '''Witch'' Giply'),
    ('LOC_CITIZEN_NAME_TSOD_SCARFACE_ANTON', '''Scarface'' Anton'),
    ('LOC_CITIZEN_NAME_TSOD_BELK_LOREN', 'Belk Loren'),
    ('LOC_CITIZEN_NAME_TSOD_GELIN', 'Gelin'),
    ('LOC_CITIZEN_NAME_TSOD_CODY_BALDWIN', 'Cody Baldwin'),
    ('LOC_CITIZEN_NAME_TSOD_PATTY_GRAN', 'Patty Gran'),
    ('LOC_CITIZEN_NAME_TSOD_ROPENI_GRAN', 'Ropeni Gran'),
    -- Agendas
    ('LOC_AGENDA_TSOD_TRUTH_SEEKER_NAME', 'Truth Seeker'),
    (
        'LOC_AGENDA_TSOD_TRUTH_SEEKER_DESCRIPTION',
        'Tries to build up [ICON_Science] Science, and likes civilizations that also focus on [ICON_Science] Science. Dislikes those with low [ICON_SCIENCE] Science.'
    ),
    -- Traits
    ('LOC_TSOD_QUARRY_BONUS_TECH_DESCRIPTION', '+1[ICON_Science] to improved quarries.'),
    ('LOC_TSOD_NITER_MINE_BONUS_FAITH_DESCRIPTION', '+3 [ICON_Faith] faith to correctly improved Niter.');