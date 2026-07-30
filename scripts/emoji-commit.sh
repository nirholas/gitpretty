#!/bin/bash

# emoji-commit.sh - Smart commit with auto-emoji suggestion
# Analyzes your changes and suggests the perfect emoji

set -e

# Conventional commit type to emoji mapping
declare -A TYPE_EMOJIS=(
    ["feat"]="✨"
    ["feature"]="✨"
    ["fix"]="🐛"
    ["bugfix"]="🐛"
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
    ["add"]="➕"
    ["remove"]="➖"
    ["move"]="🚚"
    ["rename"]="✏️"
    ["security"]="🔐"
    ["breaking"]="💥"
    ["hotfix"]="🚑"
    ["deploy"]="🚀"
    ["config"]="⚙️"
    ["deps"]="📦"
    ["db"]="🗃️"
    ["api"]="🔌"
    ["ui"]="🎨"
    ["ux"]="👥"
    ["i18n"]="🌐"
    ["a11y"]="♿"
    ["merge"]="🔀"
    ["release"]="📦"
)

# File extension to emoji mapping
declare -A FILE_EMOJIS=(
    ["md"]="📝"
    ["txt"]="📄"
    ["json"]="📋"
    ["yml"]="⚙️"
    ["yaml"]="⚙️"
    ["toml"]="⚙️"
    ["ts"]="📘"
    ["tsx"]="⚛️"
    ["js"]="📒"
    ["jsx"]="⚛️"
    ["py"]="🐍"
    ["go"]="🔷"
    ["rs"]="🦀"
    ["rb"]="💎"
    ["sh"]="🐚"
    ["bash"]="🐚"
    ["css"]="🎨"
    ["scss"]="🎨"
    ["html"]="🌐"
    ["sql"]="🗃️"
    ["dockerfile"]="🐳"
    ["lock"]="🔒"
)

usage() {
    echo "💬 emoji-commit.sh - Smart commit with auto-emoji"
    echo ""
    echo "Usage: $0 [type:] <message>"
    echo ""
    echo "Types (optional prefix):"
    for key in "${!TYPE_EMOJIS[@]}"; do
        printf "  %-10s → %s\n" "$key" "${TYPE_EMOJIS[$key]}"
    done | sort
    echo ""
    echo "Examples:"
    echo "  $0 'add user authentication'         # Auto-detects ✨"
    echo "  $0 feat: 'add user authentication'   # Explicit ✨"
    echo "  $0 fix: 'resolve login bug'          # Explicit 🐛"
    echo "  $0 --suggest                         # Show suggestion only"
    echo ""
    exit 0
}

suggest_emoji() {
    local MSG="${1,,}"  # lowercase
    
    # Check for explicit type prefix
    for type in "${!TYPE_EMOJIS[@]}"; do
        if [[ "$MSG" =~ ^$type: ]]; then
            echo "${TYPE_EMOJIS[$type]}"
            return
        fi
    done
    
    # Auto-detect from message keywords
    case "$MSG" in
        *"initial"*|*"init"*) echo "🎉" ;;
        *"add"*|*"create"*|*"new"*) echo "✨" ;;
        *"fix"*|*"bug"*|*"issue"*|*"error"*) echo "🐛" ;;
        *"remove"*|*"delete"*|*"clean"*) echo "🗑️" ;;
        *"update"*|*"change"*|*"modify"*) echo "📝" ;;
        *"refactor"*|*"restructure"*) echo "♻️" ;;
        *"test"*|*"spec"*) echo "✅" ;;
        *"doc"*|*"readme"*|*"comment"*) echo "📝" ;;
        *"style"*|*"format"*|*"lint"*) echo "💄" ;;
        *"config"*|*"setting"*) echo "⚙️" ;;
        *"security"*|*"auth"*|*"encrypt"*) echo "🔐" ;;
        *"deploy"*|*"release"*|*"publish"*) echo "🚀" ;;
        *"merge"*) echo "🔀" ;;
        *"move"*|*"rename"*) echo "🚚" ;;
        *"improve"*|*"enhance"*|*"optimize"*) echo "⚡" ;;
        *"wip"*|*"progress"*) echo "🚧" ;;
        *"api"*|*"endpoint"*) echo "🔌" ;;
        *"ui"*|*"interface"*|*"layout"*) echo "🎨" ;;
        *"database"*|*"db"*|*"schema"*) echo "🗃️" ;;
        *"package"*|*"depend"*|*"bump"*) echo "📦" ;;
        *) echo "✨" ;;  # Default to sparkles
    esac
}

suggest_from_files() {
    # Analyze staged files to suggest emoji
    local STAGED=$(git diff --cached --name-only 2>/dev/null)
    
    if [ -z "$STAGED" ]; then
        return
    fi
    
    # Count file types
    local -A EXT_COUNT
    while IFS= read -r file; do
        EXT="${file##*.}"
        EXT="${EXT,,}"
        ((EXT_COUNT["$EXT"]++)) || true
    done <<< "$STAGED"
    
    # Find dominant file type
    local MAX_COUNT=0
    local DOMINANT_EXT=""
    for ext in "${!EXT_COUNT[@]}"; do
        if [ "${EXT_COUNT[$ext]}" -gt "$MAX_COUNT" ]; then
            MAX_COUNT="${EXT_COUNT[$ext]}"
            DOMINANT_EXT="$ext"
        fi
    done
    
    # Suggest based on file type if available
    if [ -n "${FILE_EMOJIS[$DOMINANT_EXT]}" ]; then
        echo "${FILE_EMOJIS[$DOMINANT_EXT]}"
    fi
}

format_message() {
    local MSG="$1"
    # Remove type prefix if present
    MSG=$(echo "$MSG" | sed 's/^[a-z]*: *//')
    # Capitalize first letter
    MSG="$(tr '[:lower:]' '[:upper:]' <<< ${MSG:0:1})${MSG:1}"
    echo "$MSG"
}

# Main
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    usage
fi

if [ "$1" == "--suggest" ]; then
    # Just show what would be suggested
    shift
    MSG="${*:-$(git diff --cached --name-only | head -1)}"
    EMOJI=$(suggest_emoji "$MSG")
    FILE_EMOJI=$(suggest_from_files)
    echo "Message: $MSG"
    echo "Suggested emoji (message): $EMOJI"
    [ -n "$FILE_EMOJI" ] && echo "Suggested emoji (files): $FILE_EMOJI"
    exit 0
fi

# Combine all arguments as message
MESSAGE="$*"

if [ -z "$MESSAGE" ]; then
    echo "❌ No commit message provided"
    echo "Usage: $0 <message>"
    exit 1
fi

# Get emoji suggestions
EMOJI=$(suggest_emoji "$MESSAGE")
FILE_EMOJI=$(suggest_from_files)

# Format the message
CLEAN_MSG=$(format_message "$MESSAGE")

# Show what we're doing
echo "💬 Commit Preview"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Message: $EMOJI $CLEAN_MSG"
[ -n "$FILE_EMOJI" ] && echo "Alt emoji (from files): $FILE_EMOJI"
echo ""

# Show staged files
echo "📁 Staged files:"
git diff --cached --name-only | while read -r file; do
    EXT="${file##*.}"
    F_EMOJI="${FILE_EMOJIS[${EXT,,}]:-📄}"
    echo "   $F_EMOJI $file"
done
echo ""

# The prompt defaults to yes, so when there is no terminal to answer it (a
# pipeline, a CI job, the gitpretty CLI reading from a script) take the default
# instead of failing on EOF, which used to abort the commit with exit 1.
if [ -t 0 ]; then
    read -p "Commit with this message? [Y/n/e(dit)] " -n 1 -r
    echo
else
    REPLY=""
fi

case $REPLY in
    [Nn])
        echo "❌ Commit cancelled"
        exit 1
        ;;
    [Ee])
        # Let user edit
        read -p "Enter custom message: " CUSTOM_MSG
        if [ -n "$CUSTOM_MSG" ]; then
            NEW_EMOJI=$(suggest_emoji "$CUSTOM_MSG")
            CLEAN_MSG=$(format_message "$CUSTOM_MSG")
            EMOJI="$NEW_EMOJI"
        fi
        ;;
esac

# Do the commit
git commit -m "$EMOJI $CLEAN_MSG"
echo ""
echo "✅ Committed: $EMOJI $CLEAN_MSG"


