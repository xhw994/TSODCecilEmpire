# 待生成图标：提示词与规格（塞西尔帝国）

还在借用官方图标、或者没有图的内容，共三类。**先看下表的「游戏里现在显示什么」**：三类都是照官方的做法借图，游戏里没有空白；换成自己的图是加分项。第 ③ 类目前游戏里根本没有地方显示，要先定要不要做。

| 类 | 数量 | 游戏里在哪显示 | 现在显示什么 | 要你出的图 |
|---|---|---|---|---|
| ① 琥珀的晋升 | 7 | 晋升树，只用 32×32 | 照抄官方斥候晋升树的 7 个图标（官方晋升也是多个共用一个图标） | 7 张图案，盾形底座我来做 |
| ② 巨作 | 2 | 巨作界面 64×64、提示框 | 官方所有文学巨作共用的那本摊开的书（`ICON_ATLAS_GREATWORKS` 第 0 格） | 2 张 |
| ③ 伟人肖像 | 12 | **目前没有界面会显示** | — | 先定要不要做，见 ③ |

风格参考图（官方同类图标，从 SDK 素材包里取出，放在 `imgs/icon-refs/`，生图时可以作为参考图上传，Midjourney 用 `--sref`）：

| 参考图 | 对应 |
|---|---|
| `promotion_ranger_alpine_15.png`、`promotion_spyglass_17.png`、`promotion_26.png` | ① 晋升（铜 / 金 / 白金三种级别的样子） |
| `greatwork_writing_index0.png` | ② 巨作（官方文学巨作那本书） |
| `greatperson_generic_admiral.png` | ③ 伟人（官方只有按类别的铜章，没有个人肖像） |

## 通用规格（每张都要满足）

- 正方形 1:1，**至少 1024×1024**，PNG。
- 主体居中，四周留白约 6%（不碰边，也不要太小）。
- 背景按每项写的颜色，**纯色、无渐变、无纹理、无地面阴影**，方便抠图。
- 不要文字、水印、签名、边框、画框。
- 光源从左上方来（与游戏内图标一致）。
- 存放：放到 `imgs/icons/`，文件名按每项给的名字。

---

## ① 琥珀的 7 个晋升 → `imgs/icons/promotion_<英文名>.png`

游戏只在晋升树里用 **32×32** 显示（`UnitPromotionPopup.lua` 调 `FindIconAtlas(..., 32)`）。官方晋升图标是一个下端尖的五边形盾牌，盾面颜色表示级别：1 级铜、2 级银、3 级金、4 级白金，中间一个浅色图案。**盾牌和级别颜色我来画**，你只生成中间的图案。

现在的问题：图标是按官方斥候晋升树的位置照抄的，和效果对不上，比如「南境盗圣」（打受伤单位 +15）显示的是一座山。新图案按每个晋升的效果来。

画法：**纯黑色的平面剪影符号，放在纯白背景上**。32 像素比单位图标还小，所以要更粗：只有一两个大块面，像路牌上的符号，不要细线、不要小零件、不要多个物体堆在一起。

| 文件名 | 晋升 | 级别 | 效果 | 现在借的 | 新图案（中文 / 英文提示词里的内容） |
|---|---|---|---|---|---|
| `promotion_shadow_realm.png` | 暗影视界 | 1 铜 | +1 视野，视线穿过地形 | 第 15 格（山） | 一只睁开的眼睛，瞳孔是一弯新月 / an open eye whose pupil is a crescent moon |
| `promotion_master_thief.png` | 南境盗圣 | 1 铜 | 打受伤单位 +15 战斗力 | 第 15 格（山） | 一把刀尖朝下的短匕首 / a short dagger pointing down |
| `promotion_shadow_creature.png` | 暗影生物 | 2 银 | +1 移动力，无视地形减速 | 第 18 格（望远镜） | 一只向右迈步的靴子，后面拖着两三道烟影 / a boot striding right with two or three smoke streaks trailing behind |
| `promotion_tavern_queen.png` | 酒馆女王 | 2 银 | 每回合自动回血，领土外也回 | 第 22 格（十字箭头） | 一只冒着泡沫的大酒杯 / a large tankard with foam spilling over |
| `promotion_shadow_chosen.png` | 暗夜神选 | 3 金 | +1 移动力，只有相邻敌人能发现 | 第 17 格（望远镜） | 一弯新月，月牙内侧有一颗四芒星 / a crescent moon with a four-pointed star inside its curve |
| `promotion_night_mistress.png` | 夜幕之城的女主人 | 3 金 | +1 视野，看见隐形单位 | 第 5 格（准星） | 城墙垛口上方一只睁开的眼睛 / an open eye above a row of castle battlements |
| `promotion_shadow_authority.png` | 暗影权能 | 4 白金 | 攻击后可移动，外交 +1 | 第 26 格（兜帽人） | 一顶小王冠下面一把竖直的匕首 / a small crown above an upright dagger |

图案只是建议，按原著改动随意，但每个都要满足「32 像素能认出」。

哈吉米（Gemini）模板（把【内容】换成上表的中文）：
```
画一个游戏界面用的小图标符号：纯黑色平面剪影，纯白背景（#FFFFFF）。内容是【内容】。只用一两个大块面，粗线条，没有细节和细线，像路牌上的符号，缩小到 32 像素也能认出。不要盾牌外框、圆环、阴影、渐变、文字、边框。正方形 1024×1024。
```

Midjourney 模板（把 [content] 换成上表的英文）：
```
flat black silhouette pictogram, [content], one or two bold chunky shapes, no fine detail, no thin lines, readable at tiny size like a road sign symbol, pure white background --ar 1:1 --style raw --no text, watermark, border, shield, frame, circle, shadow
```

验收：缩到 32 像素看一眼，还能认出是什么。

## ② 两部巨作

原著里这两部都是**魔影剧**，书里都描写过它们的海报。官方文学巨作全部共用一本摊开的书；这里改画成**海报**：一张边角微卷的纸质海报（不要金色画框，免得和美术巨作的油画混淆），斜放、俯视约 30°，像官方巨作图标那样是一个立体的小物件。海报上的画面照原著，**海报上不要任何文字**。

- 背景：**纯品红色 #FF00FF**（画面里不要出现品红）。
- 画风：参考图那本书的厚涂写实质感，清晰轮廓。

### 《移民》 → `imgs/icons/greatwork_immigrants.png`

原著第 3 卷：「一艘满载着乘客的机械船行驶在宽阔的戈尔贡河上，几个有鲜明特征的主要角色浮现在画面的背景中」。

哈吉米（Gemini）：
```
按《文明6》巨作图标的画风（参考图里的书）画一个小物件：一张边角微微卷起的纸质电影海报，斜放，俯视约 30 度。海报画面是一艘满载乘客的蒸汽机械船行驶在宽阔的大河上，背景天空里隐约浮现几个人物的半身像。海报上不要任何文字。不要金色画框。背景纯品红色（#FF00FF），物件上不要出现品红。不要地面阴影、边框。正方形 1024×1024。
```

Midjourney：
```
Civilization VI great work icon style, a single paper movie poster with slightly curled corners, tilted three-quarter top view, the poster shows a crowded steam-powered passenger ship on a wide river with faint portraits of several characters in the sky behind, painterly game art with clean outlines, no lettering on the poster, no gold frame, isolated on solid flat magenta #FF00FF background --ar 1:1 --style raw --no text, watermark, ground shadow, border
```

### 《烽火》 → `imgs/icons/greatwork_beacon_fire.png`

原著第 4 卷：「一个年轻人站在那画面上，穿着旧时代的铠甲，双手拄着长剑，他背后是黑暗沉沦的平原，但一道阳光照射下来，映亮了年轻人的面庞」。

哈吉米（Gemini）：
```
按《文明6》巨作图标的画风（参考图里的书）画一个小物件：一张边角微微卷起的纸质电影海报，斜放，俯视约 30 度。海报画面是一个穿旧式铠甲的年轻骑士，双手拄着长剑站立，身后是昏暗的平原，一道阳光从上方照亮他的脸和铠甲，铠甲上有伤痕。海报上不要任何文字。不要金色画框。背景纯品红色（#FF00FF），物件上不要出现品红。不要地面阴影、边框。正方形 1024×1024。
```

Midjourney：
```
Civilization VI great work icon style, a single paper movie poster with slightly curled corners, tilted three-quarter top view, the poster shows a young knight in battered old armor standing with both hands resting on a longsword, a dark desolate plain behind him, a single shaft of sunlight lighting his face, painterly game art with clean outlines, no lettering on the poster, no gold frame, isolated on solid flat magenta #FF00FF background --ar 1:1 --style raw --no text, watermark, ground shadow, border
```

验收：缩到 64 像素能看出是一张海报、上面有一条船（或一个骑士）。

## ③ 12 位伟人肖像：先定要不要做

**目前游戏里没有任何界面会显示伟人的个人肖像**，做了也看不到：

- 伟人界面（`GreatPeoplePopup.lua`）只用按类别的铜章 `ICON_GENERIC_<类别>`，而且只列时间线上的伟人。塞西尔的伟人由 `Core/TsoDCE_CivilizationTraits.lua` 在区域首次建成时直接授予，所在类别 `AvailableInTimeline = 0`，不会进这个界面。
- 百科伟人页（`CivilopediaPage_GreatPerson.lua`）用的是伟人单位的图标 `ICON_<UnitType>`（官方的大科学家等）。
- 单位面板按单位类型和性别取肖像，也不分个人。

要让肖像显示出来，得改界面（比如替换百科伟人页的脚本，按个人取图），这是单独一件事，要你点头再做。如果要做：

- 尺寸：216 和 105（官方伟人图集的两个尺寸），正方形，胸像。
- 其中 3 位 `imgs/` 里已有角色图，我直接裁：瑞贝卡·塞西尔（`瑞贝卡·塞西尔.jpeg`）、赫蒂·塞西尔（`赫蒂·塞西尔.jpeg`）、拜伦·柯克（`拜伦·柯克.jpeg`）。
- 另外 9 位要出图：菲利普（大将军）、尼古拉斯·蛋（大工程师）、皮特曼·劳伦（大商人）、菲尔姆（大作家）、詹妮·佩罗、桑提斯·赛德、卡迈尔·斯雷恩、诺里斯（以上大科学家）、莱特·艾维肯（大预言家）。决定要做时我再按原著写每个人的外貌提示词。

---

## 我这边拿到图后做的事

图按上面的文件名放进 `imgs/icons/`（png / jpg / webp 都行，可以只交一部分），然后跑 `python -X utf8 tools/make_art.py`，它会：

1. 按背景色抠图，裁掉多余留白，按官方留白比例放回正方形。
2. 晋升：黑剪影转浅色，画五边形盾牌（颜色取自官方 `Promotions32.dds`，按级别铜 / 银 / 金 / 白金），出 32×32；`Icons/TsoDCE_UnitPromotionIcons.xml` 里有图的那几个改指自己的图集，没图的继续借官方格子。
3. 巨作：缩放到 45 / 64 / 256，`Icons/TsoDCE_GreatworkIcons.xml` 同样只改有图的。
4. 新贴图登记进 `TsoDCE_UITextures` 包。之后构建、部署，并在 `docs/test-log.md` 记一轮。

用合成的测试图跑过这条路（4 个晋升 + 1 部巨作）：盾牌与官方同尺寸并排看是同一套样式，品红底抠图无粉边，XML 与 XLP 登记正确。真图来了再看一次效果。
