---
name: emoji-git-workflow
description: Use the gitpretty CLI to make emoji conventional commits, pretty git logs, typed branches, release tags, merges and commit hooks. Use when a user asks for emoji commit messages or a more readable git history.
---

# gitpretty emoji git workflow

gitpretty is a Node launcher (`bin/cli.js`) over bash scripts. It needs bash and git. The repo is not installed from npm by this plugin: clone it and call the launcher with node.

```
git clone https://github.com/nirholas/gitpretty.git ~/gitpretty
node ~/gitpretty/bin/cli.js help
```

Below, `gp` stands for `node ~/gitpretty/bin/cli.js`. Run commands inside the git repository you want to change.

## Commands (from `gp help`)

- `gp commit "<message>"` smart commit; the emoji is picked from the message (conventional commit types such as feat, fix, docs, refactor, perf, test, chore map to emojis).
- `gp log [style]` styles are `compact` (default), `detailed`, `graph`, `stats`, `today`, `week`, `author`. Extra options: `-n <count>`, `--all`.
- `gp stash <action>` stash management, for example `gp stash save wip "testing"`; actions include save, list, pop, apply.
- `gp branch <type> <name>` creates a prefixed branch (feature, fix, docs, hotfix, refactor, build, ci, chore, wip, release).
- `gp merge <branch>` merge with an emoji message; accepts `--squash` and `--no-ff`.
- `gp tag <version> <type>` release tag with a version emoji; types: major, minor, patch, hotfix, alpha, beta, rc.
- `gp hooks <action>` where action is `install`, `uninstall`, `list` or `status` (commit-msg and pre-push hooks).
- `gp version` prints the version.

To preview an emoji without committing, call the script directly: `bash ~/gitpretty/scripts/emoji-commit.sh --suggest "<message>"`.

## Example

```
cd my-project
node ~/gitpretty/bin/cli.js branch feature login-form
node ~/gitpretty/bin/cli.js commit "feat: add login form validation"
node ~/gitpretty/bin/cli.js log graph -n 20
node ~/gitpretty/bin/cli.js tag v1.2.0 minor
```

## Caution

`gp beautify [path]` rewrites history in a heavy way: it appends a trailing newline to every file in the repository and makes one commit per file with a unique emoji, so it creates many commits. Only run it on a repository the user explicitly wants that done to, never on a shared branch without their confirmation, and read `docs/SAFETY.md` in the clone first. `gp hooks install` modifies `.git/hooks` of the current repository, so confirm before installing.
