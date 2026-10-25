# 实机测试记录（塞西尔帝国）

每轮进游戏测试后补一条：哪个构建、测了什么、结果、证据（日志原文行）、据此做的改动。用户只管测和反馈，记录由我们维护。

日志位置：`%LOCALAPPDATA%\Firaxis Games\Sid Meier's Civilization VI\Logs\`（每次启动游戏覆盖，测完要及时读）。

## 用户已定的规则

| 日期 | 决定 |
|---|---|
| 10-23 | 用户美术放 `imgs/`（本仓库叫 imgs，不是 images），不进仓库。 |
| 10-23 | 立绘近身裁切，人物占满画面；领袖头像以头部居中、不加圆环。 |
| 10-23 | 最终美术不由我们生成：写提示词与规格（`docs/icon-prompts.md`），用户出图，我们缩放、登记。 |
| 10-21 | 本地提交，不推送。 |

---

## 美术补缺 · 10-24（未进游戏）

- 构建：本条所在提交，`--clean` 重建通过；部署的 artdef 里 0 个 `TB_ERROR`、0 个被清空的元素引用；`validate_mod` 0 错误；`loc_audit` 报的 3 个是 SQL 拼接前缀（`'LOC_..._TSOD_CE_' || ...`），拼出的 tag 都有定义。
- 改动：
  - 高文立绘：外交备用立绘（825×1024）和载入画面前景（731×1461）原来是 39×39 空图，现由 `tools/make_art.py` 从 `imgs/Processed Images/LEADER_TSOD_GAWAIN_CECIL_NEUTRAL.png` 生成；选领袖界面立绘同源，裁掉顶部空白（头顶从 18% 处提到约 10%）。
  - XLP 包改名加 `TsoDCE_` 前缀：`TsoDCE_UITextures`（原 CecilEmpireUITextureDDS）、`TsoDCE_UILeaders`、`TsoDCE_UIPrideMoments`、`TsoDCE_LeaderFallbacks`、`TsoDCE_UILensAsset`；Art.xml、FallbackLeaders/Overlay artdef、civ6proj 同步。
  - 琥珀、戈尔贡平台新增 FOW 图标（22–256）。注意：原版界面脚本只给资源图标加 `_FOW`，没有地方取单位的 `_FOW`，所以游戏里多半看不到它们，属于补齐。
  - `tools/restore_cooked_entries.py` 换成提丰的新版。

### 要你进游戏看的

1. 选领袖界面：高文立绘显示正常，头部位置合适。
2. 载入画面：左侧出现高文立绘（以前是空的）。
3. 外交画面：用别的文明开局、把高文设为 AI，见面时显示高文立绘（以前是空的）。
4. 改名后没丢东西：文明 / 领袖图标、琥珀与戈尔贡平台图标和肖像、魔力方尖碑图标、药剂资源图标、三张历史时刻插图、忠诚度压力与警告图层、外交背景都还在。
5. 有问题时把 `Logs/Modding.log` 和 `Logs/ArtDef.log` 发来（搜 `TsoDCE_`）。

## 清理旧文件、补魔力方尖碑 FOW · 10-24（未进游戏，与上一条一起测即可）

- 构建：本条所在提交，`--clean` 重建。
- 删掉的旧文件（都查过没有任何引用）：
  - `src/Assets/Loyalty_Overlay_TSOD_Cecil_Empire_Box.ast`、`Loyalty_Pressure_TSOD_Cecil_Empire_Box.ast`：2024-08 改名留下的副本，和现用的 `Loyalty_*_Tsod_CE_Box.ast` 定义同名资产，材质名还是旧拼写；两份同名资产 cooker 取哪份没保证，删掉只留现用的。
  - `src/Textures/ICON_LEADER_CECIL_EMPIRE_GAWAIN_*`（8 个尺寸）：2023 年旧命名的领袖图标，早已换成 `ICON_LEADER_TSOD_GAWAIN_CECIL_*`，没在任何 XLP 或图标表里。
  - `src/` 下 10 个空的素材文件夹（Animations、Geometries 等，提丰没有它们也照常构建）。
  - 仓库根目录 `Cooked/`（2024-05 的旧烘焙产物，含旧包名的 BLP；现在的构建不写这里）：已移到回收站，没进过 git。
- 新增：魔力方尖碑 FOW 图标（32–256，棕褐色，同提丰燃石酸化工厂的做法；官方每个建筑都有 `_FOW`）。
- `tools/make_art.py` 现在能处理用户交来的晋升、巨作图（`docs/icon-prompts.md`），没图时什么都不改。

### 要你进游戏看的（追加）

6. 忠诚度：塞西尔城市的忠诚度压力箭头和「将脱离」警告图层还在（删了重复的资产定义）。
7. 魔力方尖碑在迷雾里显示正常（若能看到）。

## 伟人肖像 · 10-25（未进游戏）

- 用户决定：做伟人肖像，改百科让它按个人显示；3 位用现成图裁，另外 9 位写提示词给用户出图。
- 构建：本条所在提交，`--clean` 重建。
- 做法：
  - 新文件 `src/UI/CivilopediaPage_TsoDCE_GreatPersonPortraits.lua`，经游戏内 `ImportFiles` 加载（百科会加载所有 `CivilopediaPage_*.lua`）。它包一层 `AddPortrait`：在伟人页上，如果有名为 `ICON_<伟人类型>` 的图标就显示它，没有就照旧显示伟人单位图标。没替换官方伟人页，所以和改伟人页的 mod（如 Real Great People，它用的也是同一个图标名）不冲突。
  - 瑞贝卡·塞西尔、赫蒂·塞西尔、拜伦·柯克：从 `imgs/` 的角色图裁正方形胸像（头部居中），出 40 / 160 / 256，登记在新的 `Icons/TsoDCE_GreatPeopleIcons.xml`（游戏内 `UpdateIcons`）。
  - 其余 9 位的提示词按原著外貌写在 `docs/icon-prompts.md` ③，图放进 `imgs/icons/` 后跑 `tools/make_art.py` 即可。
- 塞西尔的伟人类别在百科伟人分区里各自成组（官方查询列出所有 `GreatPersonClasses`），所以页面本来就在。

### 要你进游戏看的（追加）

8. 百科 → 伟人 → 塞西尔的类别（如塞西尔的大科学家）→ 瑞贝卡·塞西尔：右上角是她的肖像；赫蒂（总督类）、拜伦（大海军将领类）同样。
9. 其他塞西尔伟人和官方伟人的页面照旧显示伟人单位图标，没有空白。
10. 有问题时发 `Logs/Lua.log`（搜 `CivilopediaPage_TsoDCE`）。
