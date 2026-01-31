#!/bin/bash

# emoji-merge.sh - Merge branches with emoji commit messages
# Beautiful merge commits

set -e

usage() {
    echo "🔀 emoji-merge.sh - Merge with emoji commit messages"
    echo ""
    echo "Usage: $0 <branch> [--squash]"
    echo ""
    echo "Options:"
    echo "  --squash    Squash all commits into one"
    echo "  --no-ff     Force merge commit (no fast-forward)"
    echo ""
    echo "Auto-detects branch type from name:"
    echo "  feature/*   → ✨ Merge feature"
    echo "  fix/*       → 🐛 Merge fix"
    echo "  hotfix/*    → 🚑 Merge hotfix"
    echo "  docs/*      → 📝 Merge docs"
    echo "  refactor/*  → ♻️  Merge refactor"
    echo "  release/*   → 🚀 Merge release"
    echo ""
    echo "Examples:"
    echo "  $0 feature/user-auth"
    echo "  $0 fix/login-bug --squash"
    exit 0
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z "$1" ]; then
    usage
fi

BRANCH="$1"
SQUASH=""
NOFF=""

# Parse options
for arg in "$@"; do
    case $arg in
        --squash) SQUASH="--squash" ;;
        --no-ff) NOFF="--no-ff" ;;
    esac
done

# Detect emoji from branch name
case "$BRANCH" in
    feature/*|feat/*) EMOJI="✨"; TYPE="feature" ;;
    fix/*|bugfix/*) EMOJI="🐛"; TYPE="fix" ;;
    hotfix/*) EMOJI="🚑"; TYPE="hotfix" ;;
    docs/*) EMOJI="📝"; TYPE="docs" ;;
    refactor/*) EMOJI="♻️"; TYPE="refactor" ;;
    release/*) EMOJI="🚀"; TYPE="release" ;;
    style/*) EMOJI="💄"; TYPE="style" ;;
    perf/*) EMOJI="⚡"; TYPE="perf" ;;
    test/*) EMOJI="✅"; TYPE="test" ;;
    chore/*) EMOJI="🔧"; TYPE="chore" ;;
    wip/*) EMOJI="🚧"; TYPE="wip" ;;
    *) EMOJI="🔀"; TYPE="branch" ;;
esac

# Extract branch description
DESC=$(echo "$BRANCH" | sed 's/.*\///' | tr '-' ' ')

echo "🔀 Merging: $BRANCH"
echo "   $EMOJI Merge $TYPE: $DESC"
echo ""

# Check if branch exists
if ! git rev-parse --verify "$BRANCH" > /dev/null 2>&1; then
    echo "❌ Branch not found: $BRANCH"
    exit 1
fi

# Show commits to be merged
echo "📝 Commits to merge:"
git log --oneline HEAD.."$BRANCH" | head -10
echo ""

read -p "Proceed with merge? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -n "$SQUASH" ]; then
        git merge "$BRANCH" --squash
        git commit -m "$EMOJI Merge $TYPE: $DESC"
        echo "✅ Squash merged: $BRANCH"
    else
        git merge "$BRANCH" $NOFF -m "$EMOJI Merge $TYPE: $DESC"
        echo "✅ Merged: $BRANCH"
    fi
    
    echo ""
    read -p "Delete branch $BRANCH? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git branch -d "$BRANCH"
        echo "🗑️  Branch deleted"
    fi
fi


