# 待生成图标：提示词与规格（塞西尔帝国）

还在借用官方图标、或者没有图的内容，共三类。**先看下表的「游戏里现在显示什么」**：① ② 是照官方的做法借图，游戏里没有空白，换成自己的图是加分项。③ 伟人肖像已经能在百科里按个人显示：6 位用现成角色图裁好了，另外 6 位等你出图，没图之前还是显示伟人单位图标。

| 类 | 数量 | 游戏里在哪显示 | 现在显示什么 | 要你出的图 |
|---|---|---|---|---|
| ① 琥珀的晋升 | 7 | 晋升树，只用 32×32 | 照抄官方斥候晋升树的 7 个图标（官方晋升也是多个共用一个图标） | 7 张图案，盾形底座我来做 |
| ② 巨作 | 2 | 巨作界面 64×64、提示框 | 官方所有文学巨作共用的那本摊开的书（`ICON_ATLAS_GREATWORKS` 第 0 格） | 2 张 |
| ③ 伟人肖像 | 12 | 百科伟人页 256×256；装了 Real Great People 时它的伟人页和列表也显示 | 瑞贝卡、赫蒂、拜伦、菲利普、皮特曼、莱特已有；其余 6 位是伟人单位图标 | 6 张 |

风格参考图（官方同类图标，从 SDK 素材包里取出，放在 `imgs/icon-refs/`，生图时可以作为参考图上传，Midjourney 用 `--sref`）：

| 参考图 | 对应 |
|---|---|
| `promotion_ranger_alpine_15.png`、`promotion_spyglass_17.png`、`promotion_26.png` | ① 晋升（铜 / 金 / 白金三种级别的样子） |
| `greatwork_writing_index0.png` | ② 巨作（官方文学巨作那本书） |
| `greatperson_ref_*.png`（6 张） | ③ 伟人（已裁好的 6 张，剩下 6 位的新图照它们的画风和构图） |

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

## ③ 6 位伟人肖像 → `imgs/icons/greatperson_<英文名>.png`

显示在百科伟人页右上角的 256×256 方框里（`src/UI/CivilopediaPage_TsoDCE_GreatPersonPortraits.lua`）。图名和 Real Great People 一样都是 `ICON_<伟人类型>`，所以装了那个 mod 时，它的伟人页和列表也会显示（160、40）。瑞贝卡、赫蒂、拜伦、菲利普、皮特曼·劳伦、莱特已经用 `imgs/` 里的角色图裁好（后三位的图是 10-25 你给的），剩下 6 张新图照这几张的画风和构图来；它们放在 `imgs/icon-refs/greatperson_ref_*.png`，生图时作为参考图上传。

每张都要满足（本节替代上面「通用规格」里的背景要求）：

- 正方形 1:1，至少 1024×1024。**胸像**：头部居中，头顶离上边约 8%，画到上胸口。
- 画风：参考图那种半写实厚涂插画（《黎明之剑》官方角色图的画风），脸朝向观众或四分之三侧脸。
- 背景：**画出来的昏暗环境**，不是纯色，也不要杂乱，人物要从背景里清楚地跳出来（参考图都是深色背景加一点暖色或冷色的光）。
- 不要文字、边框、圆框、水印。
- 外貌照原著（每项后面注了出处），原著没写的地方不要乱加特征。

验收：缩到 40 像素还能认出是谁（看发色、轮廓和手里的东西）。

### 尼古拉斯·蛋（大工程师）→ `greatperson_nicholas_egg.png`

原著第 1 卷第 92 章：从石头蛋里孵出来的金属球，直径约一米三，表面纯净银白、极端光滑如镜面，像工业精确打磨过，悬浮在离地不到半米的空中；能隔空把金属塑成零件，干活时身边四面八方飘着零件。**它没有脸，就是一个球。**

哈吉米（Gemini）：
```
半写实厚涂插画，方形构图：一颗悬浮在半空的金属球，纯净的银白色，表面极其光滑像镜子，镜面上映出工坊里暖黄色的灯光和窗户。球占画面约七成，居中。球周围飘着几个小金属零件（齿轮、螺栓、弹簧），像被无形的力量托着。球上没有脸、没有眼睛、没有任何花纹。背景是昏暗的机械工坊，虚化的铁砧和金属锭。不要文字、边框、圆框、水印。正方形 1024×1024。
```

Midjourney：
```
semi-realistic painterly illustration, square composition, a floating perfectly smooth mirror-polished silver-white metal sphere filling most of the frame, reflecting warm workshop lamps, a few small metal parts (gears, bolts, springs) hovering around it as if held by an invisible force, no face, no eyes, no markings on the sphere, dim mechanical workshop background with blurred anvils and metal ingots --ar 1:1 --no text, frame, border, circle, watermark, face
```

### 菲尔姆（大作家）→ `greatperson_felm.png`

原著第 3 卷：从北方巴伦来的年轻人，金发，穿一件呢料蓝色外套，旧了但干净整洁、保养得当；笑容温和有礼，带着习惯性的谦逊；魔影剧《移民》的编剧。

哈吉米（Gemini）：
```
半写实厚涂插画，方形胸像：一位年轻男子，金色头发，笑容温和有礼、略带谦逊。穿一件旧但干净整洁的蓝色呢料外套，里面是白衬衫。他手里拿着一叠写满字的剧本手稿，手稿边缘从画面下方露出。头部居中，头顶离上边约 8%，画到上胸口。背景是昏暗的船舱，一盏暖黄色的魔晶石灯。不要文字、边框、圆框、水印。正方形 1024×1024。
```

Midjourney：
```
semi-realistic painterly fantasy portrait, square bust, a young man with blond hair and a gentle, polite, slightly modest smile, an old but clean well-kept blue wool coat over a white shirt, holding a stack of handwritten script pages at the bottom edge, head centered with small headroom, dim ship cabin background lit by a warm crystal lamp --ar 1:1 --no text, frame, border, circle, watermark
```

### 詹妮·佩罗（大科学家）→ `greatperson_jennie_perro.png`

原著第 1 卷：不到二十岁，高挑瘦弱、有点病恹恹；银白色长发，因疏于打理而干枯杂乱，从两侧垂在脸颊上；左侧三分之一的脸有一片像烫伤的疤痕，顺着脖子往下蔓延；性格拘谨；四级符文师，珍藏着一本前人留下的、写满公式的厚笔记。

哈吉米（Gemini）：
```
半写实厚涂插画，方形胸像：一位不到二十岁的少女，瘦弱，脸色有点苍白，银白色长发略显干枯凌乱、从两侧垂在脸颊上。她左边脸颊到脖子有一片淡红色的旧烧伤疤痕（画清楚，但不要血腥恐怖）。神情拘谨、略带羞怯，双手把一本厚重的旧皮面笔记本抱在胸前。穿朴素的深色法师袍。头部居中，头顶离上边约 8%，画到上胸口。背景是昏暗的木屋书桌，桌上有几道发着淡蓝微光的符文。不要文字、边框、圆框、水印。正方形 1024×1024。
```

Midjourney：
```
semi-realistic painterly fantasy portrait, square bust, a frail pale girl under twenty with long silver-white hair, slightly dry and unkempt, hanging down both sides of her face, an old pinkish burn scar covering the left third of her face and running down her neck (clearly shown, not gory), shy reserved expression, hugging a thick old leather notebook to her chest, plain dark mage robe, head centered with small headroom, dim wooden cabin desk with faint glowing blue runes --ar 1:1 --no text, frame, border, circle, watermark, gore
```

### 桑提斯·赛德（大科学家）→ `greatperson_santis_saide.png`

原著第 1 卷第 191 章：年轻的二级奥术师，一头乱糟糟的头发，眼窝发红凹陷（熬了夜），又瘦又高，穿一身洗得发白的旧法袍，紧张时手总下意识地拨弄衣服上的纽扣。原著没写发色。

哈吉米（Gemini）：
```
半写实厚涂插画，方形胸像：一位又瘦又高的年轻法师，一头乱糟糟的深色头发，眼窝发红凹陷、带着熬夜的黑眼圈，神情紧张又认真。穿一件洗得发白的旧蓝灰色法袍，一只手正下意识地捏着法袍上的一颗纽扣。头部居中，头顶离上边约 8%，画到上胸口。背景是昏暗的书房，虚化的书架和一支蜡烛。不要文字、边框、圆框、水印。正方形 1024×1024。
```

Midjourney：
```
semi-realistic painterly fantasy portrait, square bust, a tall thin young mage with messy dark hair, reddened sunken eyes with dark circles from sleepless nights, nervous but earnest expression, a faded much-washed blue-grey robe, one hand fiddling with a button on his robe, head centered with small headroom, dim study background with blurred bookshelves and a candle --ar 1:1 --no text, frame, border, circle, watermark
```

### 卡迈尔·斯雷恩（大科学家）→ `greatperson_kamel_slayen.png`

原著第 1 卷第 239 章：古刚铎帝国的魔导师，转化成了「由奥术能量汇聚而成的人型生物」，体表逸散噼啪的电光，说话带着颤音和劈啪声，眼睛是「两点明亮的电光」；胸前挂着护甲片，上面写着他的名字。

哈吉米（Gemini）：
```
半写实厚涂插画，方形胸像：一个由奥术能量构成的人形生物，身体是半透明的、流动的蓝紫色魔力，体表不断迸出细小的白色电弧。脸上没有五官，只有两点明亮的白色电光作为眼睛。胸前挂着几片古旧的金属护甲，其中一片刻着一行古代文字。头部居中，头顶离上边约 8%，画到上胸口。背景是昏暗的古代魔导设施，墙上有微弱的蓝光纹路。除了护甲上的古文，不要别的文字、边框、圆框、水印。正方形 1024×1024。
```

Midjourney：
```
semi-realistic painterly fantasy portrait, square bust, a humanoid being made entirely of translucent flowing blue-violet arcane energy, small white electric arcs crackling off its body, no facial features except two bright white points of electric light for eyes, a few ancient metal armor plates hanging on its chest, one engraved with a line of old script, head centered with small headroom, dim ancient magitech facility background with faint blue glowing lines --ar 1:1 --no text, frame, border, circle, watermark
```

### 诺里斯（大科学家）→ `greatperson_norris.png`

原著第 1 卷：典型的中世纪农夫，肤色黝黑，消瘦，手脚粗大，看上去四五十岁或更老（重活和营养不良让人早衰）；表情谦卑，会露出一个谦卑的笑容，但眼睛里有和别的平民不一样的神采；种地的手艺很好。

哈吉米（Gemini）：
```
半写实厚涂插画，方形胸像：一位四五十岁的农夫，晒得黝黑，消瘦，脸上有风霜的皱纹，露出谦卑又真诚的微笑，眼睛明亮有神。穿粗布衣，一只粗大的手握着一把金黄的麦穗举在胸前。头部居中，头顶离上边约 8%，画到上胸口。背景是傍晚的麦田，虚化，暖色夕阳光。不要文字、边框、圆框、水印。正方形 1024×1024。
```

Midjourney：
```
semi-realistic painterly fantasy portrait, square bust, a lean weathered farmer in his forties or fifties with deeply tanned skin and wrinkles, a humble sincere smile and unusually bright eyes, coarse homespun clothes, one big rough hand holding a bundle of golden wheat at his chest, head centered with small headroom, blurred wheat field at dusk with warm sunset light --ar 1:1 --no text, frame, border, circle, watermark
```

---

## 我这边拿到图后做的事

图按上面的文件名放进 `imgs/icons/`（png / jpg / webp 都行，可以只交一部分），然后跑 `python -X utf8 tools/make_art.py`，它会：

0. 伟人肖像：裁成正方形，出 40 / 160 / 256，写进 `Icons/TsoDCE_GreatPeopleIcons.xml`，百科自动换成肖像。

1. 按背景色抠图，裁掉多余留白，按官方留白比例放回正方形。
2. 晋升：黑剪影转浅色，画五边形盾牌（颜色取自官方 `Promotions32.dds`，按级别铜 / 银 / 金 / 白金），出 32×32；`Icons/TsoDCE_UnitPromotionIcons.xml` 里有图的那几个改指自己的图集，没图的继续借官方格子。
3. 巨作：缩放到 45 / 64 / 256，`Icons/TsoDCE_GreatworkIcons.xml` 同样只改有图的。
4. 新贴图登记进 `TsoDCE_UITextures` 包。之后构建、部署，并在 `docs/test-log.md` 记一轮。

用合成的测试图跑过这条路（4 个晋升 + 1 部巨作）：盾牌与官方同尺寸并排看是同一套样式，品红底抠图无粉边，XML 与 XLP 登记正确。真图来了再看一次效果。
