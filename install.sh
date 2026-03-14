#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date -u +%Y%m%d%H%M%SZ)"
BACKUP_DIR="$HOME/.dotfiles-backup-$TIMESTAMP"

stow_targets=(aerospace alacritty bash git nvim zsh)

available_targets=()
backup_initialized=0

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
    local seen_conflicts=""

    dry_run_output="$(stow -n -v --restow --dir "$DOTFILES_DIR" --target "$HOME" "${available_targets[@]}" 2>&1 || true)"

    while IFS= read -r line; do
        if [[ "$line" =~ existing\ target\ ([^[:space:]]+)\ since ]]; then
            conflict_path="${BASH_REMATCH[1]}"
            if ! path_in_list "$conflict_path" $seen_conflicts; then
                seen_conflicts="$seen_conflicts $conflict_path"
                backup_target "$conflict_path"
            fi
        fi
    done <<< "$dry_run_output"
}

ensure_linux_deps() {
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update -q

    packages=(git zsh neovim npm stow)
    missing_packages=()
    local pkg
    for pkg in "${packages[@]}"; do
        if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "install ok installed"; then
            missing_packages+=("$pkg")
        fi
    done

    if [ ${#missing_packages[@]} -gt 0 ]; then
        sudo apt-get install -yq "${missing_packages[@]}"
    fi

    if ! command -v npm &>/dev/null; then
        echo "Failed to install npm"
        exit 1
    fi

    if ! command -v diff-so-fancy &>/dev/null; then
        npm install -g diff-so-fancy
    fi

    if ! command -v starship &>/dev/null; then
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
    fi
}

case "$(uname -s)" in
    Linux)
        ensure_linux_deps
        ;;
    Darwin)
        if ! command -v stow &>/dev/null; then
            echo "Please install stow with Homebrew (brew install stow) before running this script on macOS."
            exit 1
        fi
        ;;
    *)
        echo "Unsupported OS $(uname -s)."
        exit 1
        ;;
esac

mkdir -p "$HOME/.config"
collect_stow_targets
backup_stow_conflicts

    # --restow refreshes existing symlinks and is safe to rerun once conflicts are cleared.
stow --restow --dir "$DOTFILES_DIR" --target "$HOME" "${available_targets[@]}"

if [ "$backup_initialized" -eq 1 ]; then
    echo "Stow installation complete. Conflicting files were backed up to $BACKUP_DIR"
else
    echo "Stow installation complete. No conflicting files needed backup."
fi