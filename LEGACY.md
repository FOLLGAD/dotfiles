# Legacy Dotbot Files

This directory contains the original Dotbot-based setup for reference and backward compatibility.

## Files

- **`install`** - Original Dotbot installation script
- **`install.conf.yaml`** - Dotbot configuration file
- **`dotbot/`** - Dotbot submodule
- **`setup`** - Manual setup script for Homebrew and other dependencies
- **`zshrc`** - Original zsh configuration (now integrated into home.nix)

## Why Keep These?

1. **Reference**: Useful to compare old and new configurations
2. **Backward Compatibility**: In case you need to use the old system temporarily
3. **Migration Aid**: Helps verify that nothing was missed during conversion

## Deprecation Notice

⚠️ **These files are deprecated.** The repository has been migrated to use Nix Home Manager.

For the new installation method, see:
- **README.md** - Installation instructions
- **MIGRATION.md** - Migration guide from Dotbot
- **NIX-REFERENCE.md** - Quick reference for Nix commands

## Using Legacy Installation

If you still want to use the old Dotbot setup:

```bash
./install
```

Then follow the instructions in the original `setup` file for installing dependencies via Homebrew.

## Removal

These files can be safely removed once you've fully transitioned to the Nix setup and verified everything works:

```bash
rm -rf dotbot/
rm install install.conf.yaml setup
```

Note: You may want to keep `zshrc` as a reference even after migrating.
