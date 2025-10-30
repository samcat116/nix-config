{ config, pkgs, lib, ... }:

{
  # macOS (nix-darwin) specific module configurations
  # This module contains settings that only apply to macOS systems

  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # macOS-specific settings can be added here
  # For example:
  # - Homebrew integration
  # - macOS system preferences
  # - Touch ID for sudo
  # - etc.
}
