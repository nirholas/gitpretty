# 🤖 GitHub Actions Guide

Automate emoji commits and workflows with GitHub Actions.

## 📋 Available Workflows

### 1. Auto Emoji Commits (`emoji-commits.yml`)

Automatically beautifies commits when pushed to main.

**What it does:**
- Triggers on push to main branch
- Runs `emoji-file-commits.sh` to add emojis to all files
- Commits changes back to the repo

**Installation:**
```bash
# Copy to your repo
mkdir -p .github/workflows
cp gitpretty/.github/workflows/emoji-commits.yml .github/workflows/
```

**Configuration:**
```yaml
# .github/workflows/emoji-commits.yml
name: 🎨 Emoji Commits

on:
  push:
    branches: [main]

jobs:
  beautify:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
          token: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Run emoji commits
        run: |
          chmod +x emoji-file-commits.sh
          ./emoji-file-commits.sh
      
      - name: Push changes
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git push
```

---

### 2. Commit Lint (`commit-lint.yml`)

Validates that PR commits follow emoji conventions.

**What it does:**
- Triggers on pull requests
- Checks each commit message for emoji prefix
- Fails if commits lack emojis (with helpful message)

**Installation:**
```bash
cp gitpretty/.github/workflows/commit-lint.yml .github/workflows/
```

**Configuration:**
```yaml
# .github/workflows/commit-lint.yml
name: 📝 Commit Lint

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Check commits for emojis
        run: |
          COMMITS=$(git log --oneline origin/${{ github.base_ref }}..HEAD)
          MISSING=""
          
          while IFS= read -r line; do
            MSG=$(echo "$line" | cut -d' ' -f2-)
            # Check if starts with emoji
            if [[ ! "$MSG" =~ ^[🎉✨🐛📝💄♻️⚡✅🔧🚧🚀] ]]; then
              MISSING="$MISSING\n  ❌ $line"
            fi
          done <<< "$COMMITS"
          
          if [ -n "$MISSING" ]; then
            echo "::error::Commits missing emoji prefix:$MISSING"
            echo ""
            echo "💡 Tip: Use scripts/emoji-commit.sh for auto-emoji!"
            exit 1
          fi
          
          echo "✅ All commits have emoji prefixes!"
```

---

### 3. Auto Changelog (`changelog.yml`)

Generates changelog from emoji commits on release.

**What it does:**
- Triggers when a release is published
- Groups commits by emoji type
- Updates CHANGELOG.md automatically

**Installation:**
```bash
cp gitpretty/.github/workflows/changelog.yml .github/workflows/
```

---

## 🎯 Usage Scenarios

### Scenario A: Fully Automated

Every push to main gets beautified automatically.

```yaml
# Best for: Personal projects, documentation repos
on:
  push:
    branches: [main]
```

### Scenario B: PR Validation Only

Commits must have emojis, but no auto-modification.

```yaml
# Best for: Team projects with commit conventions
on:
  pull_request:
    types: [opened, synchronize]
```

### Scenario C: Manual Trigger

Run beautification on-demand.

```yaml
# Best for: Large repos, controlled releases
on:
  workflow_dispatch:
    inputs:
      branch:
        description: 'Branch to beautify'
        required: true
        default: 'main'
```

### Scenario D: Scheduled Cleanup

Weekly beautification job.

```yaml
# Best for: Long-running projects
on:
  schedule:
    - cron: '0 0 * * 0'  # Every Sunday at midnight
```

---

## 🔐 Permissions

### Required Permissions

```yaml
permissions:
  contents: write  # To push commits
  pull-requests: read  # To read PR info (if needed)
```

### Using Personal Access Token

For workflows that push back to the repo:

1. Create a PAT with `repo` scope
2. Add as repository secret: `Settings > Secrets > New`
3. Reference in workflow:

```yaml
steps:
  - uses: actions/checkout@v4
    with:
      token: ${{ secrets.PAT_TOKEN }}
```

---

## 🛠️ Customization

### Custom Emoji Set

```yaml
- name: Run with custom emojis
  env:
    EMOJI_FEAT: "🌟"
    EMOJI_FIX: "🔨"
  run: |
    ./emoji-file-commits.sh
```

### Skip Files

```yaml
- name: Run selective
  run: |
    # Only beautify specific paths
    ./emoji-file-commits.sh --include "src/**"
```

### Conditional Execution

```yaml
- name: Check if needed
  id: check
  run: |
    # Count files without emojis
    COUNT=$(./scripts/repo-stats.sh | grep "Without emoji" | grep -o '[0-9]*')
    echo "missing=$COUNT" >> $GITHUB_OUTPUT

- name: Beautify
  if: steps.check.outputs.missing > 0
  run: ./emoji-file-commits.sh
```

---

## 🔍 Debugging

### Enable Debug Logging

```yaml
env:
  ACTIONS_STEP_DEBUG: true
```

### Test Locally with `act`

```bash
# Install act
brew install act  # macOS
# or
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Run workflow locally
act push
```

### Common Issues

**Error: "refusing to allow a GitHub App to create or update workflow"**

Solution: Use a PAT instead of `GITHUB_TOKEN` for checkout.

**Error: "nothing to commit"**

This is expected if all files already have emojis. The workflow handles this gracefully.

**Error: "Permission denied"**

Solution: Ensure scripts are executable in the repo:
```bash
git update-index --chmod=+x emoji-file-commits.sh
git commit -m "🔧 Make scripts executable"
```

---

## 📝 Complete Example

Full workflow combining all features:

```yaml
name: 🎨 Complete Emoji Workflow

on:
  push:
    branches: [main]
  pull_request:
  workflow_dispatch:
  release:
    types: [published]

jobs:
  # Validate PR commits
  lint:
    if: github.event_name == 'pull_request'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - name: Lint commits
        run: ./scripts/commit-lint.sh

  # Auto-beautify on push
  beautify:
    if: github.event_name == 'push' || github.event_name == 'workflow_dispatch'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
          token: ${{ secrets.PAT_TOKEN }}
      
      - name: Beautify
        run: ./emoji-file-commits.sh
      
      - name: Push
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git diff --quiet || git push

  # Generate changelog on release
  changelog:
    if: github.event_name == 'release'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Generate changelog
        run: ./scripts/changelog-gen.sh
      - name: Upload artifact
        uses: actions/upload-artifact@v4
        with:
          name: changelog
          path: CHANGELOG.md
```

---

## 📖 Related

- [Setup Guide](SETUP.md) - Initial installation
- [Scenarios](SCENARIOS.md) - Real-world examples
- [Scripts Reference](../../README.md) - All available tools

