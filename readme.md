# Dotfiles

Personal dotfiles managed with [Nix](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager).

## Quick Start

```bash
# Clone the repository
git clone https://github.com/FOLLGAD/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installation script
./install-nix.sh
```

The script will:
1. Install Nix (if not already installed)
2. Enable flakes
3. Set up Home Manager with your configurations
4. Install all declared packages

## Documentation

- **[NIX-REFERENCE.md](NIX-REFERENCE.md)** - Quick reference for common Nix commands and patterns
- **This README** - Installation and basic usage

## Prerequisites

### Install Nix

#### Linux & macOS
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

#### Enable Flakes
After installing Nix, enable flakes by adding this to `~/.config/nix/nix.conf` (create if it doesn't exist):
```
experimental-features = nix-command flakes
```

Or run:
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Installation

### 1. Clone the repository
```bash
git clone https://github.com/FOLLGAD/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Run the automated installer

```bash
./install-nix.sh
```

Or manually install Home Manager:

#### For Linux users:
```bash
nix run home-manager/master -- switch --flake .#emil@linux
```

#### For macOS users (Apple Silicon):
```bash
nix run home-manager/master -- switch --flake .#emil
```

#### For macOS users (Intel):
```bash
nix run home-manager/master -- switch --flake .#emil@darwin-x86
```

**Note on flake targets:** the names after `#` come from `flake.nix` under `homeConfigurations`. In this repo:
- `emil`: macOS (Apple Silicon)
- `emil@darwin-x86`: macOS (Intel)
- `emil@linux`: Linux

To list them on your machine:
```bash
nix flake show ~/.dotfiles
```

### 3. Update your username

Edit `home.nix` and update the username (and home directory) if needed:
```nix
home.username = lib.mkDefault "your-actual-username";
home.homeDirectory = lib.mkDefault "/home/your-actual-username";  # or /Users/your-actual-username on macOS
```

Then rebuild:
```bash
home-manager switch --flake .
```

## Updating Configuration

After making changes to the configuration files:
```bash
home-manager switch --flake ~/.dotfiles
```

## Updating Packages

To update all packages:
```bash
nix flake update
home-manager switch --flake ~/.dotfiles
```

## Included Configurations

- **Shell**: Zsh with Oh My Zsh, vi-mode, syntax highlighting
- **Editor**: Neovim with custom configuration
- **Media Player**: MPV configuration
- **macOS Window Manager**: Aerospace (macOS only)

## Customization

### Adding New Packages

Edit `home.nix` and add packages to the `home.packages` list:
```nix
home.packages = with pkgs; [
  # ... existing packages
  your-new-package
];
```

### Adding New Programs

Home Manager provides modules for many programs. Check the [Home Manager options](https://nix-community.github.io/home-manager/options.html) for available programs.

Example:
```nix
programs.git = {
  enable = true;
  userName = "Your Name";
  userEmail = "your.email@example.com";
};
```

## File Structure

```
.
├── flake.nix           # Nix flake configuration
├── home.nix            # Home Manager configuration
├── flake.lock          # Locked versions of dependencies
├── mpv/                # MPV configuration
├── aerospace/           # Aerospace configuration (macOS)
├── zshrc               # Legacy Zsh configuration (reference only)
└── install-nix.sh       # Bootstrap installer
```

## Troubleshooting

### Flakes not enabled
If you get an error about experimental features, make sure you've enabled flakes in `~/.config/nix/nix.conf`.

### Home Manager command not found
Make sure `~/.nix-profile/bin` is in your PATH. You may need to restart your shell or source the Nix profile script.

## Resources

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Home Manager Options Search](https://mipmip.github.io/home-manager-option-search/)
