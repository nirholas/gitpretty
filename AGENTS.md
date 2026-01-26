# AGENTS.md - AI Agent Instructions

## Overview

This document provides instructions for AI agents working with the Aesthetics repository.

## Repository Purpose

Aesthetics is a collection of shell scripts for beautifying git workflows with emojis. The main script `emoji-commits.sh` adds unique emoji commits to every file in a repository.

## Key Files

| File | Purpose |
|------|---------|
| `emoji-commits.sh` | Main script - creates emoji commits for all files |
| `scripts/repo-stats.sh` | Repository statistics display |
| `scripts/git-beautify.sh` | Beautified git log output |
| `scripts/file-tree.sh` | Enhanced file tree with icons |
| `scripts/commit-lint.sh` | Commit message linting |
| `scripts/changelog-gen.sh` | Changelog generation |

## Agent Tasks

### When asked to run emoji commits:

```bash
cd /path/to/repo
/path/to/aesthetics/emoji-commits.sh .
```

### When asked about emoji conventions:

Reference the gitmoji standard:
- 🎉 Initial commit
- ✨ New feature
- 🐛 Bug fix
- 📝 Documentation
- 🚀 Deploy
- ♻️ Refactor

### When asked to add new emojis:

1. Edit `emoji-commits.sh`
2. Add to the `EMOJIS` array
3. Ensure no duplicates
4. Follow category organization

### When asked to create new scripts:

1. Create in `scripts/` directory
2. Include help text (`--help` flag)
3. Add safety checks
4. Update README.md
5. Update this AGENTS.md

## Code Style

- Use `set -e` for error handling
- Include usage function
- Add verbose output options
- Use meaningful variable names
- Comment complex logic

## Safety Requirements

All scripts that modify git history MUST:

1. Create file manifests before/after
2. Compute checksums for verification
3. Use `--allow-empty` commits when possible
4. Provide dry-run mode
5. Log all operations

## Testing

Before committing changes:

```bash
# Test emoji-commits on a test repo
mkdir /tmp/test-repo && cd /tmp/test-repo
git init
echo "test" > test.txt
git add . && git commit -m "initial"
/path/to/aesthetics/emoji-commits.sh .
```

## Common Issues

### "Not a git repository"
- Ensure you're in a git-initialized directory
- Run `git init` if needed

### "No files found"
- Check if `.gitignore` excludes files
- Verify the path is correct

### "Duplicate emoji"
- The script has 609 unique emojis
- For repos with >609 files, emojis will repeat

## Contact

- Repository: https://github.com/nirholas/aesthetics
- Issues: https://github.com/nirholas/aesthetics/issues
