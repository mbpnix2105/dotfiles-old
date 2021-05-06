{ config, ... }:

{
  # add locations to $PATH
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];  

  # add editor
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  # bash shell editor
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
    };
  };
}
