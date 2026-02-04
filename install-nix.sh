#!/usr/bin/env bash
#
# Bootstrap script for setting up dotfiles with Nix Home Manager
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Dotfiles Setup with Nix Home Manager ===${NC}\n"

# Check if Nix is installed
if ! command -v nix &> /dev/null; then
    echo -e "${YELLOW}Nix is not installed. Installing Nix...${NC}"
    
    # Determine OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Detected macOS"
    else
        echo "Detected Linux/Unix"
    fi
    
    # Install Nix with flakes enabled
    sh <(curl -L https://nixos.org/nix/install) --daemon
    
    echo -e "${GREEN}Nix installed successfully!${NC}"
    echo -e "${YELLOW}Please restart your shell and run this script again.${NC}"
    exit 0
fi

echo -e "${GREEN}✓ Nix is installed${NC}"

# Check if flakes are enabled
if ! nix flake --help &> /dev/null 2>&1; then
    echo -e "${YELLOW}Enabling Nix flakes...${NC}"
    mkdir -p ~/.config/nix
    
    if ! grep -q "experimental-features = nix-command flakes" ~/.config/nix/nix.conf 2>/dev/null; then
        echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
        echo -e "${GREEN}✓ Flakes enabled${NC}"
        echo -e "${YELLOW}Please restart your shell and run this script again.${NC}"
        exit 0
    fi
fi

echo -e "${GREEN}✓ Nix flakes are enabled${NC}"

# Determine OS and apply appropriate configuration
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: use nix-darwin (which includes Home Manager)
    if [[ $(uname -m) == "arm64" ]]; then
        DARWIN_CONFIG="emil-mac"
        echo -e "${GREEN}Detected macOS (Apple Silicon)${NC}"
    else
        # Add x86 darwin config to flake.nix if needed
        DARWIN_CONFIG="emil-mac"
        echo -e "${GREEN}Detected macOS (Intel) - using emil-mac config${NC}"
    fi

    echo -e "${GREEN}Installing nix-darwin configuration (includes Home Manager)...${NC}"
    nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake ".#${DARWIN_CONFIG}"

    echo -e "\n${GREEN}=== Setup Complete! ===${NC}"
    echo -e "${GREEN}✓ nix-darwin and Home Manager have been installed and configured${NC}"
    echo -e "\nTo update your configuration in the future, run:"
    echo -e "  ${YELLOW}darwin-rebuild switch --flake ~/.dotfiles#${DARWIN_CONFIG}${NC}"
    echo -e "\nTo update packages, run:"
    echo -e "  ${YELLOW}nix flake update && darwin-rebuild switch --flake ~/.dotfiles#${DARWIN_CONFIG}${NC}"
    echo -e "\n${YELLOW}=== macOS Note ===${NC}"
    echo -e "If you use Aerospace (window manager), you may need to grant Accessibility permissions in System Settings."
else
    # Linux: use standalone Home Manager
    FLAKE_CONFIG="emil@linux"
    echo -e "${GREEN}Detected Linux${NC}"

    # Get current username
    CURRENT_USER=$(whoami)
    echo -e "${YELLOW}Current user: $CURRENT_USER${NC}"

    echo -e "${GREEN}Installing Home Manager configuration...${NC}"
    nix --extra-experimental-features 'nix-command flakes' run home-manager/master -- switch --extra-experimental-features 'nix-command flakes' --flake ".#${FLAKE_CONFIG}"

    echo -e "\n${GREEN}=== Setup Complete! ===${NC}"
    echo -e "${GREEN}✓ Home Manager has been installed and configured${NC}"
    echo -e "\nTo update your configuration in the future, run:"
    echo -e "  ${YELLOW}home-manager switch --flake ~/.dotfiles#${FLAKE_CONFIG}${NC}"
    echo -e "\nTo update packages, run:"
    echo -e "  ${YELLOW}nix flake update && home-manager switch --flake ~/.dotfiles#${FLAKE_CONFIG}${NC}"
fi

echo -e "\n${GREEN}Enjoy your new setup!${NC}"
