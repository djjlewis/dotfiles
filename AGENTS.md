# Working in this repository

This repo contains GNU Stow packages. `install.sh` selects shared packages
plus the packages for macOS or Linux. macOS is the primary setup. Linux is
assumed to be Omarchy, which brings its own desktop, so only the shared shell
and terminal packages are stowed there.

- Check `git status` before editing. Keep unrelated work intact.
- Read the relevant config before documenting a command or shortcut. Update
  the README when behavior changes.
- `docs/` has one guide per area (macOS, AeroSpace, Ghostty, shell, tmux,
  Neovim, themes). A guide describes this setup on its own and never mentions
  Omarchy. `docs/omarchy-differences.md` is the only place that compares
  against the [Omarchy manual](https://omarchy.org/manual): it lists what
  changed and why, links to the guide for the details, and does not restate
  them. `docs/omarchy-parity-backlog.md` lists what is still missing. A fact
  lives in one of these files, not two.
- Read and apply [unslop](.agents/skills/unslop/SKILL.md) when writing or
  revising prose. Keep commands, key names, and technical meaning exact.
- Use syntax checks for changed shell scripts and TOML. Use `stow -n` to
  check package links without changing the home directory.
- Validate a tmux config on its own socket: `tmux -L check -f FILE new-session
  -d` then `tmux -L check kill-server`. A bare `tmux ... kill-server` targets
  the default socket and destroys the user's running sessions.
- Porting a function from Omarchy means porting it to zsh, not copying it.
  bash arrays start at 0 and zsh's at 1, and zsh reserves `argv`. Run
  `scripts/check-omarchy-drift` to see what upstream changed since we ported.

`CLAUDE.md` points to this file. `.claude/skills` points to `.agents/skills`
so Claude and other agents use the same local skill.

## Why this repo re-includes CLAUDE.md

`git/.gitignore_global` ignores `.claude` and `CLAUDE.md` on every repo on the
machine, which keeps agent files out of commits by default. This repo commits
them, so its `.gitignore` negates those rules with `!CLAUDE.md` and
`!.claude/`. Any other repo that needs to commit a `CLAUDE.md` needs the same
negation, and until it has one the file will not appear in `git status`.
