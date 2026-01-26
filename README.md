# ✨ gitpretty

> Make your git history beautiful

[![npm](https://img.shields.io/badge/npm-gitpretty-red.svg)](https://npmjs.com/package/gitpretty)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

```
git log --oneline
```
**Before:** 😴
```
a1b2c3d Update stuff
e4f5g6h Fix thing
i7j8k9l Add feature
```

**After:** ✨
```
a1b2c3d ✨ Add user authentication
e4f5g6h 🐛 Fix login validation  
i7j8k9l 📝 Update documentation
```

---

## 🚀 Quick Start

```bash
# Clone gitpretty
git clone https://github.com/nirholas/gitpretty.git

# Make your repo beautiful
./gitpretty/emoji-file-commits.sh /path/to/your-repo

# Push and admire on GitHub ✨
cd /path/to/your-repo && git push
```

**Result:** Every file shows a unique emoji in GitHub's file browser!

---

## 🛠️ Tools

### Core Scripts
| Script | Description |
|--------|-------------|
| `emoji-file-commits.sh` | Add emojis visible in GitHub |
| `emoji-commits.sh` | Safe mode (empty commits) |

### Git Workflow
| Script | Example |
|--------|---------|
| `emoji-commit.sh` | `"add auth"` → `✨ Add auth` |
| `emoji-branch.sh` | `feature login` → `feature/login` |
| `emoji-merge.sh` | `feature/auth` → `✨ Merge feature: auth` |
| `emoji-stash.sh` | `save wip "testing"` → `🚧 testing` |
| `emoji-log.sh` | `graph` / `today` / `week` |
| `emoji-tag.sh` | `v1.0.0 minor` → `✨ v1.0.0` |
| `emoji-hooks.sh` | Auto-emoji all commits |

### GitHub Actions
| Workflow | Trigger |
|----------|---------|
| `emoji-commits.yml` | Auto-beautify on push |
| `commit-lint.yml` | Validate PR commits |
| `changelog.yml` | Auto changelog on release |

---

## 💬 Smart Commits

```bash
./scripts/emoji-commit.sh "add dashboard"
# → ✨ Add dashboard

./scripts/emoji-commit.sh "fix login bug"
# → 🐛 Fix login bug

./scripts/emoji-commit.sh "update readme"
# → 📝 Update readme
```

**Auto-detection:**
| Keyword | Emoji | Keyword | Emoji |
|---------|-------|---------|-------|
| add, feat | ✨ | fix, bug | 🐛 |
| docs | 📝 | style | 💄 |
| refactor | ♻️ | test | ✅ |
| config | ⚙️ | security | 🔐 |
| deploy | 🚀 | remove | 🗑️ |

---

## 🪝 Auto-Emoji Hooks

```bash
# Install once
./scripts/emoji-hooks.sh install

# Every commit gets auto-emoji!
git commit -m "add feature"
# 🪝 Auto-added: ✨
# ✨ Add feature
```

---

## 📜 Pretty Logs

```bash
./scripts/emoji-log.sh graph    # ASCII graph
./scripts/emoji-log.sh today    # Today's commits
./scripts/emoji-log.sh week     # This week by day
./scripts/emoji-log.sh author   # Group by author
```

---

## 📦 Stash Management

```bash
./scripts/emoji-stash.sh save wip "working on auth"
# → 🚧 working on auth

./scripts/emoji-stash.sh list
# Beautiful stash list with emojis
```

| Type | Emoji | Type | Emoji |
|------|-------|------|-------|
| wip | 🚧 | experiment | 🧪 |
| temp | ⏳ | backup | 🔐 |
| idea | 💡 | debug | 🔍 |

---

## ⚙️ Git Aliases

Add to `~/.gitconfig`:

```ini
[alias]
    pretty = "!~/.gitpretty/scripts/emoji-commit.sh"
    pl = "!~/.gitpretty/scripts/emoji-log.sh"
    ps = "!~/.gitpretty/scripts/emoji-stash.sh"
```

Usage:
```bash
git pretty "add feature"  # ✨ Add feature
git pl graph              # Pretty log graph
git ps list               # Pretty stash list
```

---

## 📚 Docs

- [Setup Guide](docs/tutorials/SETUP.md)
- [GitHub Actions](docs/tutorials/GITHUB_ACTIONS.md)
- [Scenarios](docs/tutorials/SCENARIOS.md)
- [Emoji Guide](docs/EMOJI_GUIDE.md)

---

## 📄 License

MIT

---

<p align="center">
  <b>git pretty</b> ✨ make it beautiful
</p>

