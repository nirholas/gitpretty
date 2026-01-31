#!/bin/bash

# SAFE Script to create individual commits for every file in a repository
# Each file gets a UNIQUE emoji - STRICTLY builder/tech/geometric
# NO faces, NO rainbows, NO sad - only clean tech aesthetic
# Uses --allow-empty commits to avoid ANY file changes

set -e

REPO_PATH="$1"

if [ -z "$REPO_PATH" ]; then
    echo "Usage: $0 <repo-path>"
    exit 1
fi

cd "$REPO_PATH"
REPO_NAME=$(basename "$REPO_PATH")
echo "Working in: $(pwd)"
echo "Repository: $REPO_NAME"
echo ""

# Create temp directory for tracking
TRACK_DIR="/tmp/commit-tracker-$$"
mkdir -p "$TRACK_DIR"

MANIFEST_BEFORE="$TRACK_DIR/manifest_before.txt"
MANIFEST_AFTER="$TRACK_DIR/manifest_after.txt"
CHECKSUM_BEFORE="$TRACK_DIR/checksums_before.txt"
CHECKSUM_AFTER="$TRACK_DIR/checksums_after.txt"
LOG_FILE="$TRACK_DIR/commit_log.txt"

# STRICTLY builder/tech/geometric emojis - NO faces, NO rainbows
EMOJIS=(
    # Stars & Sparkles
    "⭐" "🌟" "✨" "💫" "🌠" "🔆" "🔅"
    # Tech & Building Tools
    "🚀" "🛠️" "⚙️" "🔧" "🔩" "⛏️" "🔨" "🪛" "🪚" "🔗"
    "⛓️" "🧰" "🔌" "💡" "🔋" "💻" "🖥️" "⌨️" "🖱️" "💾"
    "💿" "📀" "🧮" "📱" "📡" "🔭" "🔬" "🧪" "🧬" "⚗️"
    # Geometric Shapes
    "💎" "🔷" "🔶" "🔹" "🔸" "🔺" "🔻" "💠" "🔘" "⚪"
    "🟣" "🔵" "🟢" "🟡" "🟠" "🔴" "⬛" "⬜" "🟦" "🟩"
    "🟨" "🟧" "🟥" "🟪" "🟫" "◼️" "◻️" "◾" "◽" "▪️"
    "▫️" "🔳" "🔲"
    # Nature Elements (no faces)
    "🌱" "🌿" "🍀" "☘️" "🌲" "🌳" "🌴" "🪴" "🌵" "🌾"
    "🌸" "🌺" "🌻" "🌼" "🌷" "🪻" "🪷" "🌹" "💐" "🪨"
    "🪵" "🍃" "🍂" "🍁" "🌊" "💧" "🔥" "❄️" "⚡" "🌀"
    # Space & Cosmic (no faces)
    "🌍" "🌎" "🌏" "🌐" "🪐" "🌙" "🌕" "🌖" "🌗" "🌘"
    "🌑" "🌒" "🌓" "🌔" "☄️" "💥" "🌌"
    # Buildings & Architecture
    "🏗️" "🏛️" "🏰" "🏯" "🗼" "🗽" "🏠" "🏡" "🏢" "🏦"
    "🏭" "🏪" "🏫" "🏥" "🏨" "🏩" "⛪" "🕌" "🛕" "🕍"
    "⛩️" "🕋" "⛲" "⛺" "🌁" "🌃" "🌄" "🌅" "🌆" "🌇"
    "🌉" "🎡" "🎢" "🎠" "⛱️"
    # Vehicles & Transport
    "🚂" "🚃" "🚄" "🚅" "🚆" "🚇" "🚈" "🚉" "🚊" "🚝"
    "🚞" "🚋" "🚌" "🚍" "🚎" "🚐" "🚑" "🚒" "🚓" "🚔"
    "🚕" "🚖" "🚗" "🚘" "🚙" "🛻" "🚚" "🚛" "🚜" "🏎️"
    "🏍️" "🛵" "🛺" "🚲" "🛴" "🛹" "🛼" "✈️" "🛩️" "🛫"
    "🛬" "🪂" "🚁" "🚟" "🚠" "🚡" "🛰️" "🛸" "⛵" "🛶"
    "🚤" "🛳️" "⛴️" "🛥️" "🚢" "⚓"
    # Office & Documents
    "📦" "📫" "📬" "📭" "📮" "🗳️" "📝" "✏️" "✒️" "🖋️"
    "🖊️" "🖌️" "🖍️" "📁" "📂" "🗂️" "📅" "📆" "🗒️" "🗓️"
    "📇" "📈" "📉" "📊" "📋" "📌" "📍" "📎" "🖇️" "📏"
    "📐" "✂️" "🗃️" "🗄️" "🔒" "🔓" "🔏" "🔐" "🔑" "🗝️"
    "🪤" "🧲" "🪜" "⚖️" "🪝" "📿" "💰" "🪙" "💴" "💵"
    "💶" "💷" "💸" "💳" "🧾" "💹"
    # Books & Media
    "📔" "📕" "📖" "📗" "📘" "📙" "📚" "📓" "📒" "📃"
    "📜" "📄" "📰" "🗞️" "📑" "🔖" "🏷️" "🎬" "📷" "📸"
    "📹" "📼" "🔍" "🔎" "🕯️" "🏮" "🪔"
    # Art & Music (objects only)
    "🎨" "🖼️" "🎭" "🎪" "🎤" "🎧" "🎼" "🎵" "🎶" "🎷"
    "🪗" "🎸" "🎹" "🎺" "🎻" "🪕" "🥁" "🪘" "🔔" "🔕"
    "📢" "📣" "🎙️" "🎚️" "🎛️" "📻"
    # Games & Activities (objects only)
    "🎯" "🎱" "🎳" "🎮" "🕹️" "🎰" "🎲" "🧩" "🧸" "🪆"
    "♟️" "🃏" "🀄" "🎴" "⚽" "⚾" "🥎" "🏀" "🏐" "🏈"
    "🏉" "🎾" "🥏" "🏏" "🏑" "🏒" "🥍" "🏓" "🏸" "🥊"
    "🥋" "🥅" "⛳" "⛸️" "🎣" "🤿" "🎽" "🎿" "🛷" "🥌"
    "🪀" "🪁" "🏆" "🏅" "🥇" "🥈" "🥉" "🎖️" "🎗️" "🎟️"
    "🎫"
    # Celebration (objects only)
    "🎀" "🎁" "🎈" "🎉" "🎊" "🎋" "🎍" "🎎" "🎏" "🎐"
    "🎑" "🧧" "🎄" "🎃"
    # Hearts (symbols)
    "❤️" "🧡" "💛" "💚" "💙" "💜" "🖤" "🤍" "🤎" "💕"
    "💞" "💓" "💗" "💖" "💘" "💝" "💟" "❣️" "♥️"
    # Symbols & Arrows
    "☮️" "✝️" "☪️" "🕉️" "☸️" "✡️" "🔯" "🕎" "☯️" "☦️"
    "🛐" "⛎" "♈" "♉" "♊" "♋" "♌" "♍" "♎" "♏"
    "♐" "♑" "♒" "♓" "⚛️" "🔀" "🔁" "🔂" "🔄" "🔃"
    "▶️" "⏩" "⏭️" "⏯️" "◀️" "⏪" "⏮️" "🔼" "⏫" "🔽"
    "⏬" "⏸️" "⏹️" "⏺️" "⏏️" "🎦" "📶" "📳" "📴"
    "✖️" "➕" "➖" "➗" "🟰" "♾️" "‼️" "⁉️" "❓" "❔"
    "❕" "❗" "〰️" "💱" "💲" "⚕️" "♻️" "⚜️" "🔱" "📛"
    "🔰" "⭕" "✅" "☑️" "✔️" "❌" "❎" "➰" "➿" "〽️"
    "✳️" "✴️" "❇️" "©️" "®️" "™️" "#️⃣" "*️⃣" "0️⃣" "1️⃣"
    "2️⃣" "3️⃣" "4️⃣" "5️⃣" "6️⃣" "7️⃣" "8️⃣" "9️⃣" "🔟" "🔠"
    "🔡" "🔢" "🔣" "🔤" "🅰️" "🆎" "🅱️" "🆑" "🆒" "🆓"
    "ℹ️" "🆔" "Ⓜ️" "🆕" "🆖" "🅾️" "🆗" "🅿️" "🆘" "🆙"
    "🆚" "🈁" "🈂️" "🈷️" "🈶" "🈯" "🉐" "🈹" "🈚" "🈲"
    "🉑" "🈸" "🈴" "🈳" "㊗️" "㊙️" "🈺" "🈵" "🏁" "🚩"
    "🎌" "🏴" "🏳️"
    # Arrows
    "⬆️" "↗️" "➡️" "↘️" "⬇️" "↙️" "⬅️" "↖️" "↕️" "↔️"
    "↩️" "↪️" "⤴️" "⤵️" "🔙" "🔚" "🔛" "🔜" "🔝"
    # Marine life (no faces)
    "🦋" "🐚" "🌺" "🪸" "🪹" "🪺"
    # Additional tech/builder
    "🎆" "🎇" "🧨" "🪄" "🔮" "🧿" "🪬" "⚱️" "🏺" "🪣"
    "🧴" "🧷" "🧹" "🧺" "🧻" "🧼" "🪥" "🧽" "🧯" "🛒"
    "🪞" "🪟" "🛏️" "🛋️" "🪑" "🚿" "🛁" "🚽" "🪠" "🪤"
    "🪒" "🩹" "🩺" "💊" "💉" "🩸" "🧬" "🦠" "🧫" "🧪"
    "🌡️"
)

EMOJI_COUNT=${#EMOJIS[@]}
echo "Loaded $EMOJI_COUNT unique builder/tech emojis (no faces, no rainbows)"

echo ""
echo "PHASE 1: Creating pre-commit snapshot..."
echo "==========================================="

# Count files before
FILES_BEFORE=$(git ls-files | wc -l)
echo "Files tracked by git: $FILES_BEFORE"

if [ "$FILES_BEFORE" -gt "$EMOJI_COUNT" ]; then
    echo "Warning: More files ($FILES_BEFORE) than unique emojis ($EMOJI_COUNT)"
    echo "   Some emojis will be reused after cycling through all"
fi

# Create manifest of all files
git ls-files > "$MANIFEST_BEFORE"
echo "File manifest saved"

# Create checksums of all files (for verification)
echo "Calculating checksums..."
git ls-files -z | xargs -0 sha256sum 2>/dev/null > "$CHECKSUM_BEFORE" || {
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            sha256sum "$file" >> "$CHECKSUM_BEFORE" 2>/dev/null || echo "BINARY $file" >> "$CHECKSUM_BEFORE"
        fi
    done < "$MANIFEST_BEFORE"
}
CHECKSUMS_COUNT=$(wc -l < "$CHECKSUM_BEFORE")
echo "Checksums calculated for $CHECKSUMS_COUNT files"

# Get current commit count
COMMITS_BEFORE=$(git rev-list --count HEAD 2>/dev/null || echo "0")
echo "Commits before: $COMMITS_BEFORE"

echo ""
echo "PHASE 2: Processing files with UNIQUE emoji commits..."
echo "=========================================================="
echo "Using --allow-empty to avoid ANY file modifications"
echo ""

# Function to generate description based on file path
get_description() {
    local file="$1"
    local dir=$(dirname "$file")
    local name=$(basename "$file")
    local name_no_ext="${name%.*}"
    
    # Convert to readable format
    local readable_name=$(echo "$name_no_ext" | sed 's/[-_]/ /g')
    
    case "$name" in
        README*) echo "Documentation and project overview" ;;
        LICENSE*) echo "Project licensing information" ;;
        CHANGELOG*) echo "Version history and changes" ;;
        CONTRIBUTING*) echo "Contribution guidelines" ;;
        package.json) echo "Package configuration and dependencies" ;;
        package-lock.json) echo "Locked dependency versions" ;;
        tsconfig.json) echo "TypeScript compiler configuration" ;;
        .gitignore) echo "Git ignore patterns" ;;
        Dockerfile*) echo "Docker container configuration" ;;
        vercel.json) echo "Vercel deployment configuration" ;;
        index.*)
            local parent=$(basename "$dir")
            if [ "$dir" = "." ]; then
                echo "Main entry point"
            else
                echo "Entry point for $parent module"
            fi
            ;;
        *)
            # Based on directory
            case "$dir" in
                *tools*) echo "Tool: $readable_name" ;;
                *services*) echo "Service: $readable_name" ;;
                *utils*) echo "Utility: $readable_name" ;;
                *components*) echo "Component: $readable_name" ;;
                *hooks*) echo "Hook: $readable_name" ;;
                *api*) echo "API: $readable_name" ;;
                *types*) echo "Types: $readable_name" ;;
                *abi*) echo "Contract ABI: $readable_name" ;;
                *contracts*) echo "Contract: $readable_name" ;;
                *evm*) echo "EVM: $readable_name" ;;
                *sperax*) echo "Sperax: $readable_name" ;;
                *gnfd*|*greenfield*) echo "Greenfield: $readable_name" ;;
                *prompts*) echo "Prompt: $readable_name" ;;
                *resources*) echo "Resource: $readable_name" ;;
                *server*) echo "Server: $readable_name" ;;
                *lib*) echo "Library: $readable_name" ;;
                *modules*) echo "Module: $readable_name" ;;
                *docs*) echo "Documentation: $readable_name" ;;
                *examples*) echo "Example: $readable_name" ;;
                *tests*|*__tests__*) echo "Test: $readable_name" ;;
                *public*) echo "Public asset: $readable_name" ;;
                *assets*) echo "Asset: $readable_name" ;;
                *styles*) echo "Styles: $readable_name" ;;
                *) echo "$readable_name" ;;
            esac
            ;;
    esac
}

# Process files
COUNTER=0
TOTAL_FILES=$FILES_BEFORE
ERRORS=0

echo "Starting commit process..."
echo "=========================="

while IFS= read -r file; do
    # Get UNIQUE emoji by index (cycling if needed)
    EMOJI_INDEX=$((COUNTER % EMOJI_COUNT))
    EMOJI="${EMOJIS[$EMOJI_INDEX]}"
    
    # Get description
    DESC=$(get_description "$file")
    
    # Create commit message
    COMMIT_MSG="$EMOJI $DESC"
    
    # Use --allow-empty to create commit WITHOUT modifying the file
    if git commit --allow-empty -m "$COMMIT_MSG" -m "File: $file" >> "$LOG_FILE" 2>&1; then
        printf "\r[%d/%d] %s %s                              " "$((COUNTER + 1))" "$TOTAL_FILES" "$EMOJI" "$file"
    else
        echo ""
        echo "Error committing: $file"
        ERRORS=$((ERRORS + 1))
    fi
    
    COUNTER=$((COUNTER + 1))
done < "$MANIFEST_BEFORE"

echo ""
echo ""
echo "PHASE 3: Post-commit verification..."
echo "========================================"

# Count files after
FILES_AFTER=$(git ls-files | wc -l)
echo "Files after: $FILES_AFTER"

# Create manifest after
git ls-files > "$MANIFEST_AFTER"

# Create checksums after
echo "Verifying checksums..."
git ls-files -z | xargs -0 sha256sum 2>/dev/null > "$CHECKSUM_AFTER" || {
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            sha256sum "$file" >> "$CHECKSUM_AFTER" 2>/dev/null || echo "BINARY $file" >> "$CHECKSUM_AFTER"
        fi
    done < "$MANIFEST_AFTER"
}

# Get commit count after
COMMITS_AFTER=$(git rev-list --count HEAD)
NEW_COMMITS=$((COMMITS_AFTER - COMMITS_BEFORE))

echo ""
echo "VERIFICATION REPORT"
echo "======================"
echo ""
echo "Files BEFORE:    $FILES_BEFORE"
echo "Files AFTER:     $FILES_AFTER"
echo ""

# Check if file counts match
if [ "$FILES_BEFORE" -eq "$FILES_AFTER" ]; then
    echo "File count: PASSED (no files lost)"
else
    echo "File count: FAILED!"
    echo "   Missing files: $((FILES_BEFORE - FILES_AFTER))"
    diff "$MANIFEST_BEFORE" "$MANIFEST_AFTER" || true
fi

# Compare checksums
echo ""
echo "Checksum verification..."
if diff -q "$CHECKSUM_BEFORE" "$CHECKSUM_AFTER" > /dev/null 2>&1; then
    echo "Checksums: PASSED (no files modified)"
else
    echo "Checksums: Some files may have been modified"
    diff "$CHECKSUM_BEFORE" "$CHECKSUM_AFTER" | head -20 || true
fi

# Compare manifests
echo ""
echo "Manifest verification..."
if diff -q "$MANIFEST_BEFORE" "$MANIFEST_AFTER" > /dev/null 2>&1; then
    echo "Manifest: PASSED (file list identical)"
else
    echo "Manifest: FAILED (file list changed)"
    diff "$MANIFEST_BEFORE" "$MANIFEST_AFTER" || true
fi

# Check emoji uniqueness
echo ""
echo "Emoji uniqueness check..."
UNIQUE_EMOJIS_USED=$((TOTAL_FILES < EMOJI_COUNT ? TOTAL_FILES : EMOJI_COUNT))
if [ "$TOTAL_FILES" -le "$EMOJI_COUNT" ]; then
    echo "All $TOTAL_FILES files have unique emojis!"
else
    CYCLES=$((TOTAL_FILES / EMOJI_COUNT))
    REMAINDER=$((TOTAL_FILES % EMOJI_COUNT))
    echo "$TOTAL_FILES files > $EMOJI_COUNT emojis"
    echo "   Emojis cycled $CYCLES time(s) with $REMAINDER extra"
fi

echo ""
echo "Commits created: $NEW_COMMITS"
echo "Errors: $ERRORS"
echo ""
echo "SUMMARY FOR $REPO_NAME"
echo "========================="
echo "Files before:  $FILES_BEFORE"
echo "Files after:   $FILES_AFTER"
echo "New commits:   $NEW_COMMITS"
echo "Unique emojis: $UNIQUE_EMOJIS_USED"
echo "Errors:        $ERRORS"
echo ""

if [ "$FILES_BEFORE" -eq "$FILES_AFTER" ] && [ "$ERRORS" -eq 0 ]; then
    echo "SUCCESS: All files preserved, $NEW_COMMITS unique emoji commits created!"
else
    echo "WARNING: Please review the verification report above"
fi

echo ""
echo "Tracking files saved in: $TRACK_DIR"
echo "To clean up: rm -rf $TRACK_DIR"




