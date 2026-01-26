# 🎨 Aesthetics

> Beautiful CLI tools for developers who appreciate visual polish

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## ✨ See It In Action

After running `emoji-file-commits.sh`, your GitHub repository looks like this:

```
📁 your-repo
├── ⭐ README.md                 2 minutes ago
├── 🌟 package.json              2 minutes ago
├── ✨ tsconfig.json             2 minutes ago
├── 💫 src/
│   ├── 🌠 index.ts              2 minutes ago
│   ├── 🔆 utils.ts              2 minutes ago
│   └── 🔅 config.ts             2 minutes ago
├── 🚀 docs/
│   └── 🛠️ API.md                2 minutes ago
└── ⚙️ tests/
    └── 🔧 index.test.ts         2 minutes ago
```

Every file gets a unique emoji visible directly in GitHub's file browser!

## 🛠️ Scripts

| Script | Description | GitHub Visible? |
|--------|-------------|-----------------|
| **[emoji-file-commits.sh](emoji-file-commits.sh)** | Emoji per file in GitHub browser | ✅ Yes |
| [emoji-commits.sh](emoji-commits.sh) | Empty commits with emojis (safe) | ❌ No |
| [repo-stats.sh](scripts/repo-stats.sh) | Repository statistics | - |
| [git-beautify.sh](scripts/git-beautify.sh) | Beautified git log | - |
| [file-tree.sh](scripts/file-tree.sh) | Enhanced tree with icons | - |
| [commit-lint.sh](scripts/commit-lint.sh) | Lint emoji conventions | - |
| [changelog-gen.sh](scripts/changelog-gen.sh) | Generate changelogs | - |

## 🚀 Quick Start

### Make Your GitHub Beautiful (Most Popular!)

```bash
# Clone aesthetics
git clone https://github.com/nirholas/aesthetics.git

# Run on your repository
./aesthetics/emoji-file-commits.sh /path/to/your-repo

# Push to see emojis in GitHub
cd /path/to/your-repo && git push
```

**Result:** Every file shows a unique emoji in GitHub's file browser!

### One-Liner

```bash
curl -fsSL https://raw.githubusercontent.com/nirholas/aesthetics/main/emoji-file-commits.sh | bash -s /path/to/repo
```

## 📖 Script Details

### ⭐ emoji-file-commits.sh (Recommended)

**Makes emojis visible in GitHub's file browser.**

Each file is touched and committed with a unique emoji, so GitHub shows the emoji next to each filename.

```bash
./emoji-file-commits.sh /path/to/your-repo
```

**Before:**
```
Name                    Last commit message
README.md               Update documentation
package.json            Update dependencies  
src/index.ts            Fix bug
```

**After:**
```
Name                    Last commit message
README.md               ⭐ README.md
package.json            🌟 package.json
src/index.ts            ✨ index.ts
```

---

### 🔒 emoji-commits.sh (Safe Mode)

Uses `--allow-empty` commits - no file modifications. Good for adding emoji history without changing files.

```bash
./emoji-commits.sh /path/to/your-repo
```

**Features:**
- ✅ 609 unique emojis
- ✅ SHA256 checksum verification
- ✅ Zero file modifications
- ✅ Detailed verification reports

---

### 📊 repo-stats.sh

Display beautiful repository statistics.

```bash
./scripts/repo-stats.sh /path/to/repo
```

**Output:**
```
╔══════════════════════════════════════════════════════════╗
║  📊 Repository Statistics                                ║
║     my-project                                           ║
╚══════════════════════════════════════════════════════════╝

📁 Files
   Total files:       156
   Total directories: 23

📝 Git History
   Total commits:     342
   Branches:          5
   Contributors:      3

📊 File Types

   .ts        78 files  [████████████████████████████░░] 100%
   .json      12 files  [████░░░░░░░░░░░░░░░░░░░░░░░░░░]  15%
   .md         8 files  [███░░░░░░░░░░░░░░░░░░░░░░░░░░░]  10%
```

---

### 🌈 git-beautify.sh

Beautified git log with emoji prefixes.

```bash
./scripts/git-beautify.sh --limit 10
```

**Output:**
```
╔══════════════════════════════════════════════════════════╗
║  🌈 Git Log - Beautified                                 ║
╚══════════════════════════════════════════════════════════╝

a1b2c3d ✨ Add user authentication (2 hours ago)
b2c3d4e 🐛 Fix login bug (5 hours ago)
c3d4e5f 📝 Update documentation (yesterday)
d4e5f6g ♻️ Refactor API (2 days ago)
```

---

### 🌳 file-tree.sh

Enhanced directory tree with file type icons.

```bash
./scripts/file-tree.sh --depth 2 --size
```

**Output:**
```
my-project/
├── 📝 README.md (2.4K)
├── 📋 package.json (1.2K)
├── 📂 src/
│   ├── 🔷 index.ts (0.5K)
│   └── 🔷 utils.ts (1.8K)
└── 🧪 tests/
    └── 🔷 index.test.ts (1.1K)
```

---

### ✅ commit-lint.sh

Validate commits follow emoji conventions.

```bash
./scripts/commit-lint.sh --fix
```

**Output:**
```
✓ a1b2c3d ✨ Add user authentication
✓ b2c3d4e 🐛 Fix login bug
✗ c3d4e5f Update documentation
  ↳ Suggested: 📝 Update documentation

Passed: 2
Failed: 1
```

---

### 📋 changelog-gen.sh

Generate changelogs from emoji commits.

```bash
./scripts/changelog-gen.sh --since v1.0.0 --output CHANGELOG.md
```

**Output:**
```markdown
# Changelog

## Changes from v1.0.0 to HEAD

### ✨ Features
- Add user authentication (`a1b2c3d`)
- Add password reset (`f6g7h8i`)

### 🐛 Bug Fixes
- Fix login redirect (`b2c3d4e`)
```

## 🎨 468 Unique Emojis

| Category | Examples | Count |
|----------|----------|-------|
| Stars | ⭐ 🌟 ✨ 💫 | 7 |
| Tech & Tools | 🚀 🛠️ ⚙️ 🔧 💻 | 30 |
| Shapes | 💎 🔷 🔶 💠 | 33 |
| Nature | 🌱 🌿 🍀 🌲 | 30 |
| Space | 🌍 🪐 🌙 ☄️ | 17 |
| Buildings | 🏗️ 🏛️ 🏰 🗼 | 35 |
| Vehicles | 🚂 ✈️ 🛸 🚢 | 56 |
| Office | 📦 📝 📁 🔒 | 56 |
| Media | 📔 📖 📷 🔍 | 37 |
| Art & Music | 🎨 🎭 🎵 🎸 | 26 |
| Games | 🎯 🎮 🎲 🏆 | 51 |
| Celebration | 🎀 🎁 🎈 🎉 | 14 |
| Hearts | ❤️ 💙 💜 💖 | 19 |
| Symbols | ☮️ ⚛️ ♻️ ✖️ | 78+ |

## 📦 Installation

### Clone

```bash
git clone https://github.com/nirholas/aesthetics.git ~/.aesthetics
echo 'export PATH="$HOME/.aesthetics:$HOME/.aesthetics/scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Download Single Script

```bash
curl -fsSL https://raw.githubusercontent.com/nirholas/aesthetics/main/emoji-file-commits.sh -o emoji-file-commits.sh
chmod +x emoji-file-commits.sh
```

## 🔒 Safety

- `emoji-commits.sh` uses `--allow-empty` (zero file changes)
- `emoji-file-commits.sh` only touches files (updates timestamp)
- SHA256 checksums for verification
- Pre/post manifests for comparison

## 🔗 Inspired By

- [gitmoji](https://gitmoji.dev) - Emoji guide for commits
- [gitmoji-cli](https://github.com/carloscuesta/gitmoji-cli)
- [commit-message-emoji](https://github.com/dannyfritz/commit-message-emoji)

## 📄 License

MIT License - see [LICENSE](LICENSE)

---

<p align="center">
  <b>Make your GitHub beautiful ✨</b><br>
  <a href="https://github.com/nirholas/aesthetics">github.com/nirholas/aesthetics</a>
</p>

