# 🎬 Real-World Scenarios

Practical examples of using emoji gitpretty in different situations.

---

## 📦 Scenario 1: New Open Source Project

You're starting a fresh open source project and want it to look professional from day one.

### Setup

```bash
# 1. Create your project
mkdir awesome-project && cd awesome-project
git init

# 2. Install emoji hooks immediately
~/.gitpretty/scripts/emoji-hooks.sh install

# 3. Create initial files
echo "# Awesome Project" > README.md
git add README.md
git commit -m "initial commit"
# → 🎉 Initial commit (auto-emoji!)
```

### Ongoing Workflow

```bash
# Normal development - hooks handle emojis
git add src/
git commit -m "add user authentication"
# → ✨ Add user authentication

git commit -m "fix login validation"
# → 🐛 Fix login validation
```

### Result
Your git history looks beautiful from the start:
```
🎉 Initial commit
✨ Add user authentication  
🐛 Fix login validation
📝 Update README
```

---

## 🏢 Scenario 2: Team Project with Standards

Your team wants consistent commit messages but doesn't want to slow down development.

### Setup

```bash
# 1. Add commit lint workflow
mkdir -p .github/workflows
cat > .github/workflows/commit-lint.yml << 'EOF'
name: 📝 Commit Lint
on: [pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - name: Check emojis
        run: |
          BASE=${{ github.event.pull_request.base.sha }}
          HEAD=${{ github.event.pull_request.head.sha }}
          for sha in $(git rev-list $BASE..$HEAD); do
            MSG=$(git log -1 --format=%s $sha)
            if [[ ! "$MSG" =~ ^[[:punct:]]|^🔹 ]]; then
              echo "❌ Missing emoji: $MSG"
              exit 1
            fi
          done
          echo "✅ All commits have emojis"
EOF
```

### Developer Workflow

```bash
# Each developer installs locally
git clone your-repo
cd your-repo
~/.gitpretty/scripts/emoji-hooks.sh install

# Or uses emoji-commit for manual control
~/.gitpretty/scripts/emoji-commit.sh "add payment processing"
```

### Result
- PRs without emoji commits are blocked
- Developers can use auto-emoji or choose manually
- History stays consistent

---

## 🔄 Scenario 3: Beautify Legacy Repository

You have an existing repo with years of plain commits and want to add visual appeal.

### Option A: Add Going Forward Only

```bash
# Just install hooks - old history stays, new commits get emojis
cd legacy-repo
~/.gitpretty/scripts/emoji-hooks.sh install
```

### Option B: Beautify All Files (Non-Destructive)

```bash
# Add emoji commits to all current files
cd legacy-repo
~/.gitpretty/emoji-file-commits.sh

# This adds NEW commits with emojis, doesn't rewrite history
git push
```

### Option C: Automated Future Beautification

```bash
# Set up GitHub Action to beautify on push
mkdir -p .github/workflows
cp ~/.gitpretty/.github/workflows/emoji-commits.yml .github/workflows/
git add .github/workflows/
git commit -m "🤖 Add auto-emoji workflow"
git push
```

### Result
- Old history preserved
- New layer of emoji commits
- Future commits auto-beautified

---

## 🚀 Scenario 4: Release Management

Using emojis to make releases beautiful and informative.

### Creating a Release

```bash
# 1. Create release branch
~/.gitpretty/scripts/emoji-branch.sh release v2.0.0
# → Creates: release/v2.0.0

# 2. Prepare release commits
git commit -m "🚀 Bump version to 2.0.0"
git commit -m "📝 Update changelog"
git commit -m "🔧 Update dependencies"

# 3. Create release tag
~/.gitpretty/scripts/emoji-tag.sh v2.0.0 major
# → Creates: v2.0.0 with 💥 tag message

# 4. Merge to main with emoji
~/.gitpretty/scripts/emoji-merge.sh release/v2.0.0
# → 🚀 Merge release: v2.0.0
```

### Auto-Generate Changelog

```bash
# Generate changelog from emoji commits
~/.gitpretty/scripts/changelog-gen.sh

# Output groups by emoji type:
# ✨ Features
#   - Add payment processing
#   - Add user dashboard
# 🐛 Bug Fixes
#   - Fix login validation
#   - Fix cart calculation
```

---

## 🔍 Scenario 5: Code Review Enhancement

Make PRs easier to review with organized commits.

### Branch Strategy

```bash
# Feature development
~/.gitpretty/scripts/emoji-branch.sh feature user-preferences
# → feature/user-preferences

# Each commit organized
git commit -m "✨ Add preferences UI"
git commit -m "🗃️ Add preferences database schema"
git commit -m "🔌 Add preferences API endpoints"
git commit -m "✅ Add preferences tests"
git commit -m "📝 Add preferences documentation"
```

### PR Title Convention

```bash
# Use emoji in PR title
gh pr create --title "✨ Add user preferences feature" --body "..."
```

### Review Benefits
- Reviewers can quickly identify commit types
- Easy to spot if tests are missing (no ✅)
- Documentation status visible (📝)

---

## 📊 Scenario 6: Project Analytics

Understanding your commit patterns through emojis.

### Generate Stats

```bash
# Get repo statistics
~/.gitpretty/scripts/repo-stats.sh

# Output:
# 📊 Repository Statistics
# ━━━━━━━━━━━━━━━━━━━━━━━━
# Total commits: 1,234
# With emoji: 1,100 (89%)
# 
# By Type:
#   ✨ Features: 456
#   🐛 Bug fixes: 234
#   📝 Documentation: 189
#   ♻️ Refactoring: 145
#   ...
```

### Weekly Review

```bash
# See this week's progress
~/.gitpretty/scripts/emoji-log.sh week

# Output grouped by day with emoji stats
```

---

## 🧩 Scenario 7: Monorepo Management

Handling multiple packages in one repo.

### Scoped Emojis

```bash
# Include scope in commit
git commit -m "✨ [api] Add user endpoints"
git commit -m "✨ [web] Add user components"
git commit -m "🐛 [shared] Fix validation logic"
git commit -m "📦 [all] Update dependencies"
```

### Package-Specific Beautification

```bash
# Only beautify specific package
cd packages/api
~/.gitpretty/emoji-file-commits.sh --path .

# Or use include pattern
~/.gitpretty/emoji-file-commits.sh --include "packages/api/**"
```

---

## 🔐 Scenario 8: Private/Enterprise Repository

Using emojis in a corporate environment.

### Minimal Emoji Set

```bash
# Create conservative emoji config
cat > .gitpretty-config << 'EOF'
# Minimal professional emoji set
TYPE_EMOJIS=(
    ["feat"]="+"
    ["fix"]="*"
    ["docs"]="#"
    ["test"]="?"
    ["chore"]="~"
)
EOF
```

### Or Use Text Tags Instead

```bash
# Configure for text tags
# [FEAT] Add feature
# [FIX] Fix bug
# [DOCS] Update docs
```

### Compliance-Friendly Setup

```bash
# Only validate, don't auto-modify
# Use commit-lint workflow without auto-beautify
cp ~/.gitpretty/.github/workflows/commit-lint.yml .github/workflows/
# Don't copy emoji-commits.yml
```

---

## 🎓 Quick Reference

### Most Common Workflows

| Situation | Command |
|-----------|---------|
| New commit | `emoji-commit.sh "message"` |
| View history | `emoji-log.sh graph` |
| Save work in progress | `emoji-stash.sh save wip "description"` |
| Create feature branch | `emoji-branch.sh feature name` |
| Merge branch | `emoji-merge.sh feature/name` |
| Create release | `emoji-tag.sh v1.0.0 minor` |
| Beautify repo | `emoji-file-commits.sh` |
| Install hooks | `emoji-hooks.sh install` |

### Commit Type Quick Guide

| Emoji | Type | When to Use |
|-------|------|-------------|
| ✨ | feat | New feature |
| 🐛 | fix | Bug fix |
| 📝 | docs | Documentation |
| 💄 | style | Formatting/style |
| ♻️ | refactor | Code refactoring |
| ⚡ | perf | Performance |
| ✅ | test | Tests |
| 🔧 | chore | Maintenance |
| 🚀 | deploy | Deployment |
| 🔐 | security | Security |

---

## 📖 Related

- [Setup Guide](SETUP.md) - Installation instructions
- [GitHub Actions](GITHUB_ACTIONS.md) - CI/CD automation
- [Main README](../../README.md) - Full documentation
