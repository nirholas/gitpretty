#!/bin/bash

# emoji-tag.sh - Create release tags with emojis
# Beautiful versioned releases

set -e

usage() {
    echo "🏷️  emoji-tag.sh - Create emoji release tags"
    echo ""
    echo "Usage: $0 <version> [type]"
    echo ""
    echo "Types:"
    echo "  major      💥 Breaking changes"
    echo "  minor      ✨ New features (default)"
    echo "  patch      🐛 Bug fixes"
    echo "  hotfix     🚑 Critical fix"
    echo "  alpha      🧪 Alpha release"
    echo "  beta       🔬 Beta release"
    echo "  rc         🎯 Release candidate"
    echo ""
    echo "Examples:"
    echo "  $0 1.0.0              # Default: ✨ Release"
    echo "  $0 2.0.0 major        # 💥 Breaking release"
    echo "  $0 1.1.0 minor        # ✨ Feature release"
    echo "  $0 1.0.1 patch        # 🐛 Patch release"
    echo "  $0 1.0.0-alpha.1 alpha"
    exit 0
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z "$1" ]; then
    usage
fi

VERSION="$1"
TYPE="${2:-minor}"

# Map type to emoji and message
case "$TYPE" in
    major) EMOJI="💥"; MSG="Breaking Release" ;;
    minor) EMOJI="✨"; MSG="Feature Release" ;;
    patch) EMOJI="🐛"; MSG="Patch Release" ;;
    hotfix) EMOJI="🚑"; MSG="Hotfix Release" ;;
    alpha) EMOJI="🧪"; MSG="Alpha Release" ;;
    beta) EMOJI="🔬"; MSG="Beta Release" ;;
    rc) EMOJI="🎯"; MSG="Release Candidate" ;;
    *) EMOJI="🚀"; MSG="Release" ;;
esac

TAG="v${VERSION}"

echo "🏷️  Creating tag: $TAG"
echo "   $EMOJI $MSG $VERSION"
echo ""

# Generate release notes
NOTES=$(cat << EOF
$EMOJI $MSG $VERSION

## What's New

$(git log $(git describe --tags --abbrev=0 2>/dev/null || echo "HEAD~10")..HEAD --oneline --format="- %s" 2>/dev/null | head -20)

---
_Tagged with [aesthetics](https://github.com/nirholas/aesthetics)_
EOF
)

echo "$NOTES"
echo ""

read -p "Create this tag? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git tag -a "$TAG" -m "$EMOJI $MSG $VERSION"
    echo ""
    echo "✅ Tag created: $TAG"
    echo ""
    echo "📤 Push with: git push origin $TAG"
    echo "🌐 Or push all tags: git push --tags"
fi


