# Post-Installation Checklist

After running `./install-nix.sh`, use this checklist to verify everything is working correctly.

## Initial Setup ✓

- [ ] Nix is installed: `nix --version`
- [ ] Flakes are enabled: `nix flake --help` works without errors
- [ ] Home Manager is installed: `home-manager --version`
- [ ] Configuration applied successfully (no errors during `home-manager switch`)

## Environment Verification

### Shell (Zsh)
- [ ] Zsh is your default shell: `echo $SHELL` shows zsh path
- [ ] Oh-my-zsh is loaded: Check for oh-my-zsh prompt
- [ ] Vi mode works: Press `Esc` then `h/j/k/l` to navigate
- [ ] Syntax highlighting works: Type a command and see colors
- [ ] Auto-completion works: Press `Tab` after typing a command
- [ ] History works: Use `Ctrl-R` to search history
- [ ] Custom prompt displays: Should show emoji, username, path, and git info

### Packages
Run these commands to verify packages are installed:
- [ ] `bat --version` - Enhanced cat with syntax highlighting
- [ ] `fd --version` - Fast file finder
- [ ] `rg --version` (ripgrep) - Fast grep alternative
- [ ] `fzf --version` - Fuzzy finder
- [ ] `jq --version` - JSON processor
- [ ] `nvim --version` - Neovim editor

### Programs

#### Neovim
- [ ] Neovim launches: `nvim`
- [ ] Your custom config is loaded: Check for your plugins/settings
- [ ] `vim` and `vi` aliases work

#### Tmux
- [ ] Tmux launches: `tmux`
- [ ] Custom prefix (Ctrl-a) works instead of Ctrl-b
- [ ] Your custom key bindings work
- [ ] Configuration is loaded (check appearance/behavior)

#### Git
- [ ] Git is available: `git --version`
- [ ] Your git config is loaded: `git config --list`
- [ ] (Optional) Set your name/email if not already done

### Aliases
Test your custom aliases:
- [ ] `vim` opens neovim
- [ ] `..` changes to parent directory  
- [ ] `gs` runs git status
- [ ] `gpr` runs git pull --rebase
- [ ] `today` shows current date
- [ ] `now` shows current time

### Environment Variables
- [ ] `echo $EDITOR` shows `nvim`
- [ ] `echo $LANG` shows `en_US.UTF-8`
- [ ] `echo $BAT_THEME` shows `gruvbox-light`
- [ ] `echo $PATH` includes `$HOME/.local/bin`

### File Linking
Verify that configs are properly linked:
- [ ] `ls -la ~/.config/nvim` - Should be a symlink to your repo
- [ ] `ls -la ~/.config/mpv` - Should be a symlink to your repo
- [ ] `ls -la ~/.config/wezterm` - Should be a symlink to your repo
- [ ] `ls -la ~/.tmux.conf` - Should exist/be a symlink

### macOS Specific (if applicable)
- [ ] Yabai config linked: `ls -la ~/.yabairc`
- [ ] SKHD config linked: `ls -la ~/.skhdrc`
- [ ] Yabai is running (if you installed it): Check window management
- [ ] SKHD is running (if you installed it): Test hotkeys
- [ ] WezTerm AppleScript works: `Alt-t` to open WezTerm

## Advanced Verification

### Home Manager Generations
- [ ] List generations: `home-manager generations`
- [ ] Current generation is listed first
- [ ] Rollback works: `home-manager switch --flake . --rollback` then switch back

### Configuration Updates
Test the update workflow:
```bash
# 1. Make a small change to home.nix (e.g., add a comment)
# 2. Apply the change
cd ~/.dotfiles
home-manager switch --flake .
# 3. Verify no errors
```
- [ ] Configuration updates work without errors

### Package Search
- [ ] Can search for packages: `nix search nixpkgs <package-name>`
- [ ] Search returns results

### Flake Operations
- [ ] `nix flake metadata` shows flake info
- [ ] `nix flake check` validates configuration (may take a while)
- [ ] `nix flake show` displays flake outputs

## Troubleshooting

If any checks fail:

1. **Check logs**: Look for errors in the terminal output
2. **Verify file paths**: Ensure `home.username` and `home.homeDirectory` are correct
3. **Restart shell**: `exec zsh` or open a new terminal
4. **Re-run installation**: `home-manager switch --flake ~/.dotfiles`
5. **Check documentation**: See MIGRATION.md or NIX-REFERENCE.md
6. **Validate config**: Run `./validate-config.sh`

## Common Issues

### "command not found" after installation
**Solution**: Restart your shell or run:
```bash
source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
```

### Oh-my-zsh theme not appearing
**Solution**: Home Manager manages oh-my-zsh. The theme is set in `home.nix`. Check if you need to customize it.

### Neovim plugins not loading
**Solution**: Your nvim config is linked but not managed by Home Manager. Check if plugins need initialization (e.g., `:PackerSync` if using Packer).

### Configs not linked correctly
**Solution**: Check `home.file` section in `home.nix`. Re-run `home-manager switch --flake .`

### macOS: yabai/skhd not working
**Solution**: These require separate installation via Homebrew and system permissions. See README for details.

## Performance Check

- [ ] Shell starts quickly (< 1 second)
- [ ] Commands execute without noticeable delay
- [ ] Nix store size is reasonable: `du -sh /nix/store`

## Cleanup (Optional)

After verifying everything works:

### Old Generations
Remove old Home Manager generations to save space:
```bash
home-manager expire-generations "-7 days"
nix-collect-garbage -d
```
- [ ] Old generations cleaned up

### Legacy Files
If you're confident in the Nix setup, optionally remove legacy files:
```bash
# DON'T DO THIS unless you're sure!
# rm -rf dotbot/
# rm install install.conf.yaml setup
```
- [ ] Decided whether to keep or remove legacy files

## All Done! 🎉

If all checks pass:
- ✅ Your Nix Home Manager setup is working correctly
- ✅ All your dotfiles are properly configured
- ✅ You can now enjoy declarative, reproducible configuration management

## Next Steps

1. **Customize**: Edit `home.nix` to add packages or change settings
2. **Explore**: Check out [Home Manager options](https://mipmip.github.io/home-manager-option-search/)
3. **Backup**: Your `flake.lock` ensures reproducibility - commit it to git
4. **Share**: Use the same config on other machines by cloning and running `./install-nix.sh`

## Getting Help

If you encounter issues not covered here:
- Review **MIGRATION.md** for migration-specific problems
- Check **NIX-REFERENCE.md** for command help
- Consult the [Home Manager Manual](https://nix-community.github.io/home-manager/)
- Visit [NixOS Discourse](https://discourse.nixos.org/) for community support
