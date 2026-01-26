# SKILL.md - Aesthetics Skill Definition

## Skill Name
`aesthetics-cli`

## Description
Beautiful CLI tools for developers. Add emoji commits, generate stats, beautify git logs.

## Capabilities

### Primary Skills

1. **emoji-commits**
   - Add unique emoji commit for every file in a repository
   - 609 unique tech/builder emojis
   - Zero file modifications (--allow-empty)
   - SHA256 checksum verification

2. **repo-stats**
   - Display repository statistics
   - Visual progress bars
   - File type distribution
   - Commit history analysis

3. **git-beautify**
   - Transform git log to colorful output
   - Semantic emoji prefixes
   - Customizable formats

4. **file-tree**
   - Enhanced directory tree
   - File type icons
   - Size information

5. **commit-lint**
   - Validate emoji conventions
   - Suggest fixes
   - CI/CD integration

6. **changelog-gen**
   - Generate changelogs from commits
   - Group by emoji type
   - Markdown output

## Input Requirements

### emoji-commits
- `repository_path`: Path to git repository (required)

### repo-stats
- `repository_path`: Path to git repository (optional, defaults to cwd)

### git-beautify
- `--limit`: Number of commits (optional)
- `--format`: Output format (optional)

### file-tree
- `directory`: Target directory (optional)
- `--depth`: Max depth (optional)
- `--size`: Show sizes (optional)

## Output Formats

### emoji-commits
```
✅ SUCCESS! 150 emoji commits created.
Files verified: 150
Checksums: PASSED
```

### repo-stats
```
📊 Repository Statistics
========================
Total files: 150
Total commits: 500
Contributors: 5
Languages: TypeScript (60%), CSS (30%), JSON (10%)
```

## Safety Guarantees

- All scripts use `--allow-empty` commits
- SHA256 checksums verify file integrity
- Pre/post manifests for comparison
- No destructive operations
- Detailed logging

## Prerequisites

- bash 4.0+
- git 2.0+
- sha256sum (Linux) or shasum (macOS)
- Standard Unix tools (find, grep, awk)

## Installation

```bash
git clone https://github.com/nirholas/aesthetics.git
chmod +x aesthetics/*.sh aesthetics/scripts/*.sh
export PATH="$PATH:$HOME/aesthetics:$HOME/aesthetics/scripts"
```

## Examples

```bash
# Add emoji commits to current repo
emoji-commits.sh .

# View repo stats
repo-stats.sh /path/to/repo

# Beautify git log
git-beautify.sh --limit 20

# Enhanced file tree
file-tree.sh --depth 3 --size
```

## Integration

### GitHub Actions
```yaml
- name: Add emoji commits
  run: ./aesthetics/emoji-commits.sh .
```

### Pre-commit Hook
```bash
#!/bin/bash
./aesthetics/scripts/commit-lint.sh --strict
```

## Limitations

- Maximum 609 unique emojis before repetition
- Requires git repository
- Bash-only (no Windows native support)

## Version
1.0.0

## Author
nirholas

## License
MIT

