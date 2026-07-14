# ✨ gitpretty

> Make your git history beautiful with emojis and smart commits

[![npm](https://img.shields.io/badge/npm-gitpretty-red.svg)](https://npmjs.com/package/gitpretty)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## What does it do?

**Before:** 😴
``` 
a1b2c3d Update stuff
e4f5g6h Fix thing
i7j8k9l Add feature
```

**After:** ✨
```
a1b2c3d ✨ feat(auth): add user authentication
e4f5g6h 🐛 fix(login): resolve validation error on mobile  
i7j8k9l 📝 docs: update API documentation
```

---

## 🚀 Installation

```bash
# Clone to your home directory (recommended)
git clone https://github.com/nirholas/gitpretty.git ~/.gitpretty

# Or clone anywhere you like
git clone https://github.com/nirholas/gitpretty.git /path/to/gitpretty
```

---

## 📖 How to Use

### Quick Commit (Most Common)

Stage your changes and commit with a simple description:

```bash
# Stage all files and commit
git add -A && ~/.gitpretty/scripts/emoji-commit.sh "add user dashboard"
# Result: ✨ Add user dashboard

# Stage specific files and commit
git add src/auth.ts && ~/.gitpretty/scripts/emoji-commit.sh "fix login bug"
# Result: 🐛 Fix login bug
```

The script automatically detects the commit type from your message:

| Your message | Becomes |
|--------------|---------|
| `"add new feature"` | ✨ Add new feature |
| `"fix login error"` | 🐛 Fix login error |
| `"update readme"` | 📝 Update readme |
| `"refactor auth module"` | ♻️ Refactor auth module |
| `"remove old code"` | 🗑️ Remove old code |

### Smart Commit (Detailed Messages)

For more descriptive, conventional commit messages:

```bash
# Basic: type + description
git add -A && ~/.gitpretty/scripts/smart-commit.sh feat "add user authentication"
# Result: ✨ feat: add user authentication

# With scope: type + scope + description
git add -A && ~/.gitpretty/scripts/smart-commit.sh feat auth "add OAuth2 login"
# Result: ✨ feat(auth): add OAuth2 login

# Preview without committing (dry-run)
~/.gitpretty/scripts/smart-commit.sh -d feat "add new feature"
```

**Commit types:**
| Type | Emoji | Use for |
|------|-------|---------|
| `feat` | ✨ | New features |
| `fix` | 🐛 | Bug fixes |
| `docs` | 📝 | Documentation |
| `style` | 💄 | Formatting, CSS |
| `refactor` | ♻️ | Code restructuring |
| `perf` | ⚡ | Performance improvements |
| `test` | ✅ | Adding tests |
| `chore` | 🔧 | Maintenance tasks |
| `ci` | 👷 | CI/CD changes |
| `build` | 🏗️ | Build system |
| `security` | 🔐 | Security fixes |
| `deploy` | 🚀 | Deployments |

---

## 🛠️ All Scripts

### Committing

| Script | What it does | Example |
|--------|--------------|---------|
| `emoji-commit.sh` | Quick commit with auto-emoji | `git add -A && ~/.gitpretty/scripts/emoji-commit.sh "add feature"` |
| `smart-commit.sh` | Conventional commits with scope | `git add -A && ~/.gitpretty/scripts/smart-commit.sh feat auth "add login"` |
| `commit-lint.sh` | Validate commit message format | `~/.gitpretty/scripts/commit-lint.sh` |

### Branching & Merging

| Script | What it does | Example |
|--------|--------------|---------|
| `emoji-branch.sh` | Create pretty branch names | `~/.gitpretty/scripts/emoji-branch.sh feature login-page` |
| `emoji-merge.sh` | Merge with emoji message | `~/.gitpretty/scripts/emoji-merge.sh feature/auth` |
| `emoji-tag.sh` | Create tagged releases | `~/.gitpretty/scripts/emoji-tag.sh v1.0.0 major` |

### Viewing History

| Script | What it does | Example |
|--------|--------------|---------|
| `emoji-log.sh` | Pretty git log views | `~/.gitpretty/scripts/emoji-log.sh graph` |
| `emoji-log.sh` | Today's commits | `~/.gitpretty/scripts/emoji-log.sh today` |
| `emoji-log.sh` | This week's commits | `~/.gitpretty/scripts/emoji-log.sh week` |

### Stashing

| Script | What it does | Example |
|--------|--------------|---------|
| `emoji-stash.sh` | Save work in progress | `~/.gitpretty/scripts/emoji-stash.sh save wip "testing auth"` |
| `emoji-stash.sh` | List stashes | `~/.gitpretty/scripts/emoji-stash.sh list` |

### Repository Tools

| Script | What it does | Example |
|--------|--------------|---------|
| `file-tree.sh` | Show repo structure | `~/.gitpretty/scripts/file-tree.sh` |
| `repo-stats.sh` | Repository statistics | `~/.gitpretty/scripts/repo-stats.sh` |
| `changelog-gen.sh` | Generate changelog | `~/.gitpretty/scripts/changelog-gen.sh` |
| `git-beautify.sh` | Beautify existing history | `~/.gitpretty/scripts/git-beautify.sh` |

### Setup

| Script | What it does | Example |
|--------|--------------|---------|
| `emoji-hooks.sh` | Install auto-emoji git hooks | `~/.gitpretty/scripts/emoji-hooks.sh install` |

---

## 🪝 Auto-Emoji Hooks

Install once, and every commit automatically gets emojis:

```bash
# Install hooks in your repo
cd /path/to/your-repo
~/.gitpretty/scripts/emoji-hooks.sh install

# Now every commit gets auto-emoji!
git commit -m "add feature"
# 🪝 Auto-added: ✨
# ✨ Add feature
```

---

## ⚙️ Git Aliases (Optional)

Add to your `~/.gitconfig` for shorter commands:

```ini
[alias]
    # Quick emoji commit
    c = "!f() { git add -A && ~/.gitpretty/scripts/emoji-commit.sh \"$1\"; }; f"
    
    # Smart commit with type
    sc = "!f() { git add -A && ~/.gitpretty/scripts/smart-commit.sh \"$@\"; }; f"
    
    # Pretty log
    lg = "!~/.gitpretty/scripts/emoji-log.sh"
    
    # Pretty stash
    st = "!~/.gitpretty/scripts/emoji-stash.sh"
```

Then use:

```bash
git c "add new feature"           # Quick commit
git sc feat auth "add OAuth"      # Smart commit with scope
git lg graph                      # Pretty log graph
git st list                       # Pretty stash list
```

---

## 📚 More Documentation

- [Setup Guide](docs/tutorials/SETUP.md)
- [GitHub Actions](docs/tutorials/GITHUB_ACTIONS.md)
- [Scenarios](docs/tutorials/SCENARIOS.md)
- [Emoji Guide](docs/EMOJI_GUIDE.md)

---

## 📄 License

MIT

---

<p align="center">
  <b>git pretty</b> ✨ make your commits beautiful
</p>

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=nirholas/gitpretty&type=Date)](https://star-history.com/#nirholas/gitpretty&Date)
