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

---

## 🛠️ All Tools

### 🎯 Main Scripts

| Script | Description | Use Case |
|--------|-------------|----------|
| **[emoji-file-commits.sh](emoji-file-commits.sh)** | Emoji per file (GitHub visible) | Make repos beautiful |
| [emoji-commits.sh](emoji-commits.sh) | Empty commits with emojis | Safe beautification |

### 💬 Git Workflow Scripts

| Script | Description | Example |
|--------|-------------|---------|
| [emoji-commit.sh](scripts/emoji-commit.sh) | Smart commit with auto-emoji | `emoji-commit.sh "add auth"` → ✨ |
| [emoji-branch.sh](scripts/emoji-branch.sh) | Create emoji-prefixed branches | `emoji-branch.sh feature login` |
| [emoji-tag.sh](scripts/emoji-tag.sh) | Emoji release tags | `emoji-tag.sh v1.0.0 minor` |
| [emoji-merge.sh](scripts/emoji-merge.sh) | Merge with emoji messages | `emoji-merge.sh feature/auth` |
| [emoji-stash.sh](scripts/emoji-stash.sh) | Stash management | `emoji-stash.sh save wip "testing"` |
| [emoji-log.sh](scripts/emoji-log.sh) | Beautiful git log viewer | `emoji-log.sh graph` |
| [emoji-hooks.sh](scripts/emoji-hooks.sh) | Git hooks installer | `emoji-hooks.sh install` |

### 📊 Utility Scripts

| Script | Description |
|--------|-------------|
| [repo-stats.sh](scripts/repo-stats.sh) | Repository statistics |
| [git-beautify.sh](scripts/git-beautify.sh) | Beautified git log |
| [file-tree.sh](scripts/file-tree.sh) | Enhanced tree with icons |
| [commit-lint.sh](scripts/commit-lint.sh) | Lint emoji conventions |
| [changelog-gen.sh](scripts/changelog-gen.sh) | Generate changelogs |

### 🤖 GitHub Actions

| Workflow | Description | Trigger |
|----------|-------------|---------|
| [emoji-commits.yml](.github/workflows/emoji-commits.yml) | Auto-beautify on push | Push to main |
| [commit-lint.yml](.github/workflows/commit-lint.yml) | Validate PR commits | Pull requests |
| [changelog.yml](.github/workflows/changelog.yml) | Auto-generate changelog | Release publish |

---

## 🚀 Quick Start

### Option 1: Make GitHub Beautiful (Most Popular!)

```bash
# Clone aesthetics
git clone https://github.com/nirholas/aesthetics.git

# Run on your repository
./aesthetics/emoji-file-commits.sh /path/to/your-repo

# Push to see emojis in GitHub
cd /path/to/your-repo && git push
```

### Option 2: Install Git Hooks (Auto-Emoji)

```bash
# Navigate to any repo
cd /path/to/your-repo

# Install hooks - commits auto-get emojis!
/path/to/aesthetics/scripts/emoji-hooks.sh install

# Now every commit gets auto-emoji
git commit -m "add user authentication"
# → ✨ Add user authentication
```

### Option 3: Use Emoji Git Commands

```bash
# Smart commit
./scripts/emoji-commit.sh "fix login bug"     # → 🐛 Fix login bug
./scripts/emoji-commit.sh "add dashboard"     # → ✨ Add dashboard

# Beautiful log
./scripts/emoji-log.sh graph                   # ASCII graph with emojis
./scripts/emoji-log.sh today                   # Today's commits
./scripts/emoji-log.sh week                    # This week by day

# Branch management  
./scripts/emoji-branch.sh feature user-auth    # → feature/user-auth
./scripts/emoji-merge.sh feature/user-auth     # → ✨ Merge feature: user-auth

# Stash with descriptions
./scripts/emoji-stash.sh save wip "testing"    # → 🚧 testing
./scripts/emoji-stash.sh list                  # Beautiful stash list

# Release tagging
./scripts/emoji-tag.sh v1.0.0 minor            # → v1.0.0 with ✨ prefix
```

---

## 📚 Documentation

### Tutorials
- [📖 Setup Guide](docs/tutorials/SETUP.md) - Complete installation instructions
- [🤖 GitHub Actions Guide](docs/tutorials/GITHUB_ACTIONS.md) - CI/CD automation
- [🎬 Scenarios](docs/tutorials/SCENARIOS.md) - Real-world use cases

### Reference
- [📋 Emoji Guide](docs/EMOJI_GUIDE.md) - All 468+ emojis used
- [🔒 Safety](docs/SAFETY.md) - How the scripts protect your data
- [💡 Examples](docs/EXAMPLES.md) - Before/after comparisons

### AI Context
- [AGENTS.md](AGENTS.md) - AI agent guidelines
- [SKILL.md](SKILL.md) - Capability documentation
- [llms.txt](llms.txt) - LLM context (brief)
- [llms-full.txt](llms-full.txt) - LLM context (detailed)

---

## 📖 Script Details

### ⭐ emoji-file-commits.sh (Recommended)

**Makes emojis visible in GitHub's file browser.**

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

### 💬 emoji-commit.sh (Smart Commits)

Auto-detects the right emoji from your commit message.

```bash
./scripts/emoji-commit.sh "add user authentication"
# Detects "add" → ✨ Add user authentication

./scripts/emoji-commit.sh "fix login validation"  
# Detects "fix" → 🐛 Fix login validation

./scripts/emoji-commit.sh "feat: add dashboard"
# Explicit type → ✨ Add dashboard
```

**Auto-Detection Keywords:**
| Keyword | Emoji | Keyword | Emoji |
|---------|-------|---------|-------|
| add, new, feat | ✨ | fix, bug | 🐛 |
| docs, readme | 📝 | style, format | 💄 |
| refactor | ♻️ | test | ✅ |
| config | ⚙️ | security | 🔐 |
| deploy, release | 🚀 | remove, delete | 🗑️ |

---

### 🪝 emoji-hooks.sh (Auto-Emoji for All Commits)

Install git hooks that automatically add emojis to all your commits.

```bash
./scripts/emoji-hooks.sh install
```

**Installed Hooks:**
- `commit-msg` - Auto-adds emoji prefix to commit messages
- `pre-push` - Shows summary before pushing
- `post-commit` - Celebration message after commit

```bash
# After installing, every commit gets auto-emoji:
git commit -m "add login feature"
# 🪝 Auto-added emoji: ✨
# ✅ Committed: ✨ add login feature
# 🎉 Committed: ✨ add login feature
```

---

### 📜 emoji-log.sh (Beautiful Git Log)

View git history in style.

```bash
# Compact view (default)
./scripts/emoji-log.sh

# Graph view with emojis
./scripts/emoji-log.sh graph

# Today's commits
./scripts/emoji-log.sh today

# This week grouped by day
./scripts/emoji-log.sh week

# By author
./scripts/emoji-log.sh author

# With stats
./scripts/emoji-log.sh stats -n 10
```

---

### 📦 emoji-stash.sh (Stash Management)

Never lose track of your stashes again.

```bash
# Save with type and description
./scripts/emoji-stash.sh save wip "working on auth"
# → 🚧 working on auth

./scripts/emoji-stash.sh save experiment "trying new approach"
# → 🧪 trying new approach

# List stashes beautifully
./scripts/emoji-stash.sh list

# Pop/apply/drop with confirmation
./scripts/emoji-stash.sh pop 0
./scripts/emoji-stash.sh apply 1
./scripts/emoji-stash.sh drop 2
```

**Stash Types:**
| Type | Emoji | Type | Emoji |
|------|-------|------|-------|
| wip | 🚧 | experiment | 🧪 |
| temp | ⏳ | save | 💾 |
| backup | 🔐 | urgent | 🚨 |
| idea | 💡 | debug | 🔍 |

---

## 🤖 GitHub Actions Usage

### Auto-Beautify on Push

Copy `.github/workflows/emoji-commits.yml` to your repo:

```yaml
# Runs on every push to main
# Beautifies all files with emojis
# Pushes changes back
```

### Validate PR Commits

Copy `.github/workflows/commit-lint.yml` to your repo:

```yaml
# Runs on pull requests
# Checks each commit has emoji prefix
# Fails with helpful message if missing
```

### Auto Changelog

Copy `.github/workflows/changelog.yml` to your repo:

```yaml
# Runs on release publish
# Groups commits by emoji type
# Generates beautiful CHANGELOG.md
```

---

## 🔧 Configuration

### Git Aliases

Add to `~/.gitconfig`:

```ini
[alias]
    ec = "!~/.aesthetics/scripts/emoji-commit.sh"
    el = "!~/.aesthetics/scripts/emoji-log.sh"
    es = "!~/.aesthetics/scripts/emoji-stash.sh"
    eb = "!~/.aesthetics/scripts/emoji-branch.sh"
    em = "!~/.aesthetics/scripts/emoji-merge.sh"
```

Usage: `git ec "add feature"`, `git el graph`, etc.

### Shell Aliases

Add to `~/.bashrc` or `~/.zshrc`:

```bash
alias gc='emoji-commit.sh'
alias gl='emoji-log.sh'
alias gs='emoji-stash.sh'
```

---

## 📄 License

MIT License - see [LICENSE](LICENSE)

---

## 🤝 Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md)

---

<p align="center">
  Made with ✨ by developers who appreciate beautiful git histories
</p>
