#!/bin/bash

# emoji-hooks.sh - Install git hooks with emoji goodness
# Automated emoji validation and suggestions

set -e

HOOKS_DIR=".git/hooks"

usage() {
    echo "🪝 emoji-hooks.sh - Git hooks with emojis"
    echo ""
    echo "Usage: $0 <command>"
    echo ""
    echo "Commands:"
    echo "  install     - Install all emoji git hooks"
    echo "  uninstall   - Remove emoji git hooks"
    echo "  list        - Show installed hooks"
    echo "  status      - Check hook status"
    echo ""
    echo "Hooks installed:"
    echo "  commit-msg  - Validate/add emoji to commit messages"
    echo "  pre-push    - Show summary before push"
    echo "  post-commit - Celebration message"
    echo ""
    exit 0
}

# Check if in git repo
check_git() {
    if [ ! -d ".git" ]; then
        echo "❌ Not a git repository"
        exit 1
    fi
}

install_commit_msg_hook() {
    cat > "$HOOKS_DIR/commit-msg" << 'HOOK'
#!/bin/bash
# emoji-hooks: commit-msg - Ensure commits have emojis

MSG_FILE=$1
MSG=$(cat "$MSG_FILE")

# Common emojis for auto-detection
declare -A KEYWORDS=(
    ["feat"]="✨" ["add"]="✨" ["new"]="✨"
    ["fix"]="🐛" ["bug"]="🐛" ["issue"]="🐛"
    ["docs"]="📝" ["readme"]="📝" ["doc"]="📝"
    ["style"]="💄" ["format"]="💄" ["lint"]="💄"
    ["refactor"]="♻️" ["clean"]="♻️"
    ["test"]="✅" ["spec"]="✅"
    ["chore"]="🔧" ["config"]="⚙️"
    ["perf"]="⚡" ["optimize"]="⚡"
    ["security"]="🔐" ["auth"]="🔐"
    ["remove"]="🗑️" ["delete"]="🗑️"
    ["init"]="🎉" ["initial"]="🎉"
    ["wip"]="🚧" ["progress"]="🚧"
    ["deploy"]="🚀" ["release"]="🚀"
    ["merge"]="🔀"
    ["update"]="📝" ["change"]="📝"
)

# Check if message already has emoji (check first 4 chars for emoji)
FIRST_CHAR="${MSG:0:4}"
if [[ "$FIRST_CHAR" =~ [🎉✨🐛📝💄♻️⚡✅🔧🚧🚀🔐🗑️⚙️🔀📦🏗️👷⏪] ]]; then
    exit 0  # Already has emoji
fi

# Try to auto-detect appropriate emoji
MSG_LOWER="${MSG,,}"
EMOJI=""

for keyword in "${!KEYWORDS[@]}"; do
    if [[ "$MSG_LOWER" == *"$keyword"* ]]; then
        EMOJI="${KEYWORDS[$keyword]}"
        break
    fi
done

# Default emoji if none detected
EMOJI="${EMOJI:-✨}"

# Prepend emoji to message
echo "$EMOJI $MSG" > "$MSG_FILE"
echo "🪝 Auto-added emoji: $EMOJI"
HOOK
    chmod +x "$HOOKS_DIR/commit-msg"
    echo "  ✅ commit-msg hook installed"
}

install_pre_push_hook() {
    cat > "$HOOKS_DIR/pre-push" << 'HOOK'
#!/bin/bash
# emoji-hooks: pre-push - Summary before pushing

REMOTE=$1
URL=$2

echo ""
echo "🚀 Preparing to push to $REMOTE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Count commits to push
BRANCH=$(git branch --show-current)
COMMITS=$(git log --oneline @{u}..HEAD 2>/dev/null | wc -l || echo "?")

if [ "$COMMITS" != "?" ] && [ "$COMMITS" -gt 0 ]; then
    echo "📦 Commits to push: $COMMITS"
    echo ""
    git log --oneline @{u}..HEAD 2>/dev/null | head -10
    if [ "$COMMITS" -gt 10 ]; then
        echo "... and $((COMMITS - 10)) more"
    fi
else
    echo "📦 Pushing branch: $BRANCH"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

exit 0
HOOK
    chmod +x "$HOOKS_DIR/pre-push"
    echo "  ✅ pre-push hook installed"
}

install_post_commit_hook() {
    cat > "$HOOKS_DIR/post-commit" << 'HOOK'
#!/bin/bash
# emoji-hooks: post-commit - Celebration!

# Random celebration emojis
CELEBRATIONS=("🎉" "🎊" "✨" "🌟" "💫" "⭐" "🏆" "🥳" "👏" "💪")
EMOJI=${CELEBRATIONS[$RANDOM % ${#CELEBRATIONS[@]}]}

MSG=$(git log -1 --pretty=%s)
echo ""
echo "$EMOJI Committed: $MSG"
HOOK
    chmod +x "$HOOKS_DIR/post-commit"
    echo "  ✅ post-commit hook installed"
}

cmd_install() {
    check_git
    echo "🪝 Installing emoji git hooks..."
    echo ""
    
    mkdir -p "$HOOKS_DIR"
    
    install_commit_msg_hook
    install_pre_push_hook
    install_post_commit_hook
    
    echo ""
    echo "✅ All hooks installed!"
    echo ""
    echo "Your commits will now:"
    echo "  📝 Auto-add emojis to commit messages"
    echo "  🚀 Show push summary before pushing"
    echo "  🎉 Celebrate after each commit"
}

cmd_uninstall() {
    check_git
    echo "🗑️  Removing emoji git hooks..."
    
    rm -f "$HOOKS_DIR/commit-msg"
    rm -f "$HOOKS_DIR/pre-push"
    rm -f "$HOOKS_DIR/post-commit"
    
    echo "✅ Hooks removed!"
}

cmd_list() {
    check_git
    echo "🪝 Installed Hooks"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    for hook in "$HOOKS_DIR"/*; do
        if [ -f "$hook" ] && [ -x "$hook" ]; then
            NAME=$(basename "$hook")
            if grep -q "emoji-hooks" "$hook" 2>/dev/null; then
                echo "  🎨 $NAME (emoji-hooks)"
            else
                echo "  📄 $NAME"
            fi
        fi
    done
}

cmd_status() {
    check_git
    echo "🪝 Hook Status"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    HOOKS=("commit-msg" "pre-push" "post-commit")
    
    for hook in "${HOOKS[@]}"; do
        if [ -f "$HOOKS_DIR/$hook" ] && grep -q "emoji-hooks" "$HOOKS_DIR/$hook" 2>/dev/null; then
            echo "  ✅ $hook - active"
        elif [ -f "$HOOKS_DIR/$hook" ]; then
            echo "  ⚠️  $hook - exists (not emoji-hooks)"
        else
            echo "  ❌ $hook - not installed"
        fi
    done
}

# Main
case "${1:-help}" in
    install|i)      cmd_install ;;
    uninstall|u)    cmd_uninstall ;;
    list|l|ls)      cmd_list ;;
    status|s)       cmd_status ;;
    -h|--help|help) usage ;;
    *)              usage ;;
esac

