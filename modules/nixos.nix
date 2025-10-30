{ config, pkgs, lib, ... }:

{
  # NixOS-specific module configurations
  # This module contains settings that only apply to NixOS systems

  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Terminal configuration
  environment.enableAllTerminfo = true;

  # Security settings
  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;

  # NixOS Helper (nh) for easier system management
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos/";
  };
}
