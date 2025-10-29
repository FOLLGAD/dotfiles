# Migration Guide: Dotbot to Nix Home Manager

This document explains the differences between the old dotbot setup and the new Nix Home Manager configuration.

## Overview

| Aspect | Old (Dotbot) | New (Nix Home Manager) |
|--------|--------------|------------------------|
| **Setup Tool** | Dotbot (Python-based) | Nix Home Manager |
| **Package Management** | Manual via Homebrew/apt | Declarative via Nix |
| **Config Location** | `install.conf.yaml` | `flake.nix` + `home.nix` |
| **Installation** | `./install` | `./install-nix.sh` |
| **Updates** | Git pull + `./install` | `home-manager switch --flake .` |
| **Cross-platform** | Limited | Excellent (Linux/macOS) |

## Key Advantages of Nix Home Manager

### 1. **Declarative Package Management**
Instead of manually installing packages with Homebrew or apt:
```bash
# Old way
brew install ripgrep fd bat fzf
```

Now everything is declared in `home.nix`:
```nix
home.packages = with pkgs; [
  ripgrep
  fd
  bat
  fzf
];
```

### 2. **Reproducible Environment**
- Exact package versions are locked in `flake.lock`
- Same configuration works across different machines
- Easy to rollback to previous configurations

### 3. **Atomic Updates**
- Changes are applied atomically
- Failed updates don't break your system
- Previous generations are kept for rollback

### 4. **Better Program Integration**
Home Manager provides modules for many programs with better integration:
- Programs like zsh, tmux, git have dedicated configuration options
- Automatic service management
- Consistent configuration across tools

## What Changed

### Configuration Files

#### Dotbot (`install.conf.yaml`)
```yaml
- link:
    ~/.tmux.conf: tmux.conf
    ~/.zshrc: zshrc
    ~/.config/nvim: nvim
```

#### Home Manager (`home.nix`)
```nix
home.file = {
  ".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
};

programs.tmux.enable = true;
programs.zsh.enable = true;
```

### Package Installation

#### Old Setup
Manual installation via `setup` script:
```bash
brew install koekeishiya/formulae/skhd
brew install yabai
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### New Setup
Declarative in `home.nix`:
```nix
programs.zsh = {
  enable = true;
  oh-my-zsh.enable = true;
};
```

### Zsh Configuration

#### Old: `zshrc` file
- Standalone file with all configuration
- Requires oh-my-zsh to be installed separately
- Manual plugin management

#### New: `programs.zsh` in `home.nix`
- Integrated with Home Manager
- Oh-my-zsh managed by Home Manager
- Plugins declared in configuration
- Custom config in `initExtra`

### Updates

#### Old Process
```bash
cd ~/git/dotfiles
git pull
./install
brew upgrade
```

#### New Process
```bash
cd ~/.dotfiles
git pull
nix flake update  # Update package versions
home-manager switch --flake .
```

## Migration Steps

1. **Install Nix** (if not already installed)
   ```bash
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

2. **Enable Flakes**
   ```bash
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

3. **Update Configuration**
   ```bash
   cd ~/.dotfiles
   ./install-nix.sh
   ```

4. **Customize**
   - Edit `home.nix` to set your username
   - Add/remove packages as needed
   - Adjust program configurations

## Backward Compatibility

The old dotbot setup files are still present:
- `install` script
- `install.conf.yaml`
- `dotbot/` directory

These can be removed once you're comfortable with the Nix setup, or kept for reference.

## Common Tasks

### Adding a New Package

**Old:**
```bash
brew install <package>
```

**New:**
```nix
# Edit home.nix
home.packages = with pkgs; [
  # ... existing packages
  <package>
];
```
Then run: `home-manager switch --flake .`

### Updating Packages

**Old:**
```bash
brew upgrade
```

**New:**
```bash
nix flake update
home-manager switch --flake .
```

### Configuring a Program

**Old:** Create/edit dotfile manually

**New:** Use Home Manager module (if available):
```nix
programs.git = {
  enable = true;
  userName = "Your Name";
  userEmail = "your@email.com";
  aliases = {
    st = "status";
    co = "checkout";
  };
};
```

## Troubleshooting

### "experimental-features" Error
Enable flakes in `~/.config/nix/nix.conf`:
```
experimental-features = nix-command flakes
```

### Command Not Found After Installation
Ensure `~/.nix-profile/bin` is in your PATH. Restart your shell or:
```bash
source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
```

### Rollback to Previous Generation
```bash
home-manager generations
home-manager switch --flake . --rollback
```

## Resources

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Home Manager Options Search](https://mipmip.github.io/home-manager-option-search/)
- [Nix Pills](https://nixos.org/guides/nix-pills/) - Great learning resource
