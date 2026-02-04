if [[ "$OSTYPE" == "darwin"* ]]; then
    sudo nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake "$HOME/.dotfiles#emil-mac"
else
    home-manager switch --flake .
fi