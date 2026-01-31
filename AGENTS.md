# AGENTS.md - gitpretty

## Project Overview

**gitpretty** is a toolkit for making git history beautiful with emojis.

## Repository Structure

```
gitpretty/
├── emoji-file-commits.sh    # Main: visible emojis in GitHub
├── emoji-commits.sh         # Safe: empty commits with emojis
├── scripts/
│   ├── emoji-commit.sh      # Smart commit with auto-emoji
│   ├── emoji-log.sh         # Beautiful log viewer
│   ├── emoji-stash.sh       # Stash management
│   ├── emoji-branch.sh      # Branch creation
│   ├── emoji-merge.sh       # Merge with emojis
│   ├── emoji-tag.sh         # Release tags
│   ├── emoji-hooks.sh       # Git hooks installer
│   ├── repo-stats.sh        # Repository statistics
│   ├── git-beautify.sh      # Beautified git log
│   ├── file-tree.sh         # Enhanced tree
│   ├── commit-lint.sh       # Lint emoji conventions
│   └── changelog-gen.sh     # Generate changelogs
├── .github/workflows/
│   ├── emoji-commits.yml    # Auto-beautify on push
│   ├── commit-lint.yml      # Validate PR commits
│   └── changelog.yml        # Auto changelog on release
└── docs/
    └── tutorials/
        ├── SETUP.md
        ├── GITHUB_ACTIONS.md
        └── SCENARIOS.md
```

## Coding Guidelines

- All scripts are bash
- Use `set -e` for error handling
- Include usage/help with `-h` flag
- Use associative arrays for emoji mappings
- Support both interactive and non-interactive modes

## Emoji Conventions

- 468+ unique emojis
- Tech/builder focused
- No faces, no rainbows
- Common: ✨ feat, 🐛 fix, 📝 docs, ♻️ refactor, ⚡ perf, ✅ test

## Testing

```bash
# Test on a temp repo
mkdir /tmp/test-repo && cd /tmp/test-repo
git init
echo "test" > file.txt && git add . && git commit -m "init"
/path/to/gitpretty/emoji-file-commits.sh .
```


