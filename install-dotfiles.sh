# taken from https://github.com/samoshkin/tmux-config
set -e # exits if a command fails
set -u # errors if an variable is referenced before being set

is_app_installed() {
    type "$1" &>/dev/null
}

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR";

if ! is_app_installed tmux; then
    printf "WARNING: \"tmux\" command is not found. \
        Install it first\n"
            exit 1
fi

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
    printf "WARNING: Cannot found TPM (Tmux Plugin Manager) \
        at default location: \$HOME/.tmux/plugins/tpm.\n"
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ -e "$HOME/.tmux.conf" ]; then
    printf "Found existing .tmux.conf in your \$HOME directory. Will create a backup at $HOME/.tmux.conf.bak\n"
    cp -f "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak" 2>/dev/null || true
fi

if [ -e "$HOME/.zshrc" ]; then
    printf "Found existing .zshrc in your \$HOME directory. Will create a backup at $HOME/.zshrc.bak\n"
    cp -f "$HOME/.zshrc" "$HOME/.zshrc.bak" 2>/dev/null || true
fi

ln -sf "$HOME"/dotfiles/tmux/.tmux.conf "$HOME"/.tmux.conf;
ln -sf "$HOME"/dotfiles/.vimrc "$HOME"/.vimrc;
ln -sf "$HOME"/dotfiles/.zshrc "$HOME"/.zshrc;
ln -sf "$HOME"/dotfiles/nvim "$HOME"/.config/;

# Install TPM plugins.
# TPM requires running tmux server, as soon as `tmux start-server` does not work
# create dump __noop session in detached mode, and kill it when plugins are installed
printf "Install TPM plugins\n"
tmux new -d -s __noop >/dev/null 2>&1 || true 
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

printf "OK: Completed\n"
