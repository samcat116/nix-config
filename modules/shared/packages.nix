{ config, pkgs, lib, ... }:

{
  # Common packages that should be available system-wide
  environment.systemPackages = with pkgs; [
    git
    wget
    ripgrep
  ];
}
