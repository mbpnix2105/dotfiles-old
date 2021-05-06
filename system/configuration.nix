{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./security.nix
      ./fonts.nix
      ./acpi.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Bucharest";

  networking.useDHCP = false;
  networking.interfaces.enp0s20u2.useDHCP = true;
  networking.interfaces.enp8s0.useDHCP = true;
  networking.interfaces.wlp9s0.useDHCP = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  services.xserver.enable = true;

  services.xserver.videoDrivers = [ "intel" "ati" "amdgpu" ];

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.displayManager.lightdm.greeters.gtk.theme.name = "Sweet-Dark";
  services.xserver.displayManager.lightdm.greeters.gtk.iconTheme.name = "Arc";
  services.xserver.displayManager.lightdm.greeters.gtk.cursorTheme.name = "Capitaine Cursors";
  services.xserver.displayManager.lightdm.greeters.gtk.clock-format = "%H:%M";
  services.xserver.displayManager.lightdm.background = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/mbprtpmix/nixos/testing/wallpapers/mountains.jpg";
    sha256 = "0k7lpj7rlb08bwq3wy9sbbq44rml55jyp9iy4ipwzy4bch0mc6y4";
  };
  services.xserver.displayManager.lightdm.greeters.gtk.indicators = [
    "~clock" "~spacer" "~host" "~spacer" "~power"
  ];
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    font-name = Unifont 12
  '';
  
  nixpkgs.overlays = [
    (import ../overlays/packages.nix)
  ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.adb.enable = true;

  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "eurosign:e";

  sound.enable = true;
  
  services.pipewire = {
    enable = true;
    pulse = {
      enable = true;
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack = {
      enable = true;
    };
  };

  hardware.cpu.intel.updateMicrocode = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  services.xserver.libinput.enable = true;

  users.users.mbpnix = {
    isNormalUser = true;
    uid = 1000;
    hashedPassword = "$6$TplKvtK9COqGJvut$H8ZoMnTss8jfC/gWypotCp1cggWAAeskJtBCE0ivCtA0DUhWPPI1vHDQg5XpxDSkD8.SAm24exDgwNeQyxNcf/";
    description = "MBPNIX";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.zsh;
    group = "mbpnix";
  };
  
  users.groups.mbpnix = {
    gid = 1000;
    name = "mbpnix";
  };
  
  programs.qt5ct.enable = true;
  
  programs.bash = {
    enableCompletion = true;
    enableLsColors = true;
    interactiveShellInit = ''
      bind "set completion-ignore-case on"
    '';
    shellAliases = {
    x="xclip -selection c -i";      # Cut	(does not filter).
    c="xclip -selection c -i -f";		# Copy	(does filter).
    v="xclip -selection c -o";      # Paste.
    };
  };

  environment.systemPackages = with pkgs; [
    arc-icon-theme
    arc-theme
    bleachbit
    brave
    cached-nix-shell
    cachix
    capitaine-cursors
    firefox
    git
    git-crypt
    killall
    rsync
    sweet
    vim
    wget
    xclip
  ];
  
  environment.shells = [ pkgs.zsh ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "overlay2";
  };

  nix = {
    useSandbox = true;
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    binaryCaches = [
      "https://cache.nixos.org"
      "https://cachix.cachix.org"
      "https://nix-community.cachix.org"
      "https://fufexan.cachix.org"
      "https://mbpnix.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
      "mbpnix.cachix.org-1:nAfBijPdJRqcMhwDlIr4LbwPPKVWHROKx02Bcc/WbAI="
    ];
    trustedUsers = [ "root" "mbpnix" ];
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];

  system.stateVersion = "21.05";

  services.fstrim = {
    enable = true;
    interval = "daily";
  };
}
