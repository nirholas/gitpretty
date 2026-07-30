#!/bin/bash

# emoji-file-commits.sh - Add unique emoji commits that show in GitHub file browser
# Each file gets a tiny modification (trailing newline) and committed with unique emoji
# This makes emojis visible in GitHub's file listing view

set +e

REPO_PATH="$1"

if [ -z "$REPO_PATH" ]; then
    echo "Usage: $0 <repo-path>"
    echo ""
    echo "This script commits each file with a unique emoji that shows"
    echo "in GitHub's file browser next to each filename."
    echo ""
    echo "Note: Adds a trailing newline to each file to register a change."
    exit 1
fi

cd "$REPO_PATH"
REPO_NAME=$(basename "$(pwd)")
echo "Working in: $(pwd)"
echo "Repository: $REPO_NAME"
echo ""

# STRICTLY builder/tech/geometric emojis - NO faces, NO rainbows
EMOJIS=(
    "⭐" "🌟" "✨" "💫" "🌠" "🔆" "🔅"
    "🚀" "🛠️" "⚙️" "🔧" "🔩" "⛏️" "🔨" "🪛" "🪚" "🔗"
    "⛓️" "🧰" "🔌" "💡" "🔋" "💻" "🖥️" "⌨️" "🖱️" "💾"
    "💿" "📀" "🧮" "📱" "📡" "🔭" "🔬" "🧪" "🧬" "⚗️"
    "💎" "🔷" "🔶" "🔹" "🔸" "🔺" "🔻" "💠" "🔘" "⚪"
    "🟣" "🔵" "🟢" "🟡" "🟠" "🔴" "⬛" "⬜" "🟦" "🟩"
    "🟨" "🟧" "🟥" "🟪" "🟫" "◼️" "◻️" "◾" "◽" "▪️"
    "▫️" "🔳" "🔲"
    "🌱" "🌿" "🍀" "☘️" "🌲" "🌳" "🌴" "🪴" "🌵" "🌾"
    "🌸" "🌺" "🌻" "🌼" "🌷" "🪻" "🪷" "🌹" "💐" "🪨"
    "🪵" "🍃" "🍂" "🍁" "🌊" "💧" "🔥" "❄️" "⚡" "🌀"
    "🌍" "🌎" "🌏" "🌐" "🪐" "🌙" "🌕" "🌖" "🌗" "🌘"
    "🌑" "🌒" "🌓" "🌔" "☄️" "💥" "🌌"
    "🏗️" "🏛️" "🏰" "🏯" "🗼" "🗽" "🏠" "🏡" "🏢" "🏦"
    "🏭" "🏪" "🏫" "🏥" "🏨" "🏩" "⛪" "🕌" "🛕" "🕍"
    "⛩️" "🕋" "⛲" "⛺" "🌁" "🌃" "🌄" "🌅" "🌆" "🌇"
    "🌉" "🎡" "🎢" "🎠" "⛱️"
    "🚂" "🚃" "🚄" "🚅" "🚆" "🚇" "🚈" "🚉" "🚊" "🚝"
    "🚞" "🚋" "🚌" "🚍" "🚎" "🚐" "🚑" "🚒" "🚓" "🚔"
    "🚕" "🚖" "🚗" "🚘" "🚙" "🛻" "🚚" "🚛" "🚜" "🏎️"
    "🏍️" "🛵" "🛺" "🚲" "🛴" "🛹" "🛼" "✈️" "🛩️" "🛫"
    "🛬" "🪂" "🚁" "🚟" "🚠" "🚡" "🛰️" "🛸" "⛵" "🛶"
    "🚤" "🛳️" "⛴️" "🛥️" "🚢" "⚓"
    "📦" "📫" "📬" "📭" "📮" "🗳️" "📝" "✏️" "✒️" "🖋️"
    "🖊️" "🖌️" "🖍️" "📁" "📂" "🗂️" "📅" "📆" "🗒️" "🗓️"
    "📇" "📈" "📉" "📊" "📋" "📌" "📍" "📎" "🖇️" "📏"
    "📐" "✂️" "🗃️" "🗄️" "🔒" "🔓" "🔏" "🔐" "🔑" "🗝️"
    "📔" "📕" "📖" "📗" "📘" "📙" "📚" "📓" "📒" "📃"
    "📜" "📄" "📰" "🗞️" "📑" "🔖" "🏷️" "🎬" "📷" "📸"
    "📹" "📼" "🔍" "🔎" "🕯️" "🏮" "🪔"
    "🎨" "🖼️" "🎭" "🎪" "🎤" "🎧" "🎼" "🎵" "🎶" "🎷"
    "🪗" "🎸" "🎹" "🎺" "🎻" "🪕" "🥁" "🪘" "🔔" "🔕"
    "📢" "📣" "🎙️" "🎚️" "🎛️" "📻"
    "🎯" "🎱" "🎳" "🎮" "🕹️" "🎰" "🎲" "🧩" "🧸" "🪆"
    "♟️" "🃏" "🀄" "🎴" "⚽" "⚾" "🥎" "🏀" "🏐" "🏈"
    "🏉" "🎾" "🥏" "🏏" "🏑" "🏒" "🥍" "🏓" "🏸" "🥊"
    "🥋" "🥅" "⛳" "⛸️" "🎣" "🎽" "🎿" "🛷" "🥌"
    "🪀" "🪁" "🏆" "🏅" "🥇" "🥈" "🥉" "🎖️" "🎗️" "🎟️"
    "🎫"
    "🎀" "🎁" "🎈" "🎉" "🎊" "🎋" "🎍" "🎎" "🎏" "🎐"
    "🎑" "🧧" "🎄" "🎃"
    "❤️" "🧡" "💛" "💚" "💙" "💜" "🖤" "🤍" "🤎" "💕"
    "💞" "💓" "💗" "💖" "💘" "💝" "💟" "❣️" "♥️"
    "☮️" "✝️" "☪️" "🕉️" "☸️" "✡️" "🔯" "🕎" "☯️" "☦️"
    "🛐" "⛎" "♈" "♉" "♊" "♋" "♌" "♍" "♎" "♏"
    "♐" "♑" "♒" "♓" "⚛️" "🔀" "🔁" "🔂" "🔄" "🔃"
    "▶️" "⏩" "⏭️" "⏯️" "◀️" "⏪" "⏮️" "🔼" "⏫" "🔽"
    "⏬" "⏸️" "⏹️" "⏺️" "⏏️" "🎦" "📶" "📳" "📴"
    "✖️" "➕" "➖" "➗" "♾️" "‼️" "⁉️" "❓" "❔"
    "❕" "❗" "〰️" "💱" "💲" "⚕️" "♻️" "⚜️" "🔱" "📛"
    "🔰" "⭕" "✅" "☑️" "✔️" "❌" "❎" "➰" "➿" "〽️"
    "✳️" "✴️" "❇️" "©️" "®️" "™️"
)

EMOJI_COUNT=${#EMOJIS[@]}
echo "Loaded $EMOJI_COUNT unique emojis"
echo ""

# Get all tracked files
FILES=$(git ls-files)

# An empty $FILES is still one (empty) line to wc, which used to report
# "Files to process: 1" and then "SUCCESS! 0 emoji commits created" in a
# repository with nothing tracked yet.
if [ -z "$FILES" ]; then
    echo "❌ No tracked files found in $(pwd)."
    echo "   Stage and commit your files first, e.g. git add -A && git commit -m 'init'."
    exit 1
fi

FILE_COUNT=$(printf '%s\n' "$FILES" | wc -l)

echo "📁 Files to process: $FILE_COUNT"
echo ""

if [ "$FILE_COUNT" -gt "$EMOJI_COUNT" ]; then
    echo "⚠️  Warning: More files ($FILE_COUNT) than unique emojis ($EMOJI_COUNT)"
    echo "    Some emojis will repeat after $EMOJI_COUNT files"
    echo ""
fi

echo "🎯 Creating commits (each file will be modified)..."
echo "===================================================="
echo ""

INDEX=0
while IFS= read -r file; do
    if [ -z "$file" ]; then
        continue
    fi
    
    EMOJI="${EMOJIS[$INDEX % $EMOJI_COUNT]}"
    FILENAME=$(basename "$file")
    
    # Add a newline to the file to register a change
    echo "" >> "$file"
    
    # Stage and commit
    git add "$file"
    git commit -m "$EMOJI $FILENAME" --quiet 2>/dev/null || true
    
    printf "[%d/%d] %s %s\n" "$((INDEX + 1))" "$FILE_COUNT" "$EMOJI" "$file"
    
    ((INDEX++))
done <<< "$FILES"

echo ""
echo "✅ SUCCESS! $INDEX emoji commits created."
echo ""
echo "Each file now has a unique emoji in GitHub's file browser!"
echo "Push with: git push origin main"
echo ""




