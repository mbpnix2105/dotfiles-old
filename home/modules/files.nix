{ config, ... }:

let home = config.home.homeDirectory;
in {
  # screen recording
  home.file.scrrec = {
    source = ../scripts/scrrec;
    target = "${home}/.local/bin/scrrec";
  };
  # mp4 to gif
  home.file.mov2gif = {
    source = ../scripts/mov2gif;
    target = "${home}/.local/bin/mov2gif";
  };
}
