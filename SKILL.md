---
name: gitpretty
description: "Bash toolkit that adds emoji to git commits, logs, branches, tags, and stashes using conventional commit conventions. Provides smart-commit with auto-emoji detection, pretty log views (graph, today, week, author), branch prefixes, merge emoji, release tags, and git hook automation. Use when adding emoji to git commits, beautifying git log output, setting up emoji git hooks, creating conventional commits with emoji, managing git stashes with descriptions, or automating emoji in git workflows."
---

# gitpretty

Add emoji to every part of your git workflow — commits, logs, branches, tags, and stashes.

## Workflow

### 1. Quick Commit with Auto-Emoji

Stage changes and commit with automatic emoji detection from your message:

```bash
git add -A && ~/.gitpretty/scripts/emoji-commit.sh "fix login validation"
# Result: 🐛 Fix login validation
```

Keyword-to-emoji mapping:

| Keyword | Emoji | Keyword | Emoji |
|---------|-------|---------|-------|
| feat/add | ✨ | fix | 🐛 |
| docs | 📝 | refactor | ♻️ |
| perf | ⚡ | test | ✅ |
| chore | 🔧 | security | 🔐 |

See `scripts/emoji-commit.sh` for the full keyword-to-emoji mapping.

### 2. Smart Commit (Conventional Format)

For structured conventional commit messages with optional scope:

```bash
# type + description
~/.gitpretty/scripts/smart-commit.sh feat "add user authentication"
# Result: ✨ feat: add user authentication

# type + scope + description
~/.gitpretty/scripts/smart-commit.sh feat auth "add OAuth2 login"
# Result: ✨ feat(auth): add OAuth2 login

# Dry-run preview
~/.gitpretty/scripts/smart-commit.sh -d feat "add new feature"
```

### 3. Pretty Log Views

```bash
~/.gitpretty/scripts/emoji-log.sh              # Compact one-line view
~/.gitpretty/scripts/emoji-log.sh graph -n 20   # ASCII graph, last 20
~/.gitpretty/scripts/emoji-log.sh today          # Today's commits
~/.gitpretty/scripts/emoji-log.sh week           # This week's commits
~/.gitpretty/scripts/emoji-log.sh author         # Grouped by author
```

### 4. Branch, Merge, Tag, and Stash

```bash
# Create prefixed branch
~/.gitpretty/scripts/emoji-branch.sh feature user-auth

# Merge with auto-emoji
~/.gitpretty/scripts/emoji-merge.sh feature/user-auth

# Release tag with version emoji
~/.gitpretty/scripts/emoji-tag.sh v1.2.0

# Stash with description
~/.gitpretty/scripts/emoji-stash.sh save "WIP: dashboard layout"
~/.gitpretty/scripts/emoji-stash.sh list
```

### 5. Install Git Hooks for Auto-Emoji

```bash
~/.gitpretty/scripts/emoji-hooks.sh
# Verify: make a test commit and confirm emoji appears
git commit --allow-empty -m "test hook" && git log -1 --oneline
```

Installs a `prepare-commit-msg` hook that automatically adds emoji to every commit.

### 6. Beautify Repository File History

Run on a branch first — this creates commits for every file in the repo:

```bash
git checkout -b beautify
~/.gitpretty/scripts/emoji-file-commits.sh
# Verify results before merging
git log --oneline -10
# If results look wrong, abort: git checkout main && git branch -D beautify
```

## Requirements

- Bash shell (macOS/Linux)
- Git 2.0+
- Terminal with emoji/unicode font support
