{ config, pkgs, inputs, ... }:

{
  # Set the platform
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Basic system configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # System packages
  environment.systemPackages = with pkgs; [
    git
    wget
    ripgrep
  ];

  # User configuration
  users.users.sam = {
    home = "/Users/sam";
    description = "Sam Schmitt";
  };

  # Shell configuration
  programs.zsh.enable = true;



  # Home-manager configuration (nvf integration)
  home-manager.sharedModules = [ inputs.nvf.homeManagerModules.default ];

  # macOS system preferences
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
      tilesize = 48;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  # Touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # The state version (this is for nix-darwin, so it's an integer)
  system.stateVersion = 5;
}
