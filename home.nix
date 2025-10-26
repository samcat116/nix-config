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
  ];
  
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
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  home.stateVersion = "25.05";

}
