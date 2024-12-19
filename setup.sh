# Link contents to parent directory
stow .

# Ensure TPM is installed
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install tmux plugins
tmux run-shell '~/.tmux/plugins/tpm/scripts/install_plugins.sh'
