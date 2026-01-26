# 📚 GitPretty Setup Guide

Complete guide to setting up emoji-powered git workflows for beautiful repositories.

## 🚀 Quick Start (5 minutes)

### 1. Clone the Repository

```bash
git clone https://github.com/nirholas/gitpretty.git
cd gitpretty
```

### 2. Make Scripts Executable

```bash
chmod +x *.sh scripts/*.sh
```

### 3. Add to PATH (Optional but Recommended)

```bash
# Add to your ~/.bashrc or ~/.zshrc
export PATH="$PATH:/path/to/gitpretty"
export PATH="$PATH:/path/to/gitpretty/scripts"
```

### 4. Run Your First Emoji Commit

```bash
# Beautify an existing repo
cd /path/to/your/repo
/path/to/gitpretty/emoji-file-commits.sh

# Or use the smart commit tool
/path/to/gitpretty/scripts/emoji-commit.sh "add awesome feature"
```

---

## 🎯 Installation Scenarios

### Scenario 1: Personal Projects

For your own repos where you have full control:

```bash
# 1. Navigate to your project
cd ~/projects/my-awesome-project

# 2. Install git hooks for automatic emojis
/path/to/gitpretty/scripts/emoji-hooks.sh install

# 3. Every commit now gets auto-emoji! 🎉
git add .
git commit -m "add login feature"
# → ✨ add login feature
```

### Scenario 2: Team Projects

For collaborative repos with conventional commits:

```bash
# 1. Copy the GitHub Action to your repo
mkdir -p .github/workflows
cp /path/to/gitpretty/.github/workflows/commit-lint.yml .github/workflows/

# 2. Now PRs without emojis will be flagged
# Team members can use emoji-commit.sh locally
```

### Scenario 3: Beautify Existing Repo

Transform a plain repo into an emoji masterpiece:

```bash
# Option A: Safe mode (empty commits, preserves history)
cd /path/to/existing-repo
/path/to/gitpretty/emoji-commits.sh

# Option B: Visible emojis (modifies files, shows in GitHub UI)
/path/to/gitpretty/emoji-file-commits.sh
```

### Scenario 4: CI/CD Integration

Auto-emoji on every push:

```bash
# Copy the workflow
cp /path/to/gitpretty/.github/workflows/emoji-commits.yml .github/workflows/

# Commits pushed to main will get emoji beautification
```

---

## 📁 Full Installation

### System-Wide Installation

```bash
# 1. Clone to a permanent location
sudo git clone https://github.com/nirholas/gitpretty.git /opt/gitpretty

# 2. Create symlinks
sudo ln -s /opt/gitpretty/scripts/emoji-commit.sh /usr/local/bin/emoji-commit
sudo ln -s /opt/gitpretty/scripts/emoji-stash.sh /usr/local/bin/emoji-stash
sudo ln -s /opt/gitpretty/scripts/emoji-log.sh /usr/local/bin/emoji-log
sudo ln -s /opt/gitpretty/scripts/emoji-branch.sh /usr/local/bin/emoji-branch
sudo ln -s /opt/gitpretty/scripts/emoji-tag.sh /usr/local/bin/emoji-tag
sudo ln -s /opt/gitpretty/scripts/emoji-merge.sh /usr/local/bin/emoji-merge
sudo ln -s /opt/gitpretty/scripts/emoji-hooks.sh /usr/local/bin/emoji-hooks

# 3. Now available everywhere!
emoji-commit "add feature"
emoji-stash save wip "working on auth"
emoji-log graph
```

### Per-User Installation

```bash
# 1. Clone to home directory
git clone https://github.com/nirholas/gitpretty.git ~/.gitpretty

# 2. Add to PATH in ~/.bashrc or ~/.zshrc
echo 'export PATH="$PATH:$HOME/.gitpretty:$HOME/.gitpretty/scripts"' >> ~/.bashrc
source ~/.bashrc

# 3. Use anywhere!
emoji-commit.sh "fix bug"
```

### Per-Project Installation

```bash
# 1. Add as git submodule
git submodule add https://github.com/nirholas/gitpretty.git tools/gitpretty

# 2. Reference in package.json scripts
{
  "scripts": {
    "commit": "./tools/gitpretty/scripts/emoji-commit.sh",
    "beautify": "./tools/gitpretty/emoji-file-commits.sh"
  }
}
```

---

## ⚙️ Configuration

### Git Aliases

Add these to your `~/.gitconfig`:

```ini
[alias]
    # Emoji commit
    ec = "!f() { ~/.gitpretty/scripts/emoji-commit.sh \"$@\"; }; f"
    
    # Emoji log
    el = "!~/.gitpretty/scripts/emoji-log.sh"
    elg = "!~/.gitpretty/scripts/emoji-log.sh graph"
    elt = "!~/.gitpretty/scripts/emoji-log.sh today"
    
    # Emoji stash
    es = "!~/.gitpretty/scripts/emoji-stash.sh"
    esl = "!~/.gitpretty/scripts/emoji-stash.sh list"
    
    # Emoji branch
    eb = "!~/.gitpretty/scripts/emoji-branch.sh"
    
    # Emoji merge
    em = "!~/.gitpretty/scripts/emoji-merge.sh"
```

Usage:
```bash
git ec "add authentication"   # ✨ Add authentication
git el graph -n 20           # Beautiful graph log
git es save wip "testing"    # 🚧 testing
git eb feature user-auth     # Creates feature/user-auth
```

### Shell Aliases

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Quick emoji commit
alias gc='emoji-commit.sh'

# Beautiful log
alias gl='emoji-log.sh'
alias glg='emoji-log.sh graph'
alias glt='emoji-log.sh today'

# Stash with style
alias gs='emoji-stash.sh'
alias gsl='emoji-stash.sh list'

# Branches
alias gb='emoji-branch.sh'

# Tags
alias gt='emoji-tag.sh'
```

---

## 🔧 Customization

### Custom Emoji Sets

Create your own emoji mapping in `~/.gitpretty-config`:

```bash
# ~/.gitpretty-config
EMOJI_FEAT="🌟"      # Instead of ✨
EMOJI_FIX="🔨"       # Instead of 🐛
EMOJI_DOCS="📖"      # Instead of 📝
EMOJI_DEFAULT="💎"   # Instead of ✨
```

### Company/Team Standards

Create a team config file:

```bash
# .gitpretty-team
# Emoji standards for ACME Corp

TYPE_EMOJIS=(
    ["feat"]="🚀"
    ["fix"]="🔧"
    ["docs"]="📋"
    ["test"]="🧪"
    ["refactor"]="🔄"
    ["style"]="✨"
    ["chore"]="📦"
)
```

---

## 🔍 Troubleshooting

### Emojis Not Showing in GitHub

**Problem:** Commits show in `git log` but not in GitHub file browser.

**Solution:** Use `emoji-file-commits.sh` instead of `emoji-commits.sh`. This modifies files so changes appear in the GitHub UI.

### Hook Not Running

**Problem:** Commit messages don't get auto-emoji.

**Solution:**
```bash
# Check hook is installed
ls -la .git/hooks/commit-msg

# Check it's executable
chmod +x .git/hooks/commit-msg

# Reinstall hooks
emoji-hooks.sh install
```

### Permission Denied

**Problem:** Scripts won't execute.

**Solution:**
```bash
# Make all scripts executable
chmod +x ~/.gitpretty/*.sh
chmod +x ~/.gitpretty/scripts/*.sh
```

### Emojis Display as Boxes

**Problem:** Emojis show as □ or ?.

**Solution:** Install a font with emoji support:
```bash
# Ubuntu/Debian
sudo apt install fonts-noto-color-emoji

# macOS - emojis work out of the box

# Windows - use Windows Terminal with a modern font
```

---

## 📖 Next Steps

- [GitHub Actions Guide](GITHUB_ACTIONS.md) - Automate emojis in CI/CD
- [Scenarios & Examples](SCENARIOS.md) - Real-world use cases
- [Contributing](../CONTRIBUTING.md) - Help improve the tools

---

💡 **Pro Tip:** Start with `emoji-hooks.sh install` in your favorite project. You'll never want to go back to plain commits!

