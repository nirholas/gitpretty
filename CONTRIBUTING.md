# Contributing to GitPretty

Thank you for your interest in contributing! 🎉

## Ways to Contribute

1. **Report Bugs** - Open an issue with details
2. **Suggest Features** - Open an issue with your idea
3. **Submit PRs** - Fix bugs or add features
4. **Improve Docs** - Help make docs clearer
5. **Add Emojis** - Suggest new emoji categories

## Development Setup

```bash
# Clone the repo
git clone https://github.com/nirholas/gitpretty.git
cd gitpretty

# Make scripts executable
chmod +x *.sh scripts/*.sh

# Create a test repo
mkdir /tmp/test-repo && cd /tmp/test-repo
git init
echo "test" > test.txt
git add . && git commit -m "initial"

# Test changes
/path/to/gitpretty/emoji-commits.sh .
```

## Code Style

### Bash Scripts

- Use `#!/bin/bash` shebang
- Enable strict mode: `set -e`
- Use meaningful variable names
- Add comments for complex logic
- Include usage/help function

```bash
#!/bin/bash
set -e

usage() {
    echo "Usage: $0 <path>"
    exit 1
}

# Main logic here
```

### Commit Messages

Follow gitmoji conventions:

- ✨ `:sparkles:` New feature
- 🐛 `:bug:` Bug fix
- 📝 `:memo:` Documentation
- ♻️ `:recycle:` Refactor
- 🔧 `:wrench:` Configuration

Example:
```
✨ Add new script for changelog generation
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Test thoroughly
5. Commit with emoji prefix
6. Push and open PR
7. Wait for review

## Adding New Scripts

When adding a new script:

1. Create in `scripts/` directory
2. Include `--help` flag
3. Add safety checks
4. Update README.md
5. Update AGENTS.md
6. Update llms-full.txt
7. Add examples in docs/

## Adding New Emojis

To add emojis to `emoji-commits.sh`:

1. Choose appropriate category
2. Ensure no duplicates
3. Avoid faces and rainbows (aesthetic rule)
4. Update count in README.md
5. Test with a repository

## Testing

Before submitting:

```bash
# Test emoji-commits
./emoji-commits.sh /tmp/test-repo

# Test other scripts
./scripts/repo-stats.sh /tmp/test-repo
./scripts/git-beautify.sh

# Verify no shellcheck warnings
shellcheck *.sh scripts/*.sh
```

## Questions?

Open an issue or reach out!

---

Thank you for contributing! ✨




