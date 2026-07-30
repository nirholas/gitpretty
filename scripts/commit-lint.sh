#!/bin/bash

# commit-lint.sh - Lint commits for proper emoji conventions
# Part of the Aesthetics toolkit

set -e

usage() {
    echo "✅ commit-lint.sh - Validate emoji commit conventions"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -n, --last N     Check last N commits (default: 10)"
    echo "  -s, --strict     Fail on any violation"
    echo "  --fix            Suggest fixes for violations"
    echo "  -h, --help       Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --last 20 --strict"
    exit 0
}

# Defaults
LAST=10
STRICT=false
FIX=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--last) LAST="$2"; shift 2 ;;
        -s|--strict) STRICT=true; shift ;;
        --fix) FIX=true; shift ;;
        -h|--help) usage ;;
        *) shift ;;
    esac
done

# Verify git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not a git repository"
    exit 1
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Valid gitmoji prefixes
VALID_EMOJIS=(
    "🎉" "✨" "🐛" "🔥" "📝" "🚀" "💄" "♻️" "🔧" "✅"
    "🔒" "⬆️" "⬇️" "🏗️" "📦" "🔀" "🚧" "🚑" "⏪" "💚"
    "👷" "📌" "🚨" "🗑️" "💩" "🌐" "💡" "🍻" "💬" "🗃️"
    "🔊" "🔇" "👥" "🚸" "📱" "🤡" "🥚" "🙈" "📸" "⚗️"
    "🔍" "🏷️" "🌱" "🚩" "🥅" "💫" "⚰️" "🧪" "👔" "🩺"
    "🧱" "🧵" "🦺" "⭐" "🌟" "💎" "🔷" "🔶" "💠"
)

# Check if string starts with emoji
has_emoji() {
    local msg="$1"
    # Check for common emoji patterns
    if [[ "$msg" =~ ^[🎉✨🐛🔥📝🚀💄♻️🔧✅🔒⬆️⬇️🏗️📦🔀🚧🚑⏪💚👷📌🚨🗑️💩🌐💡🍻💬🗃️🔊🔇👥🚸📱🤡🥚🙈📸⚗️🔍🏷️🌱🚩🥅💫⚰️🧪👔🩺🧱🧵🦺⭐🌟💎🔷🔶💠] ]]; then
        return 0
    fi
    return 1
}

# Suggest emoji for message
suggest_emoji() {
    local msg="$1"
    msg_lower=$(echo "$msg" | tr '[:upper:]' '[:lower:]')
    
    case "$msg_lower" in
        *"initial"*|*"first"*) echo "🎉" ;;
        *"feat"*|*"feature"*|*"add"*|*"new"*) echo "✨" ;;
        *"fix"*|*"bug"*|*"patch"*) echo "🐛" ;;
        *"remove"*|*"delete"*) echo "🔥" ;;
        *"doc"*|*"readme"*) echo "📝" ;;
        *"deploy"*|*"release"*) echo "🚀" ;;
        *"style"*|*"css"*|*"ui "*|*" ui"*|*"ui:"*) echo "💄" ;;
        *"refactor"*|*"clean"*) echo "♻️" ;;
        *"config"*|*"setting"*) echo "🔧" ;;
        *"test"*) echo "✅" ;;
        *"security"*) echo "🔒" ;;
        *"build"*|*"package"*) echo "📦" ;;
        *"upgrade"*|*"update"*|*"bump"*) echo "⬆️" ;;
        *"downgrade"*) echo "⬇️" ;;
        *"merge"*) echo "🔀" ;;
        *"wip"*) echo "🚧" ;;
        *"revert"*) echo "⏪" ;;
        *) echo "✨" ;;
    esac
}

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ✅ ${BLUE}Commit Lint${NC}                                           ${CYAN}║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

PASS=0
FAIL=0
WARNINGS=0

git log --oneline -n "$LAST" --format="%h|%s" | while IFS='|' read -r hash msg; do
    if has_emoji "$msg"; then
        echo -e "${GREEN}✓${NC} ${YELLOW}$hash${NC} $msg"
        ((PASS++)) || true
    else
        echo -e "${RED}✗${NC} ${YELLOW}$hash${NC} $msg"
        ((FAIL++)) || true
        
        if [[ "$FIX" == "true" ]]; then
            suggested=$(suggest_emoji "$msg")
            echo -e "  ${BLUE}↳ Suggested: ${suggested} ${msg}${NC}"
        fi
    fi
done

echo ""
echo -e "${CYAN}══════════════════════════════════════════════════════════${NC}"

# Count results
PASS_COUNT=$(git log --oneline -n "$LAST" --format="%s" | grep -cE "^[🎉✨🐛🔥📝🚀💄♻️🔧✅🔒⬆️⬇️🏗️📦🔀🚧🚑⏪]" || true)
FAIL_COUNT=$((LAST - PASS_COUNT))

echo ""
echo -e "  ${GREEN}Passed:${NC} $PASS_COUNT"
echo -e "  ${RED}Failed:${NC} $FAIL_COUNT"
echo ""

if [[ "$STRICT" == "true" && $FAIL_COUNT -gt 0 ]]; then
    echo -e "${RED}❌ Strict mode: $FAIL_COUNT commits without emoji prefix${NC}"
    exit 1
fi

if [[ $FAIL_COUNT -eq 0 ]]; then
    echo -e "${GREEN}✅ All commits follow emoji conventions!${NC}"
fi
echo ""




