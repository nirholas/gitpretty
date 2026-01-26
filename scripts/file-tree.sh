#!/bin/bash

# file-tree.sh - Enhanced directory tree with file type icons
# Part of the Aesthetics toolkit

set -e

usage() {
    echo "🌳 file-tree.sh - Enhanced tree view with icons"
    echo ""
    echo "Usage: $0 [directory] [options]"
    echo ""
    echo "Options:"
    echo "  -d, --depth N    Maximum depth (default: 3)"
    echo "  -s, --size       Show file sizes"
    echo "  -a, --all        Show hidden files"
    echo "  -h, --help       Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/dir --depth 2 --size"
    exit 0
}

# Defaults
DIR="."
DEPTH=3
SHOW_SIZE=false
SHOW_HIDDEN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--depth) DEPTH="$2"; shift 2 ;;
        -s|--size) SHOW_SIZE=true; shift ;;
        -a|--all) SHOW_HIDDEN=true; shift ;;
        -h|--help) usage ;;
        -*) echo "Unknown option: $1"; usage ;;
        *) DIR="$1"; shift ;;
    esac
done

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m'

# Get icon for file type
get_icon() {
    local file="$1"
    local name=$(basename "$file")
    local ext="${name##*.}"
    
    # Directories
    if [[ -d "$file" ]]; then
        case "$name" in
            .git) echo "📦" ;;
            node_modules) echo "📦" ;;
            src|source) echo "📂" ;;
            docs|documentation) echo "📚" ;;
            test|tests|__tests__) echo "🧪" ;;
            build|dist|out) echo "📤" ;;
            config|configs) echo "⚙️ " ;;
            assets|images|img) echo "🖼️ " ;;
            scripts) echo "📜" ;;
            *) echo "📁" ;;
        esac
        return
    fi
    
    # Files by extension
    case "$ext" in
        # Programming
        js|mjs|cjs) echo "🟨" ;;
        ts|tsx) echo "🔷" ;;
        jsx) echo "⚛️ " ;;
        py) echo "🐍" ;;
        rb) echo "💎" ;;
        go) echo "🔵" ;;
        rs) echo "🦀" ;;
        java) echo "☕" ;;
        c|cpp|h|hpp) echo "⚙️ " ;;
        cs) echo "🟪" ;;
        php) echo "🐘" ;;
        swift) echo "🍊" ;;
        kt) echo "🟣" ;;
        
        # Web
        html|htm) echo "🌐" ;;
        css|scss|sass|less) echo "🎨" ;;
        vue) echo "💚" ;;
        svelte) echo "🔥" ;;
        
        # Data
        json) echo "📋" ;;
        yaml|yml) echo "📋" ;;
        xml) echo "📋" ;;
        csv) echo "📊" ;;
        sql) echo "🗃️ " ;;
        
        # Docs
        md|markdown) echo "📝" ;;
        txt) echo "📄" ;;
        pdf) echo "📕" ;;
        doc|docx) echo "📘" ;;
        
        # Config
        env) echo "🔐" ;;
        gitignore) echo "🙈" ;;
        dockerfile) echo "🐳" ;;
        
        # Images
        png|jpg|jpeg|gif|svg|ico|webp) echo "🖼️ " ;;
        
        # Media
        mp3|wav|ogg|flac) echo "🎵" ;;
        mp4|mov|avi|mkv) echo "🎬" ;;
        
        # Archives
        zip|tar|gz|rar|7z) echo "📦" ;;
        
        # Shell
        sh|bash|zsh) echo "💻" ;;
        
        # Lock files
        lock) echo "🔒" ;;
        
        # Default
        *) echo "📄" ;;
    esac
}

# Format file size
format_size() {
    local size=$1
    if ((size >= 1073741824)); then
        printf "%.1fG" $(echo "scale=1; $size/1073741824" | bc)
    elif ((size >= 1048576)); then
        printf "%.1fM" $(echo "scale=1; $size/1048576" | bc)
    elif ((size >= 1024)); then
        printf "%.1fK" $(echo "scale=1; $size/1024" | bc)
    else
        printf "%dB" $size
    fi
}

# Print tree
print_tree() {
    local dir="$1"
    local prefix="$2"
    local depth="$3"
    
    if ((depth > DEPTH)); then
        return
    fi
    
    local items=()
    
    if [[ "$SHOW_HIDDEN" == "true" ]]; then
        while IFS= read -r -d '' item; do
            items+=("$item")
        done < <(find "$dir" -maxdepth 1 -mindepth 1 -print0 2>/dev/null | sort -z)
    else
        while IFS= read -r -d '' item; do
            [[ $(basename "$item") != .* ]] && items+=("$item")
        done < <(find "$dir" -maxdepth 1 -mindepth 1 -print0 2>/dev/null | sort -z)
    fi
    
    local count=${#items[@]}
    local i=0
    
    for item in "${items[@]}"; do
        ((i++))
        local name=$(basename "$item")
        local icon=$(get_icon "$item")
        local connector="├──"
        local next_prefix="$prefix│   "
        
        if ((i == count)); then
            connector="└──"
            next_prefix="$prefix    "
        fi
        
        if [[ -d "$item" ]]; then
            echo -e "${prefix}${connector} ${icon} ${BLUE}${name}/${NC}"
            print_tree "$item" "$next_prefix" $((depth + 1))
        else
            local size_str=""
            if [[ "$SHOW_SIZE" == "true" ]]; then
                local size=$(stat -f%z "$item" 2>/dev/null || stat -c%s "$item" 2>/dev/null || echo "0")
                size_str=" ${GRAY}($(format_size $size))${NC}"
            fi
            echo -e "${prefix}${connector} ${icon} ${name}${size_str}"
        fi
    done
}

# Main
DIR_NAME=$(basename "$(cd "$DIR" && pwd)")

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  🌳 ${PURPLE}File Tree${NC}                                            ${CYAN}║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}${DIR_NAME}/${NC}"

print_tree "$DIR" "" 1

echo ""

# Summary
TOTAL_FILES=$(find "$DIR" -type f -not -path '*/.git/*' 2>/dev/null | wc -l)
TOTAL_DIRS=$(find "$DIR" -type d -not -path '*/.git/*' -not -path '*/.git' 2>/dev/null | wc -l)

echo -e "${GRAY}$TOTAL_DIRS directories, $TOTAL_FILES files${NC}"
echo ""



