{ config, pkgs, lib, ... }:

{
  # Enable zsh system-wide
  programs.zsh.enable = true;

  # Set zsh as default shell
  users.defaultUserShell = lib.mkDefault pkgs.zsh;
}
