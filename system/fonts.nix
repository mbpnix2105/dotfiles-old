{ pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      fira-code
      system-san-francisco-font
      san-francisco-mono-font
      iosevka-term-ss08-font
      (nerdfonts.override { fonts = [ "IBMPlexMono" "JetBrainsMono" ]; })
      terminus-nerdfont
      terminus_font
      mononoki
      unifont
    ];
  
    enableDefaultFonts = false;
  
    fontconfig.defaultFonts = {
      serif = [ "Unifont" ];
      sansSerif = [ "Unifont" ];
      monospace = [ "Unifont" ];
    };
  };
}
