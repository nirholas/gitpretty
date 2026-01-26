#!/bin/bash

# emoji-branch.sh - Create branches with emoji prefixes
# Makes your branch list beautiful and descriptive

set -e

usage() {
    echo "🌿 emoji-branch.sh - Create emoji-prefixed branches"
    echo ""
    echo "Usage: $0 <type> <name>"
    echo ""
    echo "Types:"
    echo "  feature, feat    ✨ New feature"
    echo "  fix, bugfix      🐛 Bug fix"
    echo "  hotfix           🚑 Critical hotfix"
    echo "  docs             📝 Documentation"
    echo "  style            💄 UI/Style"
    echo "  refactor         ♻️  Refactoring"
    echo "  perf             ⚡ Performance"
    echo "  test             ✅ Tests"
    echo "  build            📦 Build"
    echo "  ci               👷 CI/CD"
    echo "  chore            🔧 Chores"
    echo "  wip              🚧 Work in progress"
    echo "  release          🚀 Release"
    echo "  security         🔒 Security"
    echo "  experiment       ⚗️  Experiment"
    echo ""
    echo "Examples:"
    echo "  $0 feature user-auth"
    echo "  $0 fix login-bug"
    echo "  $0 hotfix critical-patch"
    exit 0
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z "$1" ] || [ -z "$2" ]; then
    usage
fi

TYPE="$1"
NAME="$2"

# Map type to emoji
case "$TYPE" in
    feature|feat) EMOJI="✨"; PREFIX="feature" ;;
    fix|bugfix) EMOJI="🐛"; PREFIX="fix" ;;
    hotfix) EMOJI="🚑"; PREFIX="hotfix" ;;
    docs|documentation) EMOJI="📝"; PREFIX="docs" ;;
    style|ui) EMOJI="💄"; PREFIX="style" ;;
    refactor) EMOJI="♻️"; PREFIX="refactor" ;;
    perf|performance) EMOJI="⚡"; PREFIX="perf" ;;
    test|tests) EMOJI="✅"; PREFIX="test" ;;
    build) EMOJI="📦"; PREFIX="build" ;;
    ci) EMOJI="👷"; PREFIX="ci" ;;
    chore) EMOJI="🔧"; PREFIX="chore" ;;
    wip) EMOJI="🚧"; PREFIX="wip" ;;
    release) EMOJI="🚀"; PREFIX="release" ;;
    security|sec) EMOJI="🔒"; PREFIX="security" ;;
    experiment|exp) EMOJI="⚗️"; PREFIX="experiment" ;;
    *) 
        echo "❌ Unknown type: $TYPE"
        echo "Run '$0 --help' for available types"
        exit 1
        ;;
esac

# Create branch name (emoji in commit, clean name for branch)
BRANCH_NAME="${PREFIX}/${NAME}"

echo "🌿 Creating branch: $BRANCH_NAME"

git checkout -b "$BRANCH_NAME"

echo ""
echo "✅ Branch created: $BRANCH_NAME"
echo ""
echo "💡 When you commit, use: git commit -m \"$EMOJI Your message\""
echo ""

# Create initial commit
read -p "Create initial commit? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git commit --allow-empty -m "$EMOJI Start $PREFIX: $NAME"
    echo "✅ Initial commit created"
fi
