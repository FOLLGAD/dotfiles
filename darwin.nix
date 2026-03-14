{ pkgs, ghostty, ... }:
{
  # Nix settings (nix-daemon is now managed automatically)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.enable = false;

  # Keep behavior consistent with your Home Manager config
  nixpkgs.config.allowUnfree = true;

  # Primary user for nix-darwin (required for homebrew, etc.)
  system.primaryUser = "emil";

  # Identify the user account that Home Manager should manage.
  users.users.emil = {
    name = "emil";
    home = "/Users/emil";
  };

  # Reuse your existing Home Manager module under nix-darwin.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit ghostty; };
    backupFileExtension = "backup";
    users.emil = import ./home.nix;
  };

  # Declaratively manage Homebrew (casks, taps, formulae) via nix-darwin.
  homebrew = {
    enable = true;
    casks = [
      "beeper"
      "ghostty"
      "granola"
      "raycast"
      "spotify"
    ];
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # This tracks backwards-incompatible nix-darwin defaults.
  system.stateVersion = 5;
}

