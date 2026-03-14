if [[ "$OSTYPE" == "darwin"* ]]; then
    sudo nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake "$HOME/.dotfiles#lovemaker"
else
    home-manager switch --flake .
fi