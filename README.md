# 🎨 Aesthetics

> Beautiful CLI tools for developers who appreciate visual polish

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## ✨ What is Aesthetics?

Aesthetics is a toolkit of shell scripts that make your development workflow more beautiful. Each script is designed with visual appeal, safety, and efficiency in mind.

Inspired by [gitmoji](https://gitmoji.dev) and [commit-message-emoji](https://github.com/dannyfritz/commit-message-emoji).

## 🛠️ Scripts

| Script | Description |
|--------|-------------|
| [emoji-commits.sh](emoji-commits.sh) | Add unique emoji commits to every file in a repository |
| [repo-stats.sh](scripts/repo-stats.sh) | Beautiful repository statistics with visual charts |
| [git-beautify.sh](scripts/git-beautify.sh) | Beautify git log with semantic emoji prefixes |
| [file-tree.sh](scripts/file-tree.sh) | Enhanced tree view with file type icons |
| [commit-lint.sh](scripts/commit-lint.sh) | Lint commits for proper emoji conventions |
| [changelog-gen.sh](scripts/changelog-gen.sh) | Generate beautiful changelogs from emoji commits |

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/nirholas/aesthetics.git
cd aesthetics

# Make scripts executable
chmod +x *.sh scripts/*.sh

# Run emoji commits on a repository
./emoji-commits.sh /path/to/your/repo
```

## 📦 Installation

### Option 1: Clone and Use

```bash
git clone https://github.com/nirholas/aesthetics.git
cd aesthetics
chmod +x *.sh scripts/*.sh
```

### Option 2: Add to PATH

```bash
git clone https://github.com/nirholas/aesthetics.git ~/.aesthetics
echo 'export PATH="$HOME/.aesthetics:$HOME/.aesthetics/scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Option 3: Single Script Download

```bash
curl -fsSL https://raw.githubusercontent.com/nirholas/aesthetics/main/emoji-commits.sh -o emoji-commits.sh
chmod +x emoji-commits.sh
```

## 📖 Script Documentation

### 🎯 emoji-commits.sh

Creates individual commits for every file in your repository, each with a unique emoji.

**Features:**
- ✅ 609 unique tech/builder emojis (no faces, no rainbows)
- ✅ SHA256 checksum verification (zero file modifications)
- ✅ Uses `--allow-empty` commits for safety
- ✅ Detailed logging and verification reports

**Usage:**
```bash
./emoji-commits.sh /path/to/repository
```

### 📊 repo-stats.sh

Display beautiful repository statistics with visual progress bars.

```bash
./scripts/repo-stats.sh [repository-path]
```

### 🌈 git-beautify.sh

Transform git log into colorful output with semantic emoji prefixes.

```bash
./scripts/git-beautify.sh [--limit N] [--format oneline|full]
```

### 🌳 file-tree.sh

Enhanced directory tree with file type icons.

```bash
./scripts/file-tree.sh [directory] [--depth N] [--size]
```

### ✅ commit-lint.sh

Validate commits follow emoji conventions.

```bash
./scripts/commit-lint.sh [--strict] [--fix]
```

### 📋 changelog-gen.sh

Generate changelogs from emoji commits.

```bash
./scripts/changelog-gen.sh [--since TAG] [--format md|json]
```

## 🎨 Emoji Convention

Based on [gitmoji](https://gitmoji.dev) standards:

| Emoji | Code | Description |
|-------|------|-------------|
| 🎉 | `:tada:` | Initial commit |
| ✨ | `:sparkles:` | New feature |
| 🐛 | `:bug:` | Bug fix |
| 🔥 | `:fire:` | Remove code/files |
| 📝 | `:memo:` | Documentation |
| 🚀 | `:rocket:` | Deploy |
| 💄 | `:lipstick:` | UI/style updates |
| ♻️ | `:recycle:` | Refactor |
| 🔧 | `:wrench:` | Configuration |
| ✅ | `:white_check_mark:` | Tests |
| 🔒 | `:lock:` | Security |
| ⬆️ | `:arrow_up:` | Upgrade deps |
| ⬇️ | `:arrow_down:` | Downgrade deps |
| 🏗️ | `:building_construction:` | Architecture |
| 📦 | `:package:` | Package/build |

[Full emoji list →](docs/EMOJI_GUIDE.md)

## 🎨 Unique Emoji Categories (609 total)

| Category | Examples | Count |
|----------|----------|-------|
| Stars & Sparkles | ⭐ 🌟 ✨ 💫 | 7 |
| Tech & Tools | 🚀 🛠️ ⚙️ 🔧 💻 | 30 |
| Geometric Shapes | 💎 🔷 🔶 🔹 | 33 |
| Nature Elements | 🌱 🌿 🍀 🌲 | 30 |
| Space & Cosmic | 🌍 🪐 🌙 ☄️ | 17 |
| Buildings | 🏗️ 🏛️ 🏰 🗼 | 35 |
| Vehicles | 🚂 ✈️ 🛸 🚀 | 56 |
| Office & Documents | 📦 📝 📁 🔒 | 56 |
| Books & Media | 📔 📖 📷 🔍 | 37 |
| Art & Music | 🎨 🎭 🎵 🎸 | 26 |
| Games & Sports | 🎯 🎮 🎲 🏆 | 51 |
| Celebration | 🎀 🎁 🎈 🎉 | 14 |
| Hearts | ❤️ 💙 💜 💖 | 19 |
| Symbols | ☮️ ⚛️ ♻️ ✖️ | 78+ |

## 🔒 Safety Features

All scripts include:

1. **Pre-flight Checks** - Verify repository state
2. **SHA256 Checksums** - File integrity verification
3. **Manifests** - Complete file listings before/after
4. **`--allow-empty`** - No file modifications
5. **Detailed Logging** - Full operation audit trail

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

MIT License - see [LICENSE](LICENSE)

## 🔗 Related Projects

- [gitmoji](https://gitmoji.dev) - An emoji guide for commit messages
- [gitmoji-cli](https://github.com/carloscuesta/gitmoji-cli) - Interactive gitmoji client
- [commit-message-emoji](https://github.com/dannyfritz/commit-message-emoji) - Emoji commit guide

---

<p align="center">
  <b>Make your terminal beautiful ✨</b>
</p>
