{ pkgs, ... }:
{
  # Required for nix-darwin on macOS
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Keep behavior consistent with your Home Manager config
  nixpkgs.config.allowUnfree = true;

  # Identify the user account that Home Manager should manage.
  users.users.emil = {
    name = "emil";
    home = "/Users/emil";
  };

  # Reuse your existing Home Manager module under nix-darwin.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.emil = import ./home.nix;
  };

  # Declaratively manage Homebrew (casks, taps, formulae) via nix-darwin.
  homebrew = {
    enable = true;
    casks = [
      "beeper"
    ];
  };

  # This tracks backwards-incompatible nix-darwin defaults.
  system.stateVersion = 5;
}

