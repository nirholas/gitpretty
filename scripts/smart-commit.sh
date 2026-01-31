#!/bin/bash

# smart-commit.sh - AI-style descriptive commit message generator
# Generates Claude Opus 4.5-style comprehensive commit messages

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Gitmoji mapping for conventional commits
declare -A GITMOJI=(
    ["feat"]="✨"
    ["fix"]="🐛"
    ["docs"]="📝"
    ["style"]="💄"
    ["refactor"]="♻️"
    ["perf"]="⚡"
    ["test"]="✅"
    ["chore"]="🔧"
    ["build"]="🏗️"
    ["ci"]="👷"
    ["revert"]="⏪"
    ["wip"]="🚧"
    ["init"]="🎉"
    ["security"]="🔐"
    ["breaking"]="💥"
    ["hotfix"]="🚑"
    ["deploy"]="🚀"
    ["deps"]="📦"
    ["i18n"]="🌐"
    ["types"]="🏷️"
    ["merge"]="🔀"
    ["release"]="🚀"
    ["config"]="⚙️"
    ["db"]="🗃️"
    ["api"]="🔌"
    ["ui"]="🎨"
    ["ux"]="👥"
    ["a11y"]="♿"
    ["infra"]="🏢"
    ["arch"]="🏛️"
)

usage() {
    echo -e "${CYAN}📝 smart-commit.sh - AI-style descriptive commit messages${NC}"
    echo ""
    echo "Usage: $0 <type> [scope] <short-description>"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help"
    echo "  -d, --dry-run  Preview message without committing"
    echo "  -a, --amend    Amend the last commit"
    echo ""
    echo "Types:"
    for key in feat fix docs style refactor perf test chore build ci; do
        printf "  ${GREEN}%-10s${NC} → %s\n" "$key" "${GITMOJI[$key]}"
    done
    echo ""
    echo "Examples:"
    echo "  $0 feat auth \"add OAuth2 login flow\""
    echo "  $0 fix \"resolve race condition in user sync\""
    echo "  $0 refactor db \"optimize query performance\""
    echo ""
    exit 0
}

# Parse arguments
DRY_RUN=false
AMEND=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) usage ;;
        -d|--dry-run) DRY_RUN=true; shift ;;
        -a|--amend) AMEND=true; shift ;;
        *) break ;;
    esac
done

if [[ $# -lt 2 ]]; then
    echo -e "${RED}Error: Not enough arguments${NC}"
    usage
fi

TYPE="$1"
shift

# Check if second arg is a scope (no spaces) or description
if [[ $# -ge 2 && ! "$1" =~ " " ]]; then
    SCOPE="$1"
    shift
    DESCRIPTION="$*"
else
    SCOPE=""
    DESCRIPTION="$*"
fi

# Validate type
if [[ -z "${GITMOJI[$TYPE]}" ]]; then
    echo -e "${RED}Error: Unknown type '$TYPE'${NC}"
    echo "Valid types: ${!GITMOJI[*]}"
    exit 1
fi

EMOJI="${GITMOJI[$TYPE]}"

# Get staged files
STAGED_FILES=$(git diff --cached --name-only 2>/dev/null || echo "")
STAGED_STATS=$(git diff --cached --stat 2>/dev/null || echo "")

if [[ -z "$STAGED_FILES" && "$DRY_RUN" == false ]]; then
    echo -e "${YELLOW}Warning: No staged changes. Stage files first with 'git add'${NC}"
    echo ""
    echo "Modified files:"
    git status --short
    exit 1
fi

# Count changes
INSERTIONS=$(git diff --cached --numstat 2>/dev/null | awk '{sum+=$1} END {print sum+0}')
DELETIONS=$(git diff --cached --numstat 2>/dev/null | awk '{sum+=$2} END {print sum+0}')
FILE_COUNT=$(echo "$STAGED_FILES" | grep -c . || echo "0")

# Analyze file types
declare -A FILE_TYPES
while IFS= read -r file; do
    [[ -z "$file" ]] && continue
    ext="${file##*.}"
    dir=$(dirname "$file" | cut -d'/' -f1)
    ((FILE_TYPES["$ext"]++)) 2>/dev/null || FILE_TYPES["$ext"]=1
done <<< "$STAGED_FILES"

# Generate scope if not provided
if [[ -z "$SCOPE" ]]; then
    # Try to infer scope from file paths
    COMMON_DIR=$(echo "$STAGED_FILES" | head -1 | cut -d'/' -f1)
    if [[ "$COMMON_DIR" == "src" ]]; then
        COMMON_DIR=$(echo "$STAGED_FILES" | head -1 | cut -d'/' -f2)
    fi
    if [[ -n "$COMMON_DIR" && "$COMMON_DIR" != "." ]]; then
        SCOPE="$COMMON_DIR"
    fi
fi

# Build the commit message header
if [[ -n "$SCOPE" ]]; then
    HEADER="$EMOJI $TYPE($SCOPE): $DESCRIPTION"
else
    HEADER="$EMOJI $TYPE: $DESCRIPTION"
fi

# Capitalize first letter of description
HEADER="${HEADER:0:$((${#EMOJI}+${#TYPE}+${#SCOPE}+4))}$(echo "${DESCRIPTION:0:1}" | tr '[:lower:]' '[:upper:]')${DESCRIPTION:1}"

# Generate body
BODY=""

# Add file summary
if [[ $FILE_COUNT -gt 0 ]]; then
    BODY+="### Changes\n\n"
    
    # Group by directory
    declare -A DIR_FILES
    while IFS= read -r file; do
        [[ -z "$file" ]] && continue
        dir=$(dirname "$file")
        [[ -z "${DIR_FILES[$dir]}" ]] && DIR_FILES[$dir]=""
        DIR_FILES[$dir]+="- \`$(basename "$file")\`\n"
    done <<< "$STAGED_FILES"
    
    for dir in "${!DIR_FILES[@]}"; do
        if [[ "$dir" == "." ]]; then
            BODY+="${DIR_FILES[$dir]}"
        else
            BODY+="**$dir/**\n${DIR_FILES[$dir]}"
        fi
        BODY+="\n"
    done
fi

# Add stats
BODY+="### Stats\n\n"
BODY+="- **Files**: $FILE_COUNT\n"
BODY+="- **Insertions**: +$INSERTIONS\n"
BODY+="- **Deletions**: -$DELETIONS\n"

# Format final message
COMMIT_MSG="$HEADER

$BODY"

# Preview or commit
if [[ "$DRY_RUN" == true ]]; then
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}Preview commit message:${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "$COMMIT_MSG"
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}Run without -d to commit${NC}"
else
    if [[ "$AMEND" == true ]]; then
        echo -e "$COMMIT_MSG" | git commit --amend -F -
        echo -e "${GREEN}✅ Amended commit successfully!${NC}"
    else
        echo -e "$COMMIT_MSG" | git commit -F -
        echo -e "${GREEN}✅ Created commit successfully!${NC}"
    fi
    echo ""
    git log -1 --oneline
fi

