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
