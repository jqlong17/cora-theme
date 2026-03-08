# Aesthetic Terminal Setup Skill

一套完整的终端美化配置方案，包含 Ghostty 终端和 OpenCode AI 助手的统一主题风格，实现磨砂玻璃质感 + Catppuccin Mocha 紫粉色调。

## 🎯 目标效果

- **Ghostty 终端**：磨砂玻璃背景 + Catppuccin Mocha 主题 + Maple Mono 编程字体
- **OpenCode**：透明背景继承终端磨砂效果 + 同款配色方案
- **整体风格**：深色紫粉色调，现代化毛玻璃质感，中英文混排美观

## 📦 依赖项

### 必需软件
1. **Ghostty** - 终端模拟器
   - macOS: `brew install --cask ghostty`
   - 或从 https://ghostty.org 下载

2. **OpenCode** - AI 编程助手
   - `brew install opencode`
   - 或从 https://opencode.ai 下载

### 字体下载

#### 1. Maple Mono (主字体)
- **用途**：英文代码显示，支持连字 (ligatures)
- **下载**：https://github.com/subframe7536/maple-font/releases
- **安装**：
  ```bash
  # macOS 自动安装
  brew tap subframe7536/maple-font
  brew install --cask maple-mono
  
  # 或手动安装
  # 1. 下载 MapleMono-*.zip
  # 2. 解压后双击 .ttf 文件安装
  ```

#### 2. PingFang SC (苹方)
- **用途**：中文显示
- **来源**：macOS 系统自带，无需额外安装
- **备选**：如系统没有，可使用 "Heiti SC" 或 "Noto Sans CJK SC"

## 🔧 配置步骤

### 步骤 1: 配置 Ghostty

创建/编辑配置文件：

**macOS 路径**：
`~/Library/Application Support/com.mitchellh.ghostty/config`

**配置内容**：
```ini
# Theme Configuration
# ===================
theme = Catppuccin Mocha

# Frosted Glass Effect (磨砂玻璃效果)
# ====================================
background-opacity = 0.85
background-blur-radius = 20
window-opacity = 0.95

# Font Configuration (字体配置)
# ===============================
font-family = Maple Mono
font-family = PingFang SC
font-size = 14
font-feature = -calt
font-feature = +liga
font-thicken = true
```

**生效**：重启 Ghostty 或按 `Command + Shift + ,`

### 步骤 2: 配置 OpenCode 主题

#### 2.1 创建主题文件

**路径**：`~/.config/opencode/themes/catppuccin-mocha.json`

**内容**：
```json
{
  "$schema": "https://opencode.ai/theme.json",
  "name": "Catppuccin Mocha",
  "description": "A soothing pastel theme with pink/purple accents, matching Ghostty terminal",
  "defs": {
    "base": "#1e1e2e",
    "mantle": "#181825",
    "crust": "#11111b",
    "text": "#cdd6f4",
    "subtext1": "#bac2de",
    "subtext0": "#a6adc8",
    "overlay2": "#9399b2",
    "overlay1": "#7f849c",
    "overlay0": "#6c7086",
    "surface2": "#585b70",
    "surface1": "#45475a",
    "surface0": "#313244",
    "pink": "#f5c2e7",
    "mauve": "#cba6f7",
    "red": "#f38ba8",
    "maroon": "#eba0ac",
    "peach": "#fab387",
    "yellow": "#f9e2af",
    "green": "#a6e3a1",
    "teal": "#94e2d5",
    "sky": "#89dceb",
    "sapphire": "#74c7ec",
    "blue": "#89b4fa",
    "lavender": "#b4befe"
  },
  "theme": {
    "primary": { "dark": "mauve", "light": "mauve" },
    "secondary": { "dark": "pink", "light": "pink" },
    "accent": { "dark": "lavender", "light": "lavender" },
    "error": { "dark": "red", "light": "red" },
    "warning": { "dark": "yellow", "light": "yellow" },
    "success": { "dark": "green", "light": "green" },
    "info": { "dark": "blue", "light": "blue" },
    "text": { "dark": "text", "light": "base" },
    "textMuted": { "dark": "overlay1", "light": "surface1" },
    "background": { "dark": "none", "light": "none" },
    "backgroundPanel": { "dark": "none", "light": "none" },
    "backgroundElement": { "dark": "none", "light": "none" },
    "border": { "dark": "surface1", "light": "overlay1" },
    "borderActive": { "dark": "overlay0", "light": "overlay2" },
    "borderSubtle": { "dark": "surface0", "light": "surface1" },
    "diffAdded": { "dark": "green", "light": "green" },
    "diffRemoved": { "dark": "red", "light": "red" },
    "diffContext": { "dark": "overlay0", "light": "overlay0" },
    "diffHunkHeader": { "dark": "surface1", "light": "surface1" },
    "diffHighlightAdded": { "dark": "green", "light": "green" },
    "diffHighlightRemoved": { "dark": "red", "light": "red" },
    "diffAddedBg": { "dark": "#1e2a1e", "light": "#e8f5e8" },
    "diffRemovedBg": { "dark": "#2a1e1e", "light": "#f5e8e8" },
    "diffContextBg": { "dark": "surface0", "light": "subtext1" },
    "diffLineNumber": { "dark": "overlay1", "light": "surface1" },
    "diffAddedLineNumberBg": { "dark": "#1e2a1e", "light": "#e8f5e8" },
    "diffRemovedLineNumberBg": { "dark": "#2a1e1e", "light": "#f5e8e8" },
    "markdownText": { "dark": "text", "light": "base" },
    "markdownHeading": { "dark": "mauve", "light": "mauve" },
    "markdownLink": { "dark": "blue", "light": "blue" },
    "markdownLinkText": { "dark": "lavender", "light": "lavender" },
    "markdownCode": { "dark": "pink", "light": "pink" },
    "markdownBlockQuote": { "dark": "overlay0", "light": "overlay0" },
    "markdownEmph": { "dark": "peach", "light": "peach" },
    "markdownStrong": { "dark": "yellow", "light": "yellow" },
    "markdownHorizontalRule": { "dark": "surface1", "light": "surface1" },
    "markdownListItem": { "dark": "mauve", "light": "mauve" },
    "markdownListEnumeration": { "dark": "pink", "light": "pink" },
    "markdownImage": { "dark": "blue", "light": "blue" },
    "markdownImageText": { "dark": "lavender", "light": "lavender" },
    "markdownCodeBlock": { "dark": "text", "light": "base" },
    "syntaxComment": { "dark": "overlay0", "light": "overlay0" },
    "syntaxKeyword": { "dark": "mauve", "light": "mauve" },
    "syntaxFunction": { "dark": "blue", "light": "blue" },
    "syntaxVariable": { "dark": "text", "light": "base" },
    "syntaxString": { "dark": "green", "light": "green" },
    "syntaxNumber": { "dark": "peach", "light": "peach" },
    "syntaxType": { "dark": "yellow", "light": "yellow" },
    "syntaxOperator": { "dark": "sky", "light": "sky" },
    "syntaxPunctuation": { "dark": "overlay1", "light": "overlay1" }
  }
}
```

#### 2.2 创建 TUI 配置

**路径**：`~/.config/opencode/tui.json`

**内容**：
```json
{
  "$schema": "https://opencode.ai/tui.json",
  "theme": "catppuccin-mocha"
}
```

**生效**：完全退出 OpenCode (`/exit`) 后重新打开

## ✅ 验证配置

### Ghostty 验证
1. 打开 Ghostty，背景应呈现磨砂玻璃效果（能看到桌面壁纸模糊背景）
2. 输入 `ghostty +list-themes | grep -i catppuccin`，确认 Catppuccin Mocha 可用
3. 输入 `fc-list | grep -i maple`，确认 Maple Mono 字体已安装

### OpenCode 验证
1. 在 OpenCode 中输入 `/theme`，确认显示 "catppuccin-mocha"
2. 界面应呈现透明背景，继承 Ghostty 的磨砂玻璃效果
3. 文字颜色应为紫粉色调（粉色、薰衣草紫等）

## 🎨 颜色参考

Catppuccin Mocha 调色板：
- 背景：`#1e1e2e` (深紫灰)
- 文字：`#cdd6f4` (柔和白)
- 粉色：`#f5c2e7`
- 薰衣草紫：`#b4befe`
- 桃色：`#fab387`
- 绿色：`#a6e3a1`
- 蓝色：`#89b4fa`

## 🔧 故障排除

### 问题：OpenCode 背景不透明
**解决**：
1. 确认 `~/.config/opencode/tui.json` 存在且配置正确
2. 确认主题文件在 `~/.config/opencode/themes/` 目录下
3. 完全退出 OpenCode (`/exit`) 后重启

### 问题：字体不生效
**解决**：
1. 确认 Maple Mono 已安装：`fc-list | grep -i maple`
2. 在 Ghostty 配置中调整字体大小：`font-size = 15`
3. 重启 Ghostty

### 问题：磨砂玻璃效果不明显
**解决**：
1. 增加模糊半径：`background-blur-radius = 30`
2. 增加透明度：`background-opacity = 0.75`
3. 确保 macOS 系统设置中允许透明效果

## 📚 参考链接

- Ghostty: https://ghostty.org
- OpenCode: https://opencode.ai
- Maple Mono: https://github.com/subframe7536/maple-font
- Catppuccin: https://github.com/catppuccin/catppuccin
- iTerm2 主题库: https://iterm2colorschemes.com

---

**作者**: opencode + user
**创建日期**: 2026-03-08
**版本**: 1.0
