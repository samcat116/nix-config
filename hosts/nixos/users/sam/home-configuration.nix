{ config, pkgs, ... }:

{
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  # User-specific packages
  home.packages = with pkgs; [
    neofetch
    ripgrep
    eza
    jq
    fzf
    fd
    bat
  ];

  # Enable Anthropic CLI tools
  programs.claude-code.enable = true;
  programs.codex.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Sam Schmitt";
    userEmail = "sam@samschmitt.com";
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      container.disabled = true;
      hostname.disabled = true;
    };
  };

  # Neovim via nvf
  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };

  home.stateVersion = "25.05";
}
