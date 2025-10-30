{ config, pkgs, ... }:


{
  home.username = "sam";
  home.homeDirectory = "/home/sam";


  home.packages = with pkgs; [
    neofetch
    ripgrep
    eza
    jq
    fzf
    fd
    bat
  ];

  programs.claude-code.enable = true;
  programs.codex.enable = true;

  programs.git = {
    enable = true;
    userName = "Sam Schmitt";
    userEmail = "sam@samschmitt.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
  };

  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      container.disabled = true;
      hostname.disabled = true;
    };
  };
  programs.nvf = {
     enable = true;
     settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
    };
  };

  home.stateVersion = "25.05";

}
