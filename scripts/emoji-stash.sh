#!/bin/bash

# emoji-stash.sh - Stash changes with emoji descriptions
# Never lose track of your stashes again

set -e

# Emoji categories for stash types
declare -A STASH_EMOJIS=(
    ["wip"]="🚧"
    ["experiment"]="🧪"
    ["temp"]="⏳"
    ["save"]="💾"
    ["backup"]="🔐"
    ["urgent"]="🚨"
    ["idea"]="💡"
    ["debug"]="🔍"
    ["test"]="✅"
    ["style"]="💄"
)

usage() {
    echo "📦 emoji-stash.sh - Stash with emoji descriptions"
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  save [type] [message]  - Stash with emoji prefix"
    echo "  list                   - List all stashes beautifully"
    echo "  pop [index]            - Pop a stash"
    echo "  apply [index]          - Apply a stash"
    echo "  drop [index]           - Drop a stash"
    echo "  show [index]           - Show stash contents"
    echo "  clear                  - Clear all stashes (with confirmation)"
    echo ""
    echo "Stash types:"
    for key in "${!STASH_EMOJIS[@]}"; do
        echo "  $key → ${STASH_EMOJIS[$key]}"
    done
    echo ""
    echo "Examples:"
    echo "  $0 save wip working on auth"
    echo "  $0 save experiment trying new approach"
    echo "  $0 list"
    echo "  $0 pop 0"
    exit 0
}

cmd_save() {
    TYPE="${1:-wip}"
    shift || true
    MESSAGE="$*"
    
    EMOJI="${STASH_EMOJIS[$TYPE]:-📦}"
    
    if [ -z "$MESSAGE" ]; then
        MESSAGE="$TYPE"
    fi
    
    FULL_MESSAGE="$EMOJI $MESSAGE"
    
    echo "📦 Stashing: $FULL_MESSAGE"
    git stash push -m "$FULL_MESSAGE"
    echo "✅ Stashed successfully!"
}

cmd_list() {
    echo "📦 Stash List"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    STASHES=$(git stash list 2>/dev/null || true)
    
    if [ -z "$STASHES" ]; then
        echo "   (empty - no stashes)"
        return
    fi
    
    INDEX=0
    while IFS= read -r line; do
        # Parse the stash entry
        REF=$(echo "$line" | cut -d':' -f1)
        BRANCH=$(echo "$line" | grep -o 'On [^:]*' | sed 's/On //' || echo "unknown")
        MESSAGE=$(echo "$line" | cut -d':' -f3- | sed 's/^ *//')
        
        # Add color based on age
        echo "  [$INDEX] $MESSAGE"
        echo "      └── $REF on $BRANCH"
        
        ((INDEX++)) || true
    done <<< "$STASHES"
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Total: $INDEX stash(es)"
}

cmd_pop() {
    INDEX="${1:-0}"
    echo "📤 Popping stash@{$INDEX}..."
    git stash pop "stash@{$INDEX}"
    echo "✅ Stash applied and removed!"
}

cmd_apply() {
    INDEX="${1:-0}"
    echo "📋 Applying stash@{$INDEX}..."
    git stash apply "stash@{$INDEX}"
    echo "✅ Stash applied (still saved)!"
}

cmd_drop() {
    INDEX="${1:-0}"
    STASH_MSG=$(git stash list | grep "stash@{$INDEX}" | cut -d':' -f3- | sed 's/^ *//')
    echo "🗑️  Dropping stash@{$INDEX}: $STASH_MSG"
    read -p "Are you sure? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git stash drop "stash@{$INDEX}"
        echo "✅ Stash dropped!"
    fi
}

cmd_show() {
    INDEX="${1:-0}"
    echo "🔍 Showing stash@{$INDEX}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    git stash show -p "stash@{$INDEX}"
}

cmd_clear() {
    COUNT=$(git stash list | wc -l)
    echo "⚠️  This will clear ALL $COUNT stashes!"
    read -p "Are you sure? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git stash clear
        echo "🗑️  All stashes cleared!"
    fi
}

# Main command dispatcher
case "${1:-help}" in
    save|s)     shift; cmd_save "$@" ;;
    list|ls|l)  cmd_list ;;
    pop|p)      shift; cmd_pop "$@" ;;
    apply|a)    shift; cmd_apply "$@" ;;
    drop|d)     shift; cmd_drop "$@" ;;
    show|sh)    shift; cmd_show "$@" ;;
    clear|c)    cmd_clear ;;
    -h|--help|help) usage ;;
    *)          cmd_save "$@" ;;  # Default to save
esac
