# Nix Home Manager Quick Reference

## Common Commands

### Initial Setup
```bash
# Install Nix (with flakes)
sh <(curl -L https://nixos.org/nix/install) --daemon

# Enable flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Install Home Manager configuration
./install-nix.sh
# OR manually:
nix run home-manager/master -- switch --flake .#emil@linux  # Linux
nix run home-manager/master -- switch --flake .#emil  # macOS (Apple Silicon)
nix run home-manager/master -- switch --flake .#emil@darwin-x86  # macOS (Intel)
```

### Daily Usage
```bash
# Apply configuration changes
home-manager switch --flake ~/.dotfiles

# Apply changes from current directory
home-manager switch --flake .

# Update packages to latest versions
nix flake update
home-manager switch --flake .

# Search for packages
nix search nixpkgs <package-name>
```

### Package Management
```bash
# List installed packages managed by Home Manager
home-manager packages

# List all Home Manager generations
home-manager generations

# Rollback to previous generation
home-manager switch --flake . --rollback
```

### Nix Store Management
```bash
# Clean up old generations and unused packages
nix-collect-garbage -d

# Remove old Home Manager generations (older than 7 days)
home-manager expire-generations "-7 days"

# Check what's in the Nix store
nix store ls /nix/store

# Optimize Nix store (deduplicate files)
nix-store --optimize
```

### Development
```bash
# Enter a development shell with packages
nix-shell -p <package1> <package2>

# Build a flake output (dry run)
nix build .#homeConfigurations.user.activationPackage --dry-run

# Check flake
nix flake check

# Show flake metadata
nix flake metadata

# Update specific input
nix flake lock --update-input nixpkgs
```

### Debugging
```bash
# Check current configuration
home-manager --version

# Show what would be built/changed
home-manager build --flake .

# Verbose output
home-manager switch --flake . --show-trace

# Show current generation
home-manager generations | head -n 1
```

## Configuration Structure

### File Organization
```
dotfiles/
├── flake.nix          # Flake configuration (inputs/outputs)
├── home.nix           # Main Home Manager configuration
├── flake.lock         # Locked versions of dependencies
├── nvim/              # Neovim configuration
├── mpv/               # MPV configuration
├── wezterm/           # WezTerm configuration
├── tmux.conf          # Tmux configuration
├── yabairc            # Yabai configuration (macOS)
└── skhdrc             # SKHD configuration (macOS)
```

### flake.nix
Defines:
- Inputs (nixpkgs, home-manager)
- Outputs (homeConfigurations for different systems)

### home.nix
Defines:
- User packages
- Program configurations
- Environment variables
- Shell aliases
- File symlinks

## Common Patterns

### Adding a Package
```nix
# In home.nix
home.packages = with pkgs; [
  # ... existing packages
  neofetch
  htop
];
```

### Configuring a Program
```nix
programs.git = {
  enable = true;
  userName = "Your Name";
  userEmail = "your@email.com";
  
  extraConfig = {
    core.editor = "nvim";
    init.defaultBranch = "main";
  };
  
  aliases = {
    st = "status";
    co = "checkout";
    br = "branch";
  };
};
```

### Setting Environment Variables
```nix
home.sessionVariables = {
  EDITOR = "nvim";
  BROWSER = "firefox";
  TERMINAL = "wezterm";
};
```

### Creating File Symlinks
```nix
home.file = {
  ".config/my-app" = {
    source = ./my-app-config;
    recursive = true;
  };
  
  ".local/bin/my-script" = {
    source = ./scripts/my-script.sh;
    executable = true;
  };
};
```

### Platform-Specific Configuration
```nix
let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  home.packages = with pkgs; [
    # Common packages
    ripgrep
    fd
  ] ++ lib.optionals isDarwin [
    # macOS-only packages
  ] ++ lib.optionals (!isDarwin) [
    # Linux-only packages
    xclip
  ];
}
```

## Useful Options

### Shell Configuration
```nix
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  
  history = {
    size = 10000;
    ignoreDups = true;
  };
  
  shellAliases = {
    ll = "ls -lah";
    ".." = "cd ..";
  };
  
  initExtra = ''
    # Custom shell code here
  '';
};
```

### Service Management
```nix
# Example: Run a background service
systemd.user.services.my-service = {
  Unit = {
    Description = "My Service";
  };
  Service = {
    ExecStart = "${pkgs.my-package}/bin/my-service";
    Restart = "always";
  };
  Install = {
    WantedBy = [ "default.target" ];
  };
};
```

## Tips & Tricks

1. **Use `lib.mkDefault`** for values you might want to override
   ```nix
   home.username = lib.mkDefault "user";
   ```

2. **Pin versions** when needed
   ```nix
   home.packages = [
     (pkgs.neovim.overrideAttrs (old: { version = "0.9.0"; }))
   ];
   ```

3. **Test before switching**
   ```bash
   home-manager build --flake .
   ```

4. **Use direnv** for automatic environment loading
   ```bash
   echo "use flake" > .envrc
   direnv allow
   ```

5. **Keep flake.lock in git** to ensure reproducibility

## Getting Help

```bash
# Home Manager help
home-manager --help

# Search for options
home-manager option <query>

# Nix help
nix --help

# Command-specific help
nix flake --help
nix search --help
```

## Resources

- Home Manager Options: https://mipmip.github.io/home-manager-option-search/
- NixOS Packages: https://search.nixos.org/packages
- Nix Manual: https://nixos.org/manual/nix/stable/
- Home Manager Manual: https://nix-community.github.io/home-manager/
