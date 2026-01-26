#!/bin/bash

# git-beautify.sh - Beautify git log with semantic emoji prefixes
# Part of the Aesthetics toolkit

set -e

usage() {
    echo "🌈 git-beautify.sh - Beautified git log output"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -l, --limit N      Number of commits to show (default: 20)"
    echo "  -f, --format FMT   Output format: oneline, full (default: oneline)"
    echo "  -s, --since DATE   Show commits since date"
    echo "  -a, --author NAME  Filter by author"
    echo "  -h, --help         Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --limit 10"
    echo "  $0 --since '1 week ago'"
    exit 0
}

# Defaults
LIMIT=20
FORMAT="oneline"
SINCE=""
AUTHOR=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -l|--limit) LIMIT="$2"; shift 2 ;;
        -f|--format) FORMAT="$2"; shift 2 ;;
        -s|--since) SINCE="$2"; shift 2 ;;
        -a|--author) AUTHOR="$2"; shift 2 ;;
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
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m'

# Emoji mapping for commit types
get_emoji() {
    local msg="$1"
    msg_lower=$(echo "$msg" | tr '[:upper:]' '[:lower:]')
    
    # Check if already has emoji (starts with emoji)
    if [[ "$msg" =~ ^[🎉✨🐛🔥📝🚀💄♻️🔧✅🔒⬆️⬇️🏗️📦] ]]; then
        echo ""
        return
    fi
    
    case "$msg_lower" in
        *"initial"*|*"first commit"*) echo "🎉 " ;;
        *"feat"*|*"feature"*|*"add"*|*"new"*) echo "✨ " ;;
        *"fix"*|*"bug"*|*"patch"*) echo "🐛 " ;;
        *"remove"*|*"delete"*) echo "🔥 " ;;
        *"doc"*|*"readme"*) echo "📝 " ;;
        *"deploy"*|*"release"*) echo "🚀 " ;;
        *"style"*|*"css"*|*"ui"*) echo "💄 " ;;
        *"refactor"*|*"clean"*) echo "♻️  " ;;
        *"config"*|*"setting"*) echo "🔧 " ;;
        *"test"*) echo "✅ " ;;
        *"security"*|*"auth"*) echo "🔒 " ;;
        *"upgrade"*|*"update"*|*"bump"*) echo "⬆️  " ;;
        *"downgrade"*) echo "⬇️  " ;;
        *"build"*|*"package"*) echo "📦 " ;;
        *"merge"*) echo "🔀 " ;;
        *"wip"*|*"progress"*) echo "🚧 " ;;
        *"hotfix"*|*"critical"*) echo "🚑 " ;;
        *"revert"*) echo "⏪ " ;;
        *) echo "💠 " ;;
    esac
}

# Build git log command
GIT_CMD="git log"
[[ -n "$LIMIT" ]] && GIT_CMD="$GIT_CMD -n $LIMIT"
[[ -n "$SINCE" ]] && GIT_CMD="$GIT_CMD --since='$SINCE'"
[[ -n "$AUTHOR" ]] && GIT_CMD="$GIT_CMD --author='$AUTHOR'"

REPO_NAME=$(basename "$(pwd)")

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  🌈 ${PURPLE}Git Log - Beautified${NC}                                 ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}     ${YELLOW}$REPO_NAME${NC}$(printf '%*s' $((40 - ${#REPO_NAME})) '')${CYAN}║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

if [[ "$FORMAT" == "full" ]]; then
    eval "$GIT_CMD --format='%H|%an|%ar|%s'" | while IFS='|' read -r hash author date msg; do
        emoji=$(get_emoji "$msg")
        short_hash="${hash:0:7}"
        echo -e "${YELLOW}$short_hash${NC} ${GRAY}($date)${NC}"
        echo -e "  ${emoji}${msg}"
        echo -e "  ${GRAY}— $author${NC}"
        echo ""
    done
else
    eval "$GIT_CMD --format='%h|%ar|%s'" | while IFS='|' read -r hash date msg; do
        emoji=$(get_emoji "$msg")
        echo -e "${YELLOW}$hash${NC} ${emoji}${msg} ${GRAY}($date)${NC}"
    done
fi

echo ""
echo -e "${CYAN}══════════════════════════════════════════════════════════${NC}"
echo -e "  ${GRAY}Showing $LIMIT commits${NC}"
echo ""


