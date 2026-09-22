#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date -u +%Y%m%d%H%M%SZ)"
BACKUP_DIR="$HOME/.dotfiles-backup-$TIMESTAMP"
PROFILE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/profile"
GROUPS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/groups"
DEFAULT_PROFILE=work
DEFAULT_THEME=catppuccin-macchiato

# brew/Brewfile is the core list every Mac gets. Each group below adds
# brew/Brewfile.<name> on top. A profile is a preset that picks groups;
# --groups names them instead.
ALL_GROUPS=(apps dev cloud media vm games personal)
work_groups=(apps dev cloud)
personal_groups=(apps dev media vm games personal)
groups=()

# Linux is assumed to be Omarchy, which ships its own desktop and its own
# theme picker. Only the shared shell and terminal packages are stowed there;
# the old i3 desktop packages live in archive/linux/i3-desktop. theme is
# macOS-only because on Omarchy it would write a colourscheme into Omarchy's
# Neovim config.
common_targets=(ghostty bash git starship tmux zsh)
macos_targets=(aerospace btop ghostty-macos mac-bin nvim theme)
linux_targets=()
stow_targets=()

available_targets=()
backup_initialized=0
profile=""
groups_flag=""
groups_flag_set=0
run_brew=1
run_defaults=1

# Stow links from packages this repo no longer manages. `stow --delete` cannot
# remove these once the package moves under archive/, because it only
# recognises links pointing at the package directory it was given.
retired_links=(
    "zellij:.config/zellij/config.kdl"
    "alacritty:.config/alacritty/alacritty.toml"
    "i3:.config/i3/config"
    "polybar:.config/polybar/config.ini"
    "picom:.config/picom/picom.conf"
    "rofi:.config/rofi/config.rasi"
    "dunst:.config/dunst/dunstrc"
    "nvim:.config/nvim/lua/plugins/omarchy-tokyo-night.lua"
    "x11:.xinitrc"
    "x11:.Xresources"
)

usage() {
    cat <<'USAGE'
Usage: ./install.sh [--profile work|personal] [--groups a,b,c]
                   [--no-brew] [--no-defaults]

  --profile NAME  Which preset of package groups to install. "work" installs
                  apps, dev and cloud. "personal" installs apps, dev, media,
                  vm, games and personal. Both also install brew/Brewfile,
                  which every Mac gets. The choice is saved to
                  ~/.config/dotfiles/profile and reused on later runs.
  --groups LIST   Comma-separated group names, installed instead of the
                  profile's preset. Saved to ~/.config/dotfiles/groups.
                  Groups: apps dev cloud media vm games personal.
                  --groups '' installs brew/Brewfile and nothing else.
  --no-brew       Stow the configs without installing any packages.
  --no-defaults   Leave the macOS system settings alone. Without this,
                  macos/defaults applies the Finder, keyboard and pointer
                  settings. It never deletes anything.
  -h, --help      Show this message.

With no --profile, the saved profile is used, then $DOTFILES_PROFILE, then
"work". Groups follow the same order: the flag, then $DOTFILES_GROUPS, then
the saved file, then the profile's preset.

Linux installs packages through the distro's package manager and ignores both
the profile and the groups.
USAGE
}

parse_args() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --profile)
                profile="${2:-}"
                if [ -z "$profile" ]; then
                    echo "--profile needs a value." >&2
                    exit 2
                fi
                shift 2
                ;;
            --profile=*)
                profile="${1#*=}"
                shift
                ;;
            --groups)
                if [ "$#" -lt 2 ]; then
                    echo "--groups needs a value. Use --groups '' for none." >&2
                    exit 2
                fi
                groups_flag="$2"
                groups_flag_set=1
                shift 2
                ;;
            --groups=*)
                groups_flag="${1#*=}"
                groups_flag_set=1
                shift
                ;;
            --no-brew)
                run_brew=0
                shift
                ;;
            --no-defaults)
                run_defaults=0
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo "Unknown option '$1'." >&2
                usage >&2
                exit 2
                ;;
        esac
    done
}

# Precedence: the flag, then the environment, then the saved file, then work.
# Work is the default so a machine never gets the personal extras by accident.
resolve_profile() {
    local from_flag="$profile"

    if [ -z "$profile" ]; then
        profile="${DOTFILES_PROFILE:-}"
    fi

    if [ -z "$profile" ] && [ -r "$PROFILE_FILE" ]; then
        profile="$(tr -d '[:space:]' < "$PROFILE_FILE")"
    fi

    profile="${profile:-$DEFAULT_PROFILE}"

    case "$profile" in
        work|personal) ;;
        *)
            echo "Unknown profile '$profile'. Use work or personal." >&2
            exit 2
            ;;
    esac

    # Only a flag rewrites the saved value, so running with DOTFILES_PROFILE set
    # once does not change what the machine gets from then on.
    if [ -n "$from_flag" ]; then
        mkdir -p "$(dirname "$PROFILE_FILE")"
        printf '%s\n' "$profile" > "$PROFILE_FILE"
    fi
}

# Precedence matches the profile: the flag, then the environment, then the
# saved file, then the profile's preset. An empty value is a real answer
# meaning "core only", which is why this tracks whether the flag was given
# rather than whether it is non-empty.
resolve_groups() {
    local raw=""
    local from_flag=0

    if [ "$groups_flag_set" -eq 1 ]; then
        raw="$groups_flag"
        from_flag=1
    elif [ -n "${DOTFILES_GROUPS+x}" ]; then
        raw="$DOTFILES_GROUPS"
    elif [ -r "$GROUPS_FILE" ]; then
        raw="$(tr -d '[:space:]' < "$GROUPS_FILE")"
    else
        case "$profile" in
            work) groups=("${work_groups[@]}") ;;
            personal) groups=("${personal_groups[@]}") ;;
        esac
        return
    fi

    local name
    while IFS= read -r name; do
        [ -n "$name" ] || continue

        if ! path_in_list "$name" "${ALL_GROUPS[@]}"; then
            echo "Unknown group '$name'. Use: ${ALL_GROUPS[*]}" >&2
            exit 2
        fi

        groups+=("$name")
    done <<< "$(printf '%s' "$raw" | tr ',' '\n')"

    # Only a flag rewrites the saved value, so exporting DOTFILES_GROUPS for
    # one run does not change what the machine gets from then on.
    if [ "$from_flag" -eq 1 ]; then
        mkdir -p "$(dirname "$GROUPS_FILE")"
        printf '%s\n' "${groups[*]+${groups[*]}}" | tr ' ' ',' > "$GROUPS_FILE"
    fi
}

set_active_targets() {
    case "$(uname -s)" in
        Darwin)
            stow_targets=("${common_targets[@]}" "${macos_targets[@]}")
            ;;
        Linux)
            stow_targets=("${common_targets[@]}" ${linux_targets[@]+"${linux_targets[@]}"})
            ;;
        *)
            stow_targets=("${common_targets[@]}")
            ;;
    esac
}

ensure_backup_dir() {
    if [ "$backup_initialized" -eq 0 ]; then
        mkdir -p "$BACKUP_DIR"
        backup_initialized=1
    fi
}

path_in_list() {
    local needle="$1"
    shift

    local item
    for item in "$@"; do
        if [ "$item" = "$needle" ]; then
            return 0
        fi
    done

    return 1
}

backup_target() {
    local relative_path="$1"
    local source_path="$HOME/$relative_path"
    local backup_path="$BACKUP_DIR/$relative_path"

    if [ ! -e "$source_path" ] && [ ! -L "$source_path" ]; then
        return
    fi

    ensure_backup_dir
    mkdir -p "$(dirname "$backup_path")"
    echo "Backing up $source_path to $backup_path"
    mv "$source_path" "$backup_path"
}

# Only stow packages that actually exist in this checkout.
collect_stow_targets() {
    local pkg
    for pkg in "${stow_targets[@]}"; do
        if [ -d "$DOTFILES_DIR/$pkg" ]; then
            available_targets+=("$pkg")
        fi
    done

    if [ ${#available_targets[@]} -eq 0 ]; then
        echo "No stow packages found to install."
        exit 1
    fi
}

# Dry-run stow first so we back up only real file conflicts, not whole config directories.
backup_stow_conflicts() {
    local dry_run_output
    local line
    local conflict_path
    local seen_conflicts=()

    dry_run_output="$(stow -n -v --restow --dir "$DOTFILES_DIR" --target "$HOME" "${available_targets[@]}" 2>&1 || true)"

    while IFS= read -r line; do
        if [[ "$line" =~ existing\ target\ ([^[:space:]]+)\ since ]]; then
            conflict_path="${BASH_REMATCH[1]}"
            if ! path_in_list "$conflict_path" "${seen_conflicts[@]+"${seen_conflicts[@]}"}"; then
                seen_conflicts+=("$conflict_path")
                backup_target "$conflict_path"
            fi
        fi
    done <<< "$dry_run_output"
}

remove_retired_links() {
    local entry pkg rel path
    for entry in "${retired_links[@]}"; do
        pkg="${entry%%:*}"
        rel="${entry#*:}"
        path="$HOME/$rel"

        [ -L "$path" ] || continue

        case "$(readlink "$path")" in
            */"$pkg"/"$rel")
                unlink "$path"
                echo "Removed retired symlink $path"
                ;;
        esac
    done
}

ensure_macos_deps() {
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is required. Install it from https://brew.sh, then re-run this script." >&2
        exit 1
    fi

    if [ "$run_brew" -eq 0 ]; then
        echo "Skipping package installation (--no-brew)."
        return
    fi

    echo "Installing core packages (profile: $profile)."
    brew bundle --file "$DOTFILES_DIR/brew/Brewfile"

    if [ ${#groups[@]} -eq 0 ]; then
        echo "No package groups selected."
        return
    fi

    local group file
    for group in "${groups[@]}"; do
        file="$DOTFILES_DIR/brew/Brewfile.$group"

        if [ ! -r "$file" ]; then
            echo "No Brewfile for group '$group', skipping." >&2
            continue
        fi

        echo "Installing the $group group."
        brew bundle --file "$file"
    done
}

detect_linux_distro() {
    if [ -r /etc/os-release ]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        echo "${ID:-unknown}"
    else
        echo "unknown"
    fi
}

ensure_linux_deps_apt() {
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update -q

    local packages=(curl git npm ripgrep stow zsh tmux neovim fzf zoxide bat fd-find inotify-tools)
    local missing_packages=()
    local pkg
    for pkg in "${packages[@]}"; do
        if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "install ok installed"; then
            missing_packages+=("$pkg")
        fi
    done

    if [ ${#missing_packages[@]} -gt 0 ]; then
        sudo apt-get install -yq "${missing_packages[@]}"
    fi

    if ! command -v diff-so-fancy &>/dev/null; then
        if command -v npm &>/dev/null; then
            sudo npm install -g diff-so-fancy
        else
            echo "npm not available; skipping diff-so-fancy."
        fi
    fi

    if ! command -v starship &>/dev/null; then
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
    fi
}

ensure_linux_deps_pacman() {
    # Omarchy already installs most of these. This is the safety net for running
    # install.sh on a plain Arch box. inotify-tools backs the rsw watcher, the
    # way fswatch does on macOS.
    local packages=(
        curl git stow zsh tmux neovim
        ripgrep fd fzf zoxide eza bat tealdeer
        starship diff-so-fancy lazygit btop
        gum inotify-tools yt-dlp
    )
    local missing=()
    local pkg
    for pkg in "${packages[@]}"; do
        if ! pacman -Q "$pkg" &>/dev/null; then
            missing+=("$pkg")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        sudo pacman -S --noconfirm --needed "${missing[@]}"
    fi
}

ensure_linux_deps() {
    if [ "$run_brew" -eq 0 ]; then
        echo "Skipping package installation (--no-brew)."
        return
    fi

    local distro
    distro="$(detect_linux_distro)"
    case "$distro" in
        ubuntu|debian|pop|linuxmint)
            ensure_linux_deps_apt
            ;;
        arch|archarm|manjaro|endeavouros|omarchy)
            ensure_linux_deps_pacman
            ;;
        *)
            echo "Unknown Linux distro '$distro'. Install these manually before re-running:"
            echo "  curl git stow zsh tmux ripgrep starship diff-so-fancy"
            exit 1
            ;;
    esac
}

parse_args "$@"
resolve_profile
resolve_groups

case "$(uname -s)" in
    Linux)
        set_active_targets
        ensure_linux_deps
        ;;
    Darwin)
        set_active_targets
        ensure_macos_deps
        if ! command -v stow &>/dev/null; then
            echo "stow is still missing. Run 'brew install stow' and try again." >&2
            exit 1
        fi
        ;;
    *)
        set_active_targets
        echo "Unsupported OS $(uname -s)."
        exit 1
        ;;
esac

mkdir -p "$HOME/.config" "$HOME/.local/bin"
collect_stow_targets
backup_stow_conflicts
remove_retired_links

# --restow refreshes existing symlinks and is safe to rerun once conflicts are
# cleared. --no-folding applies to every package, for three reasons:
#   - ghostty-macos, theme, tmux and zsh all put files in ~/.local/bin. Folded,
#     stow would link that whole directory at one package and hide the others.
#   - 'theme set' writes into ~/.config/btop/themes and ~/.config/nvim. Folded,
#     those writes would land back inside this repo.
#   - Library/Application Support holds app data beside Ghostty's config.
stow --restow --no-folding --dir "$DOTFILES_DIR" --target "$HOME" "${available_targets[@]}"

# Finder, keyboard and pointer settings. Only the groups that reproduce this
# setup; macos/defaults --list shows the rest, which stay manual because they
# change things a machine may reasonably want left alone. Nothing here deletes
# a file: folders Finder has already recorded keep their own view until
# 'macos/defaults --reset-folder-views' is run by hand.
apply_macos_defaults() {
    [ "$(uname -s)" = Darwin ] || return 0

    if [ "$run_defaults" -eq 0 ]; then
        echo "Skipping macOS system settings (--no-defaults)."
        return 0
    fi

    "$DOTFILES_DIR/macos/defaults"
}

# Ghostty, tmux, btop and Neovim read their colours from files that
# 'theme set' generates. Seed one so a fresh machine is not unthemed, but
# never overwrite a theme this machine already chose.
seed_theme() {
    local state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme"
    local theme_bin="$HOME/.local/bin/theme"

    [ -x "$theme_bin" ] || return 0
    [ -r "$state_dir/name" ] && return 0

    echo "Applying the default theme ($DEFAULT_THEME)."
    "$theme_bin" set "$DEFAULT_THEME"
}

seed_theme
apply_macos_defaults

if [ "$backup_initialized" -eq 1 ]; then
    echo "Stow installation complete. Conflicting files were backed up to $BACKUP_DIR"
else
    echo "Stow installation complete. No conflicting files needed backup."
fi
