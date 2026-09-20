# Shell

zsh, in vi mode. `Esc` enters normal mode on the command line and `i` returns to insert. Config: `zsh/.zshrc`,
`zsh/.zprofile`, and one file per group of functions in `zsh/.config/zsh/fns`.

## Finding things

| Key or command | Action                                                              |
| -------------- | ------------------------------------------------------------------- |
| `Ctrl+R`       | Search command history with fzf                                     |
| `Ctrl+T`       | Pick a file with fzf and paste its path at the cursor               |
| `Option+C`     | Pick a directory with fzf and cd into it                            |
| `ff`           | Pick a file with a preview. Prints the path                         |
| `eff`          | Pick a file and open it in Neovim                                   |
| `z name`       | Jump to a directory you have visited before. `zi` picks from a list |
| `n`            | Open Neovim on the current directory. `n file` opens files          |

fzf lists files with `rg --files`, so it respects `.gitignore`. `cd` is plain `cd`.

## Listing and reading

| Alias       | Runs                                                          |
| ----------- | ------------------------------------------------------------- |
| `ls`, `ll`  | `eza -lh`, directories first, with icons                      |
| `la`, `lsa` | The same with hidden files                                    |
| `lt`        | A two-level tree with git status. `lta` includes hidden files |
| `cat`       | `bat -pp`, so files get syntax colour without a pager         |

`grep`, `find`, `awk` and `sed` run the GNU versions from Homebrew, so flags from Linux answers work here.

## Short aliases

| Alias                 | Runs                                                         |
| --------------------- | ------------------------------------------------------------ |
| `..`, `...`, `....`   | Up one, two or three directories                             |
| `g`                   | `git`                                                        |
| `gcm`, `gcam`, `gcad` | `git commit -m`, `git commit -a -m`, `git commit -a --amend` |
| `d`                   | `docker`                                                     |
| `o`                   | Open the current directory in Finder                         |
| `t`                   | Attach to the `Work` tmux session, creating it if needed     |
| `pw`                  | `cd ~/projects/work`                                         |
| `vim`                 | `nvim`                                                       |
| `python`, `pip`       | The 3 versions                                               |
| `plz`                 | `sudo`                                                       |

## Git worktrees

```bash
ga feature-x    # new branch feature-x in ../<repo>--feature-x, and cd there
gd              # from inside a worktree: remove it and delete the branch
```

`ga` runs `mise trust` on the new directory when mise is installed. `gd` refuses to run outside a `<repo>--<branch>`
directory and asks before removing.

## SSH

`ssh` is wrapped. If an interactive session that has run for at least thirty seconds drops, it resets the terminal and
reconnects every two seconds until `Ctrl+C`. Sessions with a remote command, piped input, or a `RemoteCommand` in ssh
config are left alone, since replaying those could repeat side effects.

```bash
fip host 5432 3000   # forward localhost:5432 and :3000 to the same ports on host
lip                  # list forwards
dip 5432             # stop one
```

## Rsync on change

```bash
rsw ./site user@host:/var/www/site   # sync now and on every change
lsw                                   # list watchers
dsw                                   # stop them
```

The watcher uses fswatch and keeps one ssh connection open per host, so a password manager prompts once rather than on
every sync.

## Archives

`compress dir` makes `dir.tar.gz`. `decompress file.tar.gz` unpacks it.

## Prompt

Starship prints the last three directories in blue, the git branch in purple, the git status in yellow, and a `❯` that
turns red after a failed command. Colours are named, so they follow the terminal palette.

## Runtimes

NVM loads from Homebrew and owns Node for now. mise is installed for projects that pin their tools with `mise.toml` or
`.tool-versions`. OrbStack's shell integration loads when OrbStack is installed.
