# MGPIC 2026

MoonBit MGPIC 2026 官方网站仓库。

现在这套站点已经整理成了：

- `main/`：MoonBit + Rabbita 页面源码
- `index.html` / `preview.html`：很薄的静态入口壳
- `styles.css`：站点源样式
- `site-assets/`：给 GitHub Pages 用的同步产物
- `scripts/build-site.sh`：本地构建并同步产物的脚本

## 本地开发

先确认本机已经安装 `moon`。

### 1. 类型检查

```bash
moon check --target js
```

### 2. 构建 Rabbita 页面

```bash
./scripts/build-site.sh
```

这个脚本会：

- 执行 `moon build --target js --release`
- 从 `_build/js/release/build/.../main/main.js` 找到编译产物
- 同步到 `site-assets/main.js`
- 把 `styles.css` 同步到 `site-assets/styles.css`

### 3. 预览页面

构建完成后，直接打开：

- `index.html`
- `preview.html`

即可预览当前页面。

## 维护方式

- 内容结构主要在 [main/main.mbt](/Users/zongen/Documents/New%20project/MGPIC2026/main/main.mbt)
- 样式在 [styles.css](/Users/zongen/Documents/New%20project/MGPIC2026/styles.css)
- 改完源码后，重新运行 `./scripts/build-site.sh`

这样就能保持“源码”和“可直接发布的静态产物”同步。
