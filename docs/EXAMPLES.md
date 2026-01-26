# 📚 Examples

Practical examples for using GitPretty scripts.

## emoji-commits.sh

### Basic Usage

```bash
# Run on current directory
./emoji-commits.sh .

# Run on specific repository
./emoji-commits.sh /path/to/my-project
```

### Example Output

```
Working in: /home/user/my-project
Repository: my-project

📊 PRE-COMMIT STATUS
====================
Total files: 42
Creating checksums...
Checksums created: 42

🎯 CREATING COMMITS
===================
[1/42] ⭐ README.md
[2/42] 🌟 package.json
[3/42] ✨ src/index.ts
[4/42] 💫 src/utils.ts
[5/42] 🌠 src/config.ts
...
[42/42] 🔷 .gitignore

✅ VERIFICATION
===============
Files before: 42
Files after: 42
Checksum verification: PASSED
No files modified, added, or deleted.

🎉 SUCCESS! 42 emoji commits created.
```

### Result in Git Log

```bash
$ git log --oneline -10
a1b2c3d ⭐ README.md
b2c3d4e 🌟 package.json
c3d4e5f ✨ src/index.ts
d4e5f6g 💫 src/utils.ts
e5f6g7h 🌠 src/config.ts
f6g7h8i 🔆 src/types.ts
g7h8i9j 🔅 src/constants.ts
h8i9j0k 🚀 src/api/index.ts
i9j0k1l 🛠️ src/api/client.ts
j0k1l2m ⚙️ src/api/endpoints.ts
```

---

## repo-stats.sh

### Basic Usage

```bash
./scripts/repo-stats.sh /path/to/repo
```

### Example Output

```
╔══════════════════════════════════════════════════════════╗
║  📊 Repository Statistics                                ║
║     my-awesome-project                                   ║
╚══════════════════════════════════════════════════════════╝

📁 Files
   Total files:       156
   Total directories: 23

📝 Git History
   Total commits:     342
   Branches:          5
   Tags:              12
   Contributors:      3

📊 File Types

   .ts        78 files  [████████████████████████████░░] 100%
   .json      12 files  [████░░░░░░░░░░░░░░░░░░░░░░░░░░]  15%
   .md         8 files  [███░░░░░░░░░░░░░░░░░░░░░░░░░░░]  10%
   .css        6 files  [██░░░░░░░░░░░░░░░░░░░░░░░░░░░░]   8%
   .yml        4 files  [█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]   5%

🕐 Recent Activity

   • a1b2c3d ✨ Add new feature
   • b2c3d4e 🐛 Fix login bug
   • c3d4e5f 📝 Update docs
   • d4e5f6g ♻️ Refactor API
   • e5f6g7h ⬆️ Upgrade deps

══════════════════════════════════════════════════════════
```

---

## git-beautify.sh

### Basic Usage

```bash
# Show last 20 commits (default)
./scripts/git-beautify.sh

# Show last 10 commits
./scripts/git-beautify.sh --limit 10

# Show commits since last week
./scripts/git-beautify.sh --since "1 week ago"

# Full format with details
./scripts/git-beautify.sh --format full
```

### Example Output (oneline)

```
╔══════════════════════════════════════════════════════════╗
║  🌈 Git Log - Beautified                                 ║
║     my-project                                           ║
╚══════════════════════════════════════════════════════════╝

a1b2c3d ✨ Add user authentication (2 hours ago)
b2c3d4e 🐛 Fix password validation (5 hours ago)
c3d4e5f 📝 Update API documentation (yesterday)
d4e5f6g ♻️ Refactor database queries (2 days ago)
e5f6g7h 🔒 Patch XSS vulnerability (3 days ago)

══════════════════════════════════════════════════════════
  Showing 5 commits
```

### Example Output (full)

```
a1b2c3d (2 hours ago)
  ✨ Add user authentication
  — John Doe

b2c3d4e (5 hours ago)
  🐛 Fix password validation
  — Jane Smith
```

---

## file-tree.sh

### Basic Usage

```bash
# Current directory
./scripts/file-tree.sh

# Specific directory
./scripts/file-tree.sh /path/to/project

# With depth limit
./scripts/file-tree.sh --depth 2

# With file sizes
./scripts/file-tree.sh --size

# Show hidden files
./scripts/file-tree.sh --all
```

### Example Output

```
╔══════════════════════════════════════════════════════════╗
║  🌳 File Tree                                            ║
╚══════════════════════════════════════════════════════════╝

my-project/
├── 📝 README.md (2.4K)
├── 📋 package.json (1.2K)
├── 📋 tsconfig.json (0.8K)
├── 📂 src/
│   ├── 🔷 index.ts (0.5K)
│   ├── 🔷 utils.ts (1.8K)
│   ├── 📂 api/
│   │   ├── 🔷 client.ts (2.1K)
│   │   └── 🔷 endpoints.ts (3.4K)
│   └── 📂 components/
│       ├── ⚛️ App.tsx (1.2K)
│       └── ⚛️ Header.tsx (0.9K)
├── 📚 docs/
│   └── 📝 API.md (4.5K)
└── 🧪 tests/
    └── 🔷 index.test.ts (1.1K)

12 directories, 45 files
```

---

## commit-lint.sh

### Basic Usage

```bash
# Check last 10 commits
./scripts/commit-lint.sh

# Check last 50 commits
./scripts/commit-lint.sh --last 50

# Strict mode (exit 1 on violations)
./scripts/commit-lint.sh --strict

# Show fix suggestions
./scripts/commit-lint.sh --fix
```

### Example Output

```
╔══════════════════════════════════════════════════════════╗
║  ✅ Commit Lint                                          ║
╚══════════════════════════════════════════════════════════╝

✓ a1b2c3d ✨ Add user authentication
✓ b2c3d4e 🐛 Fix login bug
✗ c3d4e5f Update documentation
  ↳ Suggested: 📝 Update documentation
✓ d4e5f6g ♻️ Refactor API client
✗ e5f6g7h Fix typo in readme
  ↳ Suggested: ✏️ Fix typo in readme

══════════════════════════════════════════════════════════

  Passed: 3
  Failed: 2
```

---

## changelog-gen.sh

### Basic Usage

```bash
# Generate markdown changelog
./scripts/changelog-gen.sh

# From specific tag
./scripts/changelog-gen.sh --since v1.0.0

# Between tags
./scripts/changelog-gen.sh --since v1.0.0 --until v2.0.0

# Output to file
./scripts/changelog-gen.sh --output CHANGELOG.md

# JSON format
./scripts/changelog-gen.sh --format json
```

### Example Output (Markdown)

```markdown
# Changelog

_Generated on 2026-01-26_

## Changes from v1.0.0 to HEAD

### ✨ Features

- Add user authentication (`a1b2c3d`)
- Add password reset flow (`f6g7h8i`)
- Add 2FA support (`k0l1m2n`)

### 🐛 Bug Fixes

- Fix login redirect issue (`b2c3d4e`)
- Fix session timeout (`g7h8i9j`)

### 📝 Documentation

- Update API documentation (`c3d4e5f`)
- Add contribution guide (`h8i9j0k`)

### ♻️ Refactoring

- Simplify database queries (`d4e5f6g`)
- Clean up API client (`i9j0k1l`)

---

_Generated by [gitpretty](https://github.com/nirholas/gitpretty)_
```

---

## Combined Workflow

Here's a complete workflow using multiple scripts:

```bash
# 1. Check current repo status
./scripts/repo-stats.sh

# 2. Add emoji commits
./emoji-commits.sh .

# 3. Verify commits follow conventions
./scripts/commit-lint.sh

# 4. View beautified log
./scripts/git-beautify.sh --limit 20

# 5. Generate changelog
./scripts/changelog-gen.sh --output CHANGELOG.md

# 6. Push to remote
git push origin main
```



