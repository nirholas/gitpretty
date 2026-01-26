#!/bin/bash

# repo-stats.sh - Display beautiful repository statistics
# Part of the Aesthetics toolkit

set -e

usage() {
    echo "📊 repo-stats.sh - Beautiful repository statistics"
    echo ""
    echo "Usage: $0 [repository-path]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --verbose  Show detailed statistics"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/repo"
    echo "  $0  # uses current directory"
    exit 0
}

# Parse arguments
VERBOSE=false
REPO_PATH="."

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) usage ;;
        -v|--verbose) VERBOSE=true; shift ;;
        *) REPO_PATH="$1"; shift ;;
    esac
done

cd "$REPO_PATH"

# Verify git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not a git repository"
    exit 1
fi

REPO_NAME=$(basename "$(pwd)")

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Progress bar function
progress_bar() {
    local percent=$1
    local width=30
    local filled=$((percent * width / 100))
    local empty=$((width - filled))
    printf "["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] %3d%%" "$percent"
}

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  📊 ${PURPLE}Repository Statistics${NC}                                ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}     ${YELLOW}$REPO_NAME${NC}$(printf '%*s' $((40 - ${#REPO_NAME})) '')${CYAN}║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Basic stats
TOTAL_FILES=$(find . -type f -not -path './.git/*' | wc -l)
TOTAL_DIRS=$(find . -type d -not -path './.git/*' -not -path './.git' | wc -l)
TOTAL_COMMITS=$(git rev-list --count HEAD 2>/dev/null || echo "0")
TOTAL_BRANCHES=$(git branch -a 2>/dev/null | wc -l)
TOTAL_TAGS=$(git tag 2>/dev/null | wc -l)
CONTRIBUTORS=$(git log --format='%aN' 2>/dev/null | sort -u | wc -l)

echo -e "${GREEN}📁 Files${NC}"
echo -e "   Total files:       ${YELLOW}$TOTAL_FILES${NC}"
echo -e "   Total directories: ${YELLOW}$TOTAL_DIRS${NC}"
echo ""

echo -e "${GREEN}📝 Git History${NC}"
echo -e "   Total commits:     ${YELLOW}$TOTAL_COMMITS${NC}"
echo -e "   Branches:          ${YELLOW}$TOTAL_BRANCHES${NC}"
echo -e "   Tags:              ${YELLOW}$TOTAL_TAGS${NC}"
echo -e "   Contributors:      ${YELLOW}$CONTRIBUTORS${NC}"
echo ""

# File type distribution
echo -e "${GREEN}📊 File Types${NC}"

# Count files by extension
declare -A EXT_COUNT
while IFS= read -r file; do
    ext="${file##*.}"
    if [[ "$ext" == "$file" ]]; then
        ext="(no ext)"
    else
        ext=".$ext"
    fi
    ((EXT_COUNT[$ext]++)) || EXT_COUNT[$ext]=1
done < <(find . -type f -not -path './.git/*' -printf '%f\n')

# Sort and display top 10
echo ""
sorted_exts=$(for ext in "${!EXT_COUNT[@]}"; do
    echo "${EXT_COUNT[$ext]} $ext"
done | sort -rn | head -10)

max_count=$(echo "$sorted_exts" | head -1 | awk '{print $1}')

while IFS= read -r line; do
    count=$(echo "$line" | awk '{print $1}')
    ext=$(echo "$line" | awk '{print $2}')
    percent=$((count * 100 / TOTAL_FILES))
    bar_percent=$((count * 100 / max_count))
    
    printf "   ${CYAN}%-10s${NC} %4d files  " "$ext" "$count"
    progress_bar $bar_percent
    echo ""
done <<< "$sorted_exts"

echo ""

# Recent activity
echo -e "${GREEN}🕐 Recent Activity${NC}"
echo ""

git log --oneline -5 2>/dev/null | while read -r line; do
    echo -e "   ${BLUE}•${NC} $line"
done

echo ""

# Size info
if [[ "$VERBOSE" == "true" ]]; then
    echo -e "${GREEN}💾 Repository Size${NC}"
    REPO_SIZE=$(du -sh . 2>/dev/null | cut -f1)
    GIT_SIZE=$(du -sh .git 2>/dev/null | cut -f1)
    echo -e "   Total size:     ${YELLOW}$REPO_SIZE${NC}"
    echo -e "   .git folder:    ${YELLOW}$GIT_SIZE${NC}"
    echo ""
fi

echo -e "${CYAN}══════════════════════════════════════════════════════════${NC}"
echo ""

