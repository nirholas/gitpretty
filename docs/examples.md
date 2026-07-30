# gitpretty examples

Make your git history beautiful - emoji commits, pretty logs, and aesthetic workflows

## Example 1

```text
**After:** ✨
```

## Example 2

```text
---

## 🚀 Installation

### From npm (published as `gitglow`)
```

## Example 3

```text
This installs the `gitpretty` command globally.

### From source
```

## Example 4

```text
The shell scripts under `scripts/` are executable and can be run directly from
the clone — no build step is required.

---

## 📖 How to Use

### Quick Commit (Most Common)

Stage your changes and commit with a simple description:
```

## Example 5

```text
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
```

## Example 6

```text
The description is capitalized automatically, and the commit body lists the
staged files and a change summary.

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
```

## Example 7

```text
---

## ⚙️ Git Aliases (Optional)

Add to your `~/.gitconfig` for shorter commands:
```

## Example 8

```text
Then use:
```


Every snippet above is taken from the [repository documentation](https://github.com/nirholas/gitpretty#readme).
