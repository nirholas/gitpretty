#!/bin/bash

# emoji-log.sh - Beautiful git log with emojis
# Makes your git history a joy to read

set -e

usage() {
    echo "📜 emoji-log.sh - Beautiful git log viewer"
    echo ""
    echo "Usage: $0 [style] [options]"
    echo ""
    echo "Styles:"
    echo "  compact    - One line per commit (default)"
    echo "  detailed   - Full commit info"
    echo "  graph      - ASCII graph with emojis"
    echo "  stats      - Include file stats"
    echo "  today      - Today's commits only"
    echo "  week       - This week's commits"
    echo "  author     - Group by author"
    echo ""
    echo "Options:"
    echo "  -n NUM     - Limit to NUM commits"
    echo "  --all      - All branches"
    echo ""
    echo "Examples:"
    echo "  $0                  # Default compact view"
    echo "  $0 graph -n 20      # Graph of last 20"
    echo "  $0 today            # Today's work"
    exit 0
}

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Parse options
STYLE="compact"
LIMIT=""
ALL=""

while [[ $# -gt 0 ]]; do
    case $1 in
        compact|detailed|graph|stats|today|week|author)
            STYLE="$1"
            shift
            ;;
        -n)
            LIMIT="-n $2"
            shift 2
            ;;
        --all)
            ALL="--all"
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            shift
            ;;
    esac
done

format_compact() {
    git log $LIMIT $ALL --pretty=format:"%C(yellow)%h%C(reset) %s %C(dim)(%cr)%C(reset) %C(blue)<%an>%C(reset)" | 
    while IFS= read -r line; do
        # Add decorative prefix if commit doesn't start with emoji
        if [[ ! "$line" =~ ^[a-f0-9]+[[:space:]][[:punct:]]|^[a-f0-9]+[[:space:]]🔹 ]]; then
            echo "$line" | sed 's/^\([a-f0-9]*\) /\1 🔹 /'
        else
            echo "$line"
        fi
    done
}

format_detailed() {
    git log $LIMIT $ALL --pretty=format:"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📌 %C(yellow)%H%C(reset)
🌿 %C(green)%D%C(reset)
👤 %C(blue)%an%C(reset) <%ae>
📅 %C(cyan)%ci%C(reset) (%cr)

%s

%b"
}

format_graph() {
    git log $LIMIT $ALL --graph --pretty=format:"%C(yellow)%h%C(reset)%C(auto)%d%C(reset) %s %C(dim)(%cr)%C(reset)" |
    # Add emoji decorations to graph
    sed 's/\* /🔸 /g' |
    sed 's/|/│/g' |
    sed 's/\\/╲/g' |
    sed 's/\//╱/g'
}

format_stats() {
    git log $LIMIT $ALL --stat --pretty=format:"
%C(yellow)%h%C(reset) %s
%C(blue)<%an>%C(reset) %C(dim)%cr%C(reset)
"
}

format_today() {
    echo "📅 Today's Commits"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    git log --since="midnight" $ALL --pretty=format:"⏰ %C(dim)%cr%C(reset) │ %C(yellow)%h%C(reset) %s %C(blue)<%an>%C(reset)"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    COUNT=$(git log --since="midnight" $ALL --oneline | wc -l)
    echo "Total: $COUNT commit(s) today"
}

format_week() {
    echo "📆 This Week's Commits"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Group by day
    for i in {0..6}; do
        DAY=$(date -d "$i days ago" +%Y-%m-%d 2>/dev/null || date -v-${i}d +%Y-%m-%d)
        DAY_NAME=$(date -d "$i days ago" +%A 2>/dev/null || date -v-${i}d +%A)
        
        COMMITS=$(git log --since="$DAY 00:00" --until="$DAY 23:59" $ALL --oneline 2>/dev/null | wc -l)
        
        if [ "$COMMITS" -gt 0 ]; then
            echo ""
            echo "📌 $DAY_NAME ($DAY) - $COMMITS commits"
            git log --since="$DAY 00:00" --until="$DAY 23:59" $ALL --pretty=format:"   %C(yellow)%h%C(reset) %s %C(blue)<%an>%C(reset)"
            echo ""
        fi
    done
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

format_author() {
    echo "👥 Commits by Author"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Get unique authors
    git log $LIMIT $ALL --format='%an' | sort -u | while read -r author; do
        COUNT=$(git log $LIMIT $ALL --author="$author" --oneline | wc -l)
        echo ""
        echo "👤 $author ($COUNT commits)"
        git log $LIMIT $ALL --author="$author" --pretty=format:"   %C(yellow)%h%C(reset) %s %C(dim)(%cr)%C(reset)" | head -5
        if [ "$COUNT" -gt 5 ]; then
            echo "   ... and $((COUNT - 5)) more"
        fi
    done
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Execute selected format
case $STYLE in
    compact)    format_compact ;;
    detailed)   format_detailed ;;
    graph)      format_graph ;;
    stats)      format_stats ;;
    today)      format_today ;;
    week)       format_week ;;
    author)     format_author ;;
esac


