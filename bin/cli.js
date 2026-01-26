#!/usr/bin/env node

const { execSync } = require('child_process');
const path = require('path');

const args = process.argv.slice(2);
const command = args[0] || 'help';

const scriptsDir = path.join(__dirname, '..', 'scripts');
const rootDir = path.join(__dirname, '..');

const commands = {
  'beautify': 'emoji-file-commits.sh',
  'commit': 'emoji-commit.sh',
  'log': 'emoji-log.sh',
  'stash': 'emoji-stash.sh',
  'branch': 'emoji-branch.sh',
  'merge': 'emoji-merge.sh',
  'tag': 'emoji-tag.sh',
  'hooks': 'emoji-hooks.sh',
};

function showHelp() {
  console.log(`
✨ gitpretty - Make your git history beautiful

Usage: gitpretty <command> [options]

Commands:
  beautify [path]     Add emojis to all files (visible in GitHub)
  commit <message>    Smart commit with auto-emoji
  log [style]         Beautiful git log (graph|today|week|author)
  stash <action>      Stash management (save|list|pop|apply)
  branch <type> <name> Create branch (feature|fix|docs)
  merge <branch>      Merge with emoji message
  tag <version> <type> Create release tag (major|minor|patch)
  hooks <action>      Git hooks (install|uninstall|status)

Examples:
  gitpretty beautify .
  gitpretty commit "add user auth"
  gitpretty log graph
  gitpretty stash save wip "testing"

More info: https://github.com/nirholas/gitpretty
`);
}

if (command === 'help' || command === '--help' || command === '-h') {
  showHelp();
  process.exit(0);
}

if (command === 'beautify') {
  const script = path.join(rootDir, 'emoji-file-commits.sh');
  const targetPath = args[1] || '.';
  try {
    execSync(`bash "${script}" "${targetPath}"`, { stdio: 'inherit' });
  } catch (e) {
    process.exit(1);
  }
} else if (commands[command]) {
  const script = path.join(scriptsDir, commands[command]);
  const restArgs = args.slice(1).map(a => `"${a}"`).join(' ');
  try {
    execSync(`bash "${script}" ${restArgs}`, { stdio: 'inherit' });
  } catch (e) {
    process.exit(1);
  }
} else {
  console.error(`Unknown command: ${command}`);
  console.error('Run "gitpretty help" for usage');
  process.exit(1);
}
