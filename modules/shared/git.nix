{ config, pkgs, lib, ... }:

{
  # Home-manager git configuration
  home.manager.git = lib.mkIf (config ? home) {
    enable = true;
    userName = "Sam Schmitt";
    userEmail = "sam@samschmitt.com";
  };

  # System-level git configuration (NixOS/Darwin)
  programs.git = lib.mkIf (config ? environment) {
    enable = true;
    config = {
      userName = "Sam Schmitt";
      userEmail = "sam@samschmitt.com";
    };
  };
}
