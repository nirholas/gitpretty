#!/bin/bash

# gitpretty-cli.sh - Interactive CLI for all gitpretty tools
# Beautiful menu-driven interface for emoji git workflows

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GRAY='\033[0;90m'
BOLD='\033[1m'
NC='\033[0m'

# Header
print_header() {
    clear
    echo -e "${CYAN}"
    echo "  ╭──────────────────────────────────────────────╮"
    echo "  │       ✨ ${BOLD}gitpretty${NC}${CYAN} - Interactive CLI        │"
    echo "  │        Make your git history beautiful        │"
    echo "  ╰──────────────────────────────────────────────╯"
    echo -e "${NC}"
}

# Print menu item
menu_item() {
    local num="$1"
    local emoji="$2"
    local title="$3"
    local desc="$4"
    echo -e "  ${CYAN}[$num]${NC} $emoji ${BOLD}$title${NC}"
    [ -n "$desc" ] && echo -e "      ${GRAY}$desc${NC}"
}

# Divider
divider() {
    echo -e "\n  ${GRAY}────────────────────────────────────────────────${NC}\n"
}

# Wait for key
wait_key() {
    echo ""
    echo -e "  ${GRAY}Press any key to continue...${NC}"
    read -n 1 -s
}

# Run script with output
run_script() {
    local script="$1"
    shift
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    if [ -f "$ROOT_DIR/$script" ]; then
        "$ROOT_DIR/$script" "$@"
    elif [ -f "$SCRIPT_DIR/$script" ]; then
        "$SCRIPT_DIR/$script" "$@"
    else
        echo -e "${RED}Script not found: $script${NC}"
        return 1
    fi
    
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# ============================================
# COMMIT MENU
# ============================================
menu_commit() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}💬 COMMIT${NC}\n"
        
        menu_item "1" "✨" "Smart Commit" "Auto-detect emoji from message"
        menu_item "2" "🔍" "Preview Only" "Show what emoji would be used"
        menu_item "3" "📝" "Custom Type" "Specify commit type explicitly"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1)
                echo ""
                echo -ne "  ${CYAN}Enter commit message:${NC} "
                read -r msg
                if [ -n "$msg" ]; then
                    run_script "scripts/emoji-commit.sh" "$msg"
                fi
                wait_key
                ;;
            2)
                echo ""
                echo -ne "  ${CYAN}Enter message to preview:${NC} "
                read -r msg
                if [ -n "$msg" ]; then
                    run_script "scripts/emoji-commit.sh" --suggest "$msg"
                fi
                wait_key
                ;;
            3)
                echo ""
                echo -e "  ${GRAY}Types: feat, fix, docs, style, refactor, perf, test, chore${NC}"
                echo -ne "  ${CYAN}Type:${NC} "
                read -r ctype
                echo -ne "  ${CYAN}Message:${NC} "
                read -r msg
                if [ -n "$ctype" ] && [ -n "$msg" ]; then
                    run_script "scripts/emoji-commit.sh" "$ctype: $msg"
                fi
                wait_key
                ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# LOG MENU
# ============================================
menu_log() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}📜 LOGS${NC}\n"
        
        menu_item "1" "📋" "Compact" "One line per commit"
        menu_item "2" "📊" "Graph" "ASCII graph with emojis"
        menu_item "3" "📅" "Today" "Today's commits only"
        menu_item "4" "📆" "This Week" "Commits grouped by day"
        menu_item "5" "👤" "By Author" "Group commits by author"
        menu_item "6" "📈" "With Stats" "Include file statistics"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1) run_script "scripts/emoji-log.sh" compact; wait_key ;;
            2) run_script "scripts/emoji-log.sh" graph; wait_key ;;
            3) run_script "scripts/emoji-log.sh" today; wait_key ;;
            4) run_script "scripts/emoji-log.sh" week; wait_key ;;
            5) run_script "scripts/emoji-log.sh" author; wait_key ;;
            6) run_script "scripts/emoji-log.sh" stats; wait_key ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# STASH MENU
# ============================================
menu_stash() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}📦 STASH${NC}\n"
        
        menu_item "1" "📋" "List Stashes" "View all stashes beautifully"
        menu_item "2" "💾" "Save Stash" "Stash with emoji prefix"
        menu_item "3" "📤" "Pop Stash" "Pop a stash"
        menu_item "4" "📥" "Apply Stash" "Apply without removing"
        menu_item "5" "👀" "Show Stash" "Preview stash contents"
        menu_item "6" "🗑️" "Drop Stash" "Remove a stash"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1) run_script "scripts/emoji-stash.sh" list; wait_key ;;
            2)
                echo ""
                echo -e "  ${GRAY}Types: wip, experiment, temp, save, backup, urgent, idea, debug${NC}"
                echo -ne "  ${CYAN}Stash type:${NC} "
                read -r stype
                echo -ne "  ${CYAN}Description:${NC} "
                read -r desc
                if [ -n "$stype" ]; then
                    run_script "scripts/emoji-stash.sh" save "$stype" "$desc"
                fi
                wait_key
                ;;
            3)
                echo ""
                run_script "scripts/emoji-stash.sh" list
                echo ""
                echo -ne "  ${CYAN}Stash index to pop [0]:${NC} "
                read -r idx
                run_script "scripts/emoji-stash.sh" pop "${idx:-0}"
                wait_key
                ;;
            4)
                echo ""
                run_script "scripts/emoji-stash.sh" list
                echo ""
                echo -ne "  ${CYAN}Stash index to apply [0]:${NC} "
                read -r idx
                run_script "scripts/emoji-stash.sh" apply "${idx:-0}"
                wait_key
                ;;
            5)
                echo ""
                run_script "scripts/emoji-stash.sh" list
                echo ""
                echo -ne "  ${CYAN}Stash index to show [0]:${NC} "
                read -r idx
                run_script "scripts/emoji-stash.sh" show "${idx:-0}"
                wait_key
                ;;
            6)
                echo ""
                run_script "scripts/emoji-stash.sh" list
                echo ""
                echo -ne "  ${CYAN}Stash index to drop:${NC} "
                read -r idx
                if [ -n "$idx" ]; then
                    run_script "scripts/emoji-stash.sh" drop "$idx"
                fi
                wait_key
                ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# BRANCH MENU
# ============================================
menu_branch() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}🌿 BRANCHES${NC}\n"
        
        menu_item "1" "✨" "Feature Branch" "feature/name"
        menu_item "2" "🐛" "Fix Branch" "fix/name"
        menu_item "3" "🚑" "Hotfix Branch" "hotfix/name"
        menu_item "4" "📝" "Docs Branch" "docs/name"
        menu_item "5" "♻️" "Refactor Branch" "refactor/name"
        menu_item "6" "✅" "Test Branch" "test/name"
        menu_item "7" "🚧" "WIP Branch" "wip/name"
        menu_item "8" "🔧" "Custom Type" "any-type/name"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        create_branch() {
            local btype="$1"
            echo ""
            echo -ne "  ${CYAN}Branch name:${NC} "
            read -r bname
            if [ -n "$bname" ]; then
                run_script "scripts/emoji-branch.sh" "$btype" "$bname"
            fi
            wait_key
        }
        
        case $choice in
            1) create_branch "feature" ;;
            2) create_branch "fix" ;;
            3) create_branch "hotfix" ;;
            4) create_branch "docs" ;;
            5) create_branch "refactor" ;;
            6) create_branch "test" ;;
            7) create_branch "wip" ;;
            8)
                echo ""
                echo -e "  ${GRAY}Types: feature, fix, hotfix, docs, style, refactor, perf, test, ci, chore, wip, release, security, experiment${NC}"
                echo -ne "  ${CYAN}Branch type:${NC} "
                read -r btype
                echo -ne "  ${CYAN}Branch name:${NC} "
                read -r bname
                if [ -n "$btype" ] && [ -n "$bname" ]; then
                    run_script "scripts/emoji-branch.sh" "$btype" "$bname"
                fi
                wait_key
                ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# MERGE MENU
# ============================================
menu_merge() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}🔀 MERGE${NC}\n"
        
        # Show current branches
        echo -e "  ${GRAY}Current branch:${NC} $(git branch --show-current 2>/dev/null || echo 'N/A')"
        echo -e "  ${GRAY}Available branches:${NC}"
        git branch 2>/dev/null | head -10 | while read -r b; do
            echo -e "    $b"
        done
        echo ""
        
        menu_item "1" "🔀" "Standard Merge" "Merge with emoji commit"
        menu_item "2" "📦" "Squash Merge" "Squash all commits"
        menu_item "3" "⛓️" "No Fast-Forward" "Force merge commit"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1)
                echo ""
                echo -ne "  ${CYAN}Branch to merge:${NC} "
                read -r branch
                if [ -n "$branch" ]; then
                    run_script "scripts/emoji-merge.sh" "$branch"
                fi
                wait_key
                ;;
            2)
                echo ""
                echo -ne "  ${CYAN}Branch to merge:${NC} "
                read -r branch
                if [ -n "$branch" ]; then
                    run_script "scripts/emoji-merge.sh" "$branch" --squash
                fi
                wait_key
                ;;
            3)
                echo ""
                echo -ne "  ${CYAN}Branch to merge:${NC} "
                read -r branch
                if [ -n "$branch" ]; then
                    run_script "scripts/emoji-merge.sh" "$branch" --no-ff
                fi
                wait_key
                ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# TAG MENU
# ============================================
menu_tag() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}🏷️ TAGS${NC}\n"
        
        # Show recent tags
        echo -e "  ${GRAY}Recent tags:${NC}"
        git tag --sort=-version:refname 2>/dev/null | head -5 | while read -r t; do
            echo -e "    $t"
        done
        echo ""
        
        menu_item "1" "💥" "Major Release" "Breaking changes (x.0.0)"
        menu_item "2" "✨" "Minor Release" "New features (1.x.0)"
        menu_item "3" "🐛" "Patch Release" "Bug fixes (1.0.x)"
        menu_item "4" "🚑" "Hotfix" "Critical fix"
        menu_item "5" "🧪" "Alpha/Beta" "Pre-release"
        menu_item "6" "🏷️" "Custom" "Specify version and type"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        create_tag() {
            local ttype="$1"
            echo ""
            echo -ne "  ${CYAN}Version (e.g., 1.0.0):${NC} "
            read -r ver
            if [ -n "$ver" ]; then
                run_script "scripts/emoji-tag.sh" "$ver" "$ttype"
            fi
            wait_key
        }
        
        case $choice in
            1) create_tag "major" ;;
            2) create_tag "minor" ;;
            3) create_tag "patch" ;;
            4) create_tag "hotfix" ;;
            5)
                echo ""
                echo -e "  ${GRAY}Types: alpha, beta, rc${NC}"
                echo -ne "  ${CYAN}Pre-release type:${NC} "
                read -r pretype
                echo -ne "  ${CYAN}Version (e.g., 1.0.0-alpha.1):${NC} "
                read -r ver
                if [ -n "$ver" ]; then
                    run_script "scripts/emoji-tag.sh" "$ver" "${pretype:-alpha}"
                fi
                wait_key
                ;;
            6)
                echo ""
                echo -e "  ${GRAY}Types: major, minor, patch, hotfix, alpha, beta, rc${NC}"
                echo -ne "  ${CYAN}Version:${NC} "
                read -r ver
                echo -ne "  ${CYAN}Type:${NC} "
                read -r ttype
                if [ -n "$ver" ]; then
                    run_script "scripts/emoji-tag.sh" "$ver" "${ttype:-minor}"
                fi
                wait_key
                ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# HOOKS MENU
# ============================================
menu_hooks() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}🪝 GIT HOOKS${NC}\n"
        
        menu_item "1" "📥" "Install Hooks" "Auto-emoji on all commits"
        menu_item "2" "🗑️" "Uninstall Hooks" "Remove emoji hooks"
        menu_item "3" "📋" "List Hooks" "Show installed hooks"
        menu_item "4" "🔍" "Check Status" "Verify hook status"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1) run_script "scripts/emoji-hooks.sh" install; wait_key ;;
            2) run_script "scripts/emoji-hooks.sh" uninstall; wait_key ;;
            3) run_script "scripts/emoji-hooks.sh" list; wait_key ;;
            4) run_script "scripts/emoji-hooks.sh" status; wait_key ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# TOOLS MENU
# ============================================
menu_tools() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}🔧 TOOLS${NC}\n"
        
        menu_item "1" "✅" "Lint Commits" "Check emoji conventions"
        menu_item "2" "📋" "Generate Changelog" "Create changelog from commits"
        menu_item "3" "📊" "Repo Stats" "Repository statistics"
        menu_item "4" "🎨" "Beautify Log" "Pretty git log"
        menu_item "5" "🌳" "File Tree" "Enhanced directory tree"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1)
                echo ""
                echo -ne "  ${CYAN}How many commits to check [10]:${NC} "
                read -r num
                run_script "scripts/commit-lint.sh" --last "${num:-10}"
                wait_key
                ;;
            2)
                echo ""
                echo -ne "  ${CYAN}Since tag (leave empty for all):${NC} "
                read -r since
                if [ -n "$since" ]; then
                    run_script "scripts/changelog-gen.sh" --since "$since"
                else
                    run_script "scripts/changelog-gen.sh"
                fi
                wait_key
                ;;
            3) run_script "scripts/repo-stats.sh" 2>/dev/null || echo "Script not available"; wait_key ;;
            4)
                echo ""
                echo -ne "  ${CYAN}Number of commits [20]:${NC} "
                read -r num
                run_script "scripts/git-beautify.sh" --limit "${num:-20}"
                wait_key
                ;;
            5) run_script "scripts/file-tree.sh" 2>/dev/null || echo "Script not available"; wait_key ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# BEAUTIFY MENU
# ============================================
menu_beautify() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}🎨 BEAUTIFY REPO${NC}\n"
        
        echo -e "  ${YELLOW}⚠️  These modify your repository!${NC}"
        echo ""
        
        menu_item "1" "📁" "File Commits" "Add emoji to each file (visible in GitHub)"
        menu_item "2" "📝" "Empty Commits" "Add emoji commits (no file changes)"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1)
                echo ""
                echo -e "  ${YELLOW}This will modify files in your repo!${NC}"
                echo -ne "  ${CYAN}Repository path [.]:${NC} "
                read -r rpath
                echo -ne "  ${CYAN}Are you sure? [y/N]:${NC} "
                read -n 1 confirm
                echo ""
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    run_script "emoji-file-commits.sh" "${rpath:-.}"
                fi
                wait_key
                ;;
            2)
                echo ""
                echo -ne "  ${CYAN}Repository path [.]:${NC} "
                read -r rpath
                run_script "emoji-commits.sh" "${rpath:-.}"
                wait_key
                ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# QUICK ACTIONS
# ============================================
menu_quick() {
    while true; do
        print_header
        echo -e "  ${MAGENTA}⚡ QUICK ACTIONS${NC}\n"
        
        menu_item "1" "✨" "Quick Commit" "Stage all + commit with message"
        menu_item "2" "🚧" "WIP Commit" "Quick work-in-progress commit"
        menu_item "3" "💾" "Quick Stash" "Stash all changes as WIP"
        menu_item "4" "📜" "Today's Log" "See today's commits"
        menu_item "5" "📊" "Quick Stats" "Last 10 commits lint check"
        echo ""
        menu_item "b" "←" "Back" ""
        menu_item "q" "🚪" "Quit" ""
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1)
                echo ""
                git add -A 2>/dev/null || true
                git status --short
                echo ""
                echo -ne "  ${CYAN}Commit message:${NC} "
                read -r msg
                if [ -n "$msg" ]; then
                    run_script "scripts/emoji-commit.sh" "$msg"
                fi
                wait_key
                ;;
            2)
                echo ""
                git add -A 2>/dev/null || true
                git commit -m "🚧 Work in progress"
                echo -e "\n${GREEN}✅ WIP commit created${NC}"
                wait_key
                ;;
            3)
                run_script "scripts/emoji-stash.sh" save wip "quick stash"
                wait_key
                ;;
            4)
                run_script "scripts/emoji-log.sh" today
                wait_key
                ;;
            5)
                run_script "scripts/commit-lint.sh" --last 10
                wait_key
                ;;
            b|B) return ;;
            q|Q) exit 0 ;;
        esac
    done
}

# ============================================
# MAIN MENU
# ============================================
main_menu() {
    while true; do
        print_header
        
        # Show current git status
        if git rev-parse --git-dir > /dev/null 2>&1; then
            BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")
            CHANGES=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
            echo -e "  ${GRAY}Branch:${NC} ${GREEN}$BRANCH${NC}  ${GRAY}Changes:${NC} ${YELLOW}$CHANGES${NC}"
            echo ""
        fi
        
        menu_item "1" "💬" "Commit" "Smart commit with auto-emoji"
        menu_item "2" "📜" "Logs" "Beautiful git log viewer"
        menu_item "3" "📦" "Stash" "Manage stashes with emojis"
        menu_item "4" "🌿" "Branch" "Create emoji branches"
        menu_item "5" "🔀" "Merge" "Merge with emoji commits"
        menu_item "6" "🏷️" "Tag" "Create release tags"
        menu_item "7" "🪝" "Hooks" "Install git hooks"
        menu_item "8" "🔧" "Tools" "Lint, changelog, stats"
        menu_item "9" "🎨" "Beautify" "Add emojis to entire repo"
        divider
        menu_item "q" "⚡" "Quick" "Quick actions"
        echo ""
        menu_item "h" "❓" "Help" "Show documentation"
        menu_item "x" "🚪" "Exit" "Quit gitpretty"
        
        echo ""
        echo -ne "  ${CYAN}Choose:${NC} "
        read -n 1 choice
        echo ""
        
        case $choice in
            1) menu_commit ;;
            2) menu_log ;;
            3) menu_stash ;;
            4) menu_branch ;;
            5) menu_merge ;;
            6) menu_tag ;;
            7) menu_hooks ;;
            8) menu_tools ;;
            9) menu_beautify ;;
            q|Q) menu_quick ;;
            h|H)
                echo ""
                echo -e "  ${BOLD}gitpretty${NC} - Make your git history beautiful"
                echo ""
                echo -e "  ${GRAY}Documentation:${NC} https://github.com/nirholas/gitpretty"
                echo ""
                echo -e "  ${CYAN}Emoji Conventions:${NC}"
                echo "    ✨ feat     New feature"
                echo "    🐛 fix      Bug fix"
                echo "    📝 docs     Documentation"
                echo "    💄 style    UI/style changes"
                echo "    ♻️  refactor Code refactoring"
                echo "    ⚡ perf     Performance"
                echo "    ✅ test     Tests"
                echo "    🔧 chore    Maintenance"
                echo "    🚀 deploy   Deployment"
                echo "    🔐 security Security fixes"
                wait_key
                ;;
            x|X) 
                echo ""
                echo -e "  ${GREEN}✨ Happy coding!${NC}"
                echo ""
                exit 0
                ;;
        esac
    done
}

# ============================================
# ENTRY POINT
# ============================================

# Check for command line arguments for non-interactive use
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "✨ gitpretty - Interactive CLI"
    echo ""
    echo "Usage: $0 [command] [args...]"
    echo ""
    echo "Commands (non-interactive):"
    echo "  commit <message>    Smart commit"
    echo "  log [style]         View logs (compact, graph, today, week)"
    echo "  stash <cmd>         Stash management"
    echo "  branch <type> <n>   Create branch"
    echo "  merge <branch>      Merge branch"
    echo "  tag <ver> [type]    Create tag"
    echo "  hooks <cmd>         Manage hooks"
    echo ""
    echo "Run without arguments for interactive mode."
    exit 0
fi

# Non-interactive shortcuts
case "$1" in
    commit)
        shift
        run_script "scripts/emoji-commit.sh" "$@"
        exit 0
        ;;
    log)
        shift
        run_script "scripts/emoji-log.sh" "$@"
        exit 0
        ;;
    stash)
        shift
        run_script "scripts/emoji-stash.sh" "$@"
        exit 0
        ;;
    branch)
        shift
        run_script "scripts/emoji-branch.sh" "$@"
        exit 0
        ;;
    merge)
        shift
        run_script "scripts/emoji-merge.sh" "$@"
        exit 0
        ;;
    tag)
        shift
        run_script "scripts/emoji-tag.sh" "$@"
        exit 0
        ;;
    hooks)
        shift
        run_script "scripts/emoji-hooks.sh" "$@"
        exit 0
        ;;
    "")
        # Interactive mode
        main_menu
        ;;
    *)
        echo "Unknown command: $1"
        echo "Run '$0 --help' for usage"
        exit 1
        ;;
esac

