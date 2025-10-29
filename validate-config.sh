#!/usr/bin/env bash
#
# Basic validation script for Nix files
# This performs simple checks without requiring Nix to be installed
#

set -e

echo "=== Validating Nix configuration files ==="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if files exist
files=("flake.nix" "home.nix")
missing_files=0

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} Found $file"
    else
        echo -e "${RED}✗${NC} Missing $file"
        missing_files=$((missing_files + 1))
    fi
done

if [ $missing_files -gt 0 ]; then
    echo -e "\n${RED}Error: Missing required files${NC}"
    exit 1
fi

echo ""

# Check for common syntax issues
echo "=== Checking for common issues ==="

# Check for unmatched braces in flake.nix
if [ "$(grep -c '{' flake.nix)" -ne "$(grep -c '}' flake.nix)" ]; then
    echo -e "${RED}✗${NC} Unmatched braces in flake.nix"
    exit 1
else
    echo -e "${GREEN}✓${NC} Braces balanced in flake.nix"
fi

# Check for unmatched braces in home.nix
if [ "$(grep -c '{' home.nix)" -ne "$(grep -c '}' home.nix)" ]; then
    echo -e "${RED}✗${NC} Unmatched braces in home.nix"
    exit 1
else
    echo -e "${GREEN}✓${NC} Braces balanced in home.nix"
fi

# Check for required flake inputs
if ! grep -q "nixpkgs.url" flake.nix; then
    echo -e "${RED}✗${NC} Missing nixpkgs input in flake.nix"
    exit 1
else
    echo -e "${GREEN}✓${NC} nixpkgs input found in flake.nix"
fi

if ! grep -q "home-manager" flake.nix; then
    echo -e "${RED}✗${NC} Missing home-manager input in flake.nix"
    exit 1
else
    echo -e "${GREEN}✓${NC} home-manager input found in flake.nix"
fi

# Check for required home.nix settings
required_settings=("home.username" "home.homeDirectory" "home.stateVersion")
for setting in "${required_settings[@]}"; do
    if ! grep -q "$setting" home.nix; then
        echo -e "${RED}✗${NC} Missing $setting in home.nix"
        exit 1
    else
        echo -e "${GREEN}✓${NC} $setting found in home.nix"
    fi
done

# Check that referenced files exist
echo ""
echo "=== Checking referenced files ==="

ref_files=("tmux.conf" "nvim" "mpv" "wezterm" "yabairc" "skhdrc")
for file in "${ref_files[@]}"; do
    if [ -e "$file" ]; then
        echo -e "${GREEN}✓${NC} Found $file"
    else
        echo -e "${YELLOW}⚠${NC} Warning: Referenced file/directory $file not found"
    fi
done

echo ""
echo -e "${GREEN}=== Basic validation complete ===${NC}"
echo ""
echo "Note: This is a basic syntax check. To fully validate:"
echo "  1. Install Nix: sh <(curl -L https://nixos.org/nix/install) --daemon"
echo "  2. Enable flakes in ~/.config/nix/nix.conf"
echo "  3. Run: nix flake check"
echo ""
