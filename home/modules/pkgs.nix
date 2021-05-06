{ pkgs, ... }:

{
  # pkgs
  home.packages = with pkgs; [
    brave
    gimp-with-plugins
    gnome3.meld
    imagemagick
    sxiv
    ueberzug
    wmctrl
    xfce.xfce4-pulseaudio-plugin
    xorg.xkill
    xsel
  ];
}
